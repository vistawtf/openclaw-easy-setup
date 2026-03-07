---
name: voice-extractor
description: Extract a comprehensive writing style profile from any author's content. Analyzes voice, structure, word choice, formatting, and engagement patterns to produce a reusable style guide with DO/DON'T examples. Use when asked to analyze someone's writing style, create a voice profile, build a voice/style skill for a specific author, or replicate/mimic a writer's tone. Input can be URLs, pasted text, or both. Output is a complete style guide saved as a new voice skill.
---

# Voice Extractor

Analyze an author's content and produce a comprehensive, actionable writing style profile — complete with real DO/DON'T examples extracted from their work.

The output is a full voice skill (two files) that any agent can use to write in that author's style.

## Minimum Content Requirements

**Hard minimum:** 5 pieces of content (articles, threads, newsletters, or posts).

**Recommended:** 8-15 pieces across different topics.

**Why:** Style patterns only emerge through repetition. With fewer than 5 pieces, you can't distinguish personal style from topic-specific language. You'll mistake a one-time phrasing for a signature habit.

**If the user provides fewer than 5 pieces:**
1. Say so explicitly: "I have [N] pieces. I can build a preliminary profile, but it will have gaps. Some patterns I flag might be one-offs rather than true habits."
2. Build the profile anyway, but mark low-confidence observations with `[LOW CONFIDENCE — seen in only N/M samples]`.
3. Ask if they can provide more content.

**Ideal content mix:**
- Different topics (to separate style from subject matter)
- Different lengths (tweets vs. long-form reveal different habits)
- Different time periods if possible (to catch evolved vs. stable patterns)
- Include at least 2-3 strong pieces and 1-2 average ones (habits that persist in mediocre work are the real signatures)

---

## Step 1: Gather the Content

Accept input in any combination:
- **URLs:** Fetch each URL with `web_fetch`. For Twitter/X threads, try fetching — if blocked, ask the user to paste the text.
- **Pasted text:** Accept directly.
- **Files:** Read from provided file paths.

Store all gathered content mentally as the working corpus. Note the source, approximate word count, and topic of each piece.

**Before proceeding, inventory what you have:**
```
Corpus summary:
- [N] pieces collected
- Topics covered: [list]
- Platforms: [list]
- Total approximate word count: [N]
- Sufficient for full profile? [Yes / Preliminary only]
```

---

## Step 2: Analyze — The Seven Lenses

Read through the entire corpus once for general impression, then analyze systematically through each lens. For every observation, **find at least 2 concrete examples** from the corpus. If you can only find 1 example, mark it `[SINGLE INSTANCE]`.

### Lens 1: Voice & Persona

**What to look for:**
- What's the author's relationship to the reader? (mentor → student? peer → peer? expert → novice? friend → friend? provocateur → audience?)
- How much does the author reveal about themselves? (personal anecdotes? credentials? vulnerability? or purely instructional?)
- Confidence level: do they hedge or declare? Do they qualify opinions or state them as facts?
- Emotional register: passionate? detached? playful? urgent? calm?

**Extract:** 3-4 DO examples and 2-3 DON'T examples (DON'Ts are what this author would *never* write — construct them by writing the same idea in a generic/opposite style).

### Lens 2: Structure Patterns

**What to look for:**
- **Openings:** How do the first 2-3 sentences work? (question? bold claim? anecdote? statistic? scene-setting? direct address?)
- **Closings:** How do the last 2-3 sentences work? (CTA? summary? callback to opening? question? emotional punch? trailing off?)
- **Information sequencing:** What order does information flow? (problem → solution? claim → evidence? narrative → lesson? list-first? context-first?)
- **Transitions between sections:** Smooth prose bridges? Hard cuts? Headers? Conversational pivots?
- **Section length and density:** Long deep-dives or short punchy sections?

**Extract:** 2-3 opening examples, 2-3 closing examples, and transition phrases.

### Lens 3: Sentence-Level Patterns

**What to look for:**
- Average sentence length and variation (measure a few — does the author mix short and long, or stay consistent?)
- Paragraph length (1-2 sentences? 3-5? Long blocks?)
- Punctuation habits: ellipses, em dashes, semicolons, exclamation marks, colons, parentheses — which does the author reach for? Which do they avoid?
- Comma splices, fragments, run-ons — deliberate stylistic choices?
- Rhythm: does the prose have a pattern? (long → short punch? building momentum? staccato?)

**Extract:** 3-4 example sentences that demonstrate the signature rhythm.

### Lens 4: Word Choice

