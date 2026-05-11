# Publish Skill — Claude Code Skill for Packaging AI Agent Processes

> Turn any successful Claude session process into a reusable skill: local SKILL.md + public GitHub repo + landing page + site card. One trigger phrase.

**Claude Code meta-skill** | Works with: Codex CLI · Gemini CLI

<!-- ENGLISH -->

## What it does

Every day useful processes emerge in Claude chats — how to publish an eBay listing, how to transfer session context, how to ingest a video lesson into a tutorial. They die with the session. This meta-skill packages them into installable, shareable skills.

**Before:** Useful process stays in the chat, lost on compact. To share — you copy a prompt to Notion, formatting breaks, no install instructions, no requirements list.

**After:** One phrase → local SKILL.md installed + public GitHub repo with bilingual README + GitHub Pages landing + card on your site. Others install it with one `curl` command.

What gets created per skill:

1. `~/.claude/skills/<slug>/SKILL.md` — immediately triggers in your agent
2. `github.com/sergeyramas/<slug>-skill` — public repo with README, install.sh, _config.yml
3. `sergeyramas.github.io/<slug>-skill/` — GitHub Pages landing
4. Card on `sergeyramas.vercel.app` — Vercel auto-deploys

## Requirements

- **Agent:** Claude Code (primary) | Codex CLI | Gemini CLI
- **Tools / CLI:** `gh` (GitHub CLI, authenticated) · `git` · `bash`
- **Accounts:** GitHub account · Vercel-connected site repo (optional, for cards)
- **Local structure:** `~/.claude/skills/` for skills · `~/Documents/<your-site>/content/items/` for MDX cards (Velite format)
- **OS:** macOS / Linux

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/sergeyramas/publish-skill/main/install.sh | bash
```

Or manually:
```bash
git clone https://github.com/sergeyramas/publish-skill ~/.claude/skills/publish-skill
```

**After installing:** open `~/.claude/skills/publish-skill/SKILL.md` and replace `sergeyramas` with your GitHub username and `~/Documents/ramas-site` with your site repo path.

Restart Claude Code / Codex after install.

## Usage

Tell your agent one of these trigger phrases after a process worked:

**English triggers:**
- "publish skill"
- "ship this as a skill"
- "package this process"

**Russian triggers:**
- "упакуй это в скилл"
- "сделай из этого навык"
- "опубликуй процесс"

## How it works

The skill distills the process from the current chat (problem → steps → anti-patterns → requirements), generates a bilingual README with before/after framing and SEO keywords, creates the GitHub repo with GitHub Pages enabled, and adds an MDX card to your Vercel site. Uses Anthropic Skill Specification format for SKILL.md frontmatter.

---

<!-- RUSSIAN -->

## На русском

### Что делает

Мета-скилл для Claude Code: превращает удачный процесс из текущего чата в установленный локальный skill + публичный GitHub-репо + лендинг + карточку на сайте.

**До:** процесс остаётся в чате, теряется при компакте. Чтобы поделиться — копируешь промт в Notion, теряется форматирование, нет инструкции по установке.

**После:** одна фраза → SKILL.md установлен локально + публичный репо с двуязычным README + GitHub Pages лендинг + карточка на сайте. Друзья устанавливают через одну `curl`-команду.

### За один вызов создаётся

1. `~/.claude/skills/<slug>/SKILL.md` — сразу триггерится у тебя
2. Публичный GitHub-репо с README (EN+RU), install.sh, _config.yml
3. GitHub Pages лендинг
4. MDX-карточка на твоём сайте (Vercel автодеплоит)

### Установка

```bash
curl -fsSL https://raw.githubusercontent.com/sergeyramas/publish-skill/main/install.sh | bash
```

После установки замени в `SKILL.md`: `sergeyramas` → твой GitHub username, `~/Documents/ramas-site` → путь к твоему сайту.

### Триггер-фразы

- "упакуй это в скилл", "опубликуй процесс", "сделай из этого навык"
- "publish skill", "ship this as a skill"

---

## Author

[@sergeyramas](https://github.com/sergeyramas) — I publish proven AI agent processes as reusable skills at [sergeyramas.vercel.app](https://sergeyramas.vercel.app).

*This meta-skill was used to publish itself.*
