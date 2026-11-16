#!/usr/bin/env python
# coding=utf-8

"""
BeerEX: the Beer EXpert system bot.

A rule-based expert system (CLIPS) that suggests a beer to drink according to
taste and meal, exposed as a Telegram bot.

Each chat gets its OWN CLIPS environment (a beerex_engine.Session) so concurrent
users never share working memory. Built on python-telegram-bot v21 (async).

Author: Donato Meoli
"""

import logging
import os

from telegram import BotCommand, InlineKeyboardButton, InlineKeyboardMarkup, Update
from telegram.constants import ParseMode
from telegram.error import BadRequest
from telegram.ext import (
    Application,
    CallbackQueryHandler,
    CommandHandler,
    ContextTypes,
    MessageHandler,
    filters,
)

from beerex_engine import Session

logging.basicConfig(format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
                    level=logging.INFO)
logger = logging.getLogger(__name__)
# httpx logs every request URL at INFO, and the URL carries the bot token
logging.getLogger("httpx").setLevel(logging.WARNING)
logging.getLogger("httpcore").setLevel(logging.WARNING)

# chat_id -> Session  (each user keeps their own working memory)
SESSIONS: dict[int, Session] = {}
MAX_SESSIONS = 5000


def get_session(update):
    chat_id = update.effective_chat.id
    session = SESSIONS.get(chat_id)
    if session is None:
        if len(SESSIONS) >= MAX_SESSIONS:
            SESSIONS.pop(next(iter(SESSIONS)))  # evict oldest
        user = update.effective_user
        lang = "it" if user and (user.language_code or "").startswith("it") else "en"
        session = SESSIONS[chat_id] = Session(lang=lang)
    return session


def _button(text, data):
    return InlineKeyboardButton(text, callback_data=data)


def _keyboard(session, screen):
    """Inline keyboard of a screen: one button per answer, then why/help/back."""
    if screen["state"] == "final":
        return InlineKeyboardMarkup([[_button(session.tr("◀️ Back"), "back"),
                                      _button(session.tr("🔄 Start over"), "new")]])
    # the relation in the payload lets a tap on an old message be recognized as stale
    rows = [[_button(label, ("a:%d:%s" % (i, screen["relation"]))[:64])]
            for i, label in enumerate(screen["labels"])]
    extra = []
    if screen["why"]:
        extra.append(_button(session.tr("❓ Why"), "why"))
    if screen["help"]:
        extra.append(_button(session.tr("ℹ️ What do these mean?"), "help"))
    if screen["can_prev"]:
        extra.append(_button(session.tr("◀️ Back"), "back"))
    if extra:
        rows.append(extra)
    return InlineKeyboardMarkup(rows)


def _welcome_keyboard(session):
    other = _button("🇬🇧 English", "lang:en") if session.lang == "it" else _button("🇮🇹 Italiano", "lang:it")
    return InlineKeyboardMarkup([[_button(session.tr("🍺 Start"), "new"), other]])


async def _render(chat, session, screen):
    kwargs = {"reply_markup": _keyboard(session, screen)}
    if screen["state"] == "final":
        kwargs.update(parse_mode=ParseMode.MARKDOWN, disable_web_page_preview=True)
    await chat.send_message(screen["display"], **kwargs)


async def _welcome(chat, session, name=None):
    session.reset()
    text = session.initial_display()
    if name:
        text = session.tr("Hello %s! 🤖") % name + "\n\n" + text
    await chat.send_message(text, reply_markup=_welcome_keyboard(session))


async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Greet on /start and offer to begin."""
    await _welcome(update.effective_chat, get_session(update), update.effective_user.first_name)


async def new(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Start a new consultation on /new."""
    session = get_session(update)
    await _render(update.effective_chat, session, session.new())


