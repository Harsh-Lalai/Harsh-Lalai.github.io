#!/usr/bin/env bash
# Render the live /cv/ page to ./cv.pdf using headless Chrome.
# Requires `bundle exec jekyll serve` to be running.

set -euo pipefail

URL="http://localhost:4000/cv/"
OUT="$(cd "$(dirname "$0")/.." && pwd)/cv.pdf"

CHROME=""
for candidate in \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  "/Applications/Chromium.app/Contents/MacOS/Chromium" \
  "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" \
  "google-chrome" "chromium"
do
  if [[ -x "$candidate" ]] || command -v "$candidate" >/dev/null 2>&1; then
    CHROME="$candidate"
    break
  fi
done

if [[ -z "$CHROME" ]]; then
  echo "Error: Chrome or Chromium not found. Install Google Chrome to generate the PDF." >&2
  exit 1
fi

if ! curl -sf "$URL" > /dev/null; then
  echo "Error: Jekyll server is not responding at $URL." >&2
  echo "Start it in another terminal with:  bundle exec jekyll serve" >&2
  exit 1
fi

echo "Rendering $URL -> $OUT"
"$CHROME" \
  --headless=new \
  --disable-gpu \
  --no-pdf-header-footer \
  --print-to-pdf-no-header \
  --virtual-time-budget=10000 \
  --run-all-compositor-stages-before-draw \
  --print-to-pdf="$OUT" \
  "$URL" >/dev/null 2>&1

echo "Done. Wrote $OUT"
