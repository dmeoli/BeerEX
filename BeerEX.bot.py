#!/usr/bin/env python
# coding=utf-8

"""
BeerEX: the Beer EXpert system bot.
This expert system suggests a beer to drink according to taste and meal.

Author: Donato Meoli
"""

from telegram import ReplyKeyboardRemove, KeyboardButton, ReplyKeyboardMarkup, \
    InlineKeyboardMarkup, InlineKeyboardButton, ParseMode
from telegram.ext import MessageHandler, CommandHandler, CallbackQueryHandler, Filters, Updater
from emoji import emojize
import logging
import clips
import sys
import re
import os

# Enable logging
logging.basicConfig(format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
                    level=logging.INFO)

logger = logging.getLogger(__name__)


def start(bot, update):
    """
    Sends a welcome message when the command /start is issued.
    """

    clips.Reset()
    clips.Run()
    update.message.reply_text(text='Hello %s! 🤖' % update.message.from_user.first_name,
                              reply_markup=ReplyKeyboardRemove())
    update.message.reply_text(clips.Eval('(find-fact ((?u UI-state)) (eq ?u:state initial))')[0].Slots['display'])


def new(bot, update):
    """
    Starts a new chat with the beer expert when the command /new is issued.
    """

    clips.Reset()
    clips.Run()
    nextUIState(bot, update)


def nextUIState(bot, update):
    """
    Re-creates the dialog window to match the current state in working memory.
    """

    current_id = clips.Eval('(find-fact ((?s state-list)) TRUE)')[0].Slots['current']
    current_ui = clips.Eval('(find-fact ((?u UI-state)) (eq ?u:id %s))' % current_id)
    state = current_ui[0].Slots['state']
    if state == 'initial':
        clips.Assert('(next %s)' % current_id)
        clips.Run()
        nextUIState(bot, update)
    elif state == 'final':
        keyboard = [[KeyboardButton(text=emojize(':back: Previous', use_aliases=True))],
                    [KeyboardButton(text=emojize(':repeat: Restart', use_aliases=True))],
                    [KeyboardButton(text=emojize(':x: Cancel', use_aliases=True))]]
        update.message.reply_text(text=current_ui[0].Slots['display'],
                                  parse_mode=ParseMode.MARKDOWN,
                                  disable_web_page_preview=True,
                                  reply_markup=ReplyKeyboardMarkup(keyboard))
    else:
        keyboard = list()
        for answer in current_ui[0].Slots['valid-answers']:
            keyboard.append([KeyboardButton(text=answer)])
        if current_ui[0].Slots['help']:
            keyboard.append([KeyboardButton(text=emojize(':sos: Help', use_aliases=True))])
        if current_ui[0].Slots['why']:
            keyboard.append([KeyboardButton(text=emojize(':question: Why', use_aliases=True))])
        if len(clips.Eval('(find-fact ((?s state-list)) TRUE)')[0].Slots['sequence']) > 2:
            keyboard.append([KeyboardButton(text=emojize(':back: Previous', use_aliases=True))])
        keyboard.append([KeyboardButton(text=emojize(':x: Cancel', use_aliases=True))])
        update.message.reply_text(text=current_ui[0].Slots['display'],
                                  reply_markup=ReplyKeyboardMarkup(keyboard))


def handleEvent(bot, update):
    """
    Triggers the next state in working memory based on which button is pressed.
    """

    current_id = clips.Eval('(find-fact ((?s state-list)) TRUE)')[0].Slots['current']
    current_ui = clips.Eval('(find-fact ((?u UI-state)) (eq ?u:id %s))' % current_id)
    response = update.message.text
    if response in current_ui[0].Slots['valid-answers']:
        if len(response.split(' ')) > 1:
            clips.Assert('(next %s "%s")' % (current_id, response))
        else:
            clips.Assert('(next %s %s)' % (current_id, response))
        clips.Run()
        nextUIState(bot, update)
    elif response == emojize(':sos: Help', use_aliases=True):
        help = current_ui[0].Slots['help']
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
    elif response == emojize(':question: Why', use_aliases=True):
        update.message.reply_text(text=current_ui[0].Slots['why'],
                                  parse_mode=ParseMode.MARKDOWN)
    elif response == emojize(':back: Previous', use_aliases=True):
        clips.Assert('(prev %s)' % current_id)
        clips.Run()
        nextUIState(bot, update)
    elif response == emojize(':repeat: Restart', use_aliases=True):
        new(bot, update)
    elif response == emojize(':x: Cancel', use_aliases=True):
        clips.Reset()
        update.message.reply_text(text='Bye! I hope we can talk again some day. 👋🏻',
                                  reply_markup=ReplyKeyboardRemove())


def imageButton(bot, update):
    """
    Sends help images based on which button is pressed.
    """

    query = update.callback_query
    bot.send_photo(chat_id=query.message.chat_id,
                   photo=query.data)


def unknown(bot, update):
    """
    Sends an error message when an unrecognized command is typed.
    """

    bot.send_message(chat_id=update.message.chat_id,
                     text='Unrecognized command. Say what?')


def error(bot, update, error):
    """
    Log errors caused by updates.
    """

    logger.warning('Update %s caused error %s' % (update, error))


def main():
    """
    Run bot.
    """

    # Set default encoding to utf-8
    reload(sys)
    sys.setdefaultencoding('utf-8')

    # Load the Beer EXpert system
    clips.Load('clips/beerex.clp')

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
    # updater.start_webhook(listen='0.0.0.0',
    #                       port=int(os.environ.get('PORT', '5000')),
    #                       url_path=token)
    # updater.bot.set_webhook('https://beerex-telegram-bot.herokuapp.com/' + token)
    updater.start_polling()

    # Run the bot until you press Ctrl-C or the process receives SIGINT, SIGTERM or SIGABRT. This should
    # be used most of the time, since start_polling() is non-blocking and will stop the bot gracefully.
    updater.idle()


if __name__ == '__main__':
    main()
