#!/usr/bin/env python
# coding=utf-8

"""
BeerEX web API: the same dialogue engine as the bot, over HTTP.

Stateless by replay: every POST /step carries the whole list of answers given
so far, the server replays them on a fresh CLIPS environment and returns the
current screen (going back is just sending a shorter list). Run with
`uvicorn beerex_api:app`.

Author: Donato Meoli
"""

import os
from typing import Annotated, Literal

from fastapi import FastAPI, HTTPException, Request
from fastapi.exceptions import RequestValidationError
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from pydantic import BaseModel, Field

from beerex_engine import InvalidAnswer, replay

MAX_ANSWERS = 64       # the longest dialogue is about 15 answers
MAX_BODY = 4096        # bytes
ORIGINS = os.environ.get("BEEREX_ORIGINS", "https://dmeoli.github.io,http://localhost:8780").split(",")


class Step(BaseModel):
    lang: Literal["en", "it"] = "en"
    backend: Literal["cf", "fuzzy"] = "fuzzy"
    answers: list[Annotated[str, Field(max_length=64)]] = Field(default_factory=list, max_length=MAX_ANSWERS)
    seed: int = Field(0, ge=0, le=2**31 - 1)   # fixes the order of the random questions


app = FastAPI(title="BeerEX", docs_url=None, redoc_url=None, openapi_url=None)


@app.middleware("http")
async def limit_body(request: Request, call_next):
    if request.method == "POST":
        size = request.headers.get("content-length")
        if size is None:
            return JSONResponse({"detail": "Content-Length required"}, status_code=411)
        if not size.isdigit() or int(size) > MAX_BODY:
            return JSONResponse({"detail": "request body too large"}, status_code=413)
    return await call_next(request)


# added last, so it wraps the size limit and its errors carry the CORS headers
app.add_middleware(CORSMiddleware, allow_origins=ORIGINS, allow_methods=["GET", "POST"],
                   allow_headers=["Content-Type"], max_age=86400)


@app.exception_handler(RequestValidationError)
async def bad_request(request: Request, exc: RequestValidationError):
    msg = "; ".join("%s: %s" % (".".join(str(x) for x in e["loc"][1:]) or "body", e["msg"]) for e in exc.errors())
    return JSONResponse({"detail": msg}, status_code=400)


@app.get("/")
def health():
    return {"ok": True}


@app.post("/step")
def step(req: Step):
    try:
        view = replay(req.answers, lang=req.lang, backend=req.backend, seed=req.seed)
    except InvalidAnswer as e:
        raise HTTPException(status_code=400, detail=str(e)) from None
    view["seed"] = req.seed
    return view
