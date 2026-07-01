#!/usr/bin/env bash
# post-commit-doc-check.sh
# Evento: PostToolUse / Bash
# Depois de um `git commit` que tocou codigo (app/, resources/, routes/,
# database/) sem atualizar IMPLEMENTATION.md nos ultimos 3 commits, emite um
# aviso. Sempre informativo (exit 0).

set -u

INPUT="$(cat 2>/dev/null || true)"
[ -z "$INPUT" ] && exit 0
command -v jq >/dev/null 2>&1 || exit 0

COMMAND="$(printf '%s' "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)"
[ -z "$COMMAND" ] && exit 0

# So reage a comandos git commit.
printf '%s' "$COMMAND" | grep -Eq 'git[[:space:]]+commit' || exit 0

# Precisa de um repo git com pelo menos um commit.
command -v git >/dev/null 2>&1 || exit 0
git rev-parse --verify HEAD >/dev/null 2>&1 || exit 0

# Arquivos alterados no commit recem-criado. `git show` e usado (nao diff-tree)
# porque tambem lista arquivos para um commit raiz, que nao tem pai para diff.
CHANGED="$(git show --name-only --format= HEAD 2>/dev/null)"
[ -z "$CHANGED" ] && exit 0

# Este commit tocou codigo?
printf '%s' "$CHANGED" | grep -Eq '^(app|resources|routes|database)/' || exit 0

# Ignora commits docs:/chore: (nao se espera que atualizem IMPLEMENTATION.md).
SUBJECT="$(git log -1 --format=%s 2>/dev/null)"
printf '%s' "$SUBJECT" | grep -Eiq '^(docs|chore)(\(|:)' && exit 0

# IMPLEMENTATION.md foi atualizado em algum dos ultimos 3 commits?
RECENT_DOCS="$(git log -3 --name-only --format= 2>/dev/null | grep -c 'IMPLEMENTATION.md' || true)"
if [ "${RECENT_DOCS:-0}" -eq 0 ]; then
  echo "Aviso: codigo foi commitado mas IMPLEMENTATION.md nao foi atualizado nos ultimos commits."
  echo "Use /laravel-toolkit:docs para atualizar a documentacao."
fi

exit 0
