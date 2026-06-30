#!/usr/bin/env bash
# skill-auto-suggest.sh
# Event: UserPromptSubmit
# Maps keywords in .prompt to at most 2 laravel-toolkit skills and prints a
# one-line suggestion to STDOUT (injected as context). Never blocks (exit 0).

set -u

INPUT="$(cat 2>/dev/null || true)"
[ -z "$INPUT" ] && exit 0
command -v jq >/dev/null 2>&1 || exit 0

PROMPT="$(printf '%s' "$INPUT" | jq -r '.prompt // empty' 2>/dev/null)"
[ -z "$PROMPT" ] && exit 0

# Do not suggest when the user is already invoking a skill.
printf '%s' "$PROMPT" | grep -q '/laravel-toolkit:' && exit 0

# Skip very short prompts (fewer than 5 words).
WORDS="$(printf '%s' "$PROMPT" | wc -w | tr -d ' ')"
[ "${WORDS:-0}" -lt 5 ] && exit 0

# Lowercase for matching.
LP="$(printf '%s' "$PROMPT" | tr '[:upper:]' '[:lower:]')"

MATCHES=""
add_match() {
  # $1 = skill name. Append once, keep insertion order, stop at 2.
  case " $MATCHES " in *" $1 "*) return ;; esac
  if [ -z "$MATCHES" ]; then MATCHES="$1"; else MATCHES="$MATCHES $1"; fi
}

# keyword-group -> skill. Each entry: an ERE of keywords mapped to a skill name.
check() {
  # $1 = skill, $2 = ERE of keywords
  printf '%s' "$LP" | grep -Eq "$2" && add_match "$1"
}

check models      'model|migration|relacao|relationship|eloquent|factory|seeder'
check architecture 'arquitetura|architecture|action|dto|policy|structure'
check enums       'enum|enums|trait|backed enum'
check exceptions  'exception|erro|error|handler|renderable|reportable'
check actions     'event|listener|job|observer|queue|fila|dispatch'
check i18n        'traducao|translation|i18n|locale|idioma|lang'
check ux          'precognition|turbo|hmr|livewire|prompts'
check realtime    'websocket|reverb|broadcast|realtime|canal|channel|pusher'
check testing     'teste|test|pest|assert|mock|fake|dataset'
check standards   'padrao|standard|pint|phpstan|code style|lint'
check sprint      'sprint|tarefa|task|backlog|kanban|iteracao'
check planner     'planejar|plan|implementacao|fases|etapas|roadmap feature'
check spec        'spec|requisito|requirement|escopo|criterio|acceptance'
check roadmap     'roadmap|estrategia|moscow|priorizar|produto|competidor'
check workflow    'commit|branch|merge|rebase|git flow|convencao'
check cicd        '\bci\b|\bcd\b|pipeline|deploy|github actions|docker|staging'
check issues      'issue|bug report|classificar|duplicado|triage'
check pr-review   '\bpr\b|pull request|merge request|code review|pr-review'
check mcp         '\bmcp\b|browser|validar|electron|api test'
check qa          '\bqa\b|qualidade|quality|validacao|tier'
check docs        'documentacao|docs|readme|implementation|checkpoint|changelog'
check coder       'implementar|codar|step by step|passo a passo'
check codebase    'melhoria|improvement|oportunidade|refatorar|codebase|analise'
check ui-ux       'interface|visual|acessibilidade|usabilidade|layout|\bui\b|\bux\b'

[ -z "$MATCHES" ] && exit 0

# Keep at most 2.
S1="$(printf '%s' "$MATCHES" | awk '{print $1}')"
S2="$(printf '%s' "$MATCHES" | awk '{print $2}')"

if [ -n "$S2" ]; then
  echo "Dica: considere usar \`/laravel-toolkit:$S1\` e \`/laravel-toolkit:$S2\` para esta tarefa."
else
  echo "Dica: \`/laravel-toolkit:$S1\` pode ajudar com isso."
fi

exit 0
