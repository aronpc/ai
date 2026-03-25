# Verification Types

Esta referência descreve os tipos de verificação disponíveis para validar implementações.

---

## 1. Command Verification

Verifica executando um comando e analisando o output.

**Quando usar:**
- Testes unitários e de integração
- Build verification
- Lint checks
- Type checking

**Configuração:**
```json
{
  "type": "command",
  "command": "npm test",
  "expected_output": "all tests passed",
  "timeout_ms": 60000
}
```

**Exemplos:**
| Linguagem | Comando |
|-----------|---------|
| Node.js | `npm test` |
| Python | `pytest` |
| PHP | `php artisan test` |
| Go | `go test ./...` |
| Rust | `cargo test` |

**Verificação de sucesso:**
- Exit code 0
- Output contém "passed" ou "ok"
- Sem erros no stderr

---

## 2. API Verification

Verifica endpoints REST ou GraphQL.

**Quando usar:**
- Novos endpoints
- Mudanças em contratos de API
- Integrações backend

**Configuração:**
```json
{
  "type": "api",
  "base_url": "http://localhost:3000",
  "endpoints": [
    {
      "method": "GET",
      "path": "/api/health",
      "expected_status": 200
    },
    {
      "method": "POST",
      "path": "/api/users",
      "body": {"name": "test"},
      "expected_status": 201
    }
  ]
}
```

**Verificação de sucesso:**
- Status code esperado retornado
- Response body tem estrutura esperada
- Headers corretos

---

## 3. Browser Verification

Verifica UI usando browser automation (Puppeteer/Playwright).

**Quando usar:**
- Mudanças de UI
- Fluxos de usuário
- Visual regression

**Configuração:**
```json
{
  "type": "browser",
  "base_url": "http://localhost:3000",
  "steps": [
    {"action": "navigate", "url": "/login"},
    {"action": "fill", "selector": "#email", "value": "test@example.com"},
    {"action": "click", "selector": "button[type=submit]"},
    {"action": "waitFor", "selector": ".dashboard"}
  ],
  "screenshot": true
}
```

**Verificação de sucesso:**
- Todos os steps completados
- Elementos esperados presentes
- Sem erros de console

---

## 4. E2E Verification

Verifica fluxos completos end-to-end.

**Quando usar:**
- Critical paths
- Fluxos cross-sistema
- Smoke tests

**Configuração:**
```json
{
  "type": "e2e",
  "test_files": ["e2e/login.spec.ts", "e2e/checkout.spec.ts"],
  "framework": "playwright",
  "browsers": ["chromium", "firefox"]
}
```

**Verificação de sucesso:**
- Todos os testes passando
- Screenshots sem diffs
- Sem timeouts

---

## 5. Manual Verification

Verificação por humano.

**Quando usar:**
- UX changes
- Review de documentação
- Aceite de features

**Configuração:**
```json
{
  "type": "manual",
  "checklist": [
    "Verificar visual do componente",
    "Testar responsividade",
    "Confirmar copy com product"
  ],
  "reviewer": "@product-owner"
}
```

**Verificação de sucesso:**
- Checklist aprovado
- Sign-off do reviewer

---

## 6. None Verification

Sem verificação automática.

**Quando usar:**
- Documentação
- Comentários
- Non-code changes

**Configuração:**
```json
{
  "type": "none",
  "note": "Documentation only, no verification needed"
}
```

---

## Combining Verification Types

Para verificações mais robustas, combine tipos:

```json
{
  "verification_strategy": {
    "primary": {
      "type": "command",
      "command": "npm test"
    },
    "secondary": {
      "type": "browser",
      "steps": ["Login flow verification"]
    }
  }
}
```
