# Publish Skill — упаковка процессов в переиспользуемые скиллы

Превращает удачный процесс из текущей Claude-сессии в установленный локальный skill + публичный GitHub-репо с инструкцией + карточку на твоём сайте. Одной командой.

---

## Зачем это нужно

### Проблема

Каждый день в чатах с Claude рождаются полезные процессы: «как опубликовать листинг на eBay», «как переносить контекст между сессиями», «как делать ингест видео-урока в туториал». Но они умирают вместе с сессией. В следующий раз ты:

- Заново объясняешь шаги
- Забываешь edge-cases
- Не можешь поделиться с другими
- Не помнишь какие MCP / API ключи нужны

### До

- Полезный процесс остаётся в чате, теряется при компакте
- Чтобы поделиться — копируешь промт в Notion / Telegram, теряется форматирование, нет установки
- Нет единого места где видны все твои наработки

### После

Одна команда упаковки даёт:
1. **Локальный SKILL.md** в `~/.claude/skills/<slug>/` — сразу триггерится у тебя
2. **Публичный GitHub-репо** `sergeyramas/<slug>-skill` с README (до/после, требования, install, триггеры)
3. **GitHub Pages landing** для красивой ссылки
4. **MDX-карточку** на твоём сайте (sergeyramas.vercel.app) — Vercel автодеплоит
5. **One-line install** для друзей: `curl -fsSL .../install.sh | bash`

Твой сайт превращается в публичный каталог твоих процессов.

---

## Требования

- **Agent:** Claude Code (использует Read/Write/Bash инструменты + Skill API)
- **Tools / CLI:**
  - `gh` (GitHub CLI), залогинен на нужный аккаунт
  - `git`
  - `bash`
- **Accounts:**
  - GitHub аккаунт (по умолчанию `sergeyramas` — поменяй в SKILL.md под себя)
  - Vercel-проект подключённый к репо твоего сайта (опционально, для карточек)
- **Локальная структура:**
  - `~/.claude/skills/` для локальной установки скиллов
  - `~/Documents/<твой-сайт>/content/items/` если хочешь карточки (формат Velite MDX)
- **OS:** macOS / Linux

---

## Установка

```bash
curl -fsSL https://raw.githubusercontent.com/sergeyramas/publish-skill/main/install.sh | bash
```

Или вручную:
```bash
git clone https://github.com/sergeyramas/publish-skill ~/.claude/skills/publish-skill
```

После установки **открой SKILL.md и замени** `sergeyramas` и `~/Documents/ramas-site` на свои значения (GitHub username и путь к твоему сайту).

---

## Использование

В конце сессии где у тебя получился удачный процесс, скажи Claude:

**По-русски:**
- "упакуй это в скилл"
- "сделай из этого навык"
- "опубликуй процесс"
- "поделись этим"

**In English:**
- "publish skill"
- "ship this as a skill"
- "package this process"

Скилл сам:
1. Дистиллирует процесс из текущего чата (проблема → шаги → антипаттерны)
2. Спрашивает уточнения если что-то неясно
3. Создаёт всё нужное и пушит

---

## Что под капотом

Скилл следует Anthropic Skill Specification: frontmatter с `name` + `description` (триггеры на двух языках), тело с секциями Goal / When NOT / Requirements / Process / Anti-patterns. Использует Velite-формат для MDX-карточек (можно адаптировать под Next.js / Astro / любой статический генератор).

GitHub Pages работает через `_config.yml` с темой `jekyll-theme-cayman` — простая установка через `gh api`.

---

## Адаптация под себя

Базовый скилл заточен под мой стек (`sergeyramas` / `~/Documents/ramas-site` с Velite-MDX). Чтобы перенести под себя:

1. В `SKILL.md` замени `sergeyramas` на свой GitHub username
2. Замени `~/Documents/ramas-site` на путь к своему сайту
3. Если у тебя другой формат content (не Velite-MDX) — адаптируй Step 6 под формат своего сайта
4. Если нет своего сайта — можно убрать Step 6 совсем, оставив только GitHub-репо

---

## Автор

[@sergeyramas](https://github.com/sergeyramas) — публикую удачные процессы как переиспользуемые скиллы на [sergeyramas.vercel.app](https://sergeyramas.vercel.app).

Этот скилл — мета-скилл: им самим я и публикую все остальные.
