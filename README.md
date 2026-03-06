# OpenClaw Starter Pack

A ready-to-use workspace for a personal AI assistant that runs on your infrastructure, remembers context across sessions, works through Telegram, runs scheduled tasks, and improves itself overnight. Built on [OpenClaw](https://docs.openclaw.ai).

## What's in the pack

| File | Purpose |
|------|---------|
| `IDENTITY.md` | Your AI's name and persona |
| `SOUL.md` | Personality, tone, language rules |
| `USER.md` | Who you are — timezone, projects, preferences |
| `AGENTS.md` | Operating rules — how the AI behaves |
| `TOOLS.md` | Your configured services and API notes |
| `OPS.md` | Operational playbook — crons, quality gates |
| `HEARTBEAT.md` | Periodic background check behavior |
| `SECURITY.md` | Security checklist and hardening guide |
| `BOOTSTRAP.md` | One-time setup wizard (auto-deletes after) |
| `memory/MEMORY.md` | Long-term memory (grows over time) |
| `skills/` | Bundled skills: auto-improve, humanizer, skill-creator |

## Prerequisites

- Node.js 18+
- Anthropic API key ([console.anthropic.com](https://console.anthropic.com))
- Telegram account (for messaging your assistant)

## Quickstart

```bash
# 1. Clone this repo
git clone https://github.com/vistawtf/openclaw-easy-setup.git
cd openclaw-easy-setup

# 2. Copy starter pack to your workspace
cp -r starter-pack/ ~/clawd/

# 3. Start the gateway
openclaw gateway start

# 4. Connect Telegram
# First: message @BotFather on Telegram, send /newbot, copy the token
openclaw channels add --channel telegram --token YOUR_BOT_TOKEN
```

Then message your bot on Telegram. It will detect `BOOTSTRAP.md` and walk you through setup.

Don't have OpenClaw? Install it first: `npm install -g openclaw`

## Skills

Three skills are bundled: **auto-improve** (overnight self-improvement), **humanizer** (removes AI writing patterns), and **skill-creator** (build your own skills).

Browse more at [clawhub.com](https://clawhub.com). To install one, tell your assistant what you need or paste the skill link in chat.

## Guides

New to OpenClaw? Start here:

- **[Setup Guide](https://vistawtf.github.io/openclaw-easy-setup/setup-guide.html)** — file-by-file walkthrough of every config file
- **[Skills Guide](https://vistawtf.github.io/openclaw-easy-setup/skills-helper.html)** — how skills work, what's bundled, how to create your own

## Resources

- [OpenClaw Docs](https://docs.openclaw.ai)
- [ClawhHub Marketplace](https://clawhub.com)
- [Community Discord](https://discord.gg/openclaw)
