---
name: documentation-updates
description: Atualização de documentação (IMPLEMENTATION.md, CHECKPOINT.md, README.md)
license: MIT
compatibility: Requer PHP 8.2+, Laravel 11+
metadata:
  author: aronpc
  version: 1.0.0
  category: development
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
---

# Documentation Updates

## Quando usar esta skill

Use esta skill sempre que:
- Implementar qualquer feature/tarefa
- Completar marcos principais
- Atualizar progresso do projeto
- Preparar para versão/releases

## CRÍTICO: Atualizações de Documentação

**OBRIGATÓRIO:** Após implementar QUALQUER feature, atualize docs nesta ordem:

### 1. IMPLEMENTATION.md (SEMPRE)

**Quando:** Após completar QUALQUER tarefa, feature ou sub-feature

**O que:**

- Marque itens completados: `[ ]` → `[x]`
- Atualize percentagem de progresso
- Atualize campo "Status" em seções
- Atualize tabela "Progresso Geral"
- Atualize linha "Total:" de progresso
- Atualize "Próximos Passos"

**Exemplo:**

```markdown
### 6.4 Staff Management ✅

- [x] Backend completo ✅
    - `StaffController` com CRUD completo (index, create, store, edit, update, destroy)

**Status:** Staff Management 100% completo - Backend, Forms, todas as páginas implementados.
```

### 2. CHECKPOINT.md (Marcos Principais Apenas)

**Quando:** Após feature principal, marco de versão, ou fim de sessão de trabalho

**O que:**

- **Última Atualização:** Data/hora atual
- **Versão Atual:** Bump version (v1.8.0 → v1.9.0)
- **Progresso Total:** Atualize percentagem
- **Onde Paramos:** Atualize seção "✅ Completo"
- **Próximos Passos:** Atualize o que vem a seguir
- **Métricas do Projeto:** Atualize contadores

### 3. README.md (Apenas Quando Necessário)

**Quando:** APENAS para mudanças significativas em:

- Visão geral do projeto
- Passos de instalação
- Features principais que mudam proposta de valor
- Mudanças no tech stack
- Novos comandos/padrões de uso

### Workflow de Documentação

```bash
# Após implementar uma feature:

# 1. SEMPRE atualize IMPLEMENTATION.md
# Marque tarefas completadas, atualize percentagens

# 2. Se marco principal, atualize CHECKPOINT.md
# Atualize versão, progresso, métricas

# 3. Se mudança significativa, atualize README.md (opcional)
# Apenas se visão geral do projeto mudou

# 4. Commit documentação separadamente
git add IMPLEMENTATION.md CHECKPOINT.md
git commit -m "docs: Update implementation progress to v1.9.0 (58.5%)"
```

## Regras de Resumo

| Arquivo | Quando | Frequência |
|---------|---------|------------|
| **IMPLEMENTATION.md** | Após cada feature/tarefa | ✅ SEMPRE |
| **CHECKPOINT.md** | Após features principais ou sessões | ⚠️ FREQUENTEMENTE |
| **README.md** | Apenas mudanças de visão geral | ℹ️ RARAMENTE |

## O Que NÃO Fazer

- ❌ Pular atualização de IMPLEMENTATION.md
- ❌ Atualizar README.md para cada pequena mudança
- ❌ Esquecer de atualizar percentagens e campos de status
- ❌ Commitar código e documentação juntos
- ❌ Deixar CHECKPOINT.md desatualizado após marco principal

## Formato de IMPLEMENTATION.md

### Estrutura de Seção

```markdown
### X.X Nome da Feature 🚧

**Descrição:** Breve descrição da feature

**Status:** Em andamento | Planejado | Concluído ✅

- [ ] Subtarefa 1
- [ ] Subtarefa 2
- [ ] Subtarefa 3

**Progresso:** XX%

**Próximos Passos:**
- [ ] Próximo passo 1
- [ ] Próximo passo 2
```

## Formato de CHECKPOINT.md

```markdown
# Checkpoint - v1.X.0

**Última Atualização:** AAAA-MM-DD HH:MM

**Versão Atual:** v1.X.0

**Progresso Total:** XX%

---

## ✅ Completo

### Features Implementadas

- Feature 1
- Feature 2

### Métricas do Projeto

- Total de Features: XX
- Features Concluídas: XX
- Progresso: XX%

---

## Próximos Passos

- [ ] Próxima feature 1
- [ ] Próxima feature 2
```

## Comandos Úteis

```bash
# Commitar apenas documentação
git add IMPLEMENTATION.md CHECKPOINT.md
git commit -m "docs: Update implementation progress"

# Ver mudanças desde último commit
git diff HEAD~1 IMPLEMENTATION.md
```

## Exemplos de Commits de Documentação

```bash
# ✅ GOOD - Atualização de progresso
git commit -m "docs: Update implementation progress - Staff Management complete (100%)"

# ✅ GOOD - Marco de versão
git commit -m "docs: Update checkpoint to v1.9.0 - 58.5% complete"

# ✅ GOOD - Mudança significativa
git commit -m "docs: Update README - Add Laravel Boost integration section"
```

## Melhores Práticas

### ✅ FAÇA

- Sempre atualize IMPLEMENTATION.md após cada tarefa
- Use marcadores claros de status (🚧, ✅, ❌)
- Mantenha percentagens atualizadas
- Atualize CHECKPOINT.md após marcos principais
- Commit documentação separadamente do código
- Use mensagens descritivas em commits

### ❌ NÃO FAÇA

- Não pule atualização de IMPLEMENTATION.md
- Não atualize README.md para cada pequena mudança
- Não esqueça de atualizar campos de status
- Não misture código e documentação no mesmo commit
- Não use mensagens vagas de commit

## Checklist de Documentação

Antes de finalizar qualquer feature:

- [ ] IMPLEMENTATION.md atualizado
- [ ] Tarefas marcadas como completas
- [ ] Percentagem de progresso atualizada
- [ ] Status atualizado
- [ ] Próximos passos definidos
- [ ] CHECKPOINT.md atualizado (se aplicável)
- [ ] README.md atualizado (se necessário)
- [ ] Documentação commitada separadamente

## Workflow Git

**Integração com git-workflow-laravel:**

Documentação deve ser commitada separadamente do código, seguindo Conventional Commits:

```bash
# Workflow completo após implementar feature:
# 1. Commit de código
git add app/ resources/
git commit -m "feat: Add Staff Management CRUD"

# 2. Commit de documentação
git add IMPLEMENTATION.md CHECKPOINT.md
git commit -m "docs: Update implementation progress - Staff Management complete"
```

Veja `git-workflow-laravel` para:
- Formato de mensagens Conventional Commits
- Regras de commits atômicos
- Commits de documentação com prefixo `docs:`
- Tracking de features em sprints (veja `sprint-management`)

## Referências

- [Laravel Documentation](https://laravel.com/docs) - Documentação oficial
