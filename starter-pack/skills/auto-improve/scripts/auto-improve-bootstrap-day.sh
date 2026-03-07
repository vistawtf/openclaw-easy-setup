#!/usr/bin/env bash
# auto-improve-bootstrap-day.sh
# Creates the daily memory file for today (or a given date) if it doesn't exist.
# Safe to run multiple times — idempotent.
#
# Usage: ./auto-improve-bootstrap-day.sh [YYYY-MM-DD]

set -euo pipefail

DATE_UTC="${1:-$(date -u +%Y-%m-%d)}"

# Auto-detect workspace root (script lives in skills/auto-improve/scripts/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="${CLAWD_ROOT:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
MEMORY_DIR="$ROOT/memory"
FILE="$MEMORY_DIR/$DATE_UTC.md"

mkdir -p "$MEMORY_DIR"

if [[ ! -f "$FILE" ]]; then
  cat > "$FILE" <<EOF
# $DATE_UTC

## Log

## Handoffs

## Notes
EOF
  echo "CREATED:$FILE"
else
  echo "EXISTS:$FILE"
fi
