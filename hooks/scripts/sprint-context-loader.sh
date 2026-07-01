#!/usr/bin/env bash
# sprint-context-loader.sh
# Evento: SessionStart
# Imprime um resumo curto do sprint ativo / contexto .omc no STDOUT (injetado
# como contexto). Fica em silencio quando nao ha nada relevante. Sempre exit 0.

set -u

# Este hook nao requer STDIN; drena-o de forma inofensiva se presente.
cat >/dev/null 2>&1 || true

EMITTED=0

# 1. Arquivo de tracking do sprint.
if [ -f "./sprints/tracking.md" ]; then
  # Encontra uma linha de sprint em andamento (best effort).
  ACTIVE="$(grep -iE 'em andamento|in progress|🚧|⏳' ./sprints/tracking.md 2>/dev/null | head -n1 | sed 's/^[[:space:]#>*-]*//')"
  if [ -n "$ACTIVE" ]; then
    echo "Sprint ativo: ${ACTIVE}"
    echo "Use /laravel-toolkit:sprint para gerenciar o sprint."
    EMITTED=1
  fi
fi

# 2. Diretorio de estado .omc (dica leve de presenca).
if [ -d "./.omc" ]; then
  if [ -f "./.omc/notepad.md" ]; then
    echo ".omc: notepad.md presente (contexto de sessoes anteriores disponivel)."
    EMITTED=1
  elif [ -d "./.omc/plans" ] && [ -n "$(ls -A ./.omc/plans 2>/dev/null)" ]; then
    echo ".omc: planos disponiveis em .omc/plans/."
    EMITTED=1
  fi
fi

# 3. Dica de mudancas nao commitadas (so se ja tinhamos algo a dizer).
if [ "$EMITTED" -eq 1 ] && command -v git >/dev/null 2>&1 && git rev-parse --git-dir >/dev/null 2>&1; then
  N="$(git status --short 2>/dev/null | wc -l | tr -d ' ')"
  if [ "${N:-0}" -gt 0 ]; then
    echo "Atencao: ${N} arquivo(s) com mudancas nao commitadas."
  fi
fi

exit 0
