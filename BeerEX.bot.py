#!/usr/bin/env python
# coding=utf-8

"""
BeerEX: the Beer EXpert system bot.
This expert system suggests a beer to drink according to taste and meal.

Author: Donato Meoli
"""

import logging
import os
import re

from emoji import emojize
from telegram import (ReplyKeyboardRemove, KeyboardButton, ReplyKeyboardMarkup,
                      InlineKeyboardMarkup, InlineKeyboardButton, ParseMode)
from telegram.ext import MessageHandler, CommandHandler, CallbackQueryHandler, Filters, Updater

import clips

# Enable logging
logging.basicConfig(format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
                    level=logging.INFO)

logger = logging.getLogger(__name__)

env = clips.Environment()


def start(update, context):
    """
    Sends a welcome message when the command /start is issued.
    """

    env.reset()
    env.run()
    update.message.reply_text(text='Hello %s! 🤖' % update.message.from_user.first_name,
                              reply_markup=ReplyKeyboardRemove())
    update.message.reply_text(env.eval('(find-fact ((?u UI-state)) (eq ?u:state initial))')[0]['display'])


def new(update, context):
    """
    Starts a new chat with the beer expert when the command /new is issued.
    """

    env.reset()
    env.run()
    nextUIState(context.bot, update)


def nextUIState(bot, update):
    """
    Re-creates the dialog window to match the current state in working memory.
    """

    current_id = env.eval('(find-fact ((?s state-list)) TRUE)')[0]['current']
    current_ui = env.eval('(find-fact ((?u UI-state)) (eq ?u:id %s))' % current_id)
    state = current_ui[0]['state']
    if state == 'initial':
        env.assert_string('(next %s)' % current_id)
        env.run()
        nextUIState(bot, update)
    elif state == 'final':
        keyboard = [[KeyboardButton(text=emojize(':back: Previous', language='alias'))],
                    [KeyboardButton(text=emojize(':repeat: Restart', language='alias'))],
                    [KeyboardButton(text=emojize(':x: Cancel', language='alias'))]]
        update.message.reply_text(text=current_ui[0]['display'],
                                  parse_mode=ParseMode.MARKDOWN,
                                  disable_web_page_preview=True,
                                  reply_markup=ReplyKeyboardMarkup(keyboard))
    else:
        keyboard = list()
        for answer in current_ui[0]['valid-answers']:
            keyboard.append([KeyboardButton(text=answer)])
        if current_ui[0]['help']:
            keyboard.append([KeyboardButton(text=emojize(':sos: Help', language='alias'))])
        if current_ui[0]['why']:
            keyboard.append([KeyboardButton(text=emojize(':question: Why', language='alias'))])
        if len(env.eval('(find-fact ((?s state-list)) TRUE)')[0]['sequence']) > 2:
            keyboard.append([KeyboardButton(text=emojize(':back: Previous', language='alias'))])
        keyboard.append([KeyboardButton(text=emojize(':x: Cancel', language='alias'))])
        update.message.reply_text(text=current_ui[0]['display'],
                                  reply_markup=ReplyKeyboardMarkup(keyboard))


def handleEvent(update, context):
    """
    Triggers the next state in working memory based on which button is pressed.
    """

    current_id = env.eval('(find-fact ((?s state-list)) TRUE)')[0]['current']
    current_ui = env.eval('(find-fact ((?u UI-state)) (eq ?u:id %s))' % current_id)
    response = update.message.text
    if response in current_ui[0]['valid-answers']:
        if len(response.split(' ')) > 1:
            env.assert_string('(next %s "%s")' % (current_id, response))
        else:
            env.assert_string('(next %s %s)' % (current_id, response))
        env.run()
        nextUIState(context.bot, update)
    elif response == emojize(':sos: Help', language='alias'):
        help = current_ui[0]['help']
        if not re.findall('_.+?_\(.*?\)', help):
            update.message.reply_text(text=help,
                                      parse_mode=ParseMode.MARKDOWN)
        else:
            keyboard = list()
            for pattern in re.findall('_.+?_\(.*?\)', help):
                keyboard.append([InlineKeyboardButton(text=re.findall('_(.+?)_', pattern)[0],
                                                      callback_data=re.findall('\((.*?)\)', pattern)[0])])
            for link in re.findall('\(.*?\)', help):
                help = help.replace(link, '')
            update.message.reply_text(text=help,
                                      parse_mode=ParseMode.MARKDOWN,
                                      reply_markup=InlineKeyboardMarkup(keyboard))
    elif response == emojize(':question: Why', language='alias'):
        update.message.reply_text(text=current_ui[0]['why'],
                                  parse_mode=ParseMode.MARKDOWN)
    elif response == emojize(':back: Previous', language='alias'):
        env.assert_string('(prev %s)' % current_id)
        env.run()
        nextUIState(context.bot, update)
    elif response == emojize(':repeat: Restart', language='alias'):
        new(update, context)
    elif response == emojize(':x: Cancel', language='alias'):
        env.reset()
        update.message.reply_text(text='Bye! I hope we can talk again some day. 👋🏻',
                                  reply_markup=ReplyKeyboardRemove())


def imageButton(update, context):
    """
    Sends help images based on which button is pressed.
    """

    query = update.callback_query
    context.bot.send_photo(chat_id=query.message.chat_id,
                           photo=query.data)


def unknown(update, context):
    """
    Sends an error message when an unrecognized command is typed.
    """

    context.bot.send_message(chat_id=update.message.chat_id,
                             text='Unrecognized command. Say what?')


def error(update, context):
    """
    Log errors caused by updates.
    """

    logger.warning('Update %s caused error %s', update, context.error)


def main():
    """
    Run bot.
    """

    # Load the Beer EXpert system
    env.load('clips/beerex.clp')

    # Get the Telegram Bot Authorization Token
    token = os.environ.get('TOKEN')

    # Create the updater and pass it the bot's token
    updater = Updater(token)

    # Get the dispatcher to register handlers
    dispatcher = updater.dispatcher

    # Handler registers
    dispatcher.add_handler(CommandHandler('start', start))
    dispatcher.add_handler(CommandHandler('new', new))
    dispatcher.add_handler(MessageHandler(Filters.command, unknown))
    dispatcher.add_handler(MessageHandler(Filters.text, handleEvent))
    dispatcher.add_handler(CallbackQueryHandler(imageButton))

    # Log all errors
    dispatcher.add_error_handler(error)

    # Start the bot
    updater.start_webhook(listen='0.0.0.0',
                          port=int(os.environ.get('PORT', '5000')),
                          url_path=token,
                          webhook_url='https://beerex-telegram-bot.herokuapp.com/' + token)
    # updater.start_polling()  # to run in local enable this and comment the previous line

    # Run the bot until you press Ctrl-C or the process receives SIGINT, SIGTERM or SIGABRT. This should
    # be used most of the time, since start_polling() is non-blocking and will stop the bot gracefully.
    updater.idle()


if __name__ == '__main__':
    main()
