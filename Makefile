.PHONY: install test test-clips lint run api deploy-api docker-build docker-run build-clips

install:        ## install Python deps
	pip install -r requirements.txt -r requirements-api.txt httpx ruff

lint:           ## lint the Python code
	ruff check BeerEX.bot.py beerex_engine.py beerex_api.py tests/*.py

test:           ## engine and web API tests (clipspy, no token needed)
	python tests/test_engine.py
	python tests/test_api.py

test-clips:     ## CLIPS test suite (needs the clips 6.4.x CLI; see build-clips)
	clips -f tests/test-scoring.clp | grep SCORING
	bash tests/test-cf-vs-fuzzy.sh

run:            ## run the bot (needs TOKEN in the environment)
	python BeerEX.bot.py

api:            ## run the web API locally on port 8781
	uvicorn beerex_api:app --port 8781

deploy-api:     ## build Dockerfile.api with Cloud Build and deploy it to Cloud Run
	gcloud builds submit --project bots-500321 --config deploy/cloudbuild-api.yaml .
	gcloud run deploy beerex --project bots-500321 --region europe-west1 \
	  --image europe-west1-docker.pkg.dev/bots-500321/beerex/api:latest --allow-unauthenticated \
	  --cpu 1 --memory 512Mi --min-instances 0 --max-instances 2 --concurrency 8 --cpu-throttling

build-clips:    ## build the CLIPS 6.4.2 CLI into ~/.local/bin
	bash scripts/build-clips.sh

docker-build:   ## build the Docker image
	docker build -t ghcr.io/dmeoli/beerex:latest .

docker-run:     ## run the bot in Docker (reads .env)
	docker compose up --build
