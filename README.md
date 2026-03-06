# OpenClaw Starter Pack

A ready-to-use workspace for a personal AI assistant that runs on your infrastructure, remembers context across sessions, works through Telegram, runs scheduled tasks, and improves itself overnight. Built on [OpenClaw](https://docs.openclaw.ai) by [Vista](https://vista.wtf).

## What's included

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
- A Telegram account and bot token

## Install

```bash
# 1. Install OpenClaw
npm install -g openclaw

# 2. Copy the starter pack into your workspace
cd ~ && git clone https://github.com/vistawtf/openclaw-easy-setup.git
mkdir -p ~/.openclaw/workspace/
cp -r openclaw-easy-setup/starter-pack/. ~/.openclaw/workspace/

# 3. Run the setup wizard
openclaw onboard   # AI provider, Telegram bot token, model

# 4. Start the gateway
nohup openclaw gateway &
```

Then message your bot on Telegram. `BOOTSTRAP.md` will guide your assistant through a short onboarding chat to personalize your setup.

## Full docs

- **[Setup Guide](https://vistawtf.github.io/openclaw-easy-setup/setup-guide.html)** — step-by-step from zero to working assistant
- **[Config Guide](https://vistawtf.github.io/openclaw-easy-setup/config-guide.html)** — file-by-file walkthrough of every workspace file
- **[Skills Guide](https://vistawtf.github.io/openclaw-easy-setup/skills-helper.html)** — how skills work, what's bundled, how to make your own

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
