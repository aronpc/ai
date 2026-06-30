#!/usr/bin/env bash
# post-commit-doc-check.sh
# Event: PostToolUse / Bash
# After a `git commit` that touched code (app/, resources/, routes/, database/)
# without updating IMPLEMENTATION.md in the last 3 commits, emit a warning.
# Always informational (exit 0).

set -u

INPUT="$(cat 2>/dev/null || true)"
[ -z "$INPUT" ] && exit 0
command -v jq >/dev/null 2>&1 || exit 0

COMMAND="$(printf '%s' "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)"
[ -z "$COMMAND" ] && exit 0

# Only react to git commit commands.
printf '%s' "$COMMAND" | grep -Eq 'git[[:space:]]+commit' || exit 0

# Need a git repo with at least one commit.
command -v git >/dev/null 2>&1 || exit 0
git rev-parse --verify HEAD >/dev/null 2>&1 || exit 0

# Files changed in the just-created commit. `git show` is used (not diff-tree)
# because it also lists files for a root commit, which has no parent to diff.
CHANGED="$(git show --name-only --format= HEAD 2>/dev/null)"
[ -z "$CHANGED" ] && exit 0

# Did this commit touch code?
printf '%s' "$CHANGED" | grep -Eq '^(app|resources|routes|database)/' || exit 0

# Skip docs:/chore: commits (they are not expected to update IMPLEMENTATION.md).
SUBJECT="$(git log -1 --format=%s 2>/dev/null)"
printf '%s' "$SUBJECT" | grep -Eiq '^(docs|chore)(\(|:)' && exit 0

# Was IMPLEMENTATION.md updated in any of the last 3 commits?
RECENT_DOCS="$(git log -3 --name-only --format= 2>/dev/null | grep -c 'IMPLEMENTATION.md' || true)"
if [ "${RECENT_DOCS:-0}" -eq 0 ]; then
  echo "Aviso: codigo foi commitado mas IMPLEMENTATION.md nao foi atualizado nos ultimos commits."
  echo "Use /laravel-toolkit:docs para atualizar a documentacao."
fi

exit 0