**What to look for:**
- **Recurring words/phrases:** What words appear across multiple pieces? (These are the author's verbal fingerprints.)
- **Vocabulary level:** Academic? Conversational? Technical? Slang? Mixed?
- **What's ABSENT:** This is critical. What words or patterns does this author *never* use? (Corporate language? Hedging? Filler? Certain punctuation? Specific constructions?)
- **Signature constructions:** Does the author have go-to sentence structures? ("The thing about X is..." / "Here's the deal:" / "Not X. Y.")

**Extract:** A list of 8-15 recurring words/phrases with context, and a list of 5-10 things that are notably absent.

### Lens 5: Engagement Mechanics

**What to look for:**
- How does the author create curiosity? (Information gaps? Open loops? Provocative claims? Future-pacing?)
- How does the author handle CTAs? (Direct? Embedded? Implied? Absent?)
- Does the author use controversy or strong opinions for engagement? How?
- How does the author create urgency or stakes?
- Reader interaction: does the author ask questions? Use direct address? Create hypothetical scenarios?

**Extract:** 2-3 examples of each technique identified.

### Lens 6: Formatting Specifics

**What to look for:**
- Capitalization rules (all lowercase? sentence case? title case?)
- Header style (bold text? markdown headers? ALL CAPS? numbered?)
- List style (bullets? dashes? ">"-markers? numbered? prose lists?)
- Bold/italic/underline usage patterns
- Whitespace and spacing (dense paragraphs? generous spacing? single-line paragraphs for emphasis?)
- Emoji usage (none? occasional? frequent? which ones?)
- Link formatting (inline? footnotes? bare URLs?)

**Extract:** Note every formatting convention observed, with examples.

### Lens 7: The Signature Distillation

After all six lenses, step back and answer: **What are the 5 things that, if removed, would make this stop sounding like this author?**

These are the non-negotiable traits. They should be:
- Observable (not vague)
- Specific to this author (not generic good writing advice)
- Present in every piece analyzed (not occasional flourishes)

Each trait gets a 2-3 sentence explanation of why it matters.

---

## Step 3: Build the Style Guide

Create the file at: `skills/[author-name]-voice/[author-name]-style.md`

Use this exact structure:

```markdown
# [Author Name] ([handle/platform]) Writing Style Guide

## Who is [Author Name]?

[1 paragraph: what they write about, where, for whom. Their positioning and what makes their content distinctive at a high level.]

---

## Voice & Persona

### The relationship with the reader

[Description of the author-reader dynamic. What role does the author play?]

[Tone description: what does the voice "say" implicitly?]

**DO:**
- "[real quote or close paraphrase from corpus]"
- "[real quote or close paraphrase from corpus]"
- "[real quote or close paraphrase from corpus]"

**DON'T:**
- "[same idea written in a way this author would never write]"
- "[same idea written in a way this author would never write]"
- "[same idea written in a way this author would never write]"

### Confidence level

[Description with examples]

**DO:**
- "[example]"
- "[example]"

**DON'T:**
- "[example]"
- "[example]"

---

## Structure Patterns

### Opening hooks

[Description of how the author opens pieces. What patterns recur?]

**Patterns used:**
- [Pattern name]: "[example from corpus]" ([which piece])
- [Pattern name]: "[example from corpus]" ([which piece])
- [Pattern name]: "[example from corpus]" ([which piece])

### Information sequencing

[Numbered description of the typical flow]

### Section transitions

[How the author moves between sections, with example phrases]

### Closings

[How the author ends pieces]

**DO:**
- "[real closing from corpus]"

**DON'T:**
- "[generic closing this author would never write]"

---

## Sentence-Level Patterns

### Sentence length

[Description of variation patterns with examples]

### Punctuation

[Each punctuation mark the author has a notable relationship with — usage or avoidance. With examples.]

### Paragraph length

[Typical length, variation, use of single-sentence paragraphs]

### Lists vs prose

[When and how the author uses lists. What style of list markers.]

---

## Word Choice

### Vocabulary level

[Description with DO/DON'T examples]

### Recurring words and phrases

[List of 8-15 recurring words/phrases with context]

### What's notably ABSENT

[List of word categories or specific constructions the author never uses]

---

## Engagement Mechanics

### Creating curiosity

[Techniques with examples]

### CTA construction

[How the author drives action, with examples]

### Controversy and tension

[How the author uses strong opinions or contrarian takes, if applicable]

---

## Formatting Specifics

[Every formatting convention: capitalization, bold/italic, headers, lists, whitespace, emoji, links]

---

## The 5 Things That Make It [Author Name]

Remove any of these and it stops sounding like [Author Name]:

1. **[Trait].** [2-3 sentence explanation.]
2. **[Trait].** [2-3 sentence explanation.]
3. **[Trait].** [2-3 sentence explanation.]
4. **[Trait].** [2-3 sentence explanation.]
5. **[Trait].** [2-3 sentence explanation.]

---

## Self-Review Checklist

Before publishing, run through this:

- [ ] [Checklist item derived from the analysis — binary yes/no, not subjective]
- [ ] [Checklist item]
- [ ] [Checklist item]
- [ ] [Checklist item]
- [ ] [Checklist item]
- [ ] [Checklist item]
- [ ] [Checklist item]
- [ ] [Checklist item]
- [ ] [Checklist item]
- [ ] [Checklist item]
- [ ] [At least 10 items, up to 17]
```

### Rules for building the style guide

1. **Every DO example must be a real quote or close paraphrase from the corpus.** Never invent examples. If you can't find a real example, note that explicitly.
2. **Every DON'T example should express the same idea as a corresponding DO, but in a style the author would never use.** These ARE constructed, but they must be plausible contrasts to real content.
3. **The checklist must be binary.** Every item should be answerable with yes or no, not "somewhat" or "it depends." Convert subjective observations into objective checks.
4. **If a section can't be filled confidently, say so.** Write: "[INSUFFICIENT DATA — only [N] examples found. This section needs more content to validate.]"

---

## Step 4: Build the SKILL.md

Create the file at: `skills/[author-name]-voice/SKILL.md`

Use this template:

```markdown
---
name: [author-name]-voice
description: Write content in [Author Name]'s ([handle]) voice — [one sentence describing their known style, topics, and audience]. Use when writing blog posts, threads, or articles in [Author Name]'s style.
---

# [Author Name] Voice Skill

Write content in [Author Name]'s ([handle]) distinctive voice. [One sentence about what they're known for and where they publish.]

## When to use this skill

- Writing blog posts, threads, or articles that should sound like [Author Name]
- Rewriting existing content into [Author Name]'s voice
- Creating content about [their topics] in [Author Name]'s style

## How to use

1. Read the full style guide at `skills/[author-name]-voice/[author-name]-style.md`
2. Apply all formatting and voice rules from the guide
3. Run through the self-review checklist at the bottom of the style guide before delivering

## Key rules (quick reference)

- **[Rule 1]** — [brief description]
- **[Rule 2]** — [brief description]
- **[Rule 3]** — [brief description]
- **[Rule 4]** — [brief description]
- **[Rule 5]** — [brief description]
- **[Rule 6]** — [brief description]
- **[Rule 7]** — [brief description]
- **[Rule 8]** — [brief description]
- **[Rule 9]** — [brief description]
- **[Rule 10]** — [brief description]

[These should map to the "5 Things" plus the most distinctive formatting/voice rules from the style guide. Aim for 8-12 rules.]

## Full style guide

The comprehensive style guide with DO/DON'T examples, structural patterns, engagement mechanics, and the self-review checklist is in:

skills/[author-name]-voice/[author-name]-style.md

Always read the full guide before writing. The checklist at the end is non-negotiable.
```

---

## Step 5: Deliver and Validate

1. Save both files.
2. Present the complete style guide to the user.
3. Ask the user to review and flag anything that feels off — they know the author's voice better than any analysis can capture.
4. If the user identifies issues, refine the profile.

---

## Limitations (Be Honest)

State these clearly when delivering the profile:

- **Translation loss:** If the author writes in one language and the corpus is translated, style nuances (slang, rhythm, wordplay) will be distorted or lost.
- **Platform-dependent style:** An author may write differently on Twitter vs. a blog vs. a newsletter. The profile reflects the platforms in the corpus. Flag if the corpus only covers one platform.
- **Evolution over time:** If all content is recent, the profile captures current style. If content spans years, note any observed evolution rather than averaging it out.
- **Humor and irony are hard to codify.** If the author relies heavily on humor, sarcasm, or irony, note this explicitly — these are the hardest patterns for an AI to replicate from rules alone.
- **Visual elements not captured.** If the author uses images, memes, screenshots, or video as part of their style, note that the text-only profile can't capture this dimension.
- **5 pieces is the floor, not the ideal.** With only 5 pieces, expect ~70% accuracy on style capture. With 10+, expect ~85-90%. Perfect mimicry requires human review and iteration regardless of corpus size.
