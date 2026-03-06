# OpenClaw Security Checklist

Run through this checklist before publishing your workspace or sharing it with your team.

---

## Quick Start: Hardening Script

Copy and run this script after your initial OpenClaw setup:

```bash
#!/bin/bash
# === OpenClaw Security Hardening ===

echo "Securing file permissions..."

# OpenClaw core
chmod 700 ~/.openclaw/ 2>/dev/null
chmod 600 ~/.openclaw/openclaw.json 2>/dev/null
[ -d ~/.openclaw/credentials ] && chmod 700 ~/.openclaw/credentials/ && \
  find ~/.openclaw/credentials/ -type f -exec chmod 600 {} \;
[ -f ~/.openclaw/secrets.json ] && chmod 600 ~/.openclaw/secrets.json

# API keys
for dir in ~/.config/notion ~/.config/brave ~/.config/apify ~/.config/github; do
  [ -d "$dir" ] && chmod 700 "$dir" && find "$dir" -type f -exec chmod 600 {} \;
done

echo "Running security audit..."
openclaw security audit

echo "Running secrets audit..."
openclaw secrets audit --check

echo "Done. Review any findings above."
```

---

## Pre-Publish Checklist

### Secrets & Credentials

- [ ] No API keys in any workspace file
  ```bash
  # Quick scan for common key patterns
  grep -rn "sk-ant\|sk-or\|sk-proj\|ghp_\|gsk_\|xoxb-\|xoxp-" ~/clawd/
  ```
- [ ] `~/.config/` directories: `chmod 700` (dirs), `chmod 600` (files)
- [ ] `~/.openclaw/`: `chmod 700` (dir), `chmod 600` (config files)
- [ ] `openclaw secrets audit --check` returns clean

### Git Hygiene

- [ ] `.gitignore` exists at workspace root (template below)
- [ ] `git status` reviewed before every commit
- [ ] No `~/.openclaw/` files in repo
- [ ] No daily logs with sensitive personal info committed
- [ ] Git history clean of old keys (if ever committed — **revoke immediately**)

### Access Control

- [ ] Telegram/WhatsApp: `dmPolicy: "pairing"` or `allowFrom` set
- [ ] Groups: `requireMention: true`
- [ ] Gateway: `bind: "loopback"`, `auth.mode: "token"` with strong token
- [ ] `openclaw security audit` has no critical findings

### Tool Restrictions

- [ ] `tools.fs.workspaceOnly: true` (unless you need system-wide access)
- [ ] `tools.exec.security: "deny"` or `"allowlist"` (unless needed)
- [ ] `tools.elevated.enabled: false` (unless needed)
- [ ] Consider sandboxing for shared/exposed setups

---

## Recommended `.gitignore`

Create this file at the root of your workspace:

```gitignore
# ====================================
# OpenClaw Workspace .gitignore
# ====================================

# === SECRETS ===
.env
.env.*
**/*.key
**/*.pem
**/*.secret
**/*.p12
**/secrets*
**/credentials*
**/api_key*

# === OPENCLAW STATE ===
openclaw.json
auth.json
auth-profiles.json
sessions.json
secrets.json
*.jsonl

# === OS ===
.DS_Store
Thumbs.db

# === TEMP / DEBUG ===
*.tmp
*.bak
*.swp
*~
screenshots/
debug/
quick-capture/inbox.md

# === OPTIONAL: Personal daily logs ===
# Uncomment if your daily logs contain sensitive info:
# memory/????-??-??.md
```

---

## Token Revocation Quick Reference

If a token is ever exposed (in git, logs, screenshots, etc.), **revoke immediately**:

| Service | How to Revoke |
|---------|--------------|
| **Anthropic** | console.anthropic.com → API Keys → Delete key |
| **OpenAI** | platform.openai.com → API Keys → Revoke |
| **Telegram Bot** | @BotFather → /mybots → your bot → API Token → Revoke Current Token |
| **Notion** | notion.so/my-integrations → your integration → Regenerate token |
| **Brave Search** | brave.com/search/api → Dashboard → Regenerate |
| **GitHub** | github.com → Settings → Developer settings → Tokens → Delete |
| **Gateway Token** | Edit `gateway.auth.token` in `openclaw.json` → restart gateway |

