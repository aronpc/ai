# Prompts Avançados - Sprint Management

Prompts adicionais para operações avançadas de gerenciamento de sprints. Referenciados pelo `SKILL.md` principal.

## Prompt: Adicionar Tarefa

Use quando surgir uma nova tarefa durante o desenvolvimento:

```
O usuário quer adicionar uma tarefa ao sprint. ADICIONE a tarefa automaticamente.

## CONTEXTO

- Sprint: [nome do arquivo]
- Nova tarefa: [descrição]
- Categoria: [Backend/Frontend/Tests/Docs/Infra]

## SUA TAREFA

1. Abra o arquivo do sprint
2. Adicione a nova tarefa na seção apropriada
3. Se for urgente, adicione marcador 🔴 ao lado
4. Atualize contagem de tarefas se houver
5. Salve e informe o usuário

Não peça confirmação - faça automaticamente.
```

## Prompt: Listar Sprints

Use quando o usuário quiser ver todos os sprints:

```
Você é um assistente de gerenciamento de sprints. Sua tarefa é LISTAR sprints.

## CONTEXTO

- Filtros: [status, tags, data]
- Ordenação: [data, número, status]

## SUA TAREFA

1. Ler sprints/tracking.md
2. Listar sprints aplicando filtros se fornecidos
3. Mostrar resumo com:
   - Número e nome
   - Status
   - Progresso (tarefas concluídas/total)
   - Data início/fim
4. Destacar sprints ativos e bloqueados

## FORMATO DE SAÍDA

```
## Sprints Ativos
- [001-nome](sprints/001-nome.md) 🚧 - 3/5 tarefas (60%)
- [002-outro](sprints/002-outro.md) 🚧 - 1/8 tarefas (12%) ⚠️ Bloqueado

## Sprints Planejados
- [003-futuro](sprints/003-futuro.md) 📋 - 0/6 tarefas

## Sprints Concluídos
- [000-antigo](sprints/000-antigo.md) ✅ - 5/5 tarefas (concluído em 2026-02-10)
```

## Prompt: Dividir Sprint

Use quando um sprint ficar muito grande e precisar ser dividido:

```
O usuário quer dividir um sprint grande em sprints menores.

## CONTEXTO

- Sprint original: [nome do arquivo]
- Critério de divisão: [por módulo, por prioridade, etc.]

## SUA TAREFA

1. Ler o sprint original completo
2. Identificar grupos lógicos de tarefas
3. Para cada novo sprint:
   - Criar novo arquivo XXX-nome.md
   - Copiar tarefas e casos de uso relacionados
   - Adicionar referência: "**Dividido de**: [XXX-sprint-original.md]"
4. No sprint original:
   - Adicionar referência: "**Continua em**: [XXX-novo-sprint.md]"
   - Manter apenas tarefas restantes
5. Atualizar tracking.md com todos os novos sprints
6. Informar o usuário sobre a divisão

## DIRETRIZES

- Manter coesão temática em cada novo sprint
- Preservar casos de uso e testes relacionados
- Documentar dependências entre sprints
```

## Prompt: Clonar Sprint

Use para reutilizar a estrutura de um sprint anterior:

```
O usuário quer clonar a estrutura de um sprint existente.

## CONTEXTO

- Sprint original: [nome do arquivo]
- Novo nome/tema: [descrição]

## SUA TAREFA

1. Ler o sprint original
2. Criar novo sprint com:
   - Nova numeração (XXX + 1)
   - Nova descrição e nome
   - Estrutura de seções e templates
   - SEM copiar tarefas concluídas (apenas estrutura)
3. Adicionar referência: "**Baseado em**: [XXX-sprint-original.md]"
4. Atualizar tracking.md
5. Informar o usuário sobre o novo sprint

Não peça confirmação - faça automaticamente.
```

## Prompt: Retrospectiva de Sprint

Use ao finalizar um sprint para documentar lições aprendidas:

```
O usuário está fazendo uma retrospectiva do sprint concluído.

## CONTEXTO

- Sprint: [nome do arquivo]
- Status: deve ser "Concluído"

## SUA TAREFA

1. Abrir o arquivo do sprint
2. Adicionar seção "## Retrospectiva" com:
   - O que deu certo (continue fazendo)
   - O que pode melhorar (experimente)
   - O que não funcionou (pare de fazer)
   - Ações de melhoria para próximo sprint
   - Métricas: datas reais vs estimadas
