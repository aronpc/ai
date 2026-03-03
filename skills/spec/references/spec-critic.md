# Spec Critic Reference

Guia para revisão e crítica de especificações.

---

## Objetivo

Garantir que a especificação é completa, clara e implementável antes do desenvolvimento começar.

---

## Checklist de Revisão

### 1. Clareza do Problema

- [ ] O problema está claramente definido?
- [ ] O contexto está bem estabelecido?
- [ ] Os stakeholders estão identificados?
- [ ] O valor de negócio é claro?

**Red Flags:**
- "Precisamos de X" sem explicar por quê
- Problema genérico demais
- Sem contexto de quem é afetado

### 2. Goals e Non-Goals

- [ ] Goals são específicos e mensuráveis?
- [ ] Non-goals estão explícitos?
- [ ] Scope está bem definido?
- [ ] Não há feature creep?

**Red Flags:**
- Goals vagos ("melhorar UX")
- Non-goals ausentes
- Scope ilimitado

### 3. Design Técnico

- [ ] Arquitetura está clara?
- [ ] Data model está completo?
- [ ] APIs estão especificadas?
- [ ] UI/UX está documentada?
- [ ] Edge cases considerados?

**Red Flags:**
- Diagramas faltando
- API contracts vagos
- Sem tratamento de erros

### 4. Segurança

- [ ] Autenticação/autorização especificada?
- [ ] Dados sensíveis identificados?
- [ ] Input validation planejada?
- [ ] Rate limiting considerado?

**Red Flags:**
- Sem menção a auth
- Dados sensíveis sem proteção
- Sem validação de input

### 5. Performance

- [ ] Requisitos de performance definidos?
- [ ] Escalabilidade considerada?
- [ ] Caching strategy definida?
- [ ] Database optimization planejada?

**Red Flags:**
- "Deve ser rápido"
- Sem métricas específicas
- Sem consideração de escala

### 6. Testes

- [ ] Estratégia de testes definida?
- [ ] Critérios de aceitação claros?
- [ ] Edge cases cobertos?
- [ ] Teste de carga considerado?

**Red Flags:**
- "Precisa de testes"
- Sem critérios específicos
- Edge cases ignorados

### 7. Riscos

- [ ] Riscos identificados?
- [ ] Mitigações propostas?
- [ ] Dependências mapeadas?
- [ ] Plano B existe?

**Red Flags:**
- Sem seção de riscos
- "Não há riscos"
- Dependências não mapeadas

### 8. Implementabilidade

- [ ] Plano de implementação realista?
- [ ] Estimativas críveis?
- [ ] Skills disponíveis?
- [ ] Infraestrutura pronta?

**Red Flags:**
- Timeline agressiva
- Skills não disponíveis
- Infra não existe

---

## Critique Format

### Summary
```markdown
## Spec Critique: [Feature Name]

**Overall Quality:** Excellent | Good | Needs Work | Poor
**Ready for Implementation:** Yes | No | With Changes

### Executive Summary
[2-3 sentences on overall assessment]
```

### Issues by Severity

```markdown
## Critical Issues (Must Fix)

### 1. [Issue Title]
**Section:** [Which section]
**Problem:** [What's wrong]
**Impact:** [Why it matters]
**Suggestion:** [How to fix]
```

```markdown
## Major Issues (Should Fix)

### 1. [Issue Title]
**Section:** [Which section]
**Problem:** [What's wrong]
**Suggestion:** [How to fix]
```

```markdown
## Minor Issues (Nice to Fix)

### 1. [Issue Title]
**Section:** [Which section]
**Problem:** [What's wrong]
**Suggestion:** [How to fix]
```

### Recommendations

```markdown
## Recommendations

1. [Recommendation 1]
2. [Recommendation 2]
3. [Recommendation 3]
```

### Questions

```markdown
## Questions for Clarification

1. [Question 1]
2. [Question 2]
```

---

## Common Issues

### Problem Statement Issues

| Issue | Example | Fix |
|-------|---------|-----|
| Too vague | "Need better UX" | "Users can't find the checkout button, causing 30% cart abandonment" |
| No context | "Add feature X" | Explain who needs it and why |
| Solution-first | "We need a dashboard" | Start with the problem, not the solution |

### Technical Design Issues

| Issue | Detection | Fix |
|-------|-----------|-----|
| Missing API spec | No request/response examples | Add OpenAPI-style specs |
| No error handling | Only happy path | Add error states and handling |
| No migration plan | DB changes without migration | Add migration strategy |
| Missing auth | No auth mentioned | Add auth requirements |

### Scope Issues

| Issue | Detection | Fix |
|-------|-----------|-----|
| Feature creep | Goals keep expanding | Move to "Future Phases" |
| Unclear boundaries | "And also..." | Define explicit non-goals |
| Gold plating | Nice-to-haves mixed with must-haves | Use MoSCoW prioritization |

---

## Output JSON

```json
{
  "spec_id": "spec-001",
  "reviewer": "@reviewer",
  "reviewed_at": "2024-01-15T10:00:00Z",
  "overall_quality": "good",
  "ready_for_implementation": false,
  "issues": [
    {
      "id": "ISSUE-1",
      "section": "Technical Design",
      "severity": "critical",
      "title": "Missing authentication specification",
      "description": "No authentication method specified for API endpoints",
      "suggestion": "Add JWT authentication with refresh token rotation",
      "blocking": true
    }
  ],
  "recommendations": [
    "Consider adding rate limiting to public endpoints",
    "Document retry strategy for failed requests"
  ],
  "questions": [
    "Should we support both web and mobile clients from day 1?"
  ],
  "approved_sections": ["Problem Statement", "Goals"],
  "needs_revision_sections": ["Technical Design", "Security"]
}
```
