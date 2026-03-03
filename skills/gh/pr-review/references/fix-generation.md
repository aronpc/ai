# Fix Generation Strategies

Estratégias para gerar sugestões de fix em reviews.

---

## Fix Suggestion Principles

1. **Seja específico** - Mostre código exato
2. **Seja minimal** - Menor mudança que resolve
3. **Preserve style** - Siga padrões do codebase
4. **Explain why** - Justifique a mudança

---

## Fix Categories

### Security Fixes

#### SQL Injection
```javascript
// BEFORE (vulnerable)
const query = `SELECT * FROM users WHERE id = ${userId}`;

// AFTER (fixed)
const query = 'SELECT * FROM users WHERE id = ?';
db.query(query, [userId]);
```

#### XSS Prevention
```javascript
// BEFORE (vulnerable - directly using user input in DOM)
// User input rendered without sanitization

// AFTER (fixed)
// Use textContent for plain text (automatically escapes HTML)
element.textContent = userInput;

// OR use a sanitization library for HTML content
import DOMPurify from 'dompurify';
element.textContent = DOMPurify.sanitize(userInput);
```

#### Auth Check
```javascript
// BEFORE (missing auth)
app.get('/api/users/:id', (req, res) => {
  // ...
});

// AFTER (with auth)
app.get('/api/users/:id', authMiddleware, (req, res) => {
  if (!canAccessUser(req.user, req.params.id)) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  // ...
});
```

---

### Quality Fixes

#### Extract Function
```javascript
// BEFORE (long function)
function processOrder(order) {
  // 100 lines of code...
}

// AFTER (extracted)
function processOrder(order) {
  validateOrder(order);
  calculateTotals(order);
  applyDiscounts(order);
  saveOrder(order);
  notifyCustomer(order);
}
```

#### Reduce Complexity
```javascript
// BEFORE (nested conditionals)
function getStatus(user) {
  if (user.active) {
    if (user.verified) {
      if (user.premium) {
        return 'premium';
      } else {
        return 'verified';
      }
    } else {
      return 'active';
    }
  } else {
    return 'inactive';
  }
}

// AFTER (simplified)
function getStatus(user) {
  if (!user.active) return 'inactive';
  if (!user.verified) return 'active';
  return user.premium ? 'premium' : 'verified';
}
```

#### Remove Duplication
```javascript
// BEFORE (duplicated)
function validateEmail(email) {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
}
function validateUserEmail(email) {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
}

// AFTER (DRY)
const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
function validateEmail(email) {
  return EMAIL_REGEX.test(email);
}
```

---

### Logic Fixes

#### Null Check
```javascript
// BEFORE (missing null check)
function getFullName(user) {
  return user.firstName + ' ' + user.lastName;
}

// AFTER (with null check)
function getFullName(user) {
  if (!user) return '';
  return [user.firstName, user.lastName].filter(Boolean).join(' ');
}
```

#### Error Handling
```javascript
// BEFORE (unhandled promise)
async function fetchUser(id) {
  const response = await fetch(`/api/users/${id}`);
  return response.json();
}

// AFTER (with error handling)
async function fetchUser(id) {
  try {
    const response = await fetch(`/api/users/${id}`);
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}`);
    }
    return response.json();
  } catch (error) {
    logger.error('Failed to fetch user', { id, error: error.message });
    throw new UserFetchError(id, error);
  }
}
```

---

## Fix Suggestion Format

### Inline Comment Format
```markdown
**Issue:** [Description of the issue]

**Why it's a problem:** [Explanation]

**Suggested fix:**
```javascript
// Code example
```

**References:** [Links to docs/patterns if applicable]
```

### Example
```markdown
**Issue:** SQL Injection vulnerability

**Why it's a problem:** User input is directly interpolated into the query string, allowing attackers to execute arbitrary SQL.

**Suggested fix:**
```javascript
// Use parameterized query
const query = 'SELECT * FROM users WHERE id = ?';
db.query(query, [userId]);
```

**References:**
- [OWASP SQL Injection](https://owasp.org/www-community/attacks/SQL_Injection)
- [Node.js Security Best Practices](https://nodejs.org/en/docs/guides/security/)
```

---

## When NOT to Suggest Fix

- Issue is too complex for inline fix
- Requires architectural discussion
- Multiple valid approaches exist
- Need more context to suggest correctly

Instead, flag as **needs discussion**:

```markdown
**Issue:** [Description]

**This requires discussion.** Multiple approaches are possible:
1. Option A: [Description + pros/cons]
2. Option B: [Description + pros/cons]

Recommend: [Your recommendation with reasoning]
```
