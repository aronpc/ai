# Research Agent Reference

Guia para pesquisa de soluções e integrações.

---

## Objetivo

Pesquisar tecnologias, APIs e padrões necessários para implementar a feature.

---

## Áreas de Pesquisa

### 1. Integrações Externas

**APIs:**
- Autenticação necessária?
- Rate limits?
- SLA/disponibilidade?
- Custo?

**Bibliotecas:**
- Popularidade e manutenção?
- Licença compatível?
- Bundle size?
- Alternativas?

### 2. Padrões Internos

**Verificar:**
- Similar features existentes
- Shared components
- Common patterns
- Internal libraries

### 3. Best Practices

**Fontes:**
- Documentação oficial
- Blog posts técnicos
- Stack Overflow
- GitHub discussions

---

## Processo de Pesquisa

### Step 1: Identificar Necessidades

```markdown
## Integrações Necessárias

- [ ] Autenticação OAuth
- [ ] Storage de arquivos
- [ ] Email service
- [ ] Payment processing
- [ ] Analytics
```

### Step 2: Pesquisar Cada Integração

Para cada necessidade:

```json
{
  "name": "OAuth Provider",
  "type": "API",
  "purpose": "Social login",
  "providers": [
    {
      "name": "Auth0",
      "pros": ["Full-featured", "Good docs"],
      "cons": ["Cost", "Vendor lock-in"],
      "url": "https://auth0.com"
    },
    {
      "name": "NextAuth",
      "pros": ["Free", "Flexible"],
      "cons": ["Self-managed"],
      "url": "https://next-auth.js.org"
    }
  ],
  "recommendation": "NextAuth - cost-effective and flexible",
  "implementation_notes": "Use JWT strategy"
}
```

### Step 3: Documentar Findings

```markdown
## Research Summary

### Authentication
**Decision:** NextAuth with JWT strategy
**Rationale:** Cost-effective, flexible, good TypeScript support
**Implementation:** Follow existing pattern in src/auth/

### File Storage
**Decision:** S3 with presigned URLs
**Rationale:** Scalable, secure, existing infrastructure
**Implementation:** Use existing @/lib/storage utility

### Email
**Decision:** Resend
**Rationale:** Modern API, good deliverability, free tier
**Implementation:** New integration needed
```

---

## Output Format

```json
{
  "integrations_needed": [
    {
      "name": "Integration Name",
      "type": "API|Library|Service",
      "purpose": "Why needed",
      "documentation_url": "https://...",
      "api_reference": "https://...",
      "authentication": "OAuth2|API Key|None",
      "rate_limits": "1000 req/min",
      "cost": "Free tier available",
      "implementation_notes": "Important notes",
      "code_examples": [
        {
          "language": "typescript",
          "code": "// Example code"
        }
      ]
    }
  ],
  "internal_patterns": [
    {
      "feature": "Similar feature",
      "location": "src/features/similar/",
      "pattern": "Pattern to follow",
      "reusable_components": ["Component1", "Component2"]
    }
  ],
  "alternatives_considered": [
    {
      "name": "Alternative Name",
      "category": "API|Library|Service",
      "pros": ["Pro 1", "Pro 2"],
      "cons": ["Con 1", "Con 2"],
      "decision": "chosen|rejected|backup",
      "reason": "Why this decision"
    }
  ],
  "technical_notes": "Important technical details and gotchas",
  "open_questions": [
    {
      "question": "Question about integration",
      "impact": "Affects implementation",
      "owner": "@someone"
    }
  ]
}
```

---

## Research Checklist

### Para APIs
- [ ] Documentação lida
- [ ] Authentication method identificado
- [ ] Rate limits entendidos
- [ ] Error handling documentado
- [ ] Sandbox/test environment identificado
- [ ] SDK disponibilidade verificada

### Para Bibliotecas
- [ ] GitHub stars e activity
- [ ] Último release date
- [ ] Open issues relevantes
- [ ] Bundle size (frontend)
- [ ] TypeScript support
- [ ] Licença verificada

### Para Patterns
- [ ] Código existente revisado
- [ ] Componentes reutilizáveis identificados
- [ ] Dono do código consultado
- [ ] Testes existentes entendidos

---

## Web Search Queries

### Para APIs
```
"[API name] documentation"
"[API name] rate limits"
"[API name] authentication"
"[API name] SDK [language]"
"[API name] vs [alternative]"
```

### Para Libraries
```
"[library name] vs [alternative]"
"[library name] best practices"
"[library name] TypeScript"
"[library name] tutorial 2024"
```

### Para Patterns
```
"[pattern name] best practices"
"[feature] implementation patterns"
"[technology] architecture patterns"
```
