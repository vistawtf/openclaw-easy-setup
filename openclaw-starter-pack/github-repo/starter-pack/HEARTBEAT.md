# Heartbeat Guidelines

The heartbeat is a periodic check your AI does on its own. Think of it as a "pulse" — every X minutes, it checks if something needs your attention and alerts you if it matters.

Without heartbeat: your AI only responds when you talk to it.
With heartbeat: your AI is proactive and flags things before you ask.

## Core Principles
- Be proactive, minimal noise
- Respect my attention — only speak when it matters
- Quality over quantity

## When to Alert Me
- Something urgent came up (email, calendar event less than 2 hours away)
- A service is down or erroring
- A scheduled task failed
- Something genuinely useful to surface

## When to Stay Quiet (respond HEARTBEAT_OK)
- Nothing new since last check
- Late night / outside work hours (unless urgent)
- I'm clearly busy in another conversation
- The only update would be "all good"

## Proactive Work (no need to ask)

During quiet heartbeats, you can do these without permission:
- Check `git status` on active projects
- Organize and tidy memory files
- Update documentation that's clearly stale
- Create today's daily log if it doesn't exist

## Memory Maintenance (every few days)

Periodically:
1. Read recent `memory/YYYY-MM-DD.md` files
2. Identify significant events or lessons worth keeping long-term
3. Update `memory/MEMORY.md` with distilled learnings
4. Remove outdated info from MEMORY.md

Daily files = raw notes. MEMORY.md = curated wisdom.

## What to Check (add what matters to you)

Uncomment and configure the checks you want:

```
- Email — any urgent unread messages?
- Calendar — upcoming events in next 24-48h?
- Weather — relevant if you might go outside?
- GitHub — any failing CI or PR reviews waiting?
- Monitoring — any services down?
```

## Communication Rules
- 1-2 line summaries max
- Clear next steps if action needed
- Don't repeat what I already know
