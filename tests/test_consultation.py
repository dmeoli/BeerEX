#!/usr/bin/env python3
"""
Scripted consultations: answer by the labels the user sees (as a person tapping
buttons would), check the questions are phrased in everyday words in both
languages, and that the bot keyboard carries exactly those labels.

Author: Donato Meoli
"""
import importlib.util
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

import beerex_engine as engine  # noqa: E402

# what a user would tap, by question (the order of the first eight is random)
SCRIPT = {
    "en": {"which-age": "30 or older", "regular-beer-drinker": "Yes, often", "smoker": "No",
           "which-season": "🏖 Summer", "preferred-color": "Light, golden", "preferred-alcohol": "Medium",
           "preferred-carbonation": "Very fizzy", "preferred-flavor": "Bitter",
           "main-meal": "🍕 Pizza", "pizza-topping": "🥓 Meat or cold cuts", "meat-topping-is-spicy": "Yes, spicy"},
    "it": {"which-age": "da 24 a 29", "regular-beer-drinker": "No, ogni tanto", "smoker": "No",
           "which-season": "❄️ Inverno", "preferred-color": "Scura, quasi nera", "preferred-alcohol": "Forti",
           "preferred-carbonation": "Poco", "preferred-flavor": "Tostato, come il caffè",
           "main-meal": "🍰 Un dolce", "which-dessert": "🍫 Al cioccolato", "which-chocolate": "Fondente intenso"},
}

# technical wording that must not reach the user in a question or an option
JARGON = re.compile(r"certaint|certezz|probab|%|>=|μ|\bcf\b|fuzzy|carbonat|alcoholic|entrée|\d+\.\d", re.I)


def _consult(lang, backend):
    answers, view = [], engine.replay([], lang=lang, backend=backend, seed=7)
    asked = []
    while view["kind"] == "question":
        labels = {o["label"]: o["value"] for o in view["options"]}
        label = SCRIPT[lang][view["id"]]
        assert label in labels, (view["id"], label, list(labels))
        asked.append(view["id"])
        answers.append(labels[label])
        view = engine.replay(answers, lang=lang, backend=backend, seed=7)
    assert set(asked) == set(SCRIPT[lang]), set(asked) ^ set(SCRIPT[lang])
    return view


def test_scripted_consultations():
    for backend in ("fuzzy", "cf"):
        res = _consult("en", backend)
        assert res["kind"] == "result" and res["items"], res
        assert "selected" in res["title"] and "reasons" in res["text"], res
        assert backend == "cf" or "Why these beers" in res["text"], res
        res = _consult("it", backend)
        assert res["kind"] == "result" and res["items"], res
        assert "selezionato" in res["title"] and "motivi" in res["text"], res
        assert backend == "cf" or "Perché queste birre" in res["text"], res
        for it in res["items"]:
            assert re.fullmatch(r"\d+%", it["score"]), it


def _all_questions(lang):
    """Every question reachable after the eight profile questions, by relation."""
    seen = {}

    def walk(answers):
        view = engine.replay(answers, lang=lang, seed=0)
        if view["kind"] != "question":
            return
        seen.setdefault(view["id"], view)
        values = [o["value"] for o in view["options"]]
        for v in values[:1] if len(answers) < 8 else values:
            walk(answers + [v])
    walk([])
    return seen


def test_questions_are_plain_and_translated():
    en, it = _all_questions("en"), _all_questions("it")
    assert set(en) == set(it) and len(en) >= 40, len(en)
    for rel, q in en.items():
        texts = [q["text"]] + [o["label"] for o in q["options"]]
        for t in texts + [it[rel]["text"]] + [o["label"] for o in it[rel]["options"]]:
            assert not JARGON.search(t), (rel, t)
        assert all(o["label"] != o["value"] or o["value"][0].isupper() for o in q["options"]), (rel, q["options"])
        assert it[rel]["text"] != q["text"], ("untranslated question", rel)
        assert [o["value"] for o in it[rel]["options"]] == [o["value"] for o in q["options"]], rel


def test_bot_keyboard_uses_the_labels():
    spec = importlib.util.spec_from_file_location("beerexbot", os.path.join(ROOT, "BeerEX.bot.py"))
    bot = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(bot)
    session = engine.Session(lang="it", seed=1)
    screen = session.new()
    while screen["state"] != "final":
        rows = bot._keyboard(session, screen).inline_keyboard
        buttons = [r[0] for r in rows[:len(screen["labels"])]]
        assert [b.text for b in buttons] == screen["labels"]
        assert all(len(b.callback_data.encode()) <= 64 for r in rows for b in r)
        extra = [b.callback_data for b in rows[-1]] if len(rows) > len(buttons) else []
        assert ("why" in extra) == bool(screen["why"])
        screen = session.answer(screen["valid_answers"][-1])
    final = [b.callback_data for b in bot._keyboard(session, screen).inline_keyboard[0]]
    assert final == ["back", "new"]


if __name__ == "__main__":
    test_scripted_consultations()
    test_questions_are_plain_and_translated()
    test_bot_keyboard_uses_the_labels()
    print("CONSULTATION TESTS PASS")
