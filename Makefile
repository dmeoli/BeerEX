.PHONY: install test test-clips lint run docker-build docker-run build-clips

install:        ## install Python deps
	pip install -r requirements.txt ruff

lint:           ## lint the Python code
	ruff check BeerEX.bot.py tests/test_engine.py

test:           ## engine smoke test (clipspy, no token needed)
	python tests/test_engine.py

test-clips:     ## CLIPS test suite (needs the clips 6.4.x CLI; see build-clips)
	clips -f tests/test-scoring.clp | grep SCORING
	bash tests/test-cf-vs-fuzzy.sh

run:            ## run the bot (needs TOKEN in the environment)
	python BeerEX.bot.py

build-clips:    ## build the CLIPS 6.4.2 CLI into ~/.local/bin
	bash scripts/build-clips.sh

docker-build:   ## build the Docker image
	docker build -t ghcr.io/dmeoli/beerex:latest .

docker-run:     ## run the bot in Docker (reads .env)
	docker compose up --build
