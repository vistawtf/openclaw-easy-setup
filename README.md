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
- An API key from your AI provider (Anthropic, OpenAI, etc.)
- Telegram account

## Quickstart

```bash
# 1. Install OpenClaw (if you haven't already)
npm install -g openclaw
openclaw onboard   # follow the wizard: AI provider, Telegram bot token, model

# 2. Clone this repo and copy the starter pack
git clone https://github.com/vistawtf/openclaw-easy-setup.git
cp -r openclaw-easy-setup/starter-pack/. ~/.openclaw/workspace/

# 3. Restart the gateway so the new files load
pkill -f "openclaw gateway" && nohup openclaw gateway &
```

Then message your bot on Telegram — `BOOTSTRAP.md` will guide your assistant through a short onboarding chat to personalize your workspace.

> **Heads up:** Copying the starter pack overwrites files with the same names. Back up first if you have existing config: `cp -r ~/.openclaw/workspace/ ~/.openclaw/workspace-backup/`

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
