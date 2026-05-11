---
name: publish-skill
description: Use when the user wants to package a successful process from the current conversation into a reusable Claude Code / Codex skill AND publish it so others can install and repeat it. Triggers on "упакуй это в скилл", "сделай из этого навык", "опубликуй процесс", "ship this as a skill", "publish skill", "поделись этим", or any phrasing where the user says a process worked and wants it preserved + shareable. Creates the local SKILL.md, a public GitHub repo with README + installer + GitHub Pages landing, and adds a card to sergeyramas.vercel.app.
---

# Publish Skill

Goal: take a successful process from this conversation and produce:
1. Working local skill at `~/.claude/skills/<slug>/SKILL.md` (immediately usable)
2. Public GitHub repo `sergeyramas/<slug>-skill` with install instructions
3. GitHub Pages landing for the repo
4. Card on https://sergeyramas.vercel.app pointing to the repo

## When NOT to invoke

- User wants a one-off note (use `wiki-update` instead)
- Process didn't actually work yet — wait for verification first
- Skill already exists at that path — ask before overwriting

## Process

### Step 1 — Identify the source process

Distill from the conversation:
- **What problem** does the process solve (one sentence)
- **What inputs** the user provides
- **What outputs** the skill produces
- **What tools / MCPs / env** are required (Claude Code, Codex, Bash, gh, specific MCPs, API keys)
- **Step-by-step procedure** that worked
- **Edge cases / anti-patterns** encountered

If any of these are unclear — ask the user 1–3 focused questions before building.

### Step 2 — Pick a slug + name

- `slug` — kebab-case, ≤ 30 chars, unique under `~/.claude/skills/`
- `name` — same as slug (Anthropic skill spec uses name = letters/digits/hyphens)
- `title` — human-readable Russian, max 60 chars (used on the card)

Check uniqueness:
```bash
test -d ~/.claude/skills/<slug> && echo "EXISTS — ask user" || echo "OK"
ls ~/Documents/ramas-site/content/items/ | grep -i <slug>
```

### Step 3 — Build local skill

Path: `~/.claude/skills/<slug>/SKILL.md`

Required frontmatter:
```yaml
---
name: <slug>
description: Use when [specific triggers / symptoms / user phrases]. [What it produces.]
---
```

Then the body with these sections:
- **Goal** (one paragraph)
- **When NOT to invoke** (bullets)
- **Requirements** (what tools, agents, accounts, env)
- **Process** (numbered steps with bash where applicable)
- **Anti-patterns** (what goes wrong)

Rules:
- Description starts with "Use when..." and lists trigger phrases in both Russian and English (the user works bilingually)
- Body uses imperative voice, no narrative
- No emoji unless the user's existing skills use them

### Step 4 — Build the public repo

Working dir: `~/Documents/skills-published/<slug>-skill/` (mkdir -p)

Files:
- `SKILL.md` — copy of the local skill
- `README.md` — bilingual landing: **English first**, Russian below (see template)
- `install.sh` — one-command installer
- `_config.yml` — GitHub Pages config with SEO fields

**SEO requirements for README.md:**
- H1 must contain the primary English keyword (e.g. "Claude Code skill", "AI agent automation")
- First paragraph must contain 3–5 SEO keywords naturally
- H2 headings should use searchable terms ("Installation", "How it works", "Requirements")
- GitHub topics set via `gh repo edit --add-topic` after creation (4–6 tags)

**SEO keywords to always include** (adapt to topic):
`claude code`, `claude code skill`, `ai agent`, `anthropic claude`, `llm automation`, `codex cli`

**README.md template (English first, Russian second):**
```markdown
# <Title> — <Primary English keyword phrase>

> <One-line pitch in English, includes 2-3 SEO keywords>

**Claude Code skill** | Works with: Codex CLI · Gemini CLI

<!-- ENGLISH -->

## What it does

<2-4 sentences: problem → solution → outcome. Use keywords naturally.>

**Before:** <pain point in one line>
**After:** <outcome in one line>

## Requirements

- **Agent:** Claude Code (primary) | Codex CLI | Gemini CLI
- **Tools / MCPs:** <list>
- **Accounts / API keys:** <list or "none">
- **OS:** macOS / Linux

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/sergeyramas/<slug>-skill/main/install.sh | bash
```

Or manually:
```bash
git clone https://github.com/sergeyramas/<slug>-skill ~/.claude/skills/<slug>
```

Restart Claude Code / Codex after install.

## Usage

Tell your agent one of these trigger phrases:
- "<trigger EN 1>"
- "<trigger EN 2>"

## How it works

<Brief explanation of the internals, 3-5 sentences.>

---

<!-- RUSSIAN -->

## На русском

### Что делает