After revoking:
```bash
# 1. Generate new token in the service's web UI
# 2. Update locally
echo "NEW_TOKEN" > ~/.config/<service>/api_key
chmod 600 ~/.config/<service>/api_key
# 3. Reload
openclaw secrets reload  # or: openclaw gateway restart
```

If it was in a public git repo: Revoke first, clean later. Scraping bots detect keys on GitHub within minutes.

---

## Understanding What the AI Can Access

By default, OpenClaw gives the AI broad tool access. Here's what each tool group does:

| Tool Group | What It Does | Risk Level |
|-----------|-------------|-----------|
| `group:runtime` | Execute shell commands (`exec`, `bash`, `process`) | High |
| `group:fs` | Read/write/edit files on the host | High |
| `group:ui` | Control browser, render canvas | Medium |
| `group:automation` | Create cron jobs, manage gateway | Medium |
| `group:messaging` | Send messages via channels | Medium |
| `group:nodes` | Control paired mobile/desktop nodes | Medium |

### Restrict with tool policies:

```json5
// In ~/.openclaw/openclaw.json
{
  tools: {
    deny: ["group:runtime", "group:fs"],  // Block dangerous tools
    fs: { workspaceOnly: true },           // Limit file access to workspace
    exec: { security: "deny" },            // Block command execution
    elevated: { enabled: false },           // Block host-level exec
  },
}
```

---

## Secrets Management with `openclaw secrets`

OpenClaw has a native secrets system. Instead of storing API keys in plaintext files, use SecretRefs:

```bash
# Audit current state
openclaw secrets audit --check

# Interactive migration to SecretRefs
openclaw secrets configure

# Reload after changes
openclaw secrets reload
```

### SecretRef Example (environment variable):
```json5
{
  models: {
    providers: {
      anthropic: {
        apiKey: { source: "env", provider: "default", id: "ANTHROPIC_API_KEY" }
      }
    }
  }
}
```

Supports: environment variables, file-backed secrets, and exec providers (1Password, HashiCorp Vault, sops).

---

## For Teams & Enterprises

### Security Model

OpenClaw uses a **personal assistant trust model**: one trust boundary per gateway. It is NOT a multi-tenant system.

- **One person, one gateway** — recommended default
- **One team, one gateway** — acceptable if everyone is in the same trust boundary
- **Multiple untrusted users** — separate gateways required (separate OS users/hosts)

### Shared Gateway Rules

If your team shares a gateway:
- Run on a dedicated machine/VM/container
- Use a dedicated OS user
- Do NOT sign into personal accounts on that runtime
- Enable sandboxing: `sandbox.mode: "all"`
- Set `session.dmScope: "per-channel-peer"` for per-user sessions
- Keep tool access minimal

### Key Rotation Schedule

| Key Type | Recommended Rotation | Immediate Trigger |
|----------|---------------------|-------------------|
| Model API keys (Anthropic, OpenAI) | Every 90 days | Suspected leak |
| Bot tokens (Telegram, Discord) | Every 180 days | Employee departure |
| Gateway auth token | Every 90 days | Team change |
| Integration tokens (Notion, etc.) | Every 180 days | Permission change |

### Audit Commands for Teams

```bash
# Full security audit
openclaw security audit --deep --json

# Check for plaintext secrets
openclaw secrets audit --check

# Inspect tool access
openclaw sandbox explain --json

# Review tool configuration
openclaw config get tools
```

---

## Useful Links

- [OpenClaw Security Docs](https://docs.openclaw.ai/gateway/security)
- [Secrets Management](https://docs.openclaw.ai/gateway/secrets)
- [Sandboxing](https://docs.openclaw.ai/gateway/sandboxing)
- [Tool Policies](https://docs.openclaw.ai/gateway/sandbox-vs-tool-policy-vs-elevated)
- [Agent Workspace](https://docs.openclaw.ai/concepts/agent-workspace)

---

*Part of the OpenClaw Starter Pack — Security Module*
