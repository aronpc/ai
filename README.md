# AI Skills - Aronpc

Coleção de **Agent Skills** personalizadas para uso com Claude Code, Cursor e [Laravel Boost](https://github.com/konsulting/laravel-boost).

## Sobre

Este repositório contém skills personalizadas que seguem o padrão [Agent Skills](https://agentskills.io/). Skills são módulos de conhecimento que agentes podem carregar sob demanda para trabalhar com tarefas específicas em projetos Laravel.

## Skills Disponíveis

| Skill | Descrição |
|-------|-----------|
| **sprint-management** | Gerenciamento completo de sprints de desenvolvimento com brainstorming e documentação |

## Instalação

Use o comando `boost:add-skill` para adicionar skills ao seu projeto Laravel:

```bash
# Adicionar repositório (será pedido para escolher as skills)
php artisan boost:add-skill aronpc/ai

# Adicionar repositório com todas as skills
php artisan boost:add-skill aronpc/ai --all

# Atualizar skills instaladas
php artisan boost:update
```

## Estrutura de uma Skill

Cada skill fica em seu próprio diretório com arquivo `SKILL.md`:

```
skills/
└── sprint-management/
    └── SKILL.md
```

O arquivo `SKILL.md` deve seguir o formato com YAML frontmatter:

```markdown
---
name: sprint-management
description: Gerenciamento completo de sprints de desenvolvimento no projeto Laravel
---

# Sprint Management

## Quando usar esta skill
Use esta skill sempre que trabalhar com...
```

## Licença

[MIT](./LICENSE) - Copyright (c) 2026 AronPC
