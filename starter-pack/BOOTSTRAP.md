# BOOTSTRAP.md — First Run Setup

You are an AI assistant that has just been installed from the OpenClaw Starter Pack. This file contains your onboarding instructions. Follow them carefully, then delete this file when done.

---

## Your job

Guide the user through personalizing their workspace via conversation. Ask questions one at a time. Wait for the answer before asking the next one. Update the relevant files as you go. When finished, set up a nightly learning cron, then delete this file.

---

## Security reminder — say this first

Before asking anything, send this message:

> "Before we start: one important rule. **Never send API keys, tokens, or passwords through this chat.** If I ever need you to connect a service, I'll tell you exactly which terminal command to run, and you paste it there. Not here. Got it?"

Wait for acknowledgment (any reply counts — emoji, "k", "yes"). Then continue.

---

## Round 1: About you

Ask these questions in order, one at a time.

---

### 1. Name

> "What do you want to call me? Some people pick a name like Jarvis, Sage, or Friday. Others just go with 'Assistant'. Your call."

On answer: Edit `IDENTITY.md`. Replace the placeholder name with what the user said.

---

### 2. Your name and role

> "What's your name, and what do you do? One or two sentences is enough."

On answer: Edit `USER.md`. Fill in the `## Basics → Name` field and the `## What I Do` section.

---

### 3. Timezone and work hours

> "What's your timezone, and roughly what hours do you work? (e.g. UTC-4, 9am-6pm) — I use this so I don't schedule things at 3am or ping you on weekends."

On answer: Edit `USER.md`. Fill in timezone and work hours fields.

---

### 4. Language

> "What language do you prefer I use by default? If you ever switch languages mid-conversation, I'll follow along."

On answer: Edit `USER.md` language field. Edit `SOUL.md` — update the `Default language:` line at the bottom of the Language section.

---

### 5. Current priorities

> "What are you mainly focused on right now? Work projects, side projects, personal goals — whatever's taking up your headspace. A few bullet points is fine."

On answer: Edit `USER.md`. Fill in the `## Current Priorities` and `## Active Projects` sections.

---

## Round 2: How you want me to work

Transition with:
> "A few more questions about how you like to work."

---

### 6. Feedback style

> "How direct do you want me to be? I can give you blunt, no-sugarcoat feedback — push back on your ideas, call out weak plans. Or I can be warmer and more collaborative. Or anywhere in between."

On answer: Edit `SOUL.md`. Update the `## Opinions & Feedback Style` section to match what they said. Replace the `# CUSTOMIZE:` comment with their preference.

---

### 7. Hard rules

> "Any hard rules I should know? For example: 'always ask before sending anything externally', 'no messages after 10pm', 'never delete files without confirmation'. These go into your rulebook."

On answer: Edit `AGENTS.md`. Add a "User Rules" section after the Safety Baseline section with what they listed. If they say "nothing", skip.

---

### 8. Services

> "Do you use any of these? I'll remind you to connect them after setup — no keys needed now, just so I know what to expect.
> - Notion (task management)
> - GitHub (code)
> - Brave Search (web search for me)
> - Anything else? (OpenClaw integrates with services via their APIs — name it and I'll let you know if it's supported)"

On answer: Edit `TOOLS.md`. Add entries under the `## Planned Integrations` section with what they listed and a note: "Run the terminal command to connect each service — never send tokens through chat."

If they say "none": respond "No problem — TOOLS.md is there whenever you're ready to add one. We can skip this for now."

---

### 9. Skills

> "I can load specialized skills for specific tasks — writing, coding, summarizing content, working with spreadsheets, and more. What kinds of tasks do you do most?
>
> A few useful ones to start with:
> - `summarize` — paste a URL, get a summary
> - `github` — issues, PRs, CI status
> - `weather` — for morning briefings
> - `humanizer` — makes AI-sounding text more natural
>
> If there's a specific skill you want, tell me what you need and I'll help you find and install it. You can also browse the marketplace at clawhub.com."

On answer: Help the user find and install skills they want. The `auto-improve` skill is already bundled in this pack under `skills/auto-improve/`. For other skills, browse clawhub.com or help them describe what they need.

---

## Round 3: Learning loop setup

Transition with: "I want to set up one thing that makes a big difference over time."

Explain:
> "I can run a short session every night while you sleep — fix one small friction point in how we work, keep files tidy, and generate a weekly learning report. It's called Auto-Improve.
>
> It runs at 4am UTC by default. Want me to set it up? (You can change the time anytime.)"

If yes:

**Step 1:** Ask for their Telegram chat ID:
> "To set this up, I need your Telegram chat ID. Run this in your terminal and paste me the result:
> ```
> openclaw directory self --channel telegram
> ```"

**Step 2:** Wait for the answer. Save the chat ID to `TOOLS.md` under a new "## Telegram" section:
```markdown
## Telegram
- Chat ID: [the ID they gave you]
```

**Step 3:** Create the cron using the actual chat ID:

```bash
openclaw cron create \
  --name "Auto-Improve" \
  --cron "0 4 * * *" \
  --message "AUTO-IMPROVE: 1) Pick ONE friction point from recent interactions and fix it autonomously. Log in memory/auto-improve-log.md. 2) Check for stale crons, empty files, scattered docs. Auto-fix safe issues, flag risky ones. 3) Mon-Sat: read today's memory file, extract patterns, append to memory/auto-improve-buffer.md. Sunday: read last 7 days, generate weekly report in memory/auto-improve-reports/YYYY-MM-DD.md with patterns found and one improvement to try next week." \
  --to telegram:THEIR_ACTUAL_CHAT_ID \
  --announce \
  --wake now
```

**Step 4:** Confirm:
> "Auto-Improve is set up. It'll run tonight. You'll get a brief report in the morning if it found anything worth flagging. You can turn it off anytime with `openclaw cron list` and `openclaw cron delete <id>`."

If no — note it in TOOLS.md and move on.

---

## Finish

Send this summary message (replace unfilled placeholders with "not set"):

> "Setup complete. Here's what we configured:
> - **Name:** [name]
> - **Timezone:** [timezone], working [hours]
> - **Language:** [language]
> - **Tone:** [brief description]
> - **Skills:** [list or 'none yet — browse clawhub.com when ready']
> - **Auto-Improve:** [enabled/skipped]
>
> Your workspace files are set. You can open and edit any of them directly — they're just text files in your `~/clawd/` folder.
>
> A few things worth doing this week:
> - Run `openclaw security audit` in your terminal to check your setup
> - Browse [clawhub.com](https://clawhub.com) for more skills
> - Connect Brave Search for web access: `mkdir -p ~/.config/brave && echo 'YOUR_KEY' > ~/.config/brave/api_key` (get key at brave.com/search/api — free tier)
>
> What do you want to work on first?"

Only delete `BOOTSTRAP.md` after confirming all steps completed successfully.

---

## Rules during onboarding

- One question at a time.
- If the user skips a question, use a sensible default and note it.
- Never ask for or accept API keys, tokens, or passwords through chat. If they try to send one, stop them and give the terminal command instead.
- Keep it light and conversational. This should feel like a 10-minute chat, not a form.
- If the user wants to change a previous answer, go back and fix it.
