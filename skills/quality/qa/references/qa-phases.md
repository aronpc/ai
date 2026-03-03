# QA Phases Reference

Detalhamento de todas as fases do processo de QA (0-10).

---

## Phase 0: Load Context
Entender o que foi implementado.
- Ler spec/task
- Ler implementation plan
- Ver diff do código

## Phase 1: Complexity Assessment
Avaliar risco e determinar estratégia.
- Calcular complexity score
- Determinar tier
- Definir test requirements

## Phase 2: Test Planning
Planejar estratégia de testes.
- Identificar cenários
- Priorizar por risco
- Preparar dados de teste

## Phase 3: Smoke Test
Verificar que o básico funciona.
- [ ] Aplicação inicia
- [ ] Página carrega
- [ ] Login funciona
- [ ] API responde
- [ ] Sem erros console

## Phase 4: Functional Testing
Testar funcionalidade principal.
- Happy path
- Inputs válidos
- Outputs corretos
- UI correta

## Phase 5: Edge Cases
Testar casos extremos.
- Empty/null values
- Max length
- Invalid input
- Boundary values

## Phase 6: Integration Testing
Verificar integrações.
- API endpoints
- Database operations
- Third-party services

## Phase 7: Performance Check
Verificar performance.
- Response times
- N+1 queries
- Bundle size

## Phase 8: Security Scan
Verificações básicas.
- Input validation
- Auth checks
- No secrets hardcoded

## Phase 9: Regression Check
Nada quebrou.
- Testes automatizados
- Features relacionadas

## Phase 10: Final Validation
Confirmação final.
- Todas phases completadas
- Issues críticos resolvidos
- Pronto para deploy
