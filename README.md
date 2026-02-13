# AI Skills - Aronpc

Coleção de **Agent Skills** personalizadas para uso com Claude Code, Cursor e outros agentes compatíveis.

## Sobre

Este repositório contém skills personalizadas que seguem o padrão [Agent Skills](https://agentskills.io/). Skills são módulos de conhecimento que agentes podem carregar sob demanda para trabalhar com tarefas específicas.

## Skills Disponíveis

| Skill | Descrição |
|-------|-----------|
| **sprint-management** | Gerenciamento completo de sprints de desenvolvimento com brainstorming e documentação |

## Como Usar

### Opção 1: Git Submodule (Recomendado)

Adicionar este repositório como submodule no seu projeto Laravel:

```bash
# No diretório raiz do seu projeto
git submodule add https://github.com/aronpc/ai.git .ai/skills-custom
git submodule update --init --recursive
```

Isso criará um link em `.ai/skills-custom/` apontando para este repositório.

### Opão 2: Copiar Diretório

```bash
# Criar link simbólico
ln -s /home/aron/Projetos/ai /home/aron/Projetos/seu-projeto/.ai/skills-custom
```

### Opção 3: Clonar

```bash
git clone https://github.com/aronpc/ai.git seu-projeto/.ai/skills-custom
```

## Atualizar Skills

Sempre que adicionar ou modificar skills neste repositório, rode nos seus projetos:

```bash
# Se usando submodule
git submodule update --remote --merge

# Depois atalizar o Boost
php artisan boost:update
```

## Estrutura de uma Skill

Cada skill fica em seu próprio diretório com arquivo `SKILL.md`:

```
ai-skills/
└── sprint-management/
    └── SKILL.md
```

O arquivo `SKILL.md` deve seguir o formato:

```markdown
---
name: sprint-management
description: Gerenciamento completo de sprints de desenvolvimento no projeto Laravel
---

# Sprint Management

## Quando usar esta skill
Use esta skill sempre que trabalhar com...
```

## Criar Nova Skill

1. Criar novo diretório: `skills/ nova-skill/`
2. Criar arquivo `SKILL.md` com YAML frontmatter
3. Testar localmente
4. Commitar e push

## Licença

MIT
