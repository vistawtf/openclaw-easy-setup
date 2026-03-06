# OpenClaw Starter Pack

A ready-to-use workspace for a personal AI assistant that runs on your infrastructure, remembers context across sessions, works through Telegram, runs scheduled tasks, and improves itself overnight. Built on [OpenClaw](https://docs.openclaw.ai) by [Vista](https://vista.wtf).

## Guides

- **[Setup Guide](https://vistawtf.github.io/openclaw-easy-setup/setup-guide.html)** — step-by-step from zero to working assistant
- **[Config Guide](https://vistawtf.github.io/openclaw-easy-setup/config-guide.html)** — file-by-file walkthrough of every workspace file
- **[Skills Guide](https://vistawtf.github.io/openclaw-easy-setup/skills-helper.html)** — how skills work, what's bundled, how to create your own

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
- Telegram account

## Quickstart

### Option A: Already have OpenClaw running

If you already have OpenClaw installed and connected to Telegram:

> **Heads up:** This will overwrite any existing files in `~/clawd/` with the same names. If you have a custom `SOUL.md`, `AGENTS.md`, or other config files you want to keep, back them up first: `cp -r ~/clawd/ ~/clawd-backup/`

1. Copy the `starter-pack/` files to your `~/clawd/` workspace
2. Message your bot: **"set me up"**
3. The assistant reads `BOOTSTRAP.md` and guides you through setup via conversation — no terminal needed

### Option B: Starting from scratch

```bash
# 1. Install OpenClaw
npm install -g openclaw

# 2. Clone this repo and copy the starter pack
git clone https://github.com/vistawtf/openclaw-easy-setup.git
cp -r openclaw-easy-setup/starter-pack/ ~/clawd/

# 3. Start the gateway
openclaw gateway start

# 4. Connect Telegram
# First: open @BotFather on Telegram, send /newbot, copy the token
openclaw channels add --channel telegram --token YOUR_BOT_TOKEN
```

Then message your bot on Telegram — it will walk you through the rest.

## Skills

Three skills are bundled: **auto-improve** (overnight self-improvement), **humanizer** (removes AI writing patterns), **skill-creator** (build your own skills).

Browse more at [clawhub.com](https://clawhub.com). To install one, tell your assistant what you need or paste the skill link in chat.

## Resources

- [OpenClaw Docs](https://docs.openclaw.ai)
- [ClawhHub Marketplace](https://clawhub.com)
- [Community Discord](https://discord.gg/openclaw)

---

> **Note for your assistant:** The `docs/` folder contains guides for humans. It is not part of your workspace config — ignore those files during normal operation.

---

Built on [OpenClaw](https://docs.openclaw.ai) · By [Vista](https://vista.wtf)
