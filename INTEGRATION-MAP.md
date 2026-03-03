# Mapa de Integração das Skills

Este documento mostra como as 24 skills se relacionam e podem ser usadas em conjunto.

## Fluxo Principal de Desenvolvimento

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           CICLO DE DESCOBERTA & PLANEJAMENTO                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   roadmap-strategy ──► codebase-ideation ──► ui-ux-ideation                    │
│          │                    │                    │                            │
│          │                    └──────────┬─────────┘                            │
│          ▼                              ▼                                       │
│   sprint-management ◄──────── spec-creation                                     │
│          │                              │                                       │
│          ▼                              ▼                                       │
│   implementation-planner ◄──────────────┘                                       │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
                                       │
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              CICLO DE IMPLEMENTAÇÃO                              │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   implementation-coder ◄───┐                                                    │
│          │                  │                                                   │
│          ├──► laravel-architecture                                              │
│          ├──► laravel-models                                                    │
│          ├──► laravel-enums                                                     │
│          ├──► laravel-exceptions                                                │
│          ├──► laravel-actions-events                                            │
│          ├──► laravel-i18n                                                      │
│          ├──► laravel-ux                                                        │
│          ├──► laravel-realtime                                                  │
│          └──► laravel-coding-standards                                          │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
                                       │
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              CICLO DE VALIDAÇÃO                                  │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   laravel-testing-pest ◄──── qa-validation ────► mcp-validation                 │
│                                      │                                          │
│                                      ▼                                          │
│                             github-pr-review                                     │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
                                       │
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              CICLO DE DEPLOY                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   git-workflow-laravel ──► cicd-github-actions ──► documentation-updates        │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## Skills por Categoria

### 1. Planejamento & Estratégia

| Skill | Input | Output | Referencia Para |
|-------|-------|--------|-----------------|
| `roadmap-strategy` | Visão de produto | `roadmap.json` com features | `spec-creation`, `sprint-management` |
| `codebase-ideation` | Codebase atual | Lista de melhorias | `spec-creation`, `sprint-management` |
| `ui-ux-ideation` | UI atual | Melhorias visuais | `spec-creation`, `laravel-ux` |

### 2. Especificação & Gestão

| Skill | Input | Output | Referencia Para |
|-------|-------|--------|-----------------|
| `spec-creation` | Requisitos | `spec.md` completo | `implementation-planner` |
| `sprint-management` | Features | `sprints/XXX.md` | `implementation-planner`, `implementation-coder` |
| `implementation-planner` | Spec/Sprint | Plano JSON com phases | `implementation-coder` |

### 3. Implementação Laravel

| Skill | Quando Usar | Referencia Para |
|-------|-------------|-----------------|
| `laravel-architecture` | Actions, DTOs, Policies | `laravel-models`, `laravel-testing-pest` |
| `laravel-models` | Eloquent, relações | `laravel-architecture`, `laravel-enums` |
| `laravel-enums` | Enums PHP 8.1+ | `laravel-models`, `laravel-i18n` |
| `laravel-exceptions` | Exceções customizadas | `laravel-architecture` |
| `laravel-actions-events` | Actions, Events, Jobs | `laravel-architecture`, `laravel-realtime` |
| `laravel-i18n` | Traduções | `laravel-ux` |
| `laravel-ux` | Precognition, Prompts | `ui-ux-ideation` |
| `laravel-realtime` | WebSockets, Reverb | `laravel-actions-events` |
| `laravel-coding-standards` | Code style | Todas as skills Laravel |

### 4. Qualidade & Validação

| Skill | Input | Output | Referencia Para |
|-------|-------|--------|-----------------|
| `laravel-testing-pest` | Código | Testes Pest | `qa-validation` |
| `qa-validation` | Mudanças | Relatório QA | `github-pr-review`, `implementation-coder` |
| `mcp-validation` | App rodando | Validação visual | `qa-validation`, `ui-ux-ideation` |
| `github-pr-review` | PR diff | Review feedback | `qa-validation` |

