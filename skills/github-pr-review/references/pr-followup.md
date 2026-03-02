# PR Follow-up Process

Processo para revisão de follow-up em PRs.

---

## Quando usar Follow-up

- Após mudanças serem feitas em resposta a review
- Para verificar se issues foram resolvidos
- Para validar novos commits
- Para re-analisar após conflitos resolvidos

---

## Follow-up Workflow

### 1. Load Previous Review Context

```bash
# Get previous review comments
gh pr view [PR_NUMBER] --comments

# Get diff since last review
gh pr diff [PR_NUMBER] | git diff HEAD~1
```

### 2. Analyze Changes Since Last Review

| Tipo de Mudança | Ação |
|-----------------|------|
| Fix para issue reportado | Verificar se resolveu |
| Novo código | Analisar normalmente |
| Refactor | Verificar se manteve behavior |
| Merge conflict resolution | Verificar se correto |

### 3. Issue Resolution Check

Para cada issue do review anterior:

```markdown
### Issue #1: [Título]
- **Status**: Resolved / Partially Resolved / Not Resolved / New Issue
- **Verification**: [Como foi verificado]
- **Notes**: [Observações]
```

### 4. New Code Analysis

Se houver commits novos:
- Aplicar análise completa no novo código
- Não re-analisar código já aprovado (a menos que mudou)

---

## Follow-up Report Format

```markdown
## Follow-up Review #[N]

### Issues from Previous Review

| Issue | Status | Notes |
|-------|--------|-------|
| #1 Security: SQL injection | ✅ Resolved | Parameterized query used |
| #2 Quality: Long function | ⚠️ Partial | Reduced but still > 50 lines |
| #3 Logic: Missing null check | ❌ Not resolved | Still missing |

### New Findings

[List any new issues found in the new commits]

### Updated Verdict

**Previous:** needs_changes
**Current:** [approved | needs_changes | rejected]

**Rationale:** [Why the verdict changed or stayed the same]

### Remaining Action Items

- [ ] Item 1
- [ ] Item 2
```

---

## Resolution Verification

### Como verificar se um issue foi resolvido:

**Para Security Issues:**
```bash
# 1. Read the fixed code
cat path/to/file.ts

# 2. Verify the fix addresses the vulnerability
# 3. Check for any new vulnerabilities introduced
```

**Para Quality Issues:**
```bash
# 1. Check if refactoring was done
# 2. Verify function/class size reduced
# 3. Run linter if applicable
npm run lint
```

**Para Logic Issues:**
```bash
# 1. Trace the logic path
# 2. Check edge cases
# 3. Verify tests added/updated
npm test
```

---

## Multi-round Follow-ups

Para PRs com múltiplos rounds de review:

```markdown
## Review History

| Round | Verdict | Critical Issues | High Issues | Notes |
|-------|---------|-----------------|-------------|-------|
| 1 | needs_changes | 2 | 3 | Security issues found |
| 2 | needs_changes | 0 | 1 | Security fixed, logic issue |
| 3 | approved | 0 | 0 | All issues resolved |
```

---

## Escalation

### Quando escalar:

- 3+ rounds sem resolução
- Disagreement on approach
- Fundamental architecture concerns
- Security vulnerability not being addressed

### Escalation format:

```markdown
## ⚠️ Escalation Needed

**Reason:** [Why escalation is needed]

**Issues blocking resolution:**
1. Issue description
2. Issue description

**Recommended action:** [What should happen next]
```
