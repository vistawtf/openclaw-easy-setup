---
name: auto-improve
version: 2.0.0
description: |
  Autonomous nightly maintenance using the OODA loop. Observes workspace
  friction, orients by proximity to active work, decides whether to fix
  or report ALL CLEAR, and acts. Includes daily learning capture, weekly
  focus areas, and infrastructure audits. Use when you want your agent
  to improve itself while you sleep.
---

# Auto-Improve — OODA System

Autonomous overnight improvement system. Follow this process every night.

## Setup

### Step 1: Create the cron job

```bash
openclaw cron create \
  --name "Auto-Improve" \
  --cron "0 4 * * *" \
  --message "AUTO-IMPROVE: Read the auto-improve skill and follow it exactly. Today is {date}, {weekday}." \
  --announce \
  --wake now
```

### Files created automatically on first run

- `memory/auto-improve-log.md` — running log of all nightly work
- `memory/auto-improve-buffer.md` — daily learning extracts (cleared each Sunday)
- `memory/auto-improve-reports/` — weekly reports

---

## The OODA Loop

### Phase 1: OBSERVE

Run these checks in order:

**1.1 Stale Plans**
```bash
find ~/clawd -path "*/docs/plans/*.md" -mtime +7 2>/dev/null | xargs grep -l -v "Status: DONE" 2>/dev/null
```

**1.2 Yesterday's Memory**
Read `memory/YYYY-MM-DD.md` for yesterday. Scan for:
- Unresolved issues or friction
- Decisions that need follow-up
- Pain points or repeated workarounds

**1.3 Previous Build Check**
Read the last entry in `memory/auto-improve-log.md`. Classify its impact:
- **verified** — the fix was referenced or used in a subsequent session
- **infrastructure/preventive** — proactive fix; absence of errors is success
- **unknown** — can't tell if it helped

**1.4 Task Manager (if configured)**
If you have a task manager set up (Notion, Linear, Todoist, etc.), check for tasks due today or tomorrow. Note anything the agent could prepare or start autonomously with high confidence.

---

### Phase 2: ORIENT

Score potential fixes by:
1. **Proximity to active work** — check `git log --oneline --since='7 days ago'` across your workspace repos
2. **Frequency of pain** — has this issue appeared more than once in recent memory files?
3. **Unblocking value** — would fixing this remove friction for tomorrow?

**Heuristic: "Would the user thank me tomorrow?"** If they'd skim past it, skip it.

**Never invent documentation work.** Only document things that emerged from real friction.

---

### Phase 3: DECIDE

- Genuine friction found → fix ONE thing
- Nothing clears the bar → ALL CLEAR: report what was checked

"Nothing valuable tonight" is a valid, honest outcome. Honesty beats fake production.

---

### Phase 4: ACT

If fixing:
1. Implement the fix
2. Verify it works (test, compile check, dry run)
3. If significant discovery → update AGENTS.md or TOOLS.md

---

## Logging

Append to `memory/auto-improve-log.md`:

```markdown
### YYYY-MM-DD (Weekday) — Build #[N]
Status: COMPLETE or ALL CLEAR
Category: Bug fix / Infra / Documentation / ALL CLEAR
Previous build: verified / infra-preventive / unknown
Stale Plans: [result]
Fix: [what + why, or "Nothing cleared the bar. Checked: X, Y, Z"]
Learnings Added: Yes/No
```

Increment the build number from the last entry.

---

## Weekly Focus Areas

Lightweight daily themes. Skip if nothing relevant.

| Day | Focus |
|-----|-------|
| Mon | Skim last weekly report, note one pattern worth watching |
| Tue | Active projects patrol — `git log` last 7d, check CONTEXT.md files, flag stale TODOs |
| Wed | Capture new patterns from this week into `memory/solutions/` if any emerged |
| Thu | Infrastructure audit (see below) |
| Fri–Sat | Learning capture only |
| Sun | Generate weekly report (see below) |

---

## Weekly Infrastructure Audit (Every Thursday)

In addition to the regular nightly checks:

1. **Cron health** — `openclaw cron list`, look for error states, stale one-shots, jobs that haven't run in >7 days
2. **Workspace hygiene** — empty files, temp files older than 7 days, stale git branches
3. **Memory file health** — check if `auto-improve-log.md` needs rotation (>50 entries), verify the learning buffer isn't growing unbounded
4. **Script health** — dry-run any nightly scripts to confirm they still work

Log audit findings under an `Infra Audit:` section in the log entry.

---

## Daily Learning Capture (Mon–Sat)

Every night:
1. Read yesterday's `memory/YYYY-MM-DD.md` in full
2. Decide what's worth keeping long-term in `memory/auto-improve-buffer.md`
3. **Keep:** lasting decisions, lessons learned, patterns, milestones
4. **Skip:** routine task completions, reminders, one-off facts
5. Append under a `## YYYY-MM-DD` header (skip if it already exists)

Use your judgment. No script needed.

---

## Weekly Report (Sunday only)

Instead of learning capture, generate the weekly report:

1. Read `memory/auto-improve-buffer.md` (the week's accumulated learnings)
2. Read the last 7 daily memory files
3. Write to `memory/auto-improve-reports/YYYY-MM-DD.md`:

```markdown
# Weekly Report — [week range]

## What happened this week
[3–5 honest bullets. Actual judgment, not a list of events.]

## Patterns
[What keeps coming up? Recurring friction, repeated questions, consistent gaps.]

## One thing to try next week
[One concrete proposal with a reason. Not a wishlist.]

## Nightly builds this week
[Brief: what got fixed each night, any ALL CLEAR nights]
```

4. Clear the buffer:

```bash
cat > memory/auto-improve-buffer.md << 'EOF'
# Auto-Improve Learning Buffer
*Daily extracts, cleared after each Sunday weekly report.*

---
EOF
```

---

## Escalation Rules

- If 3 consecutive builds have "unknown" impact → add to the summary: "My last 3 builds may not be landing. What would actually help?"
- If a significant discovery is made → update AGENTS.md or TOOLS.md immediately
- Never modify production code without explicit approval
- If a fix could break something or needs human context → flag it in the log and skip it

---

## Design Principles

**OODA over checklists.** Observe what's real, orient to what matters, decide honestly, act precisely. Don't fill space with busywork.

**One fix per night.** Scope creep kills overnight systems. One thing done well beats three things half-done.

**Flag, don't act, when uncertain.** Write ambiguous issues to the log. The human reviews in the morning.

**Weekly report = judgment, not data dump.** Patterns, gaps, and one concrete recommendation — not a list of log entries.

---

## Cost Estimate

- **Daily:** ~5–10K tokens
- **Sunday:** ~15–20K tokens (reading 7 logs + buffer + report)
- **Monthly:** ~180–280K tokens

---

## Customization

- **Task manager:** The Notion pre-processing step can be adapted to Linear, Todoist, or skipped
- **Cron time:** Change to your timezone's quiet hours
- **Report language:** Write the weekly template in your language
- **Log file names:** Replace `auto-improve-log.md` / `auto-improve-buffer.md` with whatever naming scheme you prefer

---

*Originally developed as a live workflow, packaged for the OpenClaw community.*
