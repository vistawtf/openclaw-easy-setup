---
name: skill-creator
description: Guide for creating effective skills. This skill should be used when users want to create a new skill (or update an existing skill) that extends your agent's capabilities with specialized knowledge, workflows, or tool integrations.
---

# Skill Creator

A skill for creating new skills and iteratively improving them.

At a high level, the process of creating a skill goes like this:

- Decide what you want the skill to do and roughly how it should do it
- Write a draft of the skill
- Create a few test prompts and run the skill on them
- Help the user evaluate the results qualitatively (and optionally quantitatively)
- Rewrite the skill based on feedback
- Repeat until satisfied

Your job is to figure out where the user is in this process and help them progress through these stages. Maybe they say "I want to make a skill for X" — help narrow down what they mean, write a draft, write test cases, run them, and iterate. Maybe they already have a draft — go straight to the eval/iterate part.

Of course, always be flexible. If the user says "just vibe with me, no evaluations," do that instead.

---

## Communicating with the User

The skill creator will be used by people across a wide range of technical familiarity. Pay attention to context cues:

- "evaluation" and "benchmark" are borderline but OK
- For "JSON" and "assertion" — see serious cues from the user before using without explaining
- Briefly explain terms if you're in doubt

---

## About Skills

Skills are modular, self-contained packages that extend your agent's capabilities by providing specialized knowledge, workflows, and tools. Think of them as "onboarding guides" for specific domains — they transform a general-purpose agent into a specialized one equipped with procedural knowledge that no model can fully possess.

### What Skills Provide

1. Specialized workflows — Multi-step procedures for specific domains
2. Tool integrations — Instructions for working with specific file formats or APIs
3. Domain expertise — Company-specific knowledge, schemas, business logic
4. Bundled resources — Scripts, references, and assets for complex and repetitive tasks

---

## Core Principles

### Concise is Key

The context window is a public good. Skills share the context window with everything else: system prompt, conversation history, other skills' metadata, and the actual user request.

**Default assumption: the agent is already very smart.** Only add context the agent doesn't already have. Challenge each piece of information: "Does the agent really need this?" and "Does this paragraph justify its token cost?"

Prefer concise examples over verbose explanations.

### Set Appropriate Degrees of Freedom

Match specificity to the task's fragility and variability:

- **High freedom (text-based instructions)**: When multiple approaches are valid or decisions depend on context
- **Medium freedom (pseudocode or scripts with parameters)**: When a preferred pattern exists but some variation is acceptable
- **Low freedom (specific scripts, few parameters)**: When operations are fragile, consistency is critical, or a specific sequence must be followed

Think of the agent as exploring a path: a narrow bridge with cliffs needs specific guardrails, while an open field allows many routes.

### Explain the Why

Try hard to explain the *why* behind everything you're asking the model to do. Today's LLMs are smart. They have good theory of mind and when given a good harness can go beyond rote instructions. If you find yourself writing ALWAYS or NEVER in all caps, or using super rigid structures, that's a yellow flag — if possible, reframe and explain the reasoning. That's more humane, powerful, and effective.

---

## Anatomy of a Skill

```
skill-name/
├── SKILL.md (required)
│   ├── YAML frontmatter (name, description required)
│   └── Markdown instructions
└── Bundled Resources (optional)
    ├── scripts/    - Executable code for deterministic/repetitive tasks
    ├── references/ - Docs loaded into context as needed
    └── assets/     - Files used in output (templates, icons, fonts)
```

### SKILL.md (required)

Every SKILL.md consists of:

- **Frontmatter** (YAML): Contains `name` and `description`. These are the only fields the agent reads to determine when the skill gets used — be clear and comprehensive. Do not include any other fields.
- **Body** (Markdown): Instructions and guidance. Only loaded *after* the skill triggers.

