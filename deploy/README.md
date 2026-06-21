# Deploy — remote host with auto-update on push

This stack runs the BeerEX bot on an always-on Docker host and keeps it up to date
automatically: every `git push` to `master` makes CI publish a fresh image to
GHCR, and **Watchtower** on the host pulls it and restarts the container within
the poll interval.

```
push → GitHub Actions → ghcr.io/dmeoli/beerex:latest → Watchtower → live
```

GitHub itself cannot host a long-running polling bot, so you need one small
always-on machine. The bot is tiny (idle most of the time), so the cheapest tier
of anything works.

## Choosing the host

Use any **amd64** Linux box with Docker (CI publishes `linux/amd64` images):

| Option | Cost | Notes |
| --- | --- | --- |
| **Oracle Cloud "Always Free" (AMD `E2.1.Micro`)** | free forever | 1 GB RAM, amd64. Recommended. |
| **Cheap VPS** (Hetzner CX22, etc.) | ~€4/mo | simplest, rock-solid |
| **Raspberry Pi / any ARM box** | own hardware | ARM: CI images are amd64-only — add `linux/arm64` to the CI first |

## One-time setup on the host

```bash
# 1. install Docker + compose plugin (Debian/Ubuntu)
curl -fsSL https://get.docker.com | sh

# 2. get this folder onto the host (clone the repo, or just copy deploy/)
git clone https://github.com/dmeoli/BeerEX.git && cd BeerEX/deploy

# 3. token
cp .env.example .env && nano .env        # paste the @BotFather token

# 4. if the GHCR package is PRIVATE, log in once so pulls work
#    (create a GitHub PAT with read:packages). Skip if the package is public.
echo "$GHCR_PAT" | docker login ghcr.io -u dmeoli --password-stdin

# 5. start (detached)
docker compose up -d
```

That's it. Check it: `docker compose logs -f`. From now on, just push — the host
updates itself.

> Running another bot on the same host? Keep its stack in its own repo/folder with
> its own compose; the container names here (`beerex-bot`, `beerex-watchtower`) are
> unique so the two stacks don't collide.

## Making the GHCR package public (optional, simplest)

To avoid managing a PAT on the host, set the package to public once: GitHub →
profile → Packages → `beerex` → Package settings → Change visibility → Public.
Then step 4 is unnecessary and the `config.json` volume is ignored.

## Operating

- Logs: `docker compose logs -f beerex-bot` (or `beerex-watchtower`)
- Manual update now: `docker compose pull && docker compose up -d`
- Stop: `docker compose down`
- `restart: unless-stopped` brings the bot back after a reboot.
