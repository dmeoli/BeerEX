#!/usr/bin/env bash
#
# build-clips.sh - Build the CLIPS 6.4.2 CLI from source into ~/.local/bin, for
# the REPL and the .clp-based tests (tests/test-scoring.clp, tests/test-cf-vs-fuzzy.sh).
# The bot itself does NOT need this — clipspy bundles its own CLIPS 6.4.x.
#
# SourceForge serves a browser interstitial, so we fetch it, extract the mirror
# URL (with its one-time token) and download with a cookie jar.
set -euo pipefail

VER="6.4.2"
ZIP="clips_core_source_642.zip"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
cd "$work"

echo "Fetching CLIPS $VER source from SourceForge..."
curl -fsSL -c cj -A "Mozilla/5.0" \
  "https://sourceforge.net/projects/clipsrules/files/CLIPS/$VER/$ZIP/download" -o page.html
mirror="$(grep -oE 'https://[a-z0-9.-]+/project/clipsrules/[^"&]*'"$ZIP"'[^"]*' page.html \
          | head -1 | sed 's/&amp;/\&/g')"
[ -n "$mirror" ] || { echo "could not resolve a SourceForge mirror URL" >&2; exit 1; }
curl -fsSL -c cj -b cj -A "Mozilla/5.0" "$mirror" -o "$ZIP"

unzip -q "$ZIP"
cd clips_core_source_*/core
make >/dev/null
mkdir -p "$HOME/.local/bin"
install -m 0755 clips "$HOME/.local/bin/clips"

echo "Installed: $HOME/.local/bin/clips"
printf '(exit)\n' | "$HOME/.local/bin/clips" 2>&1 | grep -oE 'CLIPS \([0-9.]+ [0-9/]+\)' || true
echo "Ensure ~/.local/bin is on your PATH."
