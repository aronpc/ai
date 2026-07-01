#!/usr/bin/env bash
# sprint-auto-update.sh
# Evento: Stop
# Lembrete curto quando arquivos de sprint tem mudancas nao commitadas.
# Sempre exit 0.

set -u

cat >/dev/null 2>&1 || true

# So relevante quando o projeto rastreia sprints.
[ -d "./sprints" ] || exit 0

command -v git >/dev/null 2>&1 || exit 0
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

# Mudancas nao commitadas (staged ou unstaged) sob sprints/.
CHANGED="$(git status --short -- 'sprints/' 2>/dev/null)"
[ -z "$CHANGED" ] && exit 0

# tracking.md estava entre os arquivos de sprint alterados?
if ! printf '%s' "$CHANGED" | grep -q 'sprints/tracking.md'; then
  echo "Lembrete: arquivos de sprint foram modificados mas sprints/tracking.md pode estar desatualizado. Use /laravel-toolkit:sprint."
else
  N="$(printf '%s' "$CHANGED" | grep -c .)"
  echo "Lembrete: ${N} arquivo(s) de sprint com mudancas nao commitadas."
fi

exit 0
