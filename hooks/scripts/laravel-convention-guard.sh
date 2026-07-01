#!/usr/bin/env bash
# laravel-convention-guard.sh
# Evento: PreToolUse / Write|Edit
# Bloqueia anti-patterns do Laravel no momento da escrita. So atua quando
# ./artisan existe e o alvo e um arquivo .php fora de tests/,
# database/migrations/, config/. Bloqueia (exit 2) quando: caminho
# app/Services/ ou "Service" no nome da classe; uso de env() fora de config/;
# credencial hardcoded evidente. Caso contrario, exit 0.

set -u

INPUT="$(cat 2>/dev/null || true)"
[ -z "$INPUT" ] && exit 0
command -v jq >/dev/null 2>&1 || exit 0

# So atua em projetos Laravel.
[ -f "./artisan" ] || exit 0

FILE_PATH="$(printf '%s' "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)"
[ -z "$FILE_PATH" ] && exit 0

# Apenas arquivos PHP.
case "$FILE_PATH" in
  *.php) ;;
  *) exit 0 ;;
esac

# Isenta tests/, database/migrations/, config/ (casa em qualquer parte do caminho).
case "$FILE_PATH" in
  */tests/*|tests/*|*/database/migrations/*|database/migrations/*|*/config/*|config/*) exit 0 ;;
esac

# Conteudo sendo escrito (Write: conteudo completo; Edit: fragmento de new_string).
# Limitacao aceita: um anti-pattern dividido entre old_string/contexto e
# new_string pode escapar desta deteccao, pois so new_string e inspecionado
# (trade-off aceitavel para um guard heuristico).
CONTENT="$(printf '%s' "$INPUT" | jq -r '.tool_input.content // .tool_input.new_string // empty' 2>/dev/null)"

BASENAME="$(basename "$FILE_PATH" .php)"

# 1. Padrao Services proibido: caminho em app/Services/ ou classe com Service.
if printf '%s' "$FILE_PATH" | grep -Eq '(^|/)app/Services/' \
   || printf '%s' "$BASENAME" | grep -Eq 'Service$'; then
  echo "Bloqueado: use o padrao Actions em vez de Services. Crie em app/Actions/ seguindo lorisleiva/laravel-actions (veja a skill architecture)." >&2
  exit 2
fi

# 2. env() fora de config/ (arquivo ja sabido estar fora de config/).
if printf '%s' "$CONTENT" | grep -Eq '(^|[^a-zA-Z_])env[[:space:]]*\('; then
  echo "Bloqueado: nunca use env() fora de config/. Use config() para acessar valores de configuracao." >&2
  exit 2
fi

# 3. Credenciais hardcoded evidentes (atribuicao de literal parecido com API key).
if printf '%s' "$CONTENT" | grep -Eiq "(api[_-]?key|secret|password|token|access[_-]?key)[\"']?[[:space:]]*(=>|=|:)[[:space:]]*[\"'][A-Za-z0-9_\-]{16,}[\"']" \
   || printf '%s' "$CONTENT" | grep -Eq "(sk-[A-Za-z0-9]{16,}|AKIA[0-9A-Z]{16}|AIza[0-9A-Za-z_\-]{20,}|ghp_[A-Za-z0-9]{20,})"; then
  echo "Bloqueado: credenciais hardcoded detectadas. Use variaveis de ambiente via config()." >&2
  exit 2
fi

exit 0
