# AI Skills - AronPC

Coleção de **Agent Skills** personalizadas para uso com Claude Code, Cursor e [Laravel Boost](https://github.com/consulting/laravel-boost).

## Sobre

Este repositório contém **Agent Skills** personalizadas que seguem o padrão [Agent Skills](https://agentskills.io/). Skills são módulos de conhecimento que agentes podem carregar sob demanda para trabalhar com tarefas específicas em projetos Laravel.

## Skills Disponíveis

### Skills Core Laravel (8 skills)

| Skill                      | Descrição                                                         |
|----------------------------|-------------------------------------------------------------------|
| `sprint-management`        | Gerenciamento completo de sprints de desenvolvimento Laravel      |
| `laravel-coding-standards` | Padrões de código Laravel e PHP baseados nas diretrizes da Spatie |
| `laravel-architecture`     | Arquitetura limpa Laravel com Actions, DTOs, Policies             |
| `laravel-actions-events`   | Laravel Actions, Events, Jobs e Observers                          |
| `laravel-exceptions`       | Exceções customizadas com interfaces renderable/reportable        |
| `laravel-i18n`             | Internacionalização completa (EN, ES, PT-BR)                       |
| `laravel-models`           | Models Eloquent, relações, scopes, factories, multi-tenancy       |
| `laravel-testing-pest`     | Testes completos com Pest PHP (Feature, Unit, HTTP, Datasets)     |

> **Nota:** `laravel-filament` não incluído - use a skill nativa do Laravel Boost para Filament 3.x/4.x

### Skills Integração & DevOps (3 skills)

| Skill | Descrição |
|-------|-----------|
| `git-workflow-laravel` | Fluxo Git e commits atômicos para projetos Laravel |
| `cicd-github-actions`  | CI/CD com GitHub Actions para Laravel        |
| `documentation-updates` | Atualização de documentação (IMPLEMENTATION.md) |

### Skills Realtime & UX (2 skills)

| Skill | Descrição |
|-------|-----------|
| `laravel-realtime` | Laravel Reverb (WebSockets), Broadcasting, Canais presence/private |
| `laravel-ux`        | Laravel Precognition, Prompts, Turbo (HMR) para UX otimizada |

**Total: 14 skills Laravel** (atualizado para PHP 8.5+, Laravel 12, Filament 5)

## Instalação

Use o comando `boost:add-skill` para adicionar skills ao seu projeto Laravel:

```bash
# Adicionar repositório (será pedido para escolher skills)
php artisan boost:add-skill

# Adicionar skill específica
php artisan boost:add-skill laravel-coding-standards

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
