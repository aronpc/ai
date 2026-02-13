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

## Prompts de Autalização

### Prompt 1: Atualizar Tracking após Modificações

Use este prompt quando o usuário modificar sprints e precisar atualizar o tracking.md:

```
Você é um assistente de gerenciamento de sprints. Sua tarefa é ATUALIZAR o arquivo `sprints/tracking.md` com as mudanças feitas nos sprints.

## CONTEXTUALIZAÇÃO

- Último commit: [último hash ou mensagem]
- Sprints modificado(s): [listar arquivos .md modificado]
- Status atual de cada sprint: [listar status]

## SUA TAREFA

1. Ler o arquivo `sprints/tracking.md` atual
2. Para cada sprint modificado:
   - Extrair: nome, status, data início, data fim, descrição
   - Verificar se já existe entrada no tracking.md
   - Se existir: ATUALIZAR a entrada (status, datas)
   - Se não existir: ADICIONAR nova entrada no formato correto
3. Garantir que todas as linhas da tabela mantenham o formato
4. Não modificar outros arquivos, apenas o tracking.md

## FORMATO DA TABELA (mantenha este padrão)

| Sprint | Status | Data Início | Data Fim | Descrição |
|--------|--------|-------------|----------|-----------|
| [001-nome](sprints/001-nome.md) | **Status** emoji | data-início | data-fim | Descrição breve |

## STATUS E EMOJIS PERMITIDOS

- **Planejado** 📋
- **Em Andamento** 🚧
- **Concluído** ✅
- **Cancelado** ❌

## IMPORTANTE

- Use a variável $EDITOR paraaber o arquivo (ex: code, vim, nano)
- Preserve a formatação da tabela
- As datas devem estar no formato AAAA-MM-DD
```

### Prompt 2: Atualizar Sprint Atual

Use este prompt quando o usuário finalizar tarefas em um sprint e precisar atualizá-lo:

```
Você é um assistente de gerenciamento de sprints. Sua tarefa é ATUALIZAR o sprint que o usuário acabou de trabalhar.

## CONTEXTUALIZAÇÃO

- Sprint sendo trabalhado: [nome do arquivo]
- Tarefas concluídas: [listar o que foi feito]
- Status atual: [status atual do sprint]

## SUA TAREFA

1. Aber o arquivo do sprint
2. Atualizar a seção "## Status" com o novo status
3. Atualizar a seção "### Tarefas" marcando como [x] o que foi completo
4. Se todas as tarefas estiverem completas:
   - Mudar status para "Concluído ✅"
   - Adicionar data de conclusão (hoje: date +%Y-%m-%d)
5. Se ainda houver tarefas pendentes:
   - Mudar status para "Em Andamento 🚧" se ainda estiver como "Planejado"
6. Manter o resto do conteúdo intacto

## STATUS E PROGRESSÃO

- **Planejado** 📋 → **Em Andamento** 🚧 → **Concluído** ✅
- Use "Concluído" apenas quando TODAS as tarefas estiverem marcadas

## SEÕES DO SPRINT

Mantenha:
- ## Status
- ## Descrição
- ## Requisitos
- ## Implementação
  - ### Tarefas
  - ### Alterações
  - ## Testes
  - ## Notas

Não remova seções existentes!
```

### Prompt 3: Criar Novo Sprint

Use este prompt quando o usuário quiser criar um novo sprint:

```
Você é um assistente de gerenciamento de sprints. Sua tarefa é CRIAR um novo sprint para o projeto.

## CONTEXTUALIZAÇÃO

- Descrição da feature/sprint: [descrição fornecida pelo usuário]
- Requisitos conhecidos: [listar requisitos se fornecidos]
- Sprints existentes: [contexto de outros sprints relacionados]

## SUA TAREFA

1. Encontrar o último número de sprint em `sprints/tracking.md`
2. Criar arquivo `sprints/XXX-nome-descritivo.md` (XXX = próximo número)
3. Usar o template abaixo preenchendo com as informações do usuário
4. ADICIONAR entrada no `sprints/tracking.md` no formato correto
5. Aber o arquivo criado para review

## TEMPLATE PARA USAR (copie e preencha)

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

## CRITÉRIOS DE QUALIDADE

Antes de finalizar, verifique:
- [ ] O nome do sprint é descritivo (kebab-case)
- [ ] O número de sprint tem 3 dígitos com zero à esquerda quando necessário
- [ ] A descrição explica claramente o objetivo
- [ ] Os requisitos são claros e mensuráveis
- [ ] As tarefas são específicas e acionáveis
```

### Prompt 4: Revisão e Validação de Sprint

Use este prompt para revisar um sprint existente:

```
Você é um assistente de gerenciamento de sprints. Sua tarefa é REVISAR e VALIDEAR um sprint existente.

## CONTEXTUALIZAÇÃO

- Sprint a revisar: [nome do arquivo]
- Motivo da revisão: [ex: sprint ficou parado, precisa mais detalhes, etc.]

## SUA TAREFA

1. Aber o arquivo do sprint
2. Analsar:
   - O status está correto? Se não, sugerir atualização
   - A descrição é clara e objciva?
   - Os requisitos estão bem definidos?
   - As tarefas são específicas?
   - Há dependências em outros sprints? Estão documentadas?
3. Identificar problemas:
   - Tarefas muito amplas
   - Requisitos vagos
   - Falta de contexto
   - Dependências não documentadas
4. Fazer perguntas claras ao usuário para resolver problemas
5. Sugerir melhorias específicas

## PERGUNTAS SUGERIDAS

- "Este sprint parece muito amplo. Podemos quebrá-lo em sprints menores?"
- "Quais são os critérios de sucesso? Como saberemos que está concluído?"
- "Existe algum sprint existente que este depende?"
- "Quais testes você planeja escrever para validar este sprint?"
- "Este sprint usa Blueprint? Preciso adicionar seção de Blueprint?"

## CHECKLIST DE VALIDAÇÃO

- [ ] Status correto e atualizado
- [ ] Descrição clara e objciva
- [ ] Requisitos bem definidos
- [ ] Tarefas específicas e acionáveis
- [ ] Dependências documentadas
- [ ] Testes planeados
- [ ] Formatação correta e consistente
```

## Fluxo de Trabalho Sugerido

### Diário de Desenvolvimento

1. **Início do dia**: Use `git sprint-new` ou crie manualmente
2. **Durante o desenvolvimento**: Marque tarefas como [x] quando completar
3. **Fim do dia**: Use `git sprint-update-tracking` para atualizar tracking.md

### Sempre que finalizar um sprint

1. Atualize o arquivo do sprint marcando tarefas completas
2. Use `git sprint-update-tracking` para refletir no tracking.md
3. Se tudo completo: status → Concluído ✅

### Commitando mudanças

```bash
# Após trabalhar em um sprint
git commit -m "Progress: sprint 012-nome-do-sprint"

# Quando finalizar
git commit -m "Complete: sprint 012-nome-do-sprint"
git sprint-update-tracking  # Atualiza tracking.md
git commit -m "Update: tracking.md"
```

## Aliases Úteis Disponíveis

```bash
# Aber tracking.md
git sprint-track

# Aber último sprint modificado
git sprint-last

# Criar novo sprint
git sprint-new nome-do-sprint

# Atualizar tracking.md
git sprint-update-tracking
```

## Notas sobre Uso

- A variável $EDITOR define qual editor usar (code, vim, nano)
- Sempre que um prompt pedir para "aber" arquivo, use $EDITOR
- Preserve formatação e estrutura dos arquivos
- Mantenha consistência com os padrões do projeto