async def set_backend(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Switch the reasoning backend on /cf or /fuzzy."""
    backend = update.message.text.lstrip("/").split("@")[0]
    session = get_session(update)
    session.backend = backend
    session.reset()
    await update.message.reply_text(session.tr("Backend set to *%s*. Press /new to start.") % backend,
                                    parse_mode=ParseMode.MARKDOWN,
                                    reply_markup=InlineKeyboardMarkup([[_button(session.tr("🍺 Start"), "new")]]))


async def set_lang(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Switch the language on /en or /it (English is the base)."""
    session = get_session(update)
    session.lang = update.message.text.lstrip("/").split("@")[0]
    await _welcome(update.effective_chat, session)


async def _close(query, suffix=None):
    """Drop the keyboard of the message just used, noting the chosen answer."""
    try:
        if suffix and query.message.text:
            await query.edit_message_text(query.message.text + "\n\n" + suffix)
        else:
            await query.edit_message_reply_markup(None)
    except BadRequest:
        pass   # already edited, or too old to edit


async def on_button(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Drive the dialogue from the inline button pressed."""
    query = update.callback_query
    chat = update.effective_chat
    session = get_session(update)
    data = query.data or ""
    screen = session.screen()

    if data.startswith("a:"):
        idx = int(data.split(":")[1])
        if screen["state"] == "final" or idx >= len(screen["valid_answers"]) \
                or data != ("a:%d:%s" % (idx, screen["relation"]))[:64]:
            await query.answer(session.tr("This question is no longer active."))
            return
        await query.answer()
        await _close(query, "➡️ " + screen["labels"][idx])
        await _render(chat, session, session.answer(screen["valid_answers"][idx]))
    elif data == "why" and screen["state"] != "final" and screen["why"]:
        await query.answer()
        await chat.send_message(screen["why"], parse_mode=ParseMode.MARKDOWN)
    elif data == "help" and screen["state"] != "final" and screen["help"]:
        await query.answer()
        await chat.send_message(screen["help"], parse_mode=ParseMode.MARKDOWN)
    elif data == "back":
        await query.answer()
        await _close(query)
        await _render(chat, session, session.back())
    elif data == "new":
        await query.answer()
        await _close(query)
        await _render(chat, session, session.new())
    elif data.startswith("lang:"):
        await query.answer()
        session.lang = data.split(":", 1)[1]
        await _close(query)
        await _welcome(chat, session)
    else:
        await query.answer()


async def on_text(update: Update, context: ContextTypes.DEFAULT_TYPE):
    session = get_session(update)
    await update.message.reply_text(session.tr("Sorry, I didn't get that. Press a button or /new."))


async def unknown(update: Update, context: ContextTypes.DEFAULT_TYPE):
    session = get_session(update)
    await update.message.reply_text(session.tr("I don't know that command. Tap /new to start."))


async def on_error(update: object, context: ContextTypes.DEFAULT_TYPE):
    logger.warning("Update %s caused error %s", update, context.error)


async def post_init(app: Application):
    await app.bot.set_my_commands([
        BotCommand("new", "Start a new consultation"),
        BotCommand("start", "What this bot does"),
        BotCommand("it", "Italiano"),
        BotCommand("en", "English"),
        BotCommand("fuzzy", "Fuzzy reasoning (default)"),
        BotCommand("cf", "Certainty-factor reasoning"),
    ])


def main():
    token = os.environ.get("TOKEN") or os.environ.get("TELEGRAM_TOKEN")
    if not token:
        raise SystemExit("Set the TOKEN (or TELEGRAM_TOKEN) environment variable.")

    app = Application.builder().token(token).post_init(post_init).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(CommandHandler("new", new))
    app.add_handler(CommandHandler(["cf", "fuzzy"], set_backend))
    app.add_handler(CommandHandler(["en", "it"], set_lang))
    app.add_handler(MessageHandler(filters.COMMAND, unknown))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, on_text))
    app.add_handler(CallbackQueryHandler(on_button))
    app.add_error_handler(on_error)

    app.run_polling()  # long polling; webhook can be added for production


if __name__ == "__main__":
    main()
