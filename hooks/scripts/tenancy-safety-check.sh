#!/usr/bin/env bash
# tenancy-safety-check.sh
# Event: PreToolUse / Write|Edit
# Multi-tenancy heuristic. When the project looks multi-tenant and the target
# file contains queries that may miss tenant scoping, WARN via stdout.
# Never blocks (always exit 0).

set -u

INPUT="$(cat 2>/dev/null || true)"
[ -z "$INPUT" ] && exit 0
command -v jq >/dev/null 2>&1 || exit 0

[ -f "./artisan" ] || exit 0

FILE_PATH="$(printf '%s' "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)"
[ -z "$FILE_PATH" ] && exit 0

case "$FILE_PATH" in
  *.php) ;;
  *) exit 0 ;;
esac

# Only relevant dirs: Models, Actions, Controllers, Policies.
case "$FILE_PATH" in
  */app/Models/*|app/Models/*|*/app/Actions/*|app/Actions/*|*/app/Http/Controllers/*|app/Http/Controllers/*|*/app/Policies/*|app/Policies/*) ;;
  *) exit 0 ;;
esac

# Detect multi-tenancy in the project (best effort; absence -> stay silent).
IS_TENANT=0
if grep -rqsE 'tenant_id|BelongsToTenant|HasTenant|stancl/tenancy|spatie/laravel-multitenancy' \
     ./database/migrations ./app ./composer.json 2>/dev/null; then
  IS_TENANT=1
fi
[ "$IS_TENANT" -eq 1 ] || exit 0

CONTENT="$(printf '%s' "$INPUT" | jq -r '.tool_input.content // .tool_input.new_string // empty' 2>/dev/null)"

# Warn on common unscoped query shapes that lack an explicit tenant filter.
if printf '%s' "$CONTENT" | grep -Eq '::(all|find|where|first|get)[[:space:]]*\(' \
   && ! printf '%s' "$CONTENT" | grep -q 'tenant_id'; then
  echo "Aviso (tenancy): este arquivo faz queries que podem nao estar filtradas por tenant. Use o scope de tenant (ex: BelongsToTenant) ou filtre por tenant_id para evitar vazamento de dados entre tenants."
fi

exit 0
