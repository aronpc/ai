---
name: sprint-management
description: Gerenciamento completo de sprints de desenvolvimento no projeto Laravel
---

# Sprint Management

## Quando usar esta skill

Use esta skill sempre que trabalhar com:
- Criar novos sprints de desenvolvimento
- Atualizar status de sprints existentes
- Executar tarefas de um sprint
- Manter o arquivo `sprints/tracking.md`
- Validar estrutura e nomenclatura de sprints
- Documentar implementações e progresso
- Brainstorming e refinamento de ideias para sprints

## Execução Natural de Sprints

### Prompt: Executar Tarefa de Sprint

Use este prompt automaticamente quando o usuário pedir para executar algo relacionado a um sprint existente:

```
Você está ajudando o usuário a executar tarefas de um sprint. Sua tarefa é TRABALHAR na tarefa E ATUALIZAR o sprint automaticamente.

## CONTEXTO

- Tarefa solicitada: [descrição do que o usuário pediu]
- Sprints existentes: [listar sprints encontrados em sprints/]
- Commit mais recente: [mostrar último commit]

## SUA TAREFA

1. Primeiro, encontre o sprint ativo (status "Em Andamento 🚧") ou o último sprint modificado
2. Leia o arquivo do sprint completo
3. Execute a tarefa solicitada pelo usuário
4. **CRÍTICO**: Após completar a tarefa, ATUALIZE o arquivo do sprint:
   - Marque [x] na tarefa correspondente que foi completada
   - Se era a última tarefa pendente, mude status para "Concluído ✅" e adicione data de conclusão
   - Se ainda há tarefas pendentes mas estava como "Planejado", mude para "Em Andamento 🚧"
5. Salve o arquivo atualizado

## IMPORTANTE

- Sempre atualize o sprint após executar qualquer tarefa
- Não peça confirmação - a atualização é automática
- Use o formato de data AAAA-MM-DD
- Preserve todo o resto do conteúdo do sprint

## EXEMPLO

Se o usuário pediu "criar a migration de usuários" e isso é a tarefa "- [ ] Criar migration de usuários" no sprint 001:
1. Execute: php artisan make:migration create_users_table
2. Abra sprints/001-nome.md
3. Mude "- [ ] Criar migration de usuários" para "- [x] Criar migration de usuários"
4. Se era a última tarefa: mude status para "Concluído ✅" e adicione "**Data Fim**: 2026-02-13"
5. Salve e informe o usuário que o sprint foi atualizado
```

### Prompt: Iniciar Sprint

Use quando o usuário começar a trabalhar em um sprint planejado:

```
O usuário está começando a trabalhar em um sprint. ATUALIZE o status automaticamente.

## CONTEXTO

- Sprint sendo iniciado: [nome do arquivo]
- Status atual: [deve ser "Planejado"]

## SUA TAREFA

1. Abra o arquivo do sprint
2. Mude "**Status**: Planejado 📋" para "**Status**: Em Andamento 🚧"
3. Adicione "**Data Início**: [data de hoje em AAAA-MM-DD]" abaixo da linha de status
4. Salve o arquivo
5. Informe o usuário que o sprint foi iniciado

Não peça confirmação - faça automaticamente.
```

### Prompt: Finalizar Sprint

Use quando todas as tarefas de um sprint forem completadas:

```
O usuário completou todas as tarefas de um sprint. FINALIZE o sprint automaticamente.

## CONTEXTO

- Sprint sendo finalizado: [nome do arquivo]
- Status atual: [deve ser "Em Andamento"]

## SUA TAREFA

1. Abra o arquivo do sprint
2. Verifique que TODAS as tarefas estão marcadas como [x]
3. Mude "**Status**: Em Andamento 🚧" para "**Status**: Concluído ✅"
4. Adicione "**Data Fim**: [data de hoje em AAAA-MM-DD]" (se não existir)
5. Salve o arquivo
6. ATUALIZE sprints/tracking.md com o novo status
7. Sugira commit: "git add sprints/[arquivo] sprints/tracking.md && git commit -m 'Complete: sprint [nome]'"

Não peça confirmação - faça automaticamente.
```

## Brainstorming de Sprints

