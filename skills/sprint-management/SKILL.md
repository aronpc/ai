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

## Blueprint para Sprints Complexos

Para sprints que usam Filament Blueprint:
1. Salvar plano detalhado em `storage/blueprint/plans/`
2. Criar sprint correspondente em `sprints/`
3. Referenciar plano no arquivo do sprint

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
