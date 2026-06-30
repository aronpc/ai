---
description: "Suggests relevant aronpc skills based on user prompt keywords for better discoverability"
event: UserPromptSubmit
---

# Skill Auto-Suggest

Quando o usuario submeter um prompt, analise o texto e sugira skills relevantes que podem ajudar na tarefa.

## Mapa de Keywords → Skills

### Laravel Development
| Keywords | Skill | Comando |
|----------|-------|---------|
| model, migration, relacao, relationship, eloquent, factory, seeder | models | `/laravel-toolkit:models` |
| arquitetura, architecture, action, dto, policy, structure | architecture | `/laravel-toolkit:architecture` |
| enum, enums, trait, backed enum | enums | `/laravel-toolkit:enums` |
| exception, erro, error, handler, renderable, reportable | exceptions | `/laravel-toolkit:exceptions` |
| event, listener, job, observer, queue, fila, dispatch | actions | `/laravel-toolkit:actions` |
| traducao, translation, i18n, locale, idioma, lang | i18n | `/laravel-toolkit:i18n` |
| precognition, turbo, hmr, livewire, prompts | ux | `/laravel-toolkit:ux` |
| websocket, reverb, broadcast, realtime, canal, channel, pusher | realtime | `/laravel-toolkit:realtime` |
| teste, test, pest, assert, mock, fake, dataset | testing | `/laravel-toolkit:testing` |
| padrao, standard, pint, phpstan, code style, lint | standards | `/laravel-toolkit:standards` |

### Planejamento
| Keywords | Skill | Comando |
|----------|-------|---------|
| sprint, tarefa, task, backlog, kanban, iteracao | sprint | `/laravel-toolkit:sprint` |
| planejar, plan, implementacao, fases, etapas, roadmap feature | planner | `/laravel-toolkit:planner` |
| spec, requisito, requirement, escopo, criterio, acceptance | spec | `/laravel-toolkit:spec` |
| roadmap, estrategia, moscow, priorizar, produto, competidor | roadmap | `/laravel-toolkit:roadmap` |

### GitHub & DevOps
| Keywords | Skill | Comando |
|----------|-------|---------|
| commit, branch, merge, rebase, git flow, convencao | workflow | `/laravel-toolkit:workflow` |
| ci, cd, pipeline, deploy, github actions, docker, staging | cicd | `/laravel-toolkit:cicd` |
| issue, bug report, classificar, duplicado, triage | issues | `/laravel-toolkit:issues` |
| pr, pull request, review, merge request, code review | pr-review | `/laravel-toolkit:pr-review` |
| mcp, browser, validar, electron, api test | mcp | `/laravel-toolkit:mcp` |

### Qualidade
| Keywords | Skill | Comando |
|----------|-------|---------|
| qa, qualidade, quality, validacao, fase, tier | qa | `/laravel-toolkit:qa` |
| documentacao, docs, readme, implementation, checkpoint, changelog | docs | `/laravel-toolkit:docs` |
| implementar, codar, code, step by step, passo a passo | coder | `/laravel-toolkit:coder` |
| melhoria, improvement, oportunidade, refatorar, codebase, analise | codebase | `/laravel-toolkit:codebase` |
| ui, ux, interface, visual, acessibilidade, usabilidade, layout | ui-ux | `/laravel-toolkit:ui-ux` |

## Regras de Sugestao

1. **Maximo 2 sugestoes** por prompt (as mais relevantes)
2. **NAO sugira** se o usuario ja esta invocando uma skill (`/laravel-toolkit:*`)
3. **NAO sugira** para prompts muito curtos (menos de 5 palavras)
4. **NAO sugira** para prompts genericos sem contexto tecnico
5. Formato da sugestao (1 linha):
   ```
   Dica: `/laravel-toolkit:skill-name` pode ajudar com isso.
   ```
6. Se 2 skills sao relevantes:
   ```
   Dica: considere usar `/laravel-toolkit:skill1` e `/laravel-toolkit:skill2` para esta tarefa.
   ```

## Comportamento

- NUNCA bloqueie - apenas informativo
- Seja discreto - 1 linha no maximo
- Se nenhuma skill for relevante, nao emita nada
- Match deve ter pelo menos 2 keywords para sugerir (evitar falsos positivos)
