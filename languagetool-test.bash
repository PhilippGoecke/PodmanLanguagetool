#!/usr/bin/env bash
set -euo pipefail

# LanguageTool API test request
# Assumes a LanguageTool server is running (default: http://localhost:8081)
# You can also use the public API: https://api.languagetool.org

LT_URL="${LT_URL:-http://localhost:8010/v2/check}"
TEXT="${1:-Das ist ein deutscher Testsatz mit Fehler.}"
LANGUAGE="${LANGUAGE:-en-US}"

echo "Sending text to LanguageTool: $TEXT"
echo "Endpoint: $LT_URL"
echo

RESPONSE="$(curl -s -w "\n%{http_code}" -X POST "$LT_URL" \
  --data-urlencode "text=${TEXT}" \
  --data-urlencode "language=${LANGUAGE}")"

HTTP_CODE="$(echo "$RESPONSE" | tail -n1)"
BODY="$(echo "$RESPONSE" | sed '$d')"

if [ "$HTTP_CODE" != "200" ]; then
  echo "Error: LanguageTool server returned HTTP $HTTP_CODE" >&2
  echo "$BODY" >&2
  exit 1
fi

if ! echo "$BODY" | python3 -m json.tool; then
  echo "Error: Response was not valid JSON:" >&2
  echo "$BODY" >&2
  exit 1
fi
