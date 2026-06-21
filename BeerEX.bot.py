#!/usr/bin/env python
# coding=utf-8

"""
BeerEX: the Beer EXpert system bot.

A rule-based expert system (CLIPS) that suggests a beer to drink according to
taste and meal, exposed as a Telegram bot.

Each chat gets its OWN CLIPS environment (see Session) so concurrent users never
share working memory. Built on python-telegram-bot v21 (async).

Author: Donato Meoli
"""

import logging
import os
import re

import emoji
from telegram import (
    InlineKeyboardButton,
    InlineKeyboardMarkup,
    KeyboardButton,
    ReplyKeyboardMarkup,
    ReplyKeyboardRemove,
    Update,
)
from telegram.constants import ParseMode
from telegram.ext import (
    Application,
    CallbackQueryHandler,
    CommandHandler,
    ContextTypes,
    MessageHandler,
    filters,
)

import clips

logging.basicConfig(format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
                    level=logging.INFO)
logger = logging.getLogger(__name__)

BASE = os.path.dirname(os.path.abspath(__file__))


def _p(rel):
    return os.path.join(BASE, rel)


# Loaded in this order (mirrors BeerEX.clp): core + fuzzy backend + dialogue,
# then the question/knowledge rule files (the runtime loader rules are removed
# first so they don't reload at reset).
CORE_FILES = ["clips/beerex.clp",
              "clips/labels-it.clp",
              "third_party/FuzzyCLIPS/fuzzy.clp",
              "clips/beer-ranges.clp",
              "clips/beer-data.clp",
              "clips/beer-fuzzy.clp",
              "clips/beerex-fuzzy.clp",
              "clips/dialog.clp"]

# Emoji control buttons (aliases resolved once).
BTN_PREV = emoji.emojize(":back: Previous", language="alias")
BTN_RESTART = emoji.emojize(":repeat: Restart", language="alias")
BTN_CANCEL = emoji.emojize(":x: Cancel", language="alias")
BTN_HELP = emoji.emojize(":sos: Help", language="alias")
BTN_WHY = emoji.emojize(":question: Why", language="alias")

DEFAULT_BACKEND = os.environ.get("BEEREX_BACKEND", "fuzzy")  # cf | fuzzy
DEFAULT_LANG = os.environ.get("BEEREX_LANG", "en")          # en (base) | it


def _clean(value):
    """CLIPS unset slots come back as nil/empty; normalise to None."""
    if value is None:
        return None
    s = str(value)
    return None if s in ("", "nil") else s


class Session:
    """An isolated CLIPS environment driving one user's dialogue."""

    def __init__(self, backend=DEFAULT_BACKEND, lang=DEFAULT_LANG):
        self.backend = backend
        self.lang = lang
        self.env = clips.Environment()
        for f in CORE_FILES:
            self.env.load(_p(f))
        self.env.eval("(undefrule load-beer-question-rules)")
        self.env.load(_p("clips/beer-questions.clp"))
        self.env.eval("(undefrule load-beer-knowledge-rules)")
        self.env.load(_p("clips/beer-knowledge.clp"))
        self.reset()

    def reset(self):
        self.env.reset()
        # (reset) restores defglobals to their default; re-apply backend and language
        self.env.eval("(bind ?*backend* %s)" % self.backend)
        self.env.eval("(bind ?*lang* %s)" % self.lang)
        self.env.run()

    def tr(self, s):
        # Localize a bot message through the shared CLIPS catalog (English base,
        # Italian overlay); falls back to English when lang=en or uncatalogued.
        return self.env.eval('(T "%s")' % s.replace("\\", "\\\\").replace('"', '\\"'))

    # -- working-memory helpers ---------------------------------------------
    def _state_list(self):
        return self.env.eval("(find-fact ((?s state-list)) TRUE)")[0]

    def _current_ui(self):
        cid = self._state_list()["current"]
        ui = self.env.eval("(find-fact ((?u UI-state)) (eq ?u:id %s))" % cid)[0]
        return cid, ui

    def initial_display(self):
        return self.env.eval("(find-fact ((?u UI-state)) (eq ?u:state initial))")[0]["display"]

    def screen(self):
        """Advance past 'initial' states and return the current screen."""
        cid, ui = self._current_ui()
        while str(ui["state"]) == "initial":
            self.env.assert_string("(next %s)" % cid)
            self.env.run()
            cid, ui = self._current_ui()
        return {
            "state": str(ui["state"]),
            "display": ui["display"],
            "help": _clean(ui["help"]),
            "why": _clean(ui["why"]),
            "valid_answers": [str(a) for a in ui["valid-answers"]],
            "can_prev": len(self._state_list()["sequence"]) > 2,
        }

    # -- transitions --------------------------------------------------------
    def new(self):
        self.reset()
        return self.screen()

    def answer(self, response):
        cid, _ = self._current_ui()
        if " " in response:
            self.env.assert_string('(next %s "%s")' % (cid, response))
        else:
            self.env.assert_string("(next %s %s)" % (cid, response))
        self.env.run()
        return self.screen()

    def back(self):
        cid, _ = self._current_ui()
        self.env.assert_string("(prev %s)" % cid)
        self.env.run()
        return self.screen()

    def cancel(self):
        self.env.reset()


# chat_id -> Session  (each user keeps their own working memory)
SESSIONS: dict[int, Session] = {}
MAX_SESSIONS = 5000


