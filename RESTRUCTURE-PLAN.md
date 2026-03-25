# Plano de Reestruturação Semântica das Skills

## 1. Nova Estrutura de Nomenclatura (Namespaces)

### Antes → Depois

| Namespace | Nome Antigo | Nome Novo | Descrição Curta |
|-----------|-------------|-----------|-----------------|
| **@laravel/** | | | |
| | `laravel-architecture` | `@laravel/architecture` | Arquitetura limpa com Actions, DTOs, Policies |
| | `laravel-models` | `@laravel/models` | Eloquent, relações, scopes, factories |
| | `laravel-enums` | `@laravel/enums` | Enums PHP 8.1+ com archtechx/enums |
| | `laravel-exceptions` | `@laravel/exceptions` | Exceções customizadas renderable/reportable |
| | `laravel-actions-events` | `@laravel/actions` | Actions, Events, Jobs, Observers |
| | `laravel-i18n` | `@laravel/i18n` | Internacionalização EN/ES/PT-BR |
| | `laravel-ux` | `@laravel/ux` | Precognition, Prompts, Turbo |
| | `laravel-realtime` | `@laravel/realtime` | WebSockets com Reverb |
| | `laravel-testing-pest` | `@laravel/testing` | Testes com Pest PHP |
| | `laravel-coding-standards` | `@laravel/standards` | Padrões Spatie + Pint |
| **@github/** | | | |
| | `github-pr-review` | `@github/pr-review` | Review de Pull Requests |
| | `github-issue-analysis` | `@github/issues` | Análise e triagem de issues |
| | `git-workflow-laravel` | `@github/workflow` | Commits atômicos, Conventional Commits |
| **@devops/** | | | |
| | `cicd-github-actions` | `@devops/cicd` | CI/CD com GitHub Actions |
| | `mcp-validation` | `@devops/mcp` | Validação com MCP tools |
| **@planning/** | | | |
| | `sprint-management` | `@planning/sprint` | Gestão de sprints |
| | `spec-creation` | `@planning/spec` | Criação de especificações |
| | `implementation-planner` | `@planning/planner` | Planejamento de implementação |
| | `roadmap-strategy` | `@planning/roadmap` | Estratégia e roadmap |
| **@ideation/** | | | |
| | `codebase-ideation` | `@ideation/codebase` | Descoberta de melhorias no código |
| | `ui-ux-ideation` | `@ideation/ui-ux` | Descoberta de melhorias visuais |
| **@quality/** | | | |
| | `qa-validation` | `@quality/qa` | Validação de qualidade 11 fases |
| | `documentation-updates` | `@quality/docs` | Atualização de documentação |
| **@dev/** | | | |
| | `implementation-coder` | `@dev/coder` | Implementador passo-a-passo |

---

## 2. Estrutura Padronizada de SKILL.md

```yaml
---
# Frontmatter Obrigatório
name: @namespace/skill-name
description: Uma frase clara do que faz (máx 100 chars)
version: 1.0.0
author: aronpc
license: MIT

# Metadados Opcionais
category: namespace        # Agrupamento lógico
triggers:                 # Palavras que ativam a skill
  - "criar sprint"
  - "novo sprint"
  - "planejar sprint"
aliases:                  # Nomes alternativos
  - sprint
  - sprint-planner
related:                  # Skills relacionadas
  - @planning/spec
  - @planning/planner

# Configuração Técnica
compatibility: PHP 8.2+, Laravel 11+
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
---

# Título da Skill

## Resumo
Uma frase que resume o que esta skill faz.

## Quando Usar
- ✅ Use quando: situação A, situação B
- ❌ Não use para: situação C (use @outra-skill)

## Comando Rápido
/skill-name [argumentos]

## Fluxo Principal
1. Passo 1
2. Passo 2
3. Passo 3

## Skills Relacionadas
| Skill | Quando usar junto |
|-------|-------------------|
| `@related/skill` | Para que contexto |

## Exemplos

### Exemplo 1: Título
```bash
comando exemplo
```

### Exemplo 2: Título
```php
// código exemplo
```

## Referências
- `references/arquivo.md` - Descrição
```

---

## 3. Diretórios com Namespace

```
skills/
├── laravel/
│   ├── architecture/
│   │   ├── SKILL.md
│   │   └── references/
│   ├── models/
│   ├── enums/
│   ├── exceptions/
│   ├── actions/
│   ├── i18n/
│   ├── ux/
│   ├── realtime/
│   ├── testing/
│   └── standards/
├── github/
│   ├── pr-review/
│   ├── issues/
│   └── workflow/
├── devops/
│   ├── cicd/
│   └── mcp/
├── planning/
│   ├── sprint/
│   ├── spec/
│   ├── planner/
│   └── roadmap/
├── ideation/
│   ├── codebase/
│   └── ui-ux/
├── quality/
│   ├── qa/
│   └── docs/
└── dev/
    └── coder/
```

---

## 4. Triggers Semânticos por Skill

| Skill | Triggers (ativação por frase) |
|-------|-------------------------------|
| `@planning/sprint` | "criar sprint", "novo sprint", "planejar sprint", "gerenciar sprint" |
| `@planning/spec` | "criar spec", "especificação técnica", "documentar feature" |
| `@planning/planner` | "planejar implementação", "criar plano", "definir phases" |
| `@planning/roadmap` | "criar roadmap", "estratégia de produto", "análise competitiva" |
| `@ideation/codebase` | "melhorar código", "oportunidades de melhoria", "quick wins" |
| `@ideation/ui-ux` | "melhorar UI", "melhorar UX", "análise visual" |
| `@dev/coder` | "implementar", "codar", "escrever código", "criar feature" |
| `@quality/qa` | "validar qualidade", "QA", "verificar código", "quality check" |
| `@quality/docs` | "atualizar documentação", "atualizar README", "atualizar docs" |
| `@github/pr-review` | "revisar PR", "code review", "analisar pull request" |
| `@github/issues` | "analisar issue", "triagem de issues", "classificar issue" |
| `@github/workflow` | "fazer commit", "criar branch", "git workflow" |
| `@devops/cicd` | "configurar CI", "configurar CD", "pipeline", "deploy" |
| `@devops/mcp` | "validar com browser", "teste visual", "MCP validation" |
| `@laravel/architecture` | "arquitetura", "clean architecture", "DTO", "Action" |
| `@laravel/models` | "criar model", "Eloquent", "relação", "factory" |
| `@laravel/enums` | "criar enum", "enum PHP", "archtechx" |
| `@laravel/exceptions` | "criar exceção", "exception", "erro customizado" |
| `@laravel/actions` | "criar action", "Laravel Actions", "event", "job" |
| `@laravel/i18n` | "traduzir", "internacionalização", "i18n", "outro idioma" |
| `@laravel/ux` | "precognition", "prompts", "validação em tempo real" |
| `@laravel/realtime` | "websocket", "tempo real", "reverb", "broadcasting" |
| `@laravel/testing` | "criar teste", "Pest", "testar", "feature test" |
| `@laravel/standards` | "padrão de código", "code style", "Pint", "formatar" |

---

## 5. Fluxo de Migração

### Fase 1: Criar estrutura de diretórios
```bash
mkdir -p skills/{laravel,github,devops,planning,ideation,quality,dev}
```

### Fase 2: Mover e renomear skills
- Mover cada skill para seu novo namespace
- Atualizar frontmatter com novo nome
- Adicionar triggers e aliases

### Fase 3: Atualizar referências cruzadas
- Atualizar seção "Skills Relacionadas" em todas as skills
- Usar nova nomenclatura com @namespace/

### Fase 4: Atualizar marketplace.json
- Mapear novos paths para os pacotes

### Fase 5: Testar
- Verificar se Claude Code reconhece nova estrutura
- Testar triggers e aliases

---

## 6. Benefícios da Nova Estrutura

1. **Descoberta fácil**: `@laravel/` agrupa todas skills Laravel
2. **Triggers semânticos**: Frases naturais ativam skills
3. **Aliases**: Nomes curtos para uso rápido (`/sprint` vs `/sprint-management`)
4. **Consistência**: Estrutura padronizada em todas skills
5. **Manutenção**: Fácil encontrar e atualizar skills por categoria
6. **Escalabilidade**: Fácil adicionar novas skills em namespaces existentes

---

## Próximos Passos

1. [ ] Aprovar plano de reestruturação
2. [ ] Executar migração dos diretórios
3. [ ] Atualizar todos SKILL.md com nova estrutura
4. [ ] Atualizar marketplace.json
5. [ ] Atualizar INTEGRATION-MAP.md
6. [ ] Testar e validar
