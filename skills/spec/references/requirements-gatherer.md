# Requirements Gatherer Reference

Guia detalhado para coleta de requisitos.

---

## Processo de Coleta

### 1. Entender o Contexto

**Perguntas chave:**
- Qual é o problema?
- Quem é afetado?
- Qual é o impacto?
- Por que agora?

**Fontes de informação:**
- Issue/ticket description
- Stakeholder interviews
- User feedback
- Analytics data
- Competitive analysis

### 2. Identificar Stakeholders

| Stakeholder | Interesse | Como consultá-lo |
|-------------|-----------|------------------|
| Product Owner | Business value | Priorização, scope |
| Users | Needs, pain points | Interviews, surveys |
| Developers | Technical feasibility | Technical review |
| QA | Quality requirements | Test planning |
| Operations | Deployment, monitoring | Infrastructure needs |

### 3. Coletar Requisitos Funcionais

**Template:**
```
FR-[N]: [User type] deve poder [action] para [goal]

Exemplos:
FR-1: Usuário deve poder fazer login com email e senha
FR-2: Admin deve poder gerenciar permissões de usuários
FR-3: Sistema deve enviar email de confirmação após registro
```

**Priorização MoSCoW:**
| Prioridade | Definição |
|------------|-----------|
| Must | Crítico, sem isso não entrega valor |
| Should | Importante, mas pode esperar |
| Could | Nice to have, se tiver tempo |
| Won't | Não será feito nesta iteração |

### 4. Coletar Requisitos Não-Funcionais

**Categorias:**

| Categoria | Pergunta | Métrica |
|-----------|----------|---------|
| Performance | Qual o tempo de resposta aceitável? | < 200ms |
| Escalabilidade | Quantos usuários simultâneos? | 10K concurrent |
| Disponibilidade | Qual o uptime esperado? | 99.9% |
| Segurança | Que dados são sensíveis? | PII, payment |
| Usabilidade | Qual a curva de aprendizado? | < 5 min onboarding |
| Compatibilidade | Quais plataformas suportar? | Chrome, Firefox, Safari |

**Template:**
```
NFR-[N]: [Category] - [Requirement]

Exemplos:
NFR-1: Performance - API response < 200ms p95
NFR-2: Security - All PII encrypted at rest
NFR-3: Availability - 99.9% uptime SLA
```

### 5. Identificar Restrições

**Tipos de restrições:**
- **Time**: Deadline, milestones
- **Budget**: Cost limits, licensing
- **Technical**: Stack, infrastructure
- **Regulatory**: Compliance requirements
- **Resource**: Team size, skills

### 6. Definir Critérios de Aceitação

**Template Given-When-Then:**
```
AC-[N]: Given [context], when [action], then [outcome]

Exemplos:
AC-1: Given user is logged in, when they click logout, then session is terminated
AC-2: Given cart has items, when user applies coupon, then discount is applied
```

---

## Output Format

```json
{
  "title": "Feature Title",
  "description": "Brief description",
  "problem_statement": "What problem does this solve",
  "stakeholders": [
    {"role": "Product Owner", "contact": "@name", "interest": "Business value"}
  ],
  "functional_requirements": [
    {
      "id": "FR-1",
      "description": "User must be able to login",
      "priority": "must",
      "acceptance_criteria": ["AC-1", "AC-2"]
    }
  ],
  "non_functional_requirements": [
    {
      "id": "NFR-1",
      "type": "performance",
      "description": "API response < 200ms p95",
      "metric": "p95 latency < 200ms"
    }
  ],
  "constraints": [
    {"type": "time", "description": "Must ship by Q2"},
    {"type": "technical", "description": "Must use existing auth system"}
  ],
  "acceptance_criteria": [
    {
      "id": "AC-1",
      "description": "Given X, when Y, then Z",
      "related_requirements": ["FR-1"]
    }
  ],
  "open_questions": [
    {
      "question": "Should we support social login?",
      "impact": "Affects FR-1, FR-2",
      "owner": "@product-owner"
    }
  ],
  "assumptions": [
    "Users have valid email addresses"
  ],
  "out_of_scope": [
    "Two-factor authentication (future phase)"
  ]
}
```

---

## Interview Questions

### Para Product Owners
1. Qual o valor de negócio desta feature?
2. Como medir sucesso?
3. Qual o timeline esperado?
4. Há dependências de outras features?
5. O que acontece se não fizermos?

### Para Usuários
1. Qual o problema atual?
2. Como você resolve hoje?
3. O que seria a solução ideal?
4. Quais frustrações você tem?
5. O que você mais precisa?

### Para Desenvolvedores
1. Há padrões existentes para seguir?
2. Que APIs/serviços precisamos integrar?
3. Há preocupações técnicas?
4. Qual o esforço estimado?
5. Há riscos técnicos?

---

## Common Pitfalls

### Evitar
- Requisitos vagos ("o sistema deve ser rápido")
- Scope creep (adicionar requisitos durante dev)
- Assumir em vez de perguntar
- Ignorar edge cases
- Esquecer requisitos não-funcionais

### Fazer
- Requisitos específicos e mensuráveis
- Validar com stakeholders
- Documentar assumptions
- Identificar dependências
- Priorizar explicitamente
