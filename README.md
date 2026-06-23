# BeerEX :beer:

[![CI](https://github.com/dmeoli/BeerEX/actions/workflows/ci.yml/badge.svg)](https://github.com/dmeoli/BeerEX/actions/workflows/ci.yml)
[![Telegram](https://img.shields.io/badge/Telegram-%40BeerEXpertBot-26A5E4?logo=telegram&logoColor=white)](https://t.me/BeerEXpertBot)
[![Technical report](https://img.shields.io/badge/report-PDF-b31b1b?logo=adobeacrobatreader&logoColor=white)](doc/BeerEX.pdf)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

*"Beer is proof that God loves us and wants us to be happy."* (Benjamin Franklin)

**BeerEX** is a rule-based expert system, available as a [Telegram bot](https://t.me/BeerEXpertBot),
that suggests a beer to drink according to your taste and meal. It reasons over a
knowledge base of beer styles built from authoritative craft-beer sources, and can
explain *why* it asks each question and *how* it reached every recommendation.

It was developed during the Knowledge Engineering course @
[University of Bari "Aldo Moro"](http://www.uniba.it/) (prof.
[Floriana Esposito](http://lacam.di.uniba.it/people/FlorianaEsposito.html)) and
revised during the Artificial Intelligence Fundamentals course @
[University of Pisa](https://www.unipi.it/index.php/english).

The knowledge base is built from [CraftBeer.com](https://www.craftbeer.com)
material (published by the [Brewers Association](https://www.brewersassociation.org/)):
the **2017 Beer Styles Study Guide** and the **Beer & Food Course**.

## Highlights

- **Two reasoning backends, switchable at runtime** (`/cf` · `/fuzzy`):
  - **Certainty Factors** — the classic MYCIN-style evidence combination;
  - **Fuzzy logic** — data-grounded membership functions (colour↔SRM, alcohol↔ABV,
    bitterness↔IBU) derived from real style data, scored with a reusable pure-CLIPS
    fuzzy library.
- **Comprehensive, data-grounded knowledge base** mined from the CraftBeer guides:
  per-style numeric ranges (ABV/IBU/SRM/OG/FG/CO₂), qualitative profile (palate,
  hop, malt, serving temperature, glassware) and authoritative **food pairings**
  (cheese / entrée / dessert).
- **Transparent, per-beer explanations** ("pale colour μ1.00, high bitterness μ0.50,
  matches its CraftBeer pairing").
- **Reusable fuzzy library** — [`dmeoli/FuzzyCLIPS`](https://github.com/dmeoli/FuzzyCLIPS),
  fuzzy logic written in pure CLIPS, validated against the original FuzzyCLIPS engine,
  vendored here as a git submodule.
- **Modern, async Telegram bot** (python-telegram-bot v21) with one isolated CLIPS
  environment per chat (safe under concurrency), Docker image and CI.
- **Optional localization** (gettext-style): English is the base; an Italian overlay
  is selectable with `/en` · `/it` and falls back to English where untranslated.

## Architecture

```
            Telegram bot (async)  /  CLIPS CLI
                       │  one CLIPS env per user
                       ▼
   dialogue ── questions ──► best-* evidence ──► selection backend
   (dialog.clp) (beer-questions) (beer-knowledge)   ├─ cf    : combine-CFs
                                                     └─ fuzzy : membership + scoring
                       │                                   (beer-fuzzy.clp + FuzzyCLIPS)
                       ▼
        top beers + data-grounded explanation + serving info
```

| File | Responsibility |
| --- | --- |
| `clips/beerex.clp` | Templates, globals, CF selection, core |
| `clips/dialog.clp` | Dialogue state machine (question/answer, back/retract) |
| `clips/beer-questions.clp` | The questions asked to the user |
| `clips/beer-knowledge.clp` | Expert rules → `best-*` evidence |
| `clips/beer-styles.fct` | Symbolic style dataset |
| `clips/beer-ranges.clp` | Numeric ranges per style (fuzzy membership data) |
| `clips/beer-data.clp` | Full per-style profile + authoritative food pairings |
| `clips/beer-fuzzy.clp` | Fuzzy backend: membership functions, scoring, CF→fuzzy bridge |
| `clips/beerex-fuzzy.clp` | Wires the fuzzy backend into the selection stage |
| `third_party/FuzzyCLIPS/` | The reusable pure-CLIPS fuzzy library (submodule) |
| `scripts/extract_*.py` | Reproducible KB extraction from the CraftBeer sources |
| `BeerEX.bot.py` | Telegram bot (PTB v21, one CLIPS session per chat) |
| `BeerEX.clp` | CLI entry point |

## Quickstart

### Telegram bot — Docker (recommended)

```bash
git clone --recurse-submodules https://github.com/DonatoMeoli/BeerEX.git
cd BeerEX
cp .env.example .env          # put your @BotFather TOKEN in .env
docker compose up --build
```

### Telegram bot — local (Python 3.12)

```bash
git submodule update --init                 # fetch the fuzzy library
python3.12 -m venv .venv && . .venv/bin/activate
pip install -r requirements.txt
export TOKEN=<your-telegram-bot-token>
python BeerEX.bot.py
```

> Use Python 3.12: `clipspy` and `python-telegram-bot` do not support 3.13+ yet.

### Bot commands

| Command | Action |
| --- | --- |
| `/start` | Greet and show how it works |
| `/new` | Start a new consultation |
| `/cf` · `/fuzzy` | Switch the reasoning backend (CF / fuzzy) |
| `/en` · `/it` | Switch the output language (English base / Italian overlay) |

> `/cf`, `/fuzzy`, `/en` and `/it` take effect on the next `/new`. English is
> always the base; Italian is an overlay that falls back to English where untranslated.

### Command-line REPL

The bot needs no system CLIPS (`clipspy` bundles it), but the CLI does:

```bash
bash scripts/build-clips.sh    # builds CLIPS 6.4.2 into ~/.local/bin
clips -f BeerEX.clp
```

## Testing

```bash
make test                      # engine smoke test over clipspy (no token needed)
make test-clips                # the CLIPS test suite (needs the clips 6.4.x CLI)
```

The reusable fuzzy library carries its own **differential tests** against the
original FuzzyCLIPS engine (`third_party/FuzzyCLIPS/tests/diff_test.sh`).

## Deployment

GitHub can't host a long-running bot, but CI publishes the image to **GHCR**
(`ghcr.io/dmeoli/beerex`); run it on any small host (VPS, Fly.io, Railway, a
Raspberry Pi) with `docker run` or `docker compose up`.

## License [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Released under the MIT License. See the [LICENSE](LICENSE) file for details.
