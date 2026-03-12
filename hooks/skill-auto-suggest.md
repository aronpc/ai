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
| model, migration, relacao, relationship, eloquent, factory, seeder | models | `/aronpc:models` |
| arquitetura, architecture, action, dto, policy, structure | architecture | `/aronpc:architecture` |
| enum, enums, trait, backed enum | enums | `/aronpc:enums` |
| exception, erro, error, handler, renderable, reportable | exceptions | `/aronpc:exceptions` |
| event, listener, job, observer, queue, fila, dispatch | actions | `/aronpc:actions` |
| traducao, translation, i18n, locale, idioma, lang | i18n | `/aronpc:i18n` |
| precognition, turbo, hmr, livewire, prompts | ux | `/aronpc:ux` |
| websocket, reverb, broadcast, realtime, canal, channel, pusher | realtime | `/aronpc:realtime` |
| teste, test, pest, assert, mock, fake, dataset | testing | `/aronpc:testing` |
| padrao, standard, pint, phpstan, code style, lint | standards | `/aronpc:standards` |

### Planejamento
| Keywords | Skill | Comando |
|----------|-------|---------|
| sprint, tarefa, task, backlog, kanban, iteracao | sprint | `/aronpc:sprint` |
| planejar, plan, implementacao, fases, etapas, roadmap feature | planner | `/aronpc:planner` |
| spec, requisito, requirement, escopo, criterio, acceptance | spec | `/aronpc:spec` |
| roadmap, estrategia, moscow, priorizar, produto, competidor | roadmap | `/aronpc:roadmap` |

### GitHub & DevOps
| Keywords | Skill | Comando |
|----------|-------|---------|
| commit, branch, merge, rebase, git flow, convencao | workflow | `/aronpc:workflow` |
| ci, cd, pipeline, deploy, github actions, docker, staging | cicd | `/aronpc:cicd` |
| issue, bug report, classificar, duplicado, triage | issues | `/aronpc:issues` |
| pr, pull request, review, merge request, code review | pr-review | `/aronpc:pr-review` |
| mcp, browser, validar, electron, api test | mcp | `/aronpc:mcp` |

### Qualidade
| Keywords | Skill | Comando |
|----------|-------|---------|
| qa, qualidade, quality, validacao, fase, tier | qa | `/aronpc:qa` |
| documentacao, docs, readme, implementation, checkpoint, changelog | docs | `/aronpc:docs` |
| implementar, codar, code, step by step, passo a passo | coder | `/aronpc:coder` |
| melhoria, improvement, oportunidade, refatorar, codebase, analise | codebase | `/aronpc:codebase` |
| ui, ux, interface, visual, acessibilidade, usabilidade, layout | ui-ux | `/aronpc:ui-ux` |

## Regras de Sugestao

1. **Maximo 2 sugestoes** por prompt (as mais relevantes)
2. **NAO sugira** se o usuario ja esta invocando uma skill (`/aronpc:*`)
3. **NAO sugira** para prompts muito curtos (menos de 5 palavras)
4. **NAO sugira** para prompts genericos sem contexto tecnico
5. Formato da sugestao (1 linha):
   ```
   Dica: `/aronpc:skill-name` pode ajudar com isso.
   ```
6. Se 2 skills sao relevantes:
   ```
   Dica: considere usar `/aronpc:skill1` e `/aronpc:skill2` para esta tarefa.
   ```

## Comportamento

- NUNCA bloqueie - apenas informativo
- Seja discreto - 1 linha no maximo
- Se nenhuma skill for relevante, nao emita nada
- Match deve ter pelo menos 2 keywords para sugerir (evitar falsos positivos)
