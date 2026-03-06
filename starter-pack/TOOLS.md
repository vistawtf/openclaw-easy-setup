# TOOLS.md - Your Setup Notes

This is your personal cheat sheet. Document here: configured APIs, hosts, devices, services, and any notes about your infrastructure. Start empty and grow it as you connect services.

## API Key Storage Pattern

**Convention:** Store API keys in `~/.config/<service>/` (NOT in project files)

```bash
# Example: save an API key
mkdir -p ~/.config/brave
echo "YOUR_API_KEY" > ~/.config/brave/api_key
chmod 600 ~/.config/brave/api_key

# Example: read it from a script
BRAVE_KEY=$(cat ~/.config/brave/api_key)
```

**Configured services:**

Add your services here as you configure them:
```
# ~/.config/notion/api_key — Not configured yet
# ~/.config/brave/api_key — Not configured yet
# ~/.config/github/token — Not configured yet
```

## Messaging Channels

Document your communication channels here.

```
### Telegram
# To find your chat_id: message @userinfobot on Telegram, it replies with your ID.
# Bot: @my_assistant_bot
# My chat_id: YOUR_CHAT_ID
# Created via @BotFather
```

## Integrations

Document specific integrations here as you connect them.

```
### Notion (example)
# Token: ~/.config/notion/api_key
# Database ID: YOUR_DATABASE_ID
# Properties: Name (title), Date (date), Complete (checkbox)

### GitHub (example)
# Auth via `gh auth login`
# Default repo: user/my-project
```

## Planned Integrations

<!-- Services you plan to connect. Added during setup. -->

## Devices & Hosts

Document connected devices or servers here.

```
### SSH (example)
# home-server → 192.168.1.100, user: admin

### TTS (example)
# Preferred voice: "Nova"
```

## Notes

Any other useful notes for your setup.

---

## Why This File Exists

Your AI reads this when relevant. Anything documented here, it knows automatically. No need to explain your setup every time. Update it whenever you add a new service or discover a useful pattern.
