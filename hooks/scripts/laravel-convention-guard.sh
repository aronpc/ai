#!/usr/bin/env bash
# laravel-convention-guard.sh
# Event: PreToolUse / Write|Edit
# Blocks Laravel anti-patterns at write time. Only acts when ./artisan exists
# and the target is a .php file outside tests/, database/migrations/, config/.
# Blocks (exit 2) on: app/Services/ path or "Service" in class name; env()
# usage outside config/; obvious hardcoded credential. Otherwise exit 0.

set -u

INPUT="$(cat 2>/dev/null || true)"
[ -z "$INPUT" ] && exit 0
command -v jq >/dev/null 2>&1 || exit 0

# Only act on Laravel projects.
[ -f "./artisan" ] || exit 0

FILE_PATH="$(printf '%s' "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)"
[ -z "$FILE_PATH" ] && exit 0

# Only PHP files.
case "$FILE_PATH" in
  *.php) ;;
  *) exit 0 ;;
esac

# Exempt tests/, database/migrations/, config/ (match anywhere in the path).
case "$FILE_PATH" in
  */tests/*|tests/*|*/database/migrations/*|database/migrations/*|*/config/*|config/*) exit 0 ;;
esac

# Content being written (Write: full content; Edit: new_string fragment).
CONTENT="$(printf '%s' "$INPUT" | jq -r '.tool_input.content // .tool_input.new_string // empty' 2>/dev/null)"

BASENAME="$(basename "$FILE_PATH" .php)"

# 1. Services pattern forbidden: path in app/Services/ or class name with Service.
if printf '%s' "$FILE_PATH" | grep -Eq '(^|/)app/Services/' \
   || printf '%s' "$BASENAME" | grep -Eq 'Service$'; then
  echo "Bloqueado: use o padrao Actions em vez de Services. Crie em app/Actions/ seguindo lorisleiva/laravel-actions (veja a skill architecture)." >&2
  exit 2
fi

# 2. env() outside config/ (file already known to be outside config/).
if printf '%s' "$CONTENT" | grep -Eq '(^|[^a-zA-Z_])env[[:space:]]*\('; then
  echo "Bloqueado: nunca use env() fora de config/. Use config() para acessar valores de configuracao." >&2
  exit 2
fi

# 3. Obvious hardcoded credentials (assignment of an API-key-like literal).
if printf '%s' "$CONTENT" | grep -Eiq "(api[_-]?key|secret|password|token|access[_-]?key)[\"']?[[:space:]]*(=>|=|:)[[:space:]]*[\"'][A-Za-z0-9_\-]{16,}[\"']" \
   || printf '%s' "$CONTENT" | grep -Eq "(sk-[A-Za-z0-9]{16,}|AKIA[0-9A-Z]{16}|AIza[0-9A-Za-z_\-]{20,}|ghp_[A-Za-z0-9]{20,})"; then
  echo "Bloqueado: credenciais hardcoded detectadas. Use variaveis de ambiente via config()." >&2
  exit 2
fi

exit 0
