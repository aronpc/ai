# AI Skills - AronPC

Coleção de **24 Agent Skills**, **5 agentes autônomos** e **8 hooks** para uso com Claude Code, Cursor e [Laravel Boost](https://github.com/consulting/laravel-boost).

## Sobre

Este repositório contém **Agent Skills** personalizadas que seguem o padrão [Agent Skills](https://agentskills.io/). Skills são módulos de conhecimento que agentes podem carregar sob demanda para trabalhar com tarefas específicas em projetos Laravel.

### Funcionalidades

- **24 skills** organizadas em 4 categorias (Laravel, Planejamento, GitHub/DevOps, Qualidade)
- **5 agentes autônomos** que orquestram múltiplas skills (feature, bugfix, refactor, sprint, PR)
- **8 hooks** de guardrails e automação (convenções, qualidade, segurança, sprint)
- **Autocomplete** integrado via command wrappers para Claude Code
- **Marketplace** configurado como plugin único com auto-discovery
- **Progressive disclosure** seguindo o padrão Agent Skills (metadados → instruções → referências)

## Skills Disponíveis

### Skills Core Laravel (10 skills)

| Skill | Descrição |
|-------|-----------|
| `architecture` | Arquitetura limpa Laravel com Actions, DTOs, Policies |
| `models` | Models Eloquent, relações, scopes, factories, multi-tenancy |
| `enums` | Enums PHP 8.1+ com archtechx/enums: 7 traits para invocação, nomes, valores, opções e metadados |
| `exceptions` | Exceções customizadas com interfaces renderable/reportable |
| `actions` | Laravel Actions, Events, Jobs e Observers |
| `i18n` | Internacionalização completa (EN, ES, PT-BR) |
| `ux` | Laravel Precognition, Prompts, Turbo (HMR) para UX otimizada |
| `realtime` | Laravel Reverb (WebSockets), Broadcasting, Canais presence/private |
| `testing` | Testes completos com Pest PHP (Feature, Unit, HTTP, Datasets) |
| `standards` | Padrões de código Laravel e PHP baseados nas diretrizes da Spatie |

> **Nota:** `laravel-filament` não incluído - use a skill nativa do Laravel Boost para Filament 3.x/4.x

### Skills Planejamento & Estratégia (4 skills)

| Skill | Descrição |
|-------|-----------|
| `sprint` | Gerenciamento completo de sprints de desenvolvimento Laravel |
| `planner` | Planejamento de implementação com workflows estruturados (feature, refactor, investigation, migration) |
| `spec` | Pipeline completo de criação de especificações técnicas para implementação |
| `roadmap` | Planejamento estratégico de roadmap e análise competitiva para produtos |

### Skills GitHub & DevOps (5 skills)

| Skill | Descrição |
|-------|-----------|
| `workflow` | Fluxo Git e commits atômicos para projetos Laravel |
| `cicd` | CI/CD com GitHub Actions para Laravel |
| `issues` | Análise e classificação de issues do GitHub com detecção de duplicados, spam e priorização |
| `pr-review` | Revisão completa de Pull Requests com análise multi-aspecto (security, quality, logic, patterns) |
| `mcp` | Validação de aplicações usando MCP tools (Electron, Browser, API, Database) |

### Skills Qualidade & Implementação (5 skills)

| Skill | Descrição |
|-------|-----------|
| `qa` | Sistema completo de validação de qualidade com 11 fases de QA e workflow de correção |
| `docs` | Atualização de documentação (IMPLEMENTATION.md) |
| `coder` | Agente implementador de código passo-a-passo com verificação obrigatória e autocrítica |
| `codebase` | Identificação de oportunidades de melhoria no codebase baseada em padrões existentes |
| `ui-ux` | Identificação de melhorias de UI/UX com validação visual usando browser automation |

**Total: 24 skills** (atualizado para PHP 8.5+, Laravel 12, Filament 5)

## Agentes Autônomos

Agentes orquestram múltiplas skills para executar workflows completos de forma autônoma:

| Agente | Propósito | Skills Orquestradas |
|--------|-----------|---------------------|
| `feature-lifecycle` | Pipeline completo: spec → code → test → QA → PR | 14 skills |
| `bugfix` | Investigação → fix → testes de regressão → commit | 7 skills |
| `refactor-safe` | Refatoração com verificação contínua de testes | 7 skills |
| `sprint-executor` | Executa tarefas do sprint ativo sequencialmente | 7 skills |
| `pr-guard` | Validação pre-merge adaptativa por complexidade | 6 skills |

## Hooks

Guardrails e automações que rodam em eventos do Claude Code:

| Hook | Evento | Descrição |
|------|--------|-----------|
| `laravel-convention-guard` | Write/Edit | Bloqueia anti-patterns Laravel (Services, env() fora de config) |
| `post-commit-doc-check` | git commit | Avisa se docs não foram atualizados |
| `pre-push-quality-gate` | git push | Roda Pint + PHPStan + Pest antes do push |
| `sprint-context-loader` | Início de sessão | Mostra sprint ativo e próxima tarefa |
| `skill-auto-suggest` | Prompt do usuário | Sugere skills relevantes por keywords |
| `sprint-auto-update` | Fim de resposta | Lembra de atualizar sprint tracking |
| `tenancy-safety-check` | Write/Edit | Detecta queries sem tenant scoping |
| `ai-attribution-scrubber` | git commit | Remove atribuição AI dos commits |

## Instalação

### Opção 1: Claude Code Plugin (Recomendado)

Instale como plugin do Claude Code com autocomplete integrado:

```bash
# Instalar plugin (inclui todas as 24 skills + autocomplete)
claude plugin add aronpc/ai
```

Após a instalação, todas as skills ficam disponíveis via `/aronpc:nome-da-skill` com autocomplete.

### Opção 2: Claude Code Marketplace

Adicione via marketplace para gerenciamento de pacotes:

```bash
# 1. Adicionar marketplace
/plugin marketplace add aronpc/ai

# 2. Instalar plugin
/plugin install aronpc@aronpc-skills
```

### Opção 3: Instalação Manual

```bash
# Clonar repositório
git clone https://github.com/aronpc/ai.git

# Copiar skills para o diretório do Claude Code
cp -r ai/skills/* ~/.claude/skills/

# Ou para um projeto específico
cp -r ai/skills/* seu-projeto/.claude/skills/
```

### Opção 4: Laravel Boost

```bash
# Adicionar skill específica
php artisan boost:add-skill standards

# Adicionar todas as skills
php artisan boost:add-skill --all
```

## Estrutura do Projeto

```
ai/
├── .claude-plugin/
│   ├── plugin.json           # Configuração do plugin Claude Code
│   └── marketplace.json      # Configuração do marketplace
├── agents/                   # 5 agentes autônomos
├── hooks/                    # 8 hooks de guardrails e automação
├── commands/                 # 24 command wrappers (autocomplete)
├── skills/                   # 24 Agent Skills
│   └── [nome-skill]/
│       ├── SKILL.md          # Obrigatório - Documentação principal
│       ├── scripts/          # Opcional - Scripts executáveis
│       ├── references/       # Opcional - Documentação adicional
│       └── assets/           # Opcional - Templates e exemplos
├── scripts/                  # Scripts de manutenção
├── CLAUDE.md                 # Instruções para agentes AI
├── INTEGRATION-MAP.md        # Mapa de relações entre skills
└── RESTRUCTURE-PLAN.md       # Plano de namespaces futuros
```

## Uso

Após instalar, invoque qualquer skill via comando:

```
/aronpc:architecture    # Arquitetura Laravel
/aronpc:testing         # Testes com Pest PHP
/aronpc:sprint          # Gerenciamento de sprints
/aronpc:pr-review       # Review de Pull Requests
```

Cada skill aceita argumentos opcionais com instruções específicas:

```
/aronpc:coder implementar CRUD de produtos
/aronpc:spec criar spec para API de pagamentos
```

## Licença

[MIT](./LICENSE) - Copyright (c) 2026 AronPC
