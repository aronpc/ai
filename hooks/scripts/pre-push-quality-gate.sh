#!/usr/bin/env bash
# pre-push-quality-gate.sh
# Evento: PreToolUse / Bash
# Antes de um `git push`, executa Pint, PHPStan e Pest quando este e um
# projeto Laravel (./artisan presente) e os binarios existem em vendor/bin.
# Qualquer falha -> exit 2 (bloqueia). Nao-Laravel / ferramenta ausente -> exit 0.

set -u

INPUT="$(cat 2>/dev/null || true)"
[ -z "$INPUT" ] && exit 0
command -v jq >/dev/null 2>&1 || exit 0

COMMAND="$(printf '%s' "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)"
[ -z "$COMMAND" ] && exit 0

# So atua em git push.
printf '%s' "$COMMAND" | grep -Eq 'git[[:space:]]+push' || exit 0

# So atua em projetos Laravel.
[ -f "./artisan" ] || exit 0

run_check() {
  # $1 = nome amigavel, o restante = comando + argumentos
  local name="$1"; shift
  local bin="$1"
  [ -x "$bin" ] || return 0  # binario ausente -> pula silenciosamente
  if ! timeout 120 "$@" >/dev/null 2>&1; then
    echo "Push bloqueado: ${name} falhou. Corrija antes de fazer push." >&2
    exit 2
  fi
}

run_check "Pint (code style)"      "./vendor/bin/pint" --test
if [ -f phpstan.neon ] || [ -f phpstan.neon.dist ]; then
  run_check "PHPStan (static analysis)" "./vendor/bin/phpstan" analyse --no-progress
fi
run_check "Pest (testes)"          "./vendor/bin/pest"

exit 0
