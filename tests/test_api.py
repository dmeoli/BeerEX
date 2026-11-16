#!/usr/bin/env python3
"""
Web API test: drives full dialogues through POST /step (FastAPI TestClient),
replaying the growing list of answers as the web client does.

Author: Donato Meoli
"""
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)

from fastapi.testclient import TestClient  # noqa: E402

from beerex_api import app  # noqa: E402

CLIENT = TestClient(app)


def _step(answers, lang="en", backend="fuzzy", seed=0):
    r = CLIENT.post("/step", json={"lang": lang, "backend": backend, "answers": answers, "seed": seed})
    assert r.status_code == 200, r.text
    return r.json()


def _dialogue(lang, backend, pick=0):
    """Answer option `pick` of every question until the result."""
    answers, screen = [], _step([], lang, backend)
    while screen["kind"] == "question":
        assert screen["step"] == len(answers) and screen["options"], screen
        answers.append(screen["options"][min(pick, len(screen["options"]) - 1)]["value"])
        screen = _step(answers, lang, backend)
        assert len(answers) < 40, "dialogue did not reach a result"
    return answers, screen


def test_health():
    assert CLIENT.get("/").json() == {"ok": True}


def test_full_dialogues():
    for lang in ("en", "it"):
        for backend in ("cf", "fuzzy"):
            _, res = _dialogue(lang, backend, pick=-1)
            assert res["kind"] == "result" and res["title"] and res["text"], res
            if backend == "fuzzy":
                assert res["items"], res
                for it in res["items"]:
                    assert it["name"] and it["url"].startswith("https://") and it["score"].endswith("%")
            word = "selezionato" if lang == "it" else "selected"
            assert not res["items"] or word in res["title"], res["title"]


def test_italian_labels():
    answers, labels = [], {}
    screen = _step([], "it")
    while screen["kind"] == "question":
        labels.update((o["value"], o["label"]) for o in screen["options"])
        answers.append(screen["options"][0]["value"])
        screen = _step(answers, "it")
    assert "Ho selezionato" in screen["title"] or "Spiacente" in screen["title"], screen["title"]
    assert any(v != la for v, la in labels.items()), "option labels not localized"
    assert labels.get("yes", "sì") == "sì"


def test_undo_and_replay_are_deterministic():
    answers, res = _dialogue("en", "fuzzy", pick=1)
    assert _step(answers) == res
    back = _step(answers[:-1])
    assert back["kind"] == "question" and back["step"] == len(answers) - 1
    assert answers[-1] in [o["value"] for o in back["options"]]


def test_invalid_requests():
    first = _step([])
    r = CLIENT.post("/step", json={"answers": ["no-such-answer"]})
    assert r.status_code == 400 and first["id"] in r.json()["detail"]
    answers, _ = _dialogue("en", "fuzzy")
    assert CLIENT.post("/step", json={"answers": answers + ["yes"]}).status_code == 400
    assert CLIENT.post("/step", json={"lang": "fr"}).status_code == 400
    assert CLIENT.post("/step", json={"answers": ["x"] * 100}).status_code == 400
    assert CLIENT.post("/step", content=b"{" + b" " * 10000 + b"}",
                       headers={"content-type": "application/json"}).status_code == 413


def test_cors():
    r = CLIENT.options("/step", headers={"Origin": "https://dmeoli.github.io",
                                         "Access-Control-Request-Method": "POST",
                                         "Access-Control-Request-Headers": "content-type"})
    assert r.headers.get("access-control-allow-origin") == "https://dmeoli.github.io"
    r = CLIENT.post("/step", json={}, headers={"Origin": "https://evil.example"})
    assert "access-control-allow-origin" not in r.headers


if __name__ == "__main__":
    for name, fn in list(globals().items()):
        if name.startswith("test_"):
            fn()
    print("API TESTS PASS")
