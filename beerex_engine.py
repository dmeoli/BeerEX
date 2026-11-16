#!/usr/bin/env python
# coding=utf-8

"""
BeerEX dialogue engine, shared by the Telegram bot and the web API.

A Session holds ONE isolated CLIPS environment (so concurrent users never share
working memory) and drives the question/answer dialogue: answer(), back(),
screen(). replay() builds a fresh Session and applies a list of answers in
order, which lets the web API stay stateless.

Author: Donato Meoli
"""

import os
import re
import threading

import clips

BASE = os.path.dirname(os.path.abspath(__file__))

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

BACKENDS = ("cf", "fuzzy")
LANGS = ("en", "it")
DEFAULT_BACKEND = os.environ.get("BEEREX_BACKEND", "fuzzy")  # cf | fuzzy
DEFAULT_LANG = os.environ.get("BEEREX_LANG", "en")          # en (base) | it


def _p(rel):
    return os.path.join(BASE, rel)


def _clean(value):
    """CLIPS unset slots come back as nil/empty; normalise to None."""
    if value is None:
        return None
    s = str(value)
    return None if s in ("", "nil") else s


class InvalidAnswer(ValueError):
    """An answer that is not among the options of the current question."""


class Session:
    """An isolated CLIPS environment driving one user's dialogue.

    The questions of the scenario and preference stages are asked in random
    order; a seed makes the order reproducible (needed to replay answers).
    """

    def __init__(self, backend=DEFAULT_BACKEND, lang=DEFAULT_LANG, seed=None):
        self.backend = backend
        self.lang = lang
        self.seed = seed
        self.env = clips.Environment()
        for f in CORE_FILES:
            self.env.load(_p(f))
        self.env.eval("(undefrule load-beer-question-rules)")
        self.env.load(_p("clips/beer-questions.clp"))
        self.env.eval("(undefrule load-beer-knowledge-rules)")
        self.env.load(_p("clips/beer-knowledge.clp"))
        self.reset()

    def reset(self):
        if self.seed is not None:
            self.env.eval("(seed %d)" % self.seed)
        self.env.reset()
        # (reset) restores defglobals to their default; re-apply backend and language
        self.env.eval("(bind ?*backend* %s)" % self.backend)
        self.env.eval("(bind ?*lang* %s)" % self.lang)
        self.env.run()

    def tr(self, s):
        # Localize a string through the shared CLIPS catalog (English base,
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
            "relation": str(ui["relation-asserted"]),
            "display": ui["display"],
            "help": _clean(ui["help"]),
            "why": _clean(ui["why"]),
            "valid_answers": [str(a) for a in ui["valid-answers"]],
            "labels": self._labels(ui),
            "can_prev": len(self._state_list()["sequence"]) > 2,
        }

    def _labels(self, ui):
        """What the user sees for each answer: the question's own labels (already
        localized by translate-ui), else the localized answer code."""
        values = [str(a) for a in ui["valid-answers"]]
        labels = [str(a) for a in ui["labels"]]
        if len(labels) != len(values):
            labels = [self.tr(a) for a in values]
        return labels

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

    # -- structured view (web API) ------------------------------------------
    def view(self, screen, step):
        """The screen as plain data: a question with its options, or the result."""
        if screen["state"] != "final":
            return {"kind": "question",
                    "id": screen["relation"],
                    "text": screen["display"],
                    "help": screen["help"],
                    "why": screen["why"],
                    "options": [{"value": a, "label": la} for a, la in zip(screen["valid_answers"], screen["labels"])],
                    "multi": False,
                    "step": step}
        return dict(self._parse_result(screen["display"]), kind="result", step=step)

    def _parse_result(self, display):
        # One line per beer: 🍺 [Family - Style](url) — 🌡 temp · 🥃 glass <match> NN%
        item = re.compile(r"🍺 \[(?P<name>[^\]]+)\]\((?P<url>[^)]+)\)(?: — (?P<detail>.*?))?\s+%s\s+(?P<score>\d+%%)"
                          % re.escape(self.tr("match")))
        lines = display.strip().split("\n")
        title = lines[0].strip(" *")
        items, rest = [], []
        for line in lines[1:]:
            m = item.match(line.strip())
            if m:
                url = m["url"] if m["url"].startswith("http") else "https://" + m["url"]
                items.append({"name": m["name"], "url": url, "detail": m["detail"], "score": m["score"]})
            else:
                rest.append(line.rstrip())
        text = "\n".join(rest).strip()
        if not items:
            text = text.strip(" *")
        return {"title": title, "items": items, "text": text}


# The CLIPS random generator behind (seed) is shared by the whole process, so
# a seeded replay must not interleave with another one.
_REPLAY_LOCK = threading.Lock()


def replay(answers, lang=DEFAULT_LANG, backend=DEFAULT_BACKEND, seed=0):
    """Build a fresh session, apply the answers in order, return the current view.

    Raises InvalidAnswer if an answer is not an option of the question it meets.
    """
    if lang not in LANGS:
        raise InvalidAnswer("unknown language %r" % lang)
    if backend not in BACKENDS:
        raise InvalidAnswer("unknown backend %r" % backend)
    with _REPLAY_LOCK:
        session = Session(backend=backend, lang=lang, seed=seed)
        screen = session.new()
        for i, value in enumerate(answers):
            if screen["state"] == "final":
                raise InvalidAnswer("answer %d (%r): the dialogue is already over" % (i + 1, value))
            if value not in screen["valid_answers"]:
                raise InvalidAnswer("answer %d (%r) is not an option of question %r; options: %s"
                                    % (i + 1, value, screen["relation"], ", ".join(screen["valid_answers"])))
            screen = session.answer(value)
        return session.view(screen, len(answers))
