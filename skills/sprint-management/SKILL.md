---
name: sprint-management
description: Gerenciamento completo de sprints de desenvolvimento no projeto Laravel
---

# Sprint Management

## Quando usar esta skill

Use esta skill sempre que trabalhar com:
- Criar novos sprints de desenvolvimento
- Atualizar status de sprints existentes
- Manter o arquivo `sprints/tracking.md`
- Validar estrutura e nomenclatura de sprints
- Documentar implementações e progresso
- Brainstorming e refinamento de ideias para sprints

## Brainstorming de Sprints

### Processo de Brainstorming

Antes de criar ou modificar um sprint, use o brainstorming para explorar e refinar as ideias:

#### 1. Exploração Inicial
- **Qual problema estamos resolvendo?**
- **Qual valor isso traz para o usuário/projeto?**
- **Quais são os requisitos mínimos?**
- **Existe algo similar no códigobase que podemos reaproveitar?**

#### 2. Perguntas para Refinamento
- **Escopo**: Está muito amplo? Muito específico?
- **Dependências**: Depende de outros sprints ou features?
- **Complexidade**: Pode ser quebrado em sprints menores?
- **Prioridade**: É crítico, importante, ou pode aguardar?

#### 3. Template de Documentação de Brainstorming
```markdown
## Brainstorming

### Ideias Iniciais
- Ideia 1
- Ideia 2

### Análise de Opções
| Opção | Vantagens | Desvantagens | Prioridade |
|-------|----------|--------------|------------|
| Abordagem A | - | - | Alta |
| Abordagem B | - | - | Média |

### Decisão Tomada
- [x] Decisão tomada
- Motivo: [explicar]

### Próximos Passos
1. Passo 1
2. Passo 2
```

### 4. Checklist de Qualidade de Sprint
Antes de finalizar a documentação de um sprint, verifique:

- [ ] **Objetivo claro**: O objetivo do sprint está explícito e mensurável
- [ ] **Escopo definido**: Limites claros entre o que está incluído e excluído
- [ ] **Aceitabilidade**: Pode ser razoavelmente implementado com os recursos atuais
- [ ] **Testabilidade**: É possível escrever testes para as funcionalidades
- [ ] **Dependências mapeadas**: Dependências de outros sprints estão documentadas
- [ ] **Critérios de sucesso**: O que define que o sprint está "completo"?

### 5. Refinamento Iterativo
Quando o usuário fornecer informações sobre um sprint:
1. Primeiro fazer brainstorming para explorar diferentes aboragens
2. Apresentar as opções com vantagens/desvantagens
3. Perguntar qual abordagem o usuário prefere
4. Documentar a decisão tomada e o motivo
5. Prosseguir com a documentação final do sprint

## Estrutura de Sprints

### Diretório Base
Todos os sprints são mantidos em `sprints/`:
- `sprints/tracking.md` - Visão geral e rastreamento de todos os sprints
- `sprints/XXX-nome-do-sprint.md` - Documentação individual de cada sprint

### Nomenclatura de Arquivos
- **Tracking**: `sprints/tracking.md`
- **Sprint individual**: `sprints/XXX-nome-curto.md`
  - `XXX`: Número sequencial de 3 dígitos (001, 002, 003...)
  - `nome-curto`: Nome em kebab-case, descritivo

## Status de Sprints

| Status | Descrição |
|--------|-----------|
| **Planejado** | Sprint planejado, aguardando início |
| **Em Andamento** 🚧 | Sprint em execução ativa |
| **Concluído** ✅ | Sprint finalizado e implementado |
| **Cancelado** | Sprint cancelado |

## Criar Novo Sprint

### 1. Criar arquivo do sprint
```bash
# Criar arquivo com número sequencial
sprints/012-nome-do-sprint.md
```

### 2. Template de arquivo de sprint
```markdown
# Sprint XXX: Nome Descritivo

## Status
**Status**: Planejado 📋

## Descrição
Descrição detalhada do objetivo deste sprint.

## Requisitos
- Requisito 1
- Requisito 2

## Implementação

### Tarefas
- [ ] Tarefa 1
- [ ] Tarefa 2

### Alterações
- **Backend**:
  - `app/Models/...`
  - `database/migrations/...`

- **Frontend**:
  - `resources/js/Pages/...`
  - `resources/views/...`

## Testes
- [ ] Testes unitários
- [ ] Testes de feature
- [ ] Testes de browser

## Notas
Notas adicionais sobre implementação.
```

## Atualizar Tracking

### Adicionar novo sprint ao `sprints/tracking.md`
```markdown
| [012-nome-do-sprint](sprints/012-nome-do-sprint.md) | **Planejado** 📋 | - | - | Descrição breve do sprint |
```

### Formato de entrada na tabela
```markdown
| [XXX-nome-arquivo](sprints/XXX-nome-arquivo.md) | **Status** emoji | data-início | data-fim | Descrição |
```

## Comandos Úteis

### Ver todos os sprints
```bash
ls -la sprints/
```