def get_session(chat_id):
    session = SESSIONS.get(chat_id)
    if session is None:
        if len(SESSIONS) >= MAX_SESSIONS:
            SESSIONS.pop(next(iter(SESSIONS)))  # evict oldest
        session = SESSIONS[chat_id] = Session()
    return session


def _keyboard(screen):
    if screen["state"] == "final":
        rows = [[KeyboardButton(BTN_PREV)], [KeyboardButton(BTN_RESTART)], [KeyboardButton(BTN_CANCEL)]]
    else:
        rows = [[KeyboardButton(a)] for a in screen["valid_answers"]]
        if screen["help"]:
            rows.append([KeyboardButton(BTN_HELP)])
        if screen["why"]:
            rows.append([KeyboardButton(BTN_WHY)])
        if screen["can_prev"]:
            rows.append([KeyboardButton(BTN_PREV)])
        rows.append([KeyboardButton(BTN_CANCEL)])
    return ReplyKeyboardMarkup(rows, resize_keyboard=True)


async def _render(update, screen):
    kwargs = {"reply_markup": _keyboard(screen)}
    if screen["state"] == "final":
        kwargs.update(parse_mode=ParseMode.MARKDOWN, disable_web_page_preview=True)
    await update.message.reply_text(screen["display"], **kwargs)


async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Welcome message on /start."""
    session = get_session(update.effective_chat.id)
    session.reset()
    await update.message.reply_text(session.tr("Hello %s! 🤖") % update.effective_user.first_name,
                                    reply_markup=ReplyKeyboardRemove())
    await update.message.reply_text(session.initial_display())


async def new(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Start a new consultation on /new."""
    session = get_session(update.effective_chat.id)
    await _render(update, session.new())


async def set_backend(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Switch the reasoning backend on /cf or /fuzzy."""
    backend = update.message.text.lstrip("/").split("@")[0]
    session = get_session(update.effective_chat.id)
    session.backend = backend
    session.reset()
    await update.message.reply_text(session.tr("Backend set to *%s*. Press /new to start.") % backend,
                                    parse_mode=ParseMode.MARKDOWN)


async def set_lang(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Switch the output language on /en or /it (English is the base)."""
    lang = update.message.text.lstrip("/").split("@")[0]
    session = get_session(update.effective_chat.id)
    session.lang = lang
    session.reset()
    await update.message.reply_text(session.tr("Language set to *%s*. Press /new to start.") % lang,
                                    parse_mode=ParseMode.MARKDOWN)


async def handle_event(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Drive the dialogue from the button/text the user sent."""
    session = get_session(update.effective_chat.id)
    response = update.message.text
    screen = session.screen()

    if response in screen["valid_answers"]:
        await _render(update, session.answer(response))
    elif response == BTN_HELP and screen["help"]:
        await _send_help(update, screen["help"])
    elif response == BTN_WHY and screen["why"]:
        await update.message.reply_text(screen["why"], parse_mode=ParseMode.MARKDOWN)
    elif response == BTN_PREV:
        await _render(update, session.back())
    elif response == BTN_RESTART:
        await _render(update, session.new())
    elif response == BTN_CANCEL:
        session.cancel()
        await update.message.reply_text(session.tr("Bye! I hope we can talk again some day. 👋🏻"),
                                        reply_markup=ReplyKeyboardRemove())
    else:
        await update.message.reply_text(session.tr("Sorry, I didn't get that. Press a button or /new."))


async def _send_help(update, help_text):
    """Help text may embed _Label_(image-url) links -> inline image buttons."""
    patterns = re.findall(r"_.+?_\(.*?\)", help_text)
    if not patterns:
        await update.message.reply_text(help_text, parse_mode=ParseMode.MARKDOWN)
        return
    keyboard = [[InlineKeyboardButton(re.findall(r"_(.+?)_", p)[0],
                                      callback_data=re.findall(r"\((.*?)\)", p)[0])]
                for p in patterns]
    for link in re.findall(r"\(.*?\)", help_text):
        help_text = help_text.replace(link, "")
    await update.message.reply_text(help_text, parse_mode=ParseMode.MARKDOWN,
                                    reply_markup=InlineKeyboardMarkup(keyboard))


async def image_button(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Send a help image when its inline button is pressed."""
    query = update.callback_query
    await query.answer()
    await context.bot.send_photo(chat_id=query.message.chat_id, photo=query.data)


async def unknown(update: Update, context: ContextTypes.DEFAULT_TYPE):
    session = get_session(update.effective_chat.id)
    await update.message.reply_text(session.tr("Unrecognized command. Say what?"))


async def on_error(update: object, context: ContextTypes.DEFAULT_TYPE):
    logger.warning("Update %s caused error %s", update, context.error)


def main():
    token = os.environ.get("TOKEN") or os.environ.get("TELEGRAM_TOKEN")
    if not token:
        raise SystemExit("Set the TOKEN (or TELEGRAM_TOKEN) environment variable.")

    app = Application.builder().token(token).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(CommandHandler("new", new))
    app.add_handler(CommandHandler(["cf", "fuzzy"], set_backend))
    app.add_handler(CommandHandler(["en", "it"], set_lang))
    app.add_handler(MessageHandler(filters.COMMAND, unknown))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_event))
    app.add_handler(CallbackQueryHandler(image_button))
    app.add_error_handler(on_error)

    app.run_polling()  # long polling; webhook can be added for production


if __name__ == "__main__":
    main()
