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

from beerex_engine import Session

logging.basicConfig(format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
                    level=logging.INFO)
logger = logging.getLogger(__name__)

# Emoji control buttons (aliases resolved once).
BTN_PREV = emoji.emojize(":back: Previous", language="alias")
BTN_RESTART = emoji.emojize(":repeat: Restart", language="alias")
BTN_CANCEL = emoji.emojize(":x: Cancel", language="alias")
BTN_HELP = emoji.emojize(":sos: Help", language="alias")
BTN_WHY = emoji.emojize(":question: Why", language="alias")


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