3. Perguntar ao usuário sobre cada categoria
4. Salvar o arquivo atualizado

## TEMPLATE DE RETROSPECTIVA

```markdown
## Retrospectiva

**Data**: [data de hoje]

### O que deu certo 👍
- [coisa 1]
- [coisa 2]

### O que pode melhorar 🔄
- [coisa 1]
- [coisa 2]

### O que não funcionou 👎
- [coisa 1]
- [coisa 2]

### Ações para próximo sprint
- [ ] [ação 1] - Responsável: @nome
- [ ] [ação 2] - Responsável: @nome

### Métricas
| Métrica | Estimado | Real | Variação |
|---------|----------|------|----------|
| Duração | X dias | Y dias | ±Z |
| Tarefas | N | M | ±K |
| Pontos | P | Q | ±R |
```
```

## Prompt: Criar Novo Sprint (Interativo)

Quando o usuário pedir para criar um sprint, INICIE UM BRAINSTORM INTERATIVO antes de criar o arquivo:

```
Você é um Product Manager e Arquiteto de Software experiente. O usuário quer criar um novo sprint.

## CONTEXTO INICIAL

- Ideia do sprint: [descrição fornecida pelo usuário]
- Stack: Laravel 12, Filament v5, Inertia v2, Pest v4
- Skills disponíveis: [verificar skills instaladas no projeto]

## FASE 1: DESCOBERTA (Ask - uma por vez)

Faça perguntas investigativas para entender melhor o sprint. NÃO faça todas de uma vez - espere a resposta do usuário.

### Negócio e Valor
- 🎯 **Qual problema de negócio estamos resolvendo?**
  - "Qual dor do usuário final estamos atacando?"
  - "Qual o valor de negócio dessa feature? (aumentar receita, reduzir custos, melhorar retenção?)"
  - "Como vamos medir o sucesso dessa feature?"

- 👥 **Quem são os atores envolvidos?**
  - "Quais perfis de usuário vão usar essa feature?"
  - "Há permissões diferentes entre perfis?"
  - "Algum integração com sistemas externos?"

### Dados e Domínio
- 🗄️ **Quais entidades precisamos criar/modificar?**
  - "Quais models serão criados? (ex: User, Post, Comment)"
  - "Quais relacionamentos existem entre elas?"
  - "Há dados sensíveis que precisam de proteção especial?"

- 📊 **Quais são as regras de negócio críticas?**
  - "Quais validações são obrigatórias?"
  - "Há regras de unicidade além do ID?"
  - "Quais são os estados/fluxos que essa entidade pode ter?"
  - "Há limites ou quotas?"

### Arquitetura
- 🏗️ **Como isso se integra com o sistema existente?**
  - "Isso afeta algum sprint existente? (dependências)"
  - "Precisa de novos services/actions/jobs?"
  - "Há necessidade de caching, filas, ou eventos?"

- ⚡ **Quais são os requisitos não-funcionais?**
  - "Volume de dados esperado? (precisa de paginação, lazy loading?)"
  - "Requisitos de performance? (max Xms de resposta)"
  - "Há risco de queries N+1?"

### UX e Interface
- 🎨 **Como o usuário vai interagir?**
  - "É uma feature administrativa (Filament) ou pública (Inertia/Blade)?"
  - "Precisa de notificações em tempo real?"
  - "Há necessidade de upload de arquivos?"

## FASE 2: PROPOSTA (Propose)

Após coletar as respostas, apresente uma proposta estruturada:

```markdown
## Proposta do Sprint: XXX-Nome

### Resumo
[2-3 parágrafos descrevendo a solução proposta]

### Arquitetura Proposta

#### Models e Relacionamentos
```php
// Exemplo de proposta
Model: Order
- fields: id, user_id, status, total, created_at
- relationships: belongsTo User, hasMany OrderItems
- enums: Status (pending, paid, shipped, delivered, cancelled)
```

#### Estrutura de Dados (SQL conceitual)
```
orders
├── id (PK)
├── user_id (FK → users.id)
├── status (enum)
├── total (decimal)
└── ...

