#!/usr/bin/env bash
# pre-push-quality-gate.sh
# Event: PreToolUse / Bash
# Before a `git push`, runs Pint, PHPStan and Pest when this is a Laravel
# project (./artisan present) and the binaries exist in vendor/bin.
# Any failure -> exit 2 (blocks). Not Laravel / missing tool -> exit 0.

set -u

INPUT="$(cat 2>/dev/null || true)"
[ -z "$INPUT" ] && exit 0
command -v jq >/dev/null 2>&1 || exit 0

COMMAND="$(printf '%s' "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)"
[ -z "$COMMAND" ] && exit 0

# Only act on git push.
printf '%s' "$COMMAND" | grep -Eq 'git[[:space:]]+push' || exit 0

# Only act on Laravel projects.
[ -f "./artisan" ] || exit 0

run_check() {
  # $1 = friendly name, rest = command + args
  local name="$1"; shift
  local bin="$1"
  [ -x "$bin" ] || return 0  # binary absent -> skip silently
  if ! "$@" >/dev/null 2>&1; then
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
