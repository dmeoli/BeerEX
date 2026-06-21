#!/usr/bin/env python3
"""
Engine smoke test for the BeerEX bot.

Drives the bot's CLIPS Session over clipspy (the real production engine path —
clipspy bundles CLIPS 6.4.x) to a recommendation, and checks per-user isolation.
Needs no Telegram token. Run directly (`python tests/test_engine.py`) or via
pytest (functions named test_*).

Author: Donato Meoli
"""
import importlib.util
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def _load_bot():
    spec = importlib.util.spec_from_file_location("beerexbot", os.path.join(ROOT, "BeerEX.bot.py"))
    bot = importlib.util.module_from_spec(spec)
    sys.modules["beerexbot"] = bot
    spec.loader.exec_module(bot)
    return bot


BOT = _load_bot()


def _drive(backend):
    """Answer the first valid option at each step until a recommendation."""
    session = BOT.Session(backend=backend)
    screen = session.new()
    for _ in range(40):
        if screen["state"] == "final":
            return screen["display"]
        screen = session.answer(screen["valid_answers"][0])
    raise AssertionError("dialogue did not reach a recommendation in 40 steps")


def test_fuzzy_recommends():
    out = _drive("fuzzy")
    assert "🍺" in out, "fuzzy backend recommended no beer"
    assert "μ" in out or "Why these beers" in out, "missing data-grounded explanation"


def test_cf_reaches_conclusion():
    out = _drive("cf")
    assert ("🍺" in out) or ("Sorry" in out), "cf backend did not conclude"


def test_sessions_are_isolated():
    a, b = BOT.Session(), BOT.Session()
    a.new()
    b.new()
    assert a.env is not b.env, "sessions must not share a CLIPS environment"


def test_italian_overlay():
    q = '(T "Are you male or female? \U0001F468\U0001F3FB\U0001F469\U0001F3FB")'
    assert "male or female" in str(BOT.Session(lang="en").env.eval(q)), "English is the base"
    assert "Sei uomo o donna" in str(BOT.Session(lang="it").env.eval(q)), "Italian overlay missing"


if __name__ == "__main__":
    test_fuzzy_recommends()
    test_cf_reaches_conclusion()
    test_sessions_are_isolated()
    print("ENGINE TESTS PASS")
