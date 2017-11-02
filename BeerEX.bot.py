# coding=utf-8

from telegram.ext import Updater, CommandHandler, Filters, MessageHandler
import clips


def start(bot, update):
    """
    Loads the Beer EXpert system and prints a welcome message.
    """

    clips.Load("./clips/beerex.clp")

    update.message.reply_text('Hello {}!'.format(update.message.from_user.first_name) + ' 🤖 \n' + 'Welcome to the ' +
                              'Beer EXpert system 🍻' + '\n\n' + '⁉️ All I need is that you answer simple questions ' +
                              'by choosing one of the responses that are offered to you.' + '\n\n' + 'To start, ' +
                              'please press the /run button 😄')


def run(bot, update):

    clips.Reset()
    clips.Run()

    nextUIState(bot, update)


def nextUIState(bot, update):

    # Get the state-list
    factlist = clips.Eval("(find-all-facts ((?f state-list)) TRUE)")
    if len(factlist) == 0:
        return

    currentID = factlist[0].Slots["current"]

    # Get the current UI state
    factlist = clips.Eval("(find-all-facts ((?f UI-state)) (eq ?f:id %s))" % (currentID))
    if len(factlist) == 0:
        return

    # Set up the choices
    valid_answers = factlist[0].Slots["valid-answers"]
    selected = factlist[0].Slots["response"]


def unknown(bot, update):
    bot.send_message(update.message.chat_id, "Sorry, I didn't understand that command.")


file = open("token", "r")
token = file.read()
updater = Updater(token)

updater.dispatcher.add_handler(CommandHandler('start', start))
updater.dispatcher.add_handler(CommandHandler('run', run))
updater.dispatcher.add_handler(MessageHandler(Filters.command, unknown))

updater.start_polling()
updater.idle()
