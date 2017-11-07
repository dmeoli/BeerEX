#!/usr/bin/env python
# coding=utf-8

from telegram import ReplyKeyboardRemove, KeyboardButton, ReplyKeyboardMarkup, ParseMode
from telegram.ext import MessageHandler, Filters, Updater, CommandHandler
from emoji import emojize
import logging
import clips
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

    # Get the initial UI state
    initial_fact = clips.Eval('(find-fact ((?f UI-state)) (eq ?f:state initial))')

    update.message.reply_text(text='Hello {}! 🤖 '.format(update.message.from_user.first_name),
                              reply_markup=ReplyKeyboardRemove())
    update.message.reply_text(initial_fact[0].Slots['display'])


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

    # Get the state-list
    fact_list = clips.Eval('(find-all-facts ((?f state-list)) TRUE)')
    if len(fact_list) == 0:
        return

    current_id = fact_list[0].Slots['current']

    # Get the current UI state
    fact_list = clips.Eval('(find-all-facts ((?f UI-state)) (eq ?f:id %s))' % current_id)
    if len(fact_list) == 0:
        return

    state = fact_list[0].Slots['state']

    if state == 'initial':
        clips.Assert('(next %s)' % current_id)
        clips.Run()
        nextUIState(bot, update)

    elif state == 'final':
        results = fact_list[0].Slots['display']

        keyboard = [[KeyboardButton(text=emojize(':back: Previous', use_aliases=True))],
                    [KeyboardButton(text=emojize(':repeat: Restart', use_aliases=True))],
                    [KeyboardButton(text=emojize(':x: Cancel', use_aliases=True))]]
        reply_markup = ReplyKeyboardMarkup(keyboard)
        update.message.reply_text(text=results,
                                  parse_mode=ParseMode.MARKDOWN,
                                  disable_web_page_preview=True,
                                  reply_markup=reply_markup)

    else:
        question = fact_list[0].Slots['display']
        valid_answers = fact_list[0].Slots['valid-answers']

        keyboard = []
        for answer in valid_answers:
            keyboard.append([KeyboardButton(text=answer)])
        keyboard.append([KeyboardButton(text=emojize(':back: Previous', use_aliases=True))])
        keyboard.append([KeyboardButton(text=emojize(':x: Cancel', use_aliases=True))])
        reply_markup = ReplyKeyboardMarkup(keyboard)
        update.message.reply_text(text=question, reply_markup=reply_markup)

        dispatcher.add_handler(MessageHandler(Filters.text, handleEvent))


def handleEvent(bot, update):
    """
    Triggers the next state in working memory based on which button was pressed.
    """

    # Get the state-list
    fact_list = clips.Eval('(find-all-facts ((?f state-list)) TRUE)')
    if len(fact_list) == 0:
        return

    current_id = fact_list[0].Slots['current']

    # Get the current UI state
    fact_list = clips.Eval('(find-all-facts ((?f UI-state)) (eq ?f:id %s))' % current_id)
    if len(fact_list) == 0:
        return

    valid_answers = fact_list[0].Slots['valid-answers']

    if update.message.text in valid_answers:
        clips.Assert('(next %s %s)' % (current_id, update.message.text))
        clips.Run()
        nextUIState(bot, update)

    elif update.message.text == emojize(':back: Previous', use_aliases=True):
        clips.Assert('(prev %s)' % current_id)
        clips.Run()
        nextUIState(bot, update)

    elif update.message.text == emojize(':repeat: Restart', use_aliases=True):
        new(bot, update)

    elif update.message.text == emojize(':x: Cancel', use_aliases=True):
        cancel(bot, update)


def cancel(bot, update):
    """
    Ends the chat with the beer expert when the command /cancel is issued.
    """

    update.message.reply_text(text='Bye! I hope we can talk again some day. 👋🏻',
                              reply_markup=ReplyKeyboardRemove())
    clips.Reset()


def unknown(bot, update):
    """
    Sends an error message when an unrecognized command is typed.
    """

    bot.send_message(chat_id=update.message.chat_id, text='Unrecognized command. Say what?')


def error(bot, update, error):
    """
    Log errors caused by updates.
    """

    logger.warning('Update %s caused error %s' % (update, error))


if __name__ == '__main__':

    # Load the Beer EXpert system
    clips.Load('./clips/beerex.clp')

    token = open('token', 'r').read()

    # Create the updater and pass it the bot's token.
    updater = Updater(token)

    # Get the dispatcher to register handlers
    dispatcher = updater.dispatcher

    # Add handlers
    dispatcher.add_handler(CommandHandler('start', start))
    dispatcher.add_handler(CommandHandler('new', new))
    dispatcher.add_handler(CommandHandler('cancel', cancel))
    dispatcher.add_handler(MessageHandler(Filters.command, unknown))

    # Log all errors
    dispatcher.add_error_handler(error)

    updater.start_webhook(listen="0.0.0.0",
                          port=int(os.environ.get('PORT', '5000')),
                          url_path=token)
    updater.bot.set_webhook("https://beerex-telegram-bot.herokuapp.com/" + token)

    # Start the bot
    updater.start_polling()

    # Run the bot until you press Ctrl-C or the process receives SIGINT,
    # SIGTERM or SIGABRT. This should be used most of the time, since
    # start_polling() is non-blocking and will stop the bot gracefully.
    updater.idle()