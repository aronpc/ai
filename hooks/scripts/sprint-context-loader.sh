#!/usr/bin/env bash
# sprint-context-loader.sh
# Event: SessionStart
# Prints a short summary of active sprint / .omc context to STDOUT (injected as
# context). Stays silent when there is nothing relevant. Always exit 0.

set -u

# This hook does not require STDIN; drain it harmlessly if present.
cat >/dev/null 2>&1 || true

EMITTED=0

# 1. Sprint tracking file.
if [ -f "./sprints/tracking.md" ]; then
  # Find an in-progress sprint line (best effort).
  ACTIVE="$(grep -iE 'em andamento|in progress|🚧|⏳' ./sprints/tracking.md 2>/dev/null | head -n1 | sed 's/^[[:space:]#>*-]*//')"
  if [ -n "$ACTIVE" ]; then
    echo "Sprint ativo: ${ACTIVE}"
    echo "Use /laravel-toolkit:sprint para gerenciar o sprint."
    EMITTED=1
  fi
fi

# 2. .omc state directory (lightweight presence hint).
if [ -d "./.omc" ]; then
  if [ -f "./.omc/notepad.md" ]; then
    echo ".omc: notepad.md presente (contexto de sessoes anteriores disponivel)."
    EMITTED=1
  elif [ -d "./.omc/plans" ] && [ -n "$(ls -A ./.omc/plans 2>/dev/null)" ]; then
    echo ".omc: planos disponiveis em .omc/plans/."
    EMITTED=1
  fi
fi

# 3. Uncommitted changes hint (only if we already had something to say).
if [ "$EMITTED" -eq 1 ] && command -v git >/dev/null 2>&1 && git rev-parse --git-dir >/dev/null 2>&1; then
  N="$(git status --short 2>/dev/null | wc -l | tr -d ' ')"
  if [ "${N:-0}" -gt 0 ]; then
    echo "Atencao: ${N} arquivo(s) com mudancas nao commitadas."
  fi
fi

exit 0
