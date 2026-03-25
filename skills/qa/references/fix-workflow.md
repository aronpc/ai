# Fix Workflow Reference

Processo de correção durante QA.

---

## Issue Classification

| Severity | Definição |
|----------|-----------|
| Blocker | Não pode deployar |
| Critical | Funcionalidade quebrada |
| Major | Funciona mas problemático |
| Minor | Cosmético |

---

## Fix Process

1. Document Issue
   - Descrição clara
   - Passos para reproduzir
   - Expected vs Actual
   - Severity

2. Report estruturado

3. Fix (se aplicável)
   - Implementar
   - Re-test
   - Verify no regressions

---

## Regression Testing

After Fix:
- Re-test the fix
- Test related areas
- Run automated tests

Checklist:
- [ ] Original issue fixed
- [ ] Edge cases work
- [ ] Related features work
- [ ] Automated tests pass
- [ ] No new errors