<2-4 предложения: проблема → решение → результат.>

**До:** <боль в одну строку>
**После:** <результат в одну строку>

### Установка

```bash
curl -fsSL https://raw.githubusercontent.com/sergeyramas/<slug>-skill/main/install.sh | bash
```

### Триггер-фразы

- "<trigger RU 1>"
- "<trigger RU 2>"

---

## Author

[@sergeyramas](https://github.com/sergeyramas) — I publish proven AI agent processes as reusable skills at [sergeyramas.vercel.app](https://sergeyramas.vercel.app).
```

**_config.yml template (with SEO):**
```yaml
theme: jekyll-theme-cayman
title: "<Title> — <Primary keyword>"
description: "<1-2 sentences with top 4 keywords. Shown in Google snippet.>"
plugins:
  - jekyll-seo-tag
```

**After repo creation — add GitHub topics:**
```bash
gh repo edit sergeyramas/<slug>-skill \
  --add-topic claude-code \
  --add-topic claude-skill \
  --add-topic ai-agent \
  --add-topic anthropic \
  --add-topic llm-automation \
  --add-topic <topic-specific-tag>
```

**install.sh:**
```bash
#!/usr/bin/env bash
set -euo pipefail
SLUG="<slug>"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}/$SLUG"
if [ -d "$DEST" ]; then
  echo "Already installed at $DEST. Remove it first or set CLAUDE_SKILLS_DIR." >&2
  exit 1
fi
mkdir -p "$(dirname "$DEST")"
git clone --depth 1 https://github.com/sergeyramas/${SLUG}-skill "$DEST"
echo "Installed → $DEST"
echo "Restart Claude Code / Codex to load."
```

### Step 5 — Create GitHub repo + push

```bash
cd ~/Documents/skills-published/<slug>-skill
git init -b main
git add .
git commit -m "Initial skill: <title>"
gh repo create sergeyramas/<slug>-skill --public --source=. --remote=origin --push \
  --description "<One-line pitch>"
```

Enable GitHub Pages (root, main branch):
```bash
gh api -X POST repos/sergeyramas/<slug>-skill/pages \
  -f source[branch]=main -f source[path]=/ 2>/dev/null || \
  gh api -X PUT repos/sergeyramas/<slug>-skill/pages \
  -f source[branch]=main -f source[path]=/
```

Landing URL: `https://sergeyramas.github.io/<slug>-skill/`

### Step 6 — Add card to ramas-site

File: `~/Documents/ramas-site/content/items/<slug>.mdx`

```markdown
---
title: "<Title>"
slug: "<slug>"
kind: solution
summary: "<≤280 char pitch: что делает, для кого, в чём польза>"
externalUrl: "https://github.com/sergeyramas/<slug>-skill"
tags: [skills, claude-code, <additional tags>]
status: live
date: <YYYY-MM-DD>
featured: false
---

## Что делает

<2-3 paragraphs from the README>

## Установка

```bash
curl -fsSL https://raw.githubusercontent.com/sergeyramas/<slug>-skill/main/install.sh | bash
```

## Триггеры

- "<trigger phrase 1>"
- "<trigger phrase 2>"

[Полная инструкция и исходники →](https://github.com/sergeyramas/<slug>-skill)
```

Commit and push:
```bash
cd ~/Documents/ramas-site
git add content/items/<slug>.mdx
git commit -m "Add skill card: <slug>"
git push
```

Vercel автоматически задеплоит.

### Step 7 — Report to user

Concise message (≤ 6 lines):
- ✅ Локальный скилл: `~/.claude/skills/<slug>/SKILL.md`
- ✅ Репо: `https://github.com/sergeyramas/<slug>-skill`
- ✅ Landing: `https://sergeyramas.github.io/<slug>-skill/`
- ✅ Карточка: `https://sergeyramas.vercel.app/solutions/<slug>` (после Vercel build ~1 мин)
- Install: `curl -fsSL .../install.sh | bash`

## Anti-patterns

- ❌ Публиковать сырой процесс без верификации в текущей сессии
- ❌ Дублировать существующий скилл вместо предложения его обновить
- ❌ Краткий README без секции "Требования" — пользователь не сможет повторить
- ❌ Слишком общий description во frontmatter — скилл не будет триггериться
- ❌ Использовать `--private` для репо (карточка должна вести на публичный URL)
- ❌ Забыть про `_config.yml` для GitHub Pages — landing не отрендерится
- ❌ Коммитить секреты / API keys в репо или в `install.sh`

## Requirements check (run before Step 5)

```bash
gh auth status >/dev/null 2>&1 || { echo "gh not authed"; exit 1; }
test -d ~/Documents/ramas-site || { echo "ramas-site missing"; exit 1; }
```
