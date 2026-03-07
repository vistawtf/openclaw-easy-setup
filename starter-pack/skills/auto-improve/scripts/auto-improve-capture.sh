#!/usr/bin/env bash
# auto-improve-capture.sh
# Extracts learnings from yesterday's daily memory file and appends to the weekly buffer.
# Runs Mon-Sat as part of the nightly auto-improve cron.
#
# Usage: ./auto-improve-capture.sh [YYYY-MM-DD]
#   (date = the day to capture; defaults to yesterday)
#
# Output:
#   APPENDED:<date>  — learnings found and added to buffer
#   EXISTS:<date>    — already captured, skipped
#   NO_INSIGHTS      — log was empty, nothing to capture

set -euo pipefail

# Default to YESTERDAY — cron runs at 4 AM, capturing the previous day's events
DATE_UTC="${1:-$(date -u -d 'yesterday' +%Y-%m-%d 2>/dev/null || date -u -v-1d +%Y-%m-%d)}"

# Auto-detect workspace root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="${CLAWD_ROOT:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
DAY_FILE="$ROOT/memory/$DATE_UTC.md"
BUFFER_FILE="$ROOT/memory/auto-improve-buffer.md"

# Bootstrap the day file if missing
"$SCRIPT_DIR/auto-improve-bootstrap-day.sh" "$DATE_UTC" >/dev/null

# Extract content from known section headers.
# Captures: Log, Notes, Handoffs, and rich session headers written by the agent.
# Skips: Local files sections (just paths, not learnings).
INSIGHTS=$(awk '
  BEGIN {capture=0}
  /^## / {capture=0}
  /^## Log/ ||
  /^## Notes/ ||
  /^## Handoffs/ ||
  /^## Session summary/ ||
  /^## What was built/ ||
  /^## Other things from today/ ||
  /^## Session continuation/ {capture=1; next}
  capture==1 {
    line=$0
    gsub(/^[[:space:]]+|[[:space:]]+$/, "", line)
    if (line != "" && line !~ /^#/) print line
  }
' "$DAY_FILE")

if [[ -z "${INSIGHTS}" ]]; then
  echo "NO_INSIGHTS"
  exit 0
fi

# Initialize buffer file if missing
if [[ ! -f "$BUFFER_FILE" ]]; then
  cat > "$BUFFER_FILE" <<'EOF'
# Auto-Improve Learning Buffer
*Daily extracts, cleared after each Sunday weekly report.*

---
EOF
fi

# Append only if this date isn't already in the buffer
if ! grep -q "^## $DATE_UTC" "$BUFFER_FILE" 2>/dev/null; then
  {
    echo ""
    echo "## $DATE_UTC"
    echo ""
    echo "$INSIGHTS"
  } >> "$BUFFER_FILE"
  echo "APPENDED:$DATE_UTC"
else
  echo "EXISTS:$DATE_UTC"
fi
