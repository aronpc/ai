# Mapa de Integração das Skills

Este documento mostra como as 24 skills se relacionam e podem ser usadas em conjunto.

## Fluxo Principal de Desenvolvimento

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           CICLO DE DESCOBERTA & PLANEJAMENTO                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   roadmap ──► codebase ──► ui-ux                    │
│          │                    │                    │                            │
│          │                    └──────────┬─────────┘                            │
│          ▼                              ▼                                       │
│   sprint ◄──────── spec                                     │
│          │                              │                                       │
│          ▼                              ▼                                       │
│   planner ◄──────────────┘                                       │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
                                       │
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              CICLO DE IMPLEMENTAÇÃO                              │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   coder ◄───┐                                                    │
│          │                  │                                                   │
│          ├──► architecture                                              │
│          ├──► models                                                    │
│          ├──► enums                                                     │
│          ├──► exceptions                                                │
│          ├──► actions                                            │
│          ├──► i18n                                                      │
│          ├──► ux                                                        │
│          ├──► realtime                                                  │
│          └──► standards                                          │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
                                       │
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              CICLO DE VALIDAÇÃO                                  │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   testing ◄──── qa ────► mcp                 │
│                                      │                                          │
│                                      ▼                                          │
│                             pr-review                                     │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
                                       │
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              CICLO DE DEPLOY                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   workflow ──► cicd ──► docs        │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## Skills por Categoria

### 1. Planejamento & Estratégia

| Skill | Input | Output | Referência Para |
|-------|-------|--------|-----------------|
| `roadmap` | Visão de produto | `roadmap.json` com features | `spec`, `sprint` |
| `codebase` | Codebase atual | Lista de melhorias | `spec`, `sprint` |
| `ui-ux` | UI atual | Melhorias visuais | `spec`, `ux` |

### 2. Especificação & Gestão

| Skill | Input | Output | Referência Para |
|-------|-------|--------|-----------------|
| `spec` | Requisitos | `spec.md` completo | `planner` |
| `sprint` | Features | `sprints/XXX.md` | `planner`, `coder` |
| `planner` | Spec/Sprint | Plano JSON com phases | `coder` |

### 3. Implementação Laravel

| Skill | Quando Usar | Referência Para |
|-------|-------------|-----------------|
| `architecture` | Actions, DTOs, Policies | `models`, `testing` |
| `models` | Eloquent, relações | `architecture`, `enums` |
| `enums` | Enums PHP 8.1+ | `models`, `i18n` |
| `exceptions` | Exceções customizadas | `architecture` |
| `actions` | Actions, Events, Jobs | `architecture`, `realtime` |
| `i18n` | Traduções | `ux` |
| `ux` | Precognition, Prompts | `ui-ux` |
| `realtime` | WebSockets, Reverb | `actions` |
| `standards` | Code style | Todas as skills Laravel |

### 4. Qualidade & Validação

| Skill | Input | Output | Referência Para |
|-------|-------|--------|-----------------|
| `testing` | Código | Testes Pest | `qa` |
| `qa` | Mudanças | Relatório QA | `pr-review`, `coder` |
| `mcp` | App rodando | Validação visual | `qa`, `ui-ux` |
| `pr-review` | PR diff | Review feedback | `qa` |

### 5. DevOps & GitHub

| Skill | Quando Usar | Referência Para |
|-------|-------------|-----------------|
| `issues` | Triagem de issues | `spec`, `sprint` |
| `pr-review` | Review de PR | `qa` |
| `workflow` | Commits, branches | `cicd` |
| `cicd` | CI/CD pipelines | `docs` |
| `docs` | Pós-implementação | - |

---

## Fluxos Recomendados

### Fluxo 1: Nova Feature Completa

```
1. roadmap     → Definir feature no roadmap
2. spec        → Criar spec técnica
3. sprint    → Criar sprint para feature
4. planner → Planejar phases
5. coder → Implementar
   ├─ architecture
   ├─ models
   ├─ enums
   └─ testing
6. qa        → Validar qualidade
7. pr-review     → Review final
8. workflow → Commit/Push
9. cicd  → Deploy
10. docs → Atualizar docs
```

### Fluxo 2: Bug Fix

```
1. issues → Analisar issue
2. planner (investigation) → Investigar
3. coder  → Corrigir
4. testing  → Testes de regressão
5. qa         → Validar
6. workflow  → Commit
```

### Fluxo 3: Refatoração

```
1. codebase     → Identificar oportunidades
2. planner (refactor) → Planejar
3. coder  → Refatorar
4. testing  → Garantir testes
5. qa         → Validar sem regressões
6. pr-review      → Review cuidadoso
```

### Fluxo 4: Melhoria de UI/UX

```
1. ui-ux        → Identificar melhorias
2. mcp        → Validar estado atual
3. spec         → Especificar mudanças
4. coder  → Implementar
5. mcp        → Validar resultado
6. qa         → QA geral
```

---

## Referências Cruzadas a Adicionar

### sprint
```yaml
related_skills:
  - spec: "Para specs técnicas detalhadas"
  - planner: "Para planejamento técnico de phases"
  - issues: "Para converter issues em sprints"
```

### planner
```yaml
related_skills:
  - spec: "Source de requisitos"
  - sprint: "Source de tarefas"
  - coder: "Executor do plano"
  - qa: "Validação do plano"
```

### coder
```yaml
related_skills:
  - planner: "Source do plano"
  - architecture: "Padrões arquiteturais"
  - standards: "Padrões de código"
  - testing: "Testes durante implementação"
  - qa: "Validação final"
```

### spec
```yaml
related_skills:
  - roadmap: "Source de features estratégicas"
  - codebase: "Source de melhorias"
  - ui-ux: "Source de melhorias UI"
  - planner: "Consumer da spec"
```

### qa
```yaml
related_skills:
  - testing: "Execução de testes"
  - pr-review: "Review de PR"
  - mcp: "Validação visual"
  - coder: "Correção de issues"
```

### pr-review
```yaml
related_skills:
  - qa: "Validação de qualidade"
  - standards: "Padrões de código"
  - workflow: "Convenções de commit"
```

---

## Próximos Passos

1. Adicionar seção `related_skills` em cada SKILL.md
2. Criar prompt templates que combinam skills
3. Documentar workflows compostos em `references/workflows.md`
