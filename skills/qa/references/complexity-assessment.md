# Complexity Assessment Reference

Critérios para avaliação de complexidade e risco.

---

## Tiers de Complexidade

| Tier | Nome | Critérios | Esforço QA |
|------|------|-----------|------------|
| 0 | Trivial | Single file, < 10 linhas | 5-15 min |
| 1 | Low | 1-2 files, lógica simples | 15-30 min |
| 2 | Medium | 3-5 files, mudanças moderadas | 30-60 min |
| 3 | High | 5+ files, mudanças complexas | 1-2 hours |
| 4 | Critical | Arquitetura, security, data migration | 2-4 hours |

---

## Fatores de Complexidade

| Fator | Peso | Condição |
|-------|------|----------|
| Files changed | +1 | Por arquivo modificado |
| New dependencies | +2 | Nova dependência adicionada |
| Database changes | +3 | Schema ou migration |
| API changes | +2 | Novo endpoint ou mudança de contrato |
| Auth changes | +3 | Mudança em autenticação/autorização |
| Breaking changes | +4 | Mudança que quebra compatibilidade |
| Third-party integration | +3 | Integração externa |
| Security sensitive | +3 | Dados sensíveis ou segurança |

---

## Cálculo de Tier

```
Score = Sum of all factors

Tier 0: Score 0-2
Tier 1: Score 3-5
Tier 2: Score 6-10
Tier 3: Score 11-15
Tier 4: Score 16+
```

---

## Risk Multipliers

| Multiplicador | Condição | Ajuste |
|---------------|----------|--------|
| Late Friday | Deploy próximo ao fim de semana | +1 Tier |
| No tests | Code sem testes | +1 Tier |
| Junior dev | Desenvolvedor júnior | +1 Tier |
| New codebase | Não conhece o código | +1 Tier |
| Time pressure | Deadline apertado | +1 Tier |

---

## Quick Assessment

```markdown
- [ ] Arquivos modificados: ___
- [ ] Mudanças em database: Y/N
- [ ] Mudanças em API: Y/N
- [ ] Mudanças em auth: Y/N
- [ ] Novas dependências: Y/N
- [ ] Breaking changes: Y/N
- [ ] Integração terceiros: Y/N
- [ ] Security-sensitive: Y/N

**Score:** ___
**Tier:** ___
**Tempo QA:** ___
```