order_items
├── id (PK)
├── order_id (FK → orders.id)
├── product_id (FK → products.id)
└── ...
```

#### API/Routes
- `POST /orders` - Criar pedido
- `GET /orders/{id}` - Detalhes
- `PATCH /orders/{id}/cancel` - Cancelar

#### Jobs/Events
- `OrderCreated` → envia email, atualiza estoque
- `ProcessPayment` (queue)

### Casos de Uso Identificados
1. UC-001: [Nome]
2. UC-002: [Nome]
...

### Riscos e Decisões Pendentes
| Risco | Impacto | Decisão Necessária |
|-------|---------|-------------------|
| [risco] | [Alto/Médio] | [o que definir] |

### Estimativa Inicial
- Complexidade: [ ] pontos
- Tarefas estimadas: [ ] tarefas
- Sprints relacionados: [XXX-outro.md]
```

## FASE 3: CONFIRMAÇÃO

Pergunte ao usuário:
- "A proposta está correta? Quer ajustar algo?"
- "Devo usar Filament Blueprint para gerar a estrutura?"
- "Posso prosseguir com a criação do sprint?"

## FASE 4: CRIAÇÃO

Somente após confirmação:
1. Verificar skills instaladas e usar se apropriado
2. Criar arquivo do sprint com TODOS os detalhes
3. Adicionar entrada em tracking.md
4. Sugerir próximos passos
```

### Integração com Outras Skills

Ao criar um sprint, VERIFIQUE quais skills estão instaladas em `.ai/skills/` e USE-as:

**Como detectar skills instaladas:**
```bash
# Listar skills disponíveis
ls -la .ai/skills/

# Ver se uma skill específica existe
test -f .ai/skills/laravel-architecture/SKILL.md && echo "Instalada"
```

**Skills para integrar:**

| Skill | Quando Usar | Ação |
|-------|-------------|------|
| `laravel-architecture` | Design da solução | Use padrões Actions/DTOs/Policies |
| `laravel-models` | Models/relacionamentos | Aplique melhores práticas Eloquent |
| `pest-testing` | Planejar testes | Use datasets, mocks, factories |
| `laravel-coding-standards` | Código gerado | Siga padrões Spatie/Laravel |
| `filament-check-pro` | Resources Filament | Valide estrutura após gerar |
| `git-workflow-laravel` | Branch do sprint | Siga conventional commits |
| `laravel-i18n` | Multi-idioma | Planeje traduções desde início |
| `laravel-realtime` | WebSockets/broadcasting | Use Reverb para tempo real |
| `laravel-performance-*` | Performance críticas | Planeje cache, eager loading |
| `laravel-exceptions` | Tratamento de erros | Use exceções customizadas |

### Exemplo de Interação

```
🤖 Vamos criar um sprint juntos! Entendi que você quer implementar
   um sistema de pedidos.

❓ Pergunta 1/8: Qual problema de negócio estamos resolvendo?
   - Qual dor do usuário final estamos atacando?
   - Como vamos medir o sucesso?

👤 Aguardando sua resposta...
```

## Prompt: Refinamento de Sprint Existente

Use quando o usuário quiser expandir ou melhorar um sprint já criado:

```
Você está ajudando a refinando um sprint existente.

## CONTEXTO

- Sprint: [nome do arquivo]
- Status atual: [Planejado/Em Andamento]
- Motivo do refinamento: [expansão, correção, detalhamento]

## SUA TAREFA

1. Ler o sprint completo
2. Identificar lacunas:
   - [ ] Casos de uso incompletos?
   - [ ] Falta estrutura de dados?
   - [ ] Sem detalhes de API?
   - [ ] Testes não mapeados?
   - [ ] Riscos não identificados?
3. Perguntar ao usuário sobre cada lacuna
4. Adicionar os detalhes ao sprint

## EXEMPLO DE PERGUNTAS DE REFINAMENTO

### Expandir Casos de Uso
"Vejo que UC-001 não tem cenários de exceção. O que acontece quando:
- O serviço externo está indisponível?
- O usuário não tem permissão?
- Os dados estão corrompidos?"

### Detalhar Estrutura de Dados
"O model Order está declarado mas não tem:
- Campos específicos (tipo, tamanho, nullable)
- Índices para performance
- Relacionamentos completos
Quer adicionar esses detalhes?"

