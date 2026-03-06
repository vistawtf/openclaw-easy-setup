---
name: auto-improve
description: Autonomous overnight improvement system that fixes one friction point per night, keeps your workspace tidy, and runs a weekly learning report. Use when you want your agent to improve itself while you sleep. Triggers on "auto-improve," "overnight review," "nightly review," "autonomous cleanup," or "weekly learning report."
---

# Auto-Improve

Autonomous overnight improvement system. Every night: fix ONE thing, clean up, learn from the day. Weekly: deep analysis with improvement proposals.

## Setup

Create a cron job at your preferred overnight hour (e.g., 4AM UTC):

```
Schedule: 0 4 * * * (UTC)
Session: main
Payload: systemEvent with the Auto-Improve prompt (see below)
```

### Cron Prompt

```
AUTO-IMPROVE:

1. FRICTION FIX: Pick ONE friction point from recent work and fix it autonomously.
   Options: (a) workspace cleanup, (b) memory consolidation, (c) file organization,
   (d) research/data prep, (e) proactive tooling, (f) documentation gaps.
   Ship it. Document in memory/auto-improve-log.md.

2. HYGIENE CHECKS:
   - Task manager: duplicates, overdue tasks, missing dates, stale tasks (>2 weeks overdue)
   - Cron: zombie jobs (fired but not deleted), disabled leftovers, error states, duplicates
   - Workspace: empty files, stale temp files, scattered docs that should be consolidated
   Report findings in memory/auto-improve-log.md. Auto-fix safe issues, flag risky ones.

3. LEARNING LOOP:
   - Mon-Sat: Read today's memory file, extract patterns/insights, append to memory/auto-improve-buffer.md
   - Sunday: Deep weekly analysis. Read buffer + last 7 days of memory files.
     Generate report in memory/auto-improve-reports/YYYY-MM-DD.md with:
     - Patterns identified
     - Concrete improvement proposals (new skills, workflows, automation)
     - Priority (high/medium/low)
     Clear buffer after.

RULES:
- Only low-risk changes (never touch production code)
- Document everything in memory/auto-improve-log.md
- One friction fix per night (stay focused)
- Flag anything risky for human review instead of acting
```

### Required Files

Create these on first run:

- `memory/auto-improve-log.md` — Running log of all nightly work
- `memory/auto-improve-buffer.md` — Daily learning extracts (cleared weekly)
- `memory/auto-improve-reports/` — Directory for weekly analysis reports

## How It Works

### 1. Friction Fix (Primary Task)

Each night, identify and fix ONE concrete problem. Pick the highest-impact, lowest-risk item.

**Good friction fixes:**
- Archive stale files cluttering the workspace
- Create CONTEXT.md files for projects (faster session ramp-up)
- Document missing API keys or config gaps
- Consolidate scattered files into single reference docs
- Implement previously approved improvements
- Update outdated documentation

**Bad friction fixes (avoid):**
- Modifying production code
- Changing configs without approval
- Anything that could break running services
- Multiple fixes in one night (scope creep)

### 2. Hygiene Checks

Run these checks every night:

**Task Manager (whichever you use — Notion, Linear, Todoist, etc):**
- Flag duplicate tasks
- List tasks overdue >1 week with suggested new dates or deletion
- Identify tasks missing dates
- Flag stale tasks (>2 weeks overdue, no progress)

**Cron Jobs:**
- Delete zombie jobs (one-shot jobs that fired but weren't cleaned up)
- Report jobs with error status
- Flag potential duplicates

**Workspace:**
- Identify empty or near-empty files
- Flag temp files older than 7 days
- Suggest consolidation for scattered related files

Auto-fix safe issues (delete empty temp files, remove zombie crons). Flag anything ambiguous for morning review.

### 3. Learning Loop

**Daily (Mon-Sat) — lightweight extraction:**
- Read the day's memory/journal file
- Extract: recurring requests, repeated workflows, pain points, mistakes, preferences
- Append findings to buffer file
- Cost: ~2-5K tokens

**Weekly (Sunday) — deep analysis:**
- Read buffer + all memory files from the past 7 days
- Generate structured report with:
  - Patterns identified (what keeps coming up?)
  - Improvement proposals (specific, actionable)
  - Priority ranking
- Clear buffer for next week
- Notify human in next morning briefing
- Cost: ~20-30K tokens

**Approval flow:**
- Human reviews weekly report when convenient
- Approves/rejects/modifies each proposal
- Agent implements only approved changes
- Track applied changes in log

## Log Format

Each entry in `memory/auto-improve-log.md`:

```markdown
### YYYY-MM-DD
**Friction Fixed:** [one-line summary]
**What I did:**
1. [step]
2. [step]

**Hygiene:**
- [findings and actions]

**Learning:** [extracted to buffer / weekly report generated]

**Ready to use:** [what's different now]
```

## Morning Integration

Pair Auto-Improve with a morning digest cron job. Include in the morning prompt:

```
Check memory/auto-improve-log.md for last night's work.
Summarize in 1-2 sentences what was fixed/improved.
On Mondays, also check for weekly reports in memory/auto-improve-reports/.
```

This way the human wakes up to a clean summary of overnight work.

## Customization

Adapt these to your setup:
- **Task manager:** Replace Notion references with your tool (Linear, Todoist, etc.)
- **Schedule:** Adjust cron time to your timezone's quiet hours
- **Hygiene scope:** Add/remove checks based on your tools (GitHub issues, Slack, etc.)
- **Learning focus:** Tune extraction patterns to your domain

## Cost Estimate

- **Daily:** ~5-10K tokens (friction fix + hygiene + daily learning)
- **Weekly (Sunday):** ~20-30K additional tokens (deep analysis)
- **Monthly total:** ~200-350K tokens

---

*Originally developed as an organic workflow, packaged as a skill for the OpenClaw community.*
