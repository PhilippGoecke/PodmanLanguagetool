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

curl -s -X POST "$LT_URL" \
  --data-urlencode "text=${TEXT}" \
  --data-urlencode "language=${LANGUAGE}" \
  | python3 -m json.tool
