# BeerEX Telegram bot — reproducible image.
# clipspy compiles CLIPS (C) at install time, so the build stage needs a compiler;
# the runtime stage stays slim.
FROM python:3.12-slim AS build
RUN apt-get update && apt-get install -y --no-install-recommends gcc \
    && rm -rf /var/lib/apt/lists/*
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

FROM python:3.12-slim
COPY --from=build /install /usr/local
WORKDIR /app
COPY BeerEX.bot.py .
COPY clips/ ./clips/
# Only the reusable fuzzy library file is needed at runtime (not the dev oracle).
COPY third_party/FuzzyCLIPS/fuzzy.clp ./third_party/FuzzyCLIPS/fuzzy.clp
ENV BEEREX_BACKEND=fuzzy
CMD ["python", "BeerEX.bot.py"]