Use o brainstorming quando estiver planejando ou refinando um sprint.

### Ask (uma de cada vez)

- **Goal**: Qual resultado os usuários devem alcançar?
- **Domain**: Quais contextos ou pacotes estão envolvidos?
- **Data**: Novos modelos/relacionamentos? Queries necessárias?
- **Interfaces**: HTTP/API/CLI? Inputs/outputs necessários? Authz?
- **Side-effects**: Email, storage, filas, sistemas externos?
- **Performance**: Throughput, latência, paginação, riscos N+1?
- **Observability**: Logs, métricas, eventos, tratamento de falhas?
- **Testing**: Ponto de entrada TDD, fixtures/factories, casos de borda?
- **Environment**: Sail ou host? Disponibilidade de DB/cache/mail/storage?

### Propose

Apresente um design de 200–300 palavras, cobrindo:
- Rotas/contratos, validação, DTOs/transformers
- Services (ports+adapters, strategies/pipelines)
- Mudanças de modelo de dados e migrations
- Jobs/events/listeners onde relevante
- Estratégia de testes (feature/unit), factories e seeds
- Quality gates e plano de rollout

### Prepare Next Steps

Sugerir um plano de implementação breve; então use `laravel:writing-plans` para formalizar.

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
| **Planejado** 📋 | Sprint planejado, aguardando início |
| **Em Andamento** 🚧 | Sprint em execução ativa |
| **Concluído** ✅ | Sprint finalizado e implementado |
| **Cancelado** ❌ | Sprint cancelado |

## Criar Novo Sprint

### Prompt: Criar Novo Sprint

Use este prompt quando o usuário quiser criar um novo sprint:

```
Você é um assistente de gerenciamento de sprints. Sua tarefa é CRIAR um novo sprint para o projeto.

## CONTEXTO

- Descrição da feature/sprint: [descrição fornecida pelo usuário]
- Requisitos conhecidos: [listar requisitos se fornecidos]
- Sprints existentes: [contexto de outros sprints relacionados]

## SUA TAREFA

1. Encontrar o último número de sprint em `sprints/tracking.md` (ou usar 001 se não existir)
2. Criar arquivo `sprints/XXX-nome-descritivo.md` (XXX = próximo número)
3. Usar o template abaixo preenchendo com as informações do usuário
4. ADICIONAR entrada em `sprints/tracking.md` no formato correto
5. Informar o usuário sobre o sprint criado

## TEMPLATE PARA USAR

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
- [ ] Há dependências documentadas
- [ ] Testes planejados
- [ ] Formatação correta e consistente
```

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
└── blueprints/                         ← Planos Blueprint (dentro do sprint!)
    └── XXX-nome-do-sprint/
        ├── blueprint.yaml
        ├── migrations/
        └── resources/
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

## Atualizar Tracking

### Prompt: Atualizar Tracking após Mudanças

Use este prompt quando o usuário modificar sprints e precisar atualizar o tracking:

```
Você é um assistente de gerenciamento de sprints. Sua tarefa é ATUALIZAR o arquivo `sprints/tracking.md` com as mudanças feitas nos sprints.

## CONTEXTO

- Sprints modificados: [listar arquivos .md modificados]
- Último commit: [hash ou mensagem do commit]
- Status atual de cada sprint: [listar status]

## SUA TAREFA

1. Ler o arquivo `sprints/tracking.md` atual
2. Para cada sprint modificado:
   - Extrair: nome, status, data início, data fim, descrição
   - Verificar se já existe entrada no tracking.md
   - Se existir: ATUALIZAR a entrada (status, datas)
   - Se não existir: ADICIONAR nova entrada no formato correto
3. Garantir que todas as linhas da tabela mantenham o formato
4. Salvar o arquivo atualizado

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

- Preserve a formatação da tabela
- As datas devem estar no formato AAAA-MM-DD
```

## Convenções

- Usar kebab-case para nomes de arquivos
- Usar português brasileiro para documentação
- Ser descritivo na descrição dos sprints
- Marcar status com emojis para identificação rápida
- Atualizar `tracking.md` sempre que modificar sprints
- **Sempre atualizar o sprint após executar tarefas** - isso é automático
