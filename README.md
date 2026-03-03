# AI Skills - AronPC

Coleção de **Agent Skills** personalizadas para uso com Claude Code, Cursor e [Laravel Boost](https://github.com/consulting/laravel-boost).

## Sobre

Este repositório contém **Agent Skills** personalizadas que seguem o padrão [Agent Skills](https://agentskills.io/). Skills são módulos de conhecimento que agentes podem carregar sob demanda para trabalhar com tarefas específicas em projetos Laravel.

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

## Instalação

### Opção 1: Claude Code Marketplace (Recomendado)

Adicione este repositório como marketplace e instale os pacotes de skills:

```bash
# 1. Adicionar marketplace
/plugin marketplace add aronpc/ai

# 2. Instalar pacote de skills (escolha um ou mais)
/plugin install laravel-development@aronpc-skills
/plugin install project-management@aronpc-skills
/plugin install github-workflows@aronpc-skills
/plugin install devops-tools@aronpc-skills
```

### Opção 2: Instalação Manual

Clone o repositório e copie as skills desejadas:

```bash
# Clonar repositório
git clone https://github.com/aronpc/ai.git

# Copiar skills para o diretório do Claude Code
cp -r ai/skills/* ~/.claude/skills/

# Ou para um projeto específico
cp -r ai/skills/* seu-projeto/.claude/skills/
```

### Opção 3: Laravel Boost

Use o comando `boost:add-skill` para adicionar skills ao seu projeto Laravel:

```bash
# Adicionar repositório (será pedido para escolher skills)
php artisan boost:add-skill

# Adicionar skill específica
php artisan boost:add-skill standards

# Adicionar todas as skills
php artisan boost:add-skill --all
```

## Estrutura de uma Skill

Cada skill segue o padrão [Agent Skills](https://agentskills.io/):

```
skills/
└── [nome-skill]/
    ├── SKILL.md              # Obrigatório - Documentação principal da skill
    ├── scripts/              # Opcional - Scripts executáveis relacionados
    ├── references/           # Opcional - Documentação adicional
    └── assets/              # Opcional - Templates, exemplos, dados
```

## Licença

[MIT](./LICENSE) - Copyright (c) 2026 AronPC