The description is the primary triggering mechanism. Include both what the skill does AND specific contexts for when to use it. All "when to use" info goes in the description, not in the body (the body isn't loaded until after triggering).

**Make descriptions a little "pushy."** The agent has a tendency to undertrigger. Instead of "How to build a dashboard," write "How to build a dashboard. Use whenever the user mentions dashboards, data visualization, or wants to display any kind of company data, even if they don't explicitly ask for a 'dashboard.'"

### Bundled Resources (optional)

#### Scripts (`scripts/`)

Executable code (Python/Bash/etc.) for deterministic or repeatedly-rewritten tasks.

- **When to include**: When the same code is being rewritten repeatedly
- **Benefits**: Token efficient, deterministic, may be executed without loading into context
- **Note**: Scripts may still need to be read by the agent for patching or environment adjustments

#### References (`references/`)

Documentation loaded as needed into context.

- **When to include**: For documentation the agent should reference while working
- **Examples**: `references/schema.md` for DB schemas, `references/api_docs.md` for API specs
- **Best practice**: If files are large (>10k words), include grep search patterns in SKILL.md
- **Avoid duplication**: Information should live in either SKILL.md or references files, not both

#### Assets (`assets/`)

Files used in output, not loaded into context.

- **When to include**: When the skill needs files used in the final output
- **Examples**: `assets/logo.png`, `assets/slides.pptx`, `assets/frontend-template/`

### What NOT to Include

Do NOT create extraneous documentation: README.md, INSTALLATION_GUIDE.md, QUICK_REFERENCE.md, CHANGELOG.md, etc. The skill should only contain what an AI agent needs to do the job at hand.

---

## Progressive Disclosure Design Principle

Skills use a three-level loading system:

1. **Metadata (name + description)** — Always in context (~100 words)
2. **SKILL.md body** — When skill triggers (<500 lines ideal)
3. **Bundled resources** — As needed (unlimited; scripts can be executed without reading into context)

Keep SKILL.md under 500 lines. When approaching this limit, split content into reference files and add clear pointers about where to go next. For reference files longer than ~100 lines, include a table of contents at the top.

### Progressive Disclosure Patterns

**Pattern 1: High-level guide with references**
```markdown
## Advanced features
- **Form filling**: See [FORMS.md](references/FORMS.md) for complete guide
- **API reference**: See [REFERENCE.md](references/REFERENCE.md) for all methods
```

**Pattern 2: Domain-specific organization**
For skills supporting multiple domains, organize by variant so the agent only reads what's relevant:
```
cloud-deploy/
├── SKILL.md (workflow + provider selection)
└── references/
    ├── aws.md
    ├── gcp.md
    └── azure.md
```

**Pattern 3: Conditional details**
```markdown
**For tracked changes**: See [REDLINING.md](references/REDLINING.md)
**For OOXML details**: See [OOXML.md](references/OOXML.md)
```

**Guidelines:**
- Keep references one level deep from SKILL.md
- Don't create all-caps MUST/ALWAYS unless truly necessary — explain the why instead

---

## Skill Creation Process

1. Capture intent and understand with concrete examples
2. Plan reusable skill contents (scripts, references, assets)
3. Create the skill directory and SKILL.md
4. Edit the skill
5. Test and iterate based on real usage

### Step 1: Capture Intent

Start by understanding the user's intent. The current conversation might already contain a workflow the user wants to capture (e.g., "turn this into a skill"). If so, extract answers from the conversation history first — the tools used, the sequence of steps, corrections the user made, input/output formats observed.

Key questions to answer:
1. What should this skill enable the agent to do?
2. When should this skill trigger? (what user phrases/contexts)
3. What's the expected output format?
4. Should we set up test cases? Skills with objectively verifiable outputs (file transforms, data extraction, code generation) benefit from test cases. Skills with subjective outputs (writing style) often don't.

Avoid asking too many questions at once. Start with the most important and follow up as needed.

Also check available MCPs — if useful for research (docs, finding similar skills, best practices), research in parallel via subagents if available.

### Step 2: Plan Reusable Skill Contents

Analyze each concrete example by:
1. Considering how to execute it from scratch
2. Identifying what scripts, references, and assets would help across repeated invocations

Examples:
- "Rotate this PDF" → `scripts/rotate_pdf.py` saves rewriting each time
- "Build me a dashboard" → `assets/template/` provides boilerplate to copy
- "How many users logged in today?" (BigQuery) → `references/schema.md` avoids re-discovering schemas

Create a list of reusable resources before writing the skill.

### Step 3: Create the Skill Directory

Skip this step only if the skill already exists and you're iterating.

```bash
mkdir -p ~/clawd/skills/<skill-name>
touch ~/clawd/skills/<skill-name>/SKILL.md
```

Add subdirectories identified in Step 2 (`scripts/`, `references/`, `assets/`) as needed. Only create what the skill actually uses — don't add empty placeholder directories.

**Note on skill location:** Skills can also be installed to `~/.openclaw/workspace/skills/` for system-level availability. Use `~/clawd/skills/` for workspace-specific skills (e.g., personal workflows).

### Step 4: Edit the Skill

The skill is being created for another agent instance to use. Include information that would be beneficial and non-obvious to another agent. Consider what procedural knowledge, domain-specific details, or reusable assets would help another agent execute these tasks more effectively.

#### Start with Reusable Contents

Implement `scripts/`, `references/`, and `assets/` files first. Note this may require user input (e.g., for a `brand-guidelines` skill, the user may need to provide brand assets).

Test scripts by actually running them with `exec` to ensure no bugs. If there are many similar scripts, test a representative sample.

#### Write SKILL.md

Use imperative/infinitive form in instructions.

**Frontmatter template:**
```yaml
---
name: skill-name
description: What this skill does. Use when: [specific triggers]. Also use when the user mentions [keywords], [phrases], or [contexts].
---
```

**Body guidelines:**
- Start with any essential orientation the agent needs
- Reference bundled resources with clear guidance on when to read them
- Use output format templates where precision matters:
  ```markdown
  ## Output format
  ALWAYS use this structure:
  # [Title]
  ## Summary
  ## Key findings
  ## Recommendations
  ```
- Use examples where helpful:
  ```markdown
  ## Example
  Input: Added user authentication with JWT tokens
  Output: feat(auth): implement JWT-based authentication
  ```

### Step 5: Test and Iterate

After creating a draft, come up with 2-3 realistic test prompts — the kind of thing a real user would actually say. Share them with the user: "Here are a few test cases I'd like to try. Do these look right, or do you want to add more?" Then run them.

**Running test cases in OpenClaw:**

For each test case, run the skill and check the output. If subagents are available, you can spawn parallel runs (with-skill vs without-skill as baseline). Save outputs to a workspace directory organized by iteration:

```
<skill-name>-workspace/
├── iteration-1/
│   ├── eval-0/
│   │   └── outputs/
│   └── eval-1/
│       └── outputs/
└── iteration-2/
    └── ...
```

**Iteration workflow:**
1. Use the skill on real tasks
2. Notice struggles or inefficiencies
3. Identify how SKILL.md or bundled resources should be updated
4. Implement changes and test again

Keep going until:
- The user says they're happy
- The feedback is all positive
- You're not making meaningful progress

#### How to Think About Improvements

**Generalize from the feedback.** You're iterating on a few examples, but the skill will be used a million times across many different prompts. Avoid overfitting to specific examples. If there's a stubborn issue, try different metaphors or recommend different working patterns.

**Keep the skill lean.** Remove things that aren't pulling their weight. If the skill is making the agent waste time on unproductive steps, remove the parts causing that.

**Look for repeated work across test cases.** If all 3 test cases resulted in the agent writing a `create_chart.py`, that's a strong signal the skill should bundle that script. Write it once, put it in `scripts/`, and point the skill at it.

---

## Description Optimization

The description field is the primary mechanism that determines whether the agent invokes a skill. After creating or improving a skill, optimize the description for better triggering accuracy.

### Principles for Good Descriptions

**Coverage:** Include different phrasings of the same intent — some formal, some casual. Include cases where the user doesn't explicitly name the skill but clearly needs it.

**Near-miss negatives:** The most valuable "don't trigger" cases are near-misses — queries that share keywords with the skill but actually need something different. Think adjacent domains and ambiguous phrasing.

**Complexity signal:** The agent consults skills for complex, multi-step tasks more reliably than simple one-off queries. Simple queries like "read this PDF" may not trigger even if the description matches perfectly. Design your descriptions to signal multi-step value.

### Description Template

```
[What the skill does in one sentence]. Use when: [specific situations]. Also use when the user mentions [keyword list], [phrase variants], or [context clues]. NOT for: [adjacent things this skill doesn't cover].
```

### Testing Descriptions

To test whether your description triggers correctly, try these queries mentally or with a test run:
- A direct request that obviously needs the skill
- A casual/informal phrasing of the same intent
- An indirect request that clearly needs the skill but doesn't name it
- A near-miss that should NOT trigger the skill

Adjust the description until the right queries trigger and the wrong ones don't.

---

## Updating an Existing Skill

When updating an existing skill (not creating new):
- **Preserve the original name.** Note the skill's directory name and `name` frontmatter — use them unchanged.
- **Copy to a writable location before editing if needed.** If the installed path is read-only (e.g., system skills), copy to `/tmp/skill-name/`, edit there, then copy back.
- **Snapshot before editing:** `cp -r <skill-path> /tmp/<skill-name>-snapshot/` so you can diff or revert.

---

## Reference: Common Patterns

### Output format enforcement
```markdown
## Report structure
ALWAYS use this exact template:
# [Title]
## Executive Summary
## Key Findings
## Recommendations
```

### Input/output examples
```markdown
## Commit message format
**Example:**
Input: Added user authentication with JWT tokens
Output: feat(auth): implement JWT-based authentication
```

### Conditional reference loading
```markdown
## Processing
For basic extraction, use [approach].
For complex tables: read [references/tables.md](references/tables.md).
For form fields: read [references/forms.md](references/forms.md).
```

---

## Quick Checklist Before Finalizing a Skill

- [ ] Description is specific enough to trigger reliably — includes keyword variants and "also use when"
- [ ] SKILL.md body is under 500 lines
- [ ] All bundled resources are referenced in SKILL.md with guidance on when to read them
- [ ] No README.md, CHANGELOG.md, or other extraneous files
- [ ] Scripts are tested and working
- [ ] The skill has been tested on at least 2-3 realistic prompts
- [ ] The "why" is explained for non-obvious instructions, not just the "what"
