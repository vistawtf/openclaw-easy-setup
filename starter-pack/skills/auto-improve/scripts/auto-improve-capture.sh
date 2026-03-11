#!/usr/bin/env bash
# auto-improve-capture.sh
# Reads yesterday's daily memory file and outputs the full content for the LLM to filter.
# The LLM decides what's worth keeping — no awk filtering here.
#
# Usage: ./auto-improve-capture.sh [YYYY-MM-DD]
#   (date = the day to capture; defaults to yesterday)
#
# Output:
#   CONTENT:<date>  — followed by the full file content
#   NO_CONTENT      — log was empty or missing

set -euo pipefail

DATE_UTC="${1:-$(date -u -d 'yesterday' +%Y-%m-%d 2>/dev/null || date -u -v-1d +%Y-%m-%d)}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="${CLAWD_ROOT:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
DAY_FILE="$ROOT/memory/$DATE_UTC.md"

"$SCRIPT_DIR/auto-improve-bootstrap-day.sh" "$DATE_UTC" >/dev/null

CONTENT=$(tail -n +2 "$DAY_FILE" 2>/dev/null | sed '/^[[:space:]]*$/d' | head -300)

if [[ -z "${CONTENT}" ]]; then
  echo "NO_CONTENT"
  exit 0
fi

echo "CONTENT:$DATE_UTC"
echo "$CONTENT"
