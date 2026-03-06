# OPS.md — Operational Playbook

This file contains operational details: how your crons work, quality standards, workflows. AGENTS.md has the core rules (always apply). OPS.md is the detailed reference (consulted when relevant). Start minimal and add sections as you need them.

## Cron Golden Defaults

When creating scheduled tasks (crons), always use these settings:

```bash
openclaw cron create \
  --name "Descriptive Name" \
  --cron "0 12 * * *" \
  --message "Clear, specific instruction" \
  --to telegram:YOUR_CHAT_ID \
  --announce \
  --wake now \
  --timeout-seconds 120
```

Key rules:
- `--wake now` — execute immediately (without this, crons may wait for next heartbeat)
- `--announce` — deliver result to user (without this, cron runs but you never see output)
- `--to` — always specify destination channel and target
- `--timeout-seconds` — set realistic timeout
- `--delete-after-run` — use for one-shot reminders

**Max active crons:** keep 15 or fewer. Disable stale ones before creating new.

## Quality Gate (Before "Done")

Never mark a task complete without:
1. Test core behavior end-to-end
2. Check compile/runtime/console errors
3. Test one realistic scenario + one edge case
4. Report what was tested

For UI work, add:
- Screenshot before/after
- Verify responsive behavior

## Subagent Spawn Rules

**Spawn when:**
- Implementation touches more than 1 file
- Debugging requires more than 3 tool calls
- UI/API build + verification needed
- Work likely takes more than 2-3 minutes

**Work directly when:**
- Quick answer/recommendation
- Simple read/search
- Task updates
- Tiny edits (less than 1 file, less than 10 lines)

## Handoff Protocol

After completing a substantial task, append to daily log (`memory/YYYY-MM-DD.md`):

```markdown
## Handoff: [Task] — [timestamp]
- Done: [what completed]
- Pending: [next steps if any]
- Decisions: [decisions made + rationale]
- Watch out: [gotchas for future reference]
```

## Cron Templates

All times below are in **UTC**. Adjust the hour to match your local timezone.

### Morning Digest (daily briefing)

```bash
openclaw cron create \
  --name "Morning Digest" \
  --cron "0 12 * * *" \
  --message "Give me a morning briefing: pending tasks for today, anything urgent, and one thing I should focus on." \
  --to telegram:YOUR_CHAT_ID \
  --announce \
  --wake now
```

Note: `0 12 * * *` = noon UTC. Adjust for your timezone (e.g. UTC-4 → use `0 12` for 8am EDT).

### Weekly Recap (every Monday)

```bash
openclaw cron create \
  --name "Weekly Recap" \
  --cron "0 14 * * 1" \
  --message "It's Monday. Give me a brief recap of last week based on memory files, and suggest 3 priorities for this week." \
  --to telegram:YOUR_CHAT_ID \
  --announce \
  --wake now
```

### Nightly Auto-Improve (daily at 4am UTC)

```bash
openclaw cron create \
  --name "Auto-Improve" \
  --cron "0 4 * * *" \
  --message "AUTO-IMPROVE: 1) Pick ONE friction point from recent interactions and fix it. Log in memory/auto-improve-log.md. 2) Check for stale crons, empty files, scattered docs. Auto-fix safe issues, flag risky ones. 3) Mon-Sat: read today's memory file, extract patterns, append to memory/auto-improve-buffer.md. Sunday: generate weekly report in memory/auto-improve-reports/YYYY-MM-DD.md." \
  --to telegram:YOUR_CHAT_ID \
  --announce \
  --wake now
```

### Monthly Lessons (1st of every month)

```bash
openclaw cron create \
  --name "Monthly Lessons" \
  --cron "0 14 1 * *" \
  --message "It's the 1st. Review the past month from memory files. What patterns do you see? What's one thing I should do differently next month? Keep it to 3-5 bullet points." \
  --to telegram:YOUR_CHAT_ID \
  --announce \
  --wake now
```

Replace `YOUR_CHAT_ID` with your actual Telegram chat ID (run `openclaw directory self --channel telegram` to find it). Keep active crons to 15 or fewer.

## Sections to Add Later

As your setup matures, you might add:

- Auto-Queue Management (for projects with a work queue)
- Token Efficiency (how to reduce API costs)
- Compound Engineering (documenting reusable solutions)
- Project-specific workflows
