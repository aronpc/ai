# Code Quality Checks Reference

Guia detalhado para verificação de qualidade de código.

---

## Readability

### Naming Conventions

| Elemento | Convenção | Exemplo |
|----------|-----------|---------|
| Variables | camelCase | `userName` |
| Constants | UPPER_SNAKE | `MAX_RETRY_COUNT` |
| Functions | camelCase | `getUserById` |
| Classes | PascalCase | `UserService` |
| Files | kebab-case | `user-service.ts` |

### Code Smells

| Smell | Sinal | Solução |
|-------|-------|---------|
| Long method | > 50 linhas | Extrair métodos |
| Large class | > 500 linhas | Separar responsabilidades |
| Long parameter list | > 4 params | Usar objeto de config |
| Duplicate code | Similar blocks | Extrair para função |
| Dead code | Não usado | Remover |
| Magic numbers | Números sem contexto | Usar constantes |

### Comments

**Bons comentários:**
```javascript
// Calculate compound interest using the formula: A = P(1 + r/n)^(nt)
// where P = principal, r = rate, n = compounding frequency, t = time
function calculateCompoundInterest(principal, rate, periods, years) {
  // Implementation
}
```

**Comentários desnecessários:**
```javascript
// BAD: Obvious comment
// Increment counter by 1
counter++;
```

---

## Maintainability

### Function Size

| Tamanho | Classificação | Ação |
|---------|---------------|------|
| < 10 linhas | Excelente | Manter |
| 10-25 linhas | Bom | Aceitável |
| 25-50 linhas | Atenção | Considerar refatorar |
| > 50 linhas | Crítico | Refatorar |

### Complexity

**Cyclomatic Complexity:**
| Score | Classificação |
|-------|---------------|
| 1-5 | Baixa |
| 6-10 | Moderada |
| 11-20 | Alta |
| > 20 | Muito alta |

**Red flags:**
- Nested if statements (> 3 levels)
- Switch statements with many cases
- Multiple return paths

### SOLID Principles

| Princípio | Verificação |
|-----------|-------------|
| **S**ingle Responsibility | Classe faz uma coisa só? |
| **O**pen/Closed | Aberto para extensão, fechado para modificação? |
| **L**iskov Substitution | Subclasses substituíveis? |
| **I**nterface Segregation | Interfaces específicas? |
| **D**ependency Inversion | Depende de abstrações? |

---

## Testability

### Indicators of Testable Code

- [ ] Funções puras quando possível
- [ ] Dependências injetadas
- [ ] Estado externo mockable
- [ ] Side effects isolados
- [ ] Funções pequenas e focadas

### Test Coverage Expectations

| Tipo de Código | Coverage Mínimo |
|----------------|-----------------|
| Critical paths | 90% |
| Business logic | 80% |
| Utilities | 70% |
| UI components | 50% |

---

## Performance

### Common Performance Issues

| Issue | Detecção | Solução |
|-------|----------|---------|
| N+1 queries | Loop com query | Eager loading |
| Memory leaks | Event listeners não removidos | Cleanup em useEffect |
| Blocking I/O | Sync operations | Async/await |
| Large bundles | Import de bibliotecas grandes | Code splitting |

### Database Patterns

```javascript
// BAD: N+1 query
for (const user of users) {
  const posts = await db.query('SELECT * FROM posts WHERE userId = ?', [user.id]);
}

// GOOD: Eager loading
const usersWithPosts = await db.query(`
  SELECT users.*, posts.*
  FROM users
  LEFT JOIN posts ON users.id = posts.userId
`);
```

---

## Error Handling

### Good Error Handling

```javascript
// GOOD: Specific error handling with context
async function getUser(id) {
  try {
    const user = await db.users.findById(id);
    if (!user) {
      throw new NotFoundError(`User ${id} not found`);
    }
    return user;
  } catch (error) {
    if (error instanceof NotFoundError) {
      throw error;
    }
    logger.error('Database error in getUser', { id, error: error.message });
    throw new InternalServerError('Failed to fetch user');
  }
}
```

### Error Handling Checklist

- [ ] Try-catch em operações que podem falhar
- [ ] Errors específicos, não genéricos
- [ ] Logging com contexto
- [ ] User-facing messages apropriados
- [ ] Cleanup de recursos (finally block)

---

## Code Organization

### File Structure

```
src/
├── components/     # UI components
├── services/       # Business logic
├── models/         # Data models
├── utils/          # Helper functions
├── constants/      # Constants
├── types/          # TypeScript types
└── tests/          # Test files
```

### Import Order

```javascript
// 1. External imports
import React from 'react';
import { useRouter } from 'next/router';

// 2. Internal imports (absolute)
import { Button } from '@/components/ui';
import { useAuth } from '@/hooks';

// 3. Relative imports
import { LocalComponent } from './LocalComponent';
import styles from './styles.module.css';
```
