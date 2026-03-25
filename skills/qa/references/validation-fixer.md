# Validation Fixer Reference

Agente de validação e correção automática.

---

## Validation Types

1. Syntax Validation (lint, TypeScript)
2. Test Validation (unit, integration)
3. Build Validation (bundle, warnings)
4. API Validation (endpoints, status codes)

---

## Auto-Fix Capabilities

Safe Auto-Fixes:
- Lint formatting
- Import order
- Unused imports
- Missing semicolons
- Typos in strings

Do NOT Auto-Fix:
- Logic errors
- API contracts
- Auth issues
- Database schema
- Business logic

---

## Fix Process

1. Validate
2. Identify Issues
3. Fix Auto-Fixable
4. Re-validate
5. Report