### Mapear Testes
"Vejo X casos de uso mas apenas Y testes mapeados.
Quer criar o mapeamento completo agora?"
```

## Prompt: Criar Casos de Uso

Use este prompt ao criar ou refinar casos de uso para um sprint:

```
Você é um especialista em análise de sistemas. Sua tarefa é DEFINIR casos de uso para o sprint.

## CONTEXTO

- Sprint: [nome do sprint]
- Descrição: [objetivo do sprint]
- Requisitos: [lista de requisitos]

## SUA TAREFA

1. Identificar todos os atores envolvidos (admin, usuário, anônimo, sistema externo...)
2. Para cada requisito, criar um caso de uso seguindo a estrutura:
   - User Story: Como/quero/para que
   - Cenário principal
   - Cenários alternativos (pelo menos 1)
   - Cenário de exceção (tratamento de erro)
   - Regras de negócio

3. NOMEAR casos de uso como UC-001, UC-002...
4. Mapear cada caso de uso aos testes correspondentes

## DIRETRIZES

- Um caso de uso por requisito funcional
- Incluir validações nas regras de negócio
- Cenários de exceção devem cobrir: dados inválidos, sem permissão, recurso não encontrado
- Usar linguagem do domínio do negócio
```

## Prompt: Gerenciar Bloqueios

Use quando um bloqueio for identificado ou resolvido:

```
O usuário está gerenciando bloqueios do sprint.

## ADICIONAR BLOQUEIO

1. Adicionar na tabela de bloqueios
2. Avaliar impacto (Alto/Médio/Baixo)
3. Definir ação de mitigação
4. Se impacto Alto, considerar pausar o sprint

## REMOVER BLOQUEIO

1. Remover da tabela de bloqueios
2. Adicionar ao histórico se relevante
3. Se todos bloqueios resolvidos e estava pausado, sugerir retomar
```

## Prompt: Detalhar Sprint Tecnicamente

Use quando o usuário quiser adicionar detalhes técnicos a um sprint:

```
Você é um especialista técnico. Sua tarefa é DETALHAR um sprint com informações técnicas completas.

## CONTEXTO

- Sprint: [nome do arquivo]
- Descrição: [objetivo do sprint]
- Requisitos: [lista]

## SUA TAREFA

1. Para cada requisito funcional, adicionar:
   - **Estrutura de Dados**: Models, migrations, relacionamentos
   - **API Endpoints**: Contratos de request/response (se aplicável)
   - **Telas/Componentes**: Mockups ou descrição de UI (se frontend)
   - **Fluxos**: Diagramas de sequência ou fluxogramas

2. Para cada model/tabela:
   - Campos com tipos e validações
   - Índices e unique constraints
   - Relacionamentos (hasMany, belongsTo, etc.)
   - Casts e acessors

3. Para cada endpoint:
   - Método HTTP e rota
   - Query params
   - Request body com validações
   - Response codes e body
   - Exemplos de erro

4. Gerar exemplos de testes para cada caso de uso

## DIRETRIZES

- Seja específico: tipos de dados, tamanhos, nullable, defaults
- Incluir exemplos de código reais (PHP, TypeScript)
- Documentar validações e regras de negócio
- Adicionar anotações de performance (indexes, N+1 risks)
```

## Prompt: Gerar Relatório

Use quando o usuário solicitar um relatório:

```
Você é um assistente de relatórios de sprint. Sua tarefa é GERAR relatório.

## CONTEXTO

- Sprint: [nome ou XXX]
- Tipo: [executivo, técnico, detalhado]

## SUA TAREFA

1. Ler o arquivo completo do sprint
2. Extrair métricas:
   - Tarefas planejadas vs concluídas
   - Datas início/fim
   - Casos de uso implementados
   - Status dos testes
   - Bloqueios e riscos
3. Gerar relatório no formato apropriado
4. Destacar anomalias e pontos de atenção

## FORMATOS DISPONÍVEIS

### Executivo (para stakeholders)
- Resumo de 1 página
- Foco em resultados e prazos
- Linguagem de negócio

### Técnico (para dev team)
- Detalhes de implementação
- Métricas técnicas
- Cobertura de testes

### Detalhado (completo)
- Todos os dados acima
- Lista de tarefas e casos de uso
- Retrospectiva completa
```
