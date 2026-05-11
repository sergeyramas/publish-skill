#!/usr/bin/env bash
set -euo pipefail

SLUG="publish-skill"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}/$SLUG"

if [ -d "$DEST" ]; then
  echo "Already installed at $DEST." >&2
  echo "Remove it first or set CLAUDE_SKILLS_DIR to install elsewhere." >&2
  exit 1
fi

mkdir -p "$(dirname "$DEST")"
git clone --depth 1 https://github.com/sergeyramas/publish-skill "$DEST"

echo ""
echo "✓ Installed → $DEST"
echo ""
echo "  IMPORTANT: open $DEST/SKILL.md and replace:"
echo "    - sergeyramas → your GitHub username"
echo "    - ~/Documents/ramas-site → path to your site repo (or remove Step 6)"
echo ""
echo "  Then restart Claude Code / Codex to load the skill."
echo ""
echo "  Trigger phrases:"
echo "    RU: «упакуй это в скилл», «опубликуй процесс», «сделай из этого навык»"
echo "    EN: «publish skill», «ship this as a skill»"
