# Workflow Patterns

Esta referência detalha os padrões de workflow para cada tipo de implementação.

---

## Feature Workflow

Para novas funcionalidades que adicionam valor ao produto.

### Estrutura de Fases

```
Phase 0: Pre-Planning
├── Load spec and requirements
├── Review existing code
└── Identify dependencies

Phase 1: Analysis
├── Map affected files
├── Identify patterns to follow
└── Check similar implementations

Phase 2: Design
├── Design API contract
├── Design component structure
└── Plan data flow

Phase 3: Implementation
├── Backend (if applicable)
│   ├── Models/Schema
│   ├── Business logic
│   └── API endpoints
├── Frontend (if applicable)
│   ├── State management
│   ├── Components
│   └── Integration
└── Tests
    ├── Unit tests
    └── Integration tests

Phase 4: Testing
├── Run all tests
├── Manual testing
└── Edge cases

Phase 5: Review
├── Self-review
├── Code review
└── Address feedback

Phase 6: Integration
├── Merge
├── Deploy to staging
└── Smoke test

Phase 7: Verification
├── E2E tests
├── User acceptance
└── Monitor metrics
```

### Checklist Feature

- [ ] Requisitos claros e completos
- [ ] Design revisado
- [ ] Backend implementado (se aplicável)
- [ ] Frontend implementado (se aplicável)
- [ ] Testes unitários
- [ ] Testes de integração
- [ ] Documentação atualizada
- [ ] Code review aprovado

---

## Refactor Workflow

Para melhorias de código sem mudança de comportamento externo.

### Estrutura de Fases

```
Phase 0: Pre-Planning
├── Define scope of refactor
├── Ensure test coverage
└── Create baseline metrics

Phase 1: Analysis
├── Map current implementation
├── Identify all usages
└── Note edge cases

Phase 2: Design
├── Plan target structure
├── Identify extraction points
└── Plan incremental steps

Phase 3: Implementation
├── Make small, focused changes
├── Run tests after each change
└── Update imports/usages

Phase 4: Testing
├── All existing tests pass
├── Behavior unchanged
└── Performance same or better

Phase 5: Cleanup
├── Remove dead code
├── Update documentation
└── Fix lint warnings
```

### Checklist Refactor

- [ ] Testes existentes passando antes
- [ ] Mudanças incrementais
- [ ] Testes rodados após cada mudança
- [ ] Comportamento inalterado
- [ ] Code review focado em correctness
- [ ] Documentação atualizada

### Red Flags

- Mudanças que quebram testes
- Mudanças de comportamento "acidentais"
- Scope creep (aumentar escopo do refactor)

---

## Investigation Workflow

Para bugs, performance issues, ou comportamentos inesperados.

### Estrutura de Fases

```
Phase 0: Problem Definition
├── Describe the problem clearly
├── Gather evidence (logs, screenshots)
├── Identify impact and urgency
└── Reproduce the issue

Phase 1: Evidence Collection
├── Check logs
├── Check metrics/traces
├── Check recent changes
└── Interview users (if applicable)

Phase 2: Hypothesis Formation
├── List possible causes
├── Rank by likelihood
└── Design tests for each

Phase 3: Hypothesis Testing
├── Test most likely first
├── Document results
└── Narrow down cause

Phase 4: Root Cause
├── Confirm root cause
├── Document findings
└── Determine fix approach

Phase 5: Fix
├── Implement fix
├── Add regression test
└── Verify fix works

Phase 6: Prevention
├── Add monitoring
├── Update documentation
└── Post-mortem (if severe)
```

### Checklist Investigation

- [ ] Problema claramente definido
- [ ] Evidências coletadas
- [ ] Hipóteses testadas sistematicamente
- [ ] Causa raiz identificada
- [ ] Fix implementado
- [ ] Teste de regressão adicionado

---

## Migration Workflow

Para migrações de dados, infraestrutura, ou frameworks.

### Estrutura de Fases

```
Phase 0: Planning
├── Map current state
├── Define target state
├── Identify risks
└── Create rollback plan

Phase 1: Preparation
├── Create migration scripts
├── Test on staging/clone
├── Prepare rollback scripts
└── Communicate stakeholders

Phase 2: Backup
├── Backup data
├── Verify backup integrity
└── Document restore procedure

Phase 3: Migration
├── Execute migration
├── Monitor progress
└── Log all actions

Phase 4: Validation
├── Verify data integrity
├── Run smoke tests
└── Check metrics

Phase 5: Cleanup
├── Remove old code/data
├── Update documentation
└── Communicate completion
```

### Checklist Migration

- [ ] Plano de rollback testado
- [ ] Backup feito e verificado
- [ ] Migração testada em staging
- [ ] Scripts de validação prontos
- [ ] Stakeholders comunicados
- [ ] Monitoramento ativo

---

## Simple Workflow

Para tarefas triviais e diretas.

### Estrutura Simplificada

```
1. Understand
   ├── Read task
   └── Clarify if needed

2. Implement
   ├── Make change
   └── Quick test

3. Commit
   ├── Self-review
   └── Commit with clear message
```

### Quando usar Simple

- Typo fixes
- Config updates
- Comment changes
- Single file changes
- Obvious bug fixes

### Quando NÃO usar Simple

- Multiple files
- API changes
- Database changes
- Breaking changes
- Unclear requirements