### Criar novo sprint (interativo)
```bash
# Encontrar próximo número sequencial
ls sprints/*.md | grep -oP '\d+' | sort -n | tail -1

# Criar arquivo do sprint
touch sprints/012-novo-sprint.md
```

### Atualizar Boost com nova skill
```bash
php artisan boost:update
```

## Validações

### Verificar estrutura do sprint
- [ ] Arquivo existe em `sprints/`
- [ ] Nomenclatura correta (XXX-nome-curto.md)
- [ ] Contém seção de status
- [ ] Contém descrição do objetivo
- [ ] Listado em `sprints/tracking.md`

### Verificar tracking
- [ ] Todos os sprints estão listados
- [ ] Status está atualizado
- [ ] Datas estão preenchidas (se aplicável)
- [ ] Links estão funcionando

## Filament Blueprint Integration

### Quando usar Blueprint com Sprints

Use Filament Blueprint quando o sprint envolver:
- Múltiplas tabelas/relacionamentos
- Formulários complexos
- Recursos Filament (Resources, Widgets, etc.)
- Estruturas de banco de dados com múltiplas migrations

### Estrutura com Blueprint

```
sprints/
├── XXX-nome-do-sprint.md          ← Documentação do sprint
└── blueprints/                         ← Planos Blueprint (dentro do sprint)
    └── XXX-nome-do-sprint/
        ├── blueprint.yaml             ← Arquivo principal do plano
        ├── migrations/                 ← Migrations geradas
        └── resources/                 ← Resources Filament
            ├── Models/
            └── Resources/
```

### Template de Sprint com Blueprint

```markdown
# Sprint XXX: Nome Descritivo

## Status
**Status**: Planejado 📋

## Descrição
Descrição detalhada do objetivo deste sprint.

## Blueprint
**Arquivo**: `sprints/XXX-nome-do-sprint/blueprints/blueprint.yaml`

Este sprint usa Filament Blueprint para gerar:
- [ ] Modelos e migrations
- [ ] Resources Filament
- [ ] Relacionamentos
- [ ] Formulários

### Comandos Blueprint
```bash
# Gerar código a partir do blueprint
php artisan blueprint:build sprints/XXX-nome-do-sprint/blueprints/blueprint.yaml

# Gerar e aplicar migrations
php artisan blueprint:build sprints/XXX-nome-do-sprint/blueprints/blueprint.yaml --migrate
```

### Estrutura Gerada
Após executar o blueprint:
- Modelos em `app/Models/`
- Migrations em `database/migrations/`
- Resources em `app/Filament/Resources/`
- Factories em `database/factories/`

## Requisitos
- Requisito 1
- Requisito 2

## Implementação

### 1. Preparação
- [ ] Revisar blueprint.yaml
- [ ] Ajustar campos/relacionamentos se necessário
- [ ] Executar `php artisan blueprint:build`

### 2. Tarefas
- [ ] Tarefa 1
- [ ] Tarefa 2

### 3. Alterações Manuais (se necessário)
- **Backend**:
  - `app/Models/...`
  - `database/migrations/...`

- **Frontend**:
  - `resources/js/Pages/...`
  - `resources/views/...`

## Testes
- [ ] Testes unitários
- [ ] Testes de feature
- [ ] Testes de browser
- [ ] Testes de Resources Filament

## Notas
Notas adicionais sobre implementação.
```

### Exemplo Prático

**Sprint**: Sistema de tags para turmas

```
sprints/
├── 005-class-group-tags.md
└── blueprints/
    └── 005-class-group-tags/
        ├── blueprint.yaml
        ├── migrations/
        │   └── 2026_02_03_000001_create_class_groups_table.php
        └── resources/
            └── ClassGroupResource/
                ├── ClassGroupResource.php
                └── Pages/
                    ├── ListClassGroups.php
                    ├── CreateClassGroup.php
                    └── EditClassGroup.php
```

No arquivo do sprint (`005-class-group-tags.md`), referenciar o blueprint:

```markdown
## Blueprint
**Arquivo**: `sprints/005-class-group-tags/blueprints/blueprint.yaml`
**Comando**: `php artisan blueprint:build sprints/005-class-group-tags/blueprints/blueprint.yaml --migrate`

Este sprint gera:
- Model `ClassGroup` com relacionamento `hasMany(ClassGroupTag)`
- Resource `ClassGroupResource` com table e forms
- Tags com cores e prioridades
```

## Convenções

- Usar kebab-case para nomes de arquivos
- Usar português brasileiro para documentação
- Ser descritivo na descrição dos sprints
- Marcar status com emojis para identificação rápida
- Atualizar `tracking.md` sem que criar ou modificar sprints

## Exemplo de Uso

Quando o usuário solicitar: "Criar sprint para implementar X"
1. Verificar último número de sprint em `tracking.md`
2. Criar arquivo `sprints/XXX-nome.md`
3. Adicionar entrada em `tracking.md`
4. Perguntar ao usuário os detalhes do sprint
5. Preencher o template com as informações fornecidas
