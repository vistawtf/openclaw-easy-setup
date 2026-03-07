---
name: auto-improve
description: Autonomous overnight improvement system that fixes one friction point per night, keeps your workspace tidy, and runs a weekly learning report. Use when you want your agent to improve itself while you sleep. Triggers on "auto-improve," "overnight review," "nightly review," "autonomous cleanup," or "weekly learning report."
---

# Auto-Improve

Autonomous overnight improvement system. Every night: fix ONE thing, clean up, learn from the day. Weekly: a real report on what's working and what isn't.

## Setup

### Step 1: Copy the scripts

Copy the two helper scripts from this skill into your workspace:

```bash
cp skills/auto-improve/scripts/auto-improve-bootstrap-day.sh scripts/
cp skills/auto-improve/scripts/auto-improve-capture.sh scripts/
chmod +x scripts/auto-improve-bootstrap-day.sh scripts/auto-improve-capture.sh
```

### Step 2: Create the cron job

The bootstrap wizard does this for you. To set it up manually:

```bash
openclaw cron create \
  --name "Auto-Improve" \
  --cron "0 4 * * *" \
  --message "AUTO-IMPROVE: Run the auto-improve skill." \
  --announce \
  --wake now
```

### Required files (created automatically on first run)

- `memory/auto-improve-log.md` — running log of all nightly work
- `memory/auto-improve-buffer.md` — daily learning extracts (cleared each Sunday)
- `memory/auto-improve-reports/` — weekly reports

---

## Cron Prompt

When the cron fires, follow these steps in order:

### 1. Bootstrap the day

```bash
bash scripts/auto-improve-bootstrap-day.sh
```

Creates today's memory file if it doesn't exist.

### 2. Friction Fix

Pick ONE friction point from recent work and fix it. Choose the highest-impact, lowest-risk item:

- Workspace cleanup (stale files, scattered docs)
- Memory consolidation (merge duplicate notes, archive old logs)
- Documentation gaps (something you had to re-figure out this week)
- Proactive tooling (a script that would save recurring manual work)
- Configuration (missing API key docs, undocumented setup steps)

Ship it. Log it in `memory/auto-improve-log.md`.

**Good fixes:** archive clutter, document a rediscovered process, create a reference file.
**Bad fixes:** touching production code, changing configs without approval, doing two things at once.

### 3. Hygiene Checks

Run these checks every night. Auto-fix safe issues. Flag risky ones.

**Cron jobs:**
- `openclaw cron list` — look for zombie jobs (one-shot jobs that already fired but weren't deleted), error states, duplicates
- Delete confirmed zombies. Flag anything ambiguous.

**Workspace:**
- Empty or near-empty files (< 3 lines of content)
- Temp files older than 7 days
- Scattered notes that belong together

**Task manager (if configured):**
- Tasks overdue > 2 weeks with no progress — flag for human review
- Tasks missing dates

### 4. Learning Capture (Mon-Sat)

```bash
bash scripts/auto-improve-capture.sh
```

Extracts content from yesterday's memory file and appends it to `memory/auto-improve-buffer.md`. If the log was empty, prints `NO_INSIGHTS` and moves on — that's fine.

### 5. Weekly Report (Sunday only)

On Sundays, generate the weekly report instead of running the capture script.

**Do this manually (no script needed):**

1. Read `memory/auto-improve-buffer.md` (the week's accumulated learnings)
2. Read the last 7 daily memory files (`memory/YYYY-MM-DD.md`)
3. Write a report to `memory/auto-improve-reports/YYYY-MM-DD.md` with this structure:

```markdown
# Weekly Report — [week range]

## What happened this week
[3-5 honest bullets. Not a list of events — actual judgment.
"Vista had no activity" beats "Vista: 0 log entries."]

## Patterns
[What keeps coming up? Recurring friction, repeated questions, consistent gaps.]

## One thing to try next week
[Single concrete proposal. Not a wishlist — one thing, with a reason.]

## Nightly builds this week
[Brief: what got fixed each night, any nights that were empty]
```

4. Clear the buffer for the new week:

```bash
cat > memory/auto-improve-buffer.md << 'EOF'
# Auto-Improve Learning Buffer
*Daily extracts, cleared after each Sunday weekly report.*

---
EOF
```

### 6. Log the run

Append to `memory/auto-improve-log.md`:

```markdown
### YYYY-MM-DD
**Friction Fixed:** [one-line summary]
**What I did:**
- [step 1]
- [step 2]

**Hygiene:** [findings and actions taken]
**Learning:** [APPENDED / NO_INSIGHTS / weekly report generated]
```

---

## Design Principles

**Bash for checks, agent for judgment.**
Repetitive verification (file exists?, how many days old?) belongs in scripts. Judgment (is this worth fixing?, what does this pattern mean?) belongs to the agent. Don't use 5K tokens to do what a `find` command does in 0.

**One fix per night.**
Scope creep kills overnight systems. One thing done well beats three things half-done.

**Flag, don't act, when uncertain.**
If a fix could break something or requires human context, write it to the log as a flag and skip it. The human reviews in the morning.

**Weekly report = judgment, not data dump.**
The report is valuable when it tells the human something they didn't already know. A list of log entries is not a report. Patterns, gaps, and one concrete recommendation — that's the report.

---

## Cost Estimate

- **Daily:** ~5-10K tokens
- **Weekly (Sunday):** ~15-20K tokens (reading 7 logs + buffer + generating report)
- **Monthly total:** ~180-280K tokens

---

## Customization

- **Task manager:** Notion references in hygiene checks can be replaced with Linear, Todoist, or skipped entirely
- **Schedule:** Change the cron time to your timezone's quiet hours
- **Report language:** The weekly report can be in any language — just write the template in yours

---

*Originally developed as a live workflow, packaged as a skill for the OpenClaw community.*