### 5. DevOps & GitHub

| Skill | Quando Usar | Referencia Para |
|-------|-------------|-----------------|
| `github-issue-analysis` | Triagem de issues | `spec-creation`, `sprint-management` |
| `github-pr-review` | Review de PR | `qa-validation` |
| `git-workflow-laravel` | Commits, branches | `cicd-github-actions` |
| `cicd-github-actions` | CI/CD pipelines | `documentation-updates` |
| `documentation-updates` | Pós-implementação | - |

---

## Fluxos Recomendados

### Fluxo 1: Nova Feature Completa

```
1. roadmap-strategy     → Definir feature no roadmap
2. spec-creation        → Criar spec técnica
3. sprint-management    → Criar sprint para feature
4. implementation-planner → Planejar phases
5. implementation-coder → Implementar
   ├─ laravel-architecture
   ├─ laravel-models
   ├─ laravel-enums
   └─ laravel-testing-pest
6. qa-validation        → Validar qualidade
7. github-pr-review     → Review final
8. git-workflow-laravel → Commit/Push
9. cicd-github-actions  → Deploy
10. documentation-updates → Atualizar docs
```

### Fluxo 2: Bug Fix

```
1. github-issue-analysis → Analisar issue
2. implementation-planner (investigation) → Investigar
3. implementation-coder  → Corrigir
4. laravel-testing-pest  → Testes de regressão
5. qa-validation         → Validar
6. git-workflow-laravel  → Commit
```

### Fluxo 3: Refatoração

```
1. codebase-ideation     → Identificar oportunidades
2. implementation-planner (refactor) → Planejar
3. implementation-coder  → Refatorar
4. laravel-testing-pest  → Garantir testes
5. qa-validation         → Validar sem regressões
6. github-pr-review      → Review cuidadoso
```

### Fluxo 4: Melhoria de UI/UX

```
1. ui-ux-ideation        → Identificar melhorias
2. mcp-validation        → Validar estado atual
3. spec-creation         → Especificar mudanças
4. implementation-coder  → Implementar
5. mcp-validation        → Validar resultado
6. qa-validation         → QA geral
```

---

## Referências Cruzadas a Adicionar

### sprint-management
```yaml
related_skills:
  - spec-creation: "Para specs técnicas detalhadas"
  - implementation-planner: "Para planejamento técnico de phases"
  - github-issue-analysis: "Para converter issues em sprints"
```

### implementation-planner
```yaml
related_skills:
  - spec-creation: "Source de requisitos"
  - sprint-management: "Source de tarefas"
  - implementation-coder: "Executor do plano"
  - qa-validation: "Validação do plano"
```

### implementation-coder
```yaml
related_skills:
  - implementation-planner: "Source do plano"
  - laravel-architecture: "Padrões arquiteturais"
  - laravel-coding-standards: "Padrões de código"
  - laravel-testing-pest: "Testes durante implementação"
  - qa-validation: "Validação final"
```

### spec-creation
```yaml
related_skills:
  - roadmap-strategy: "Source de features estratégicas"
  - codebase-ideation: "Source de melhorias"
  - ui-ux-ideation: "Source de melhorias UI"
  - implementation-planner: "Consumer da spec"
```

### qa-validation
```yaml
related_skills:
  - laravel-testing-pest: "Execução de testes"
  - github-pr-review: "Review de PR"
  - mcp-validation: "Validação visual"
  - implementation-coder: "Correção de issues"
```

### github-pr-review
```yaml
related_skills:
  - qa-validation: "Validação de qualidade"
  - laravel-coding-standards: "Padrões de código"
  - git-workflow-laravel: "Convenções de commit"
```

---

## Próximos Passos

1. Adicionar seção `related_skills` em cada SKILL.md
2. Criar prompt templates que combinam skills
3. Documentar workflows compostos em `references/workflows.md`
