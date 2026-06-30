#!/usr/bin/env bash
# sprint-auto-update.sh
# Event: Stop
# Short reminder when sprint files have uncommitted changes. Always exit 0.

set -u

cat >/dev/null 2>&1 || true

# Only relevant when the project tracks sprints.
[ -d "./sprints" ] || exit 0

command -v git >/dev/null 2>&1 || exit 0
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

# Uncommitted (staged or unstaged) changes under sprints/.
CHANGED="$(git status --short -- 'sprints/' 2>/dev/null)"
[ -z "$CHANGED" ] && exit 0

# Was tracking.md among the changed sprint files?
if ! printf '%s' "$CHANGED" | grep -q 'sprints/tracking.md'; then
  echo "Lembrete: arquivos de sprint foram modificados mas sprints/tracking.md pode estar desatualizado. Use /laravel-toolkit:sprint."
else
  N="$(printf '%s' "$CHANGED" | wc -l | tr -d ' ')"
  echo "Lembrete: ${N} arquivo(s) de sprint com mudancas nao commitadas."
fi

exit 0
