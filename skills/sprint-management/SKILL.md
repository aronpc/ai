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
| **Planejado** | Sprint planejado, aguardando início |
| **Em Andamento** 🚧 | Sprint em execução ativa |
| **Concluído** ✅ | Sprint finalizado e implementado |
| **Cancelado** | Sprint cancelado |

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

1. Encontrar o último número de sprint em `sprints/tracking.md`
2. Criar arquivo `sprints/XXX-nome-descritivo.md` (XXX = próximo número)
3. Usar o template abaixo preenchendo com as informações do usuário
4. ADICIONAR entrada em `sprints/tracking.md` no formato correto
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
4. Se o arquivo foi modificado, adicionar ao git

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

- Use a variável $EDITOR para aber o arquivo (ex: code, vim, nano)
- Preserve a formatação da tabela
- As datas devem estar no formato AAAA-MM-DD
```

## Atualizar Sprint Atual

### Prompt: Atualizar Sprint ao Finalizar Tarefas

Use este prompt quando o usuário finalizar tarefas em um sprint e precisar atualizá-lo:

```
Você é um assistente de gerenciamento de sprints. Sua tarefa é ATUALIZAR o sprint que o usuário acabou de trabalhar.

## CONTEXTO

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

## SEÕÕES DO SPRINT

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

## Scripts e Aliases

### Scripts Disponíveis

| Script | Descrição |
|--------|-----------|
| `sprint-track` | Aber tracking.md no editor |
| `sprint-last` | Aber último sprint modificado |
| `sprint-update-tracking` | Atualizar tracking.md com sprints recentes |
| `sprint-new` | Criar novo sprint com template |

### Instalação

```bash
# No diretório do projeto
bash /home/aron/Projetos/ai/hooks/install
```

Isso criará:
- Aliases git: `git sprint-track`, `git sprint-last`, `git sprint-update-tracking`, `git sprint-new`
- Estrutura `sprints/` se não existir
- Tracking.md básico

### Aliases Úteis

```bash
# Aber tracking.md
git sprint-track

# Aber último sprint modificado
git sprint-last

# Atualizar tracking.md
git sprint-update-tracking

# Criar novo sprint
git sprint-new nome-do-sprint
```

## Convenções

- Usar kebab-case para nomes de arquivos
- Usar português brasileiro para documentação
- Ser descritivo na descrição dos sprints
- Marcar status com emojis para identificação rápida
- Atualizar `tracking.md` sempre que modificar sprints

## Fluxo de Trabalho Sugerido

### Diário de Desenvolvimento

1. **Início do dia**: Use `git sprint-new` ou crie manualmente
2. **Durante o desenvolvimento**: Marque tarefas como [x] quando completar
3. **Fim do dia**: Use `git sprint-update-tracking` para refletir no tracking.md
4. **Quando finalizar**: Atualize status para "Concluído ✅"

### Commitando Mudanças

```bash
# Após trabalhar em um sprint
git commit -m "Progress: sprint 012-nome-do-sprint"

# Quando finalizar
git commit -m "Complete: sprint 012-nome-do-sprint"
git sprint-update-tracking  # Atualiza tracking.md
git commit -m "Update: tracking.md"
```
