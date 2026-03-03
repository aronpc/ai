# Security Analysis Reference

Guia detalhado para análise de segurança em Pull Requests.

---

## OWASP Top 10 (2021)

### 1. Broken Access Control

**O que buscar:**
- Missing auth checks
- IDOR (Insecure Direct Object Reference)
- Privilege escalation
- CORS misconfiguration

**Patterns inseguros:**
```javascript
// BAD: No auth check
app.get('/api/users/:id', (req, res) => {
  const user = db.getUser(req.params.id);
  res.json(user);
});

// GOOD: Auth check
app.get('/api/users/:id', authMiddleware, (req, res) => {
  if (req.user.id !== req.params.id && !req.user.isAdmin) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  const user = db.getUser(req.params.id);
  res.json(user);
});
```

### 2. Cryptographic Failures

**O que buscar:**
- Sensitive data unencrypted
- Weak encryption algorithms
- Hardcoded encryption keys
- SSL/TLS issues

**Patterns inseguros:**
```javascript
// BAD: Storing passwords in plain text
const user = { email, password: req.body.password };

// GOOD: Hashing passwords
const hashedPassword = await bcrypt.hash(password, 10);
const user = { email, password: hashedPassword };
```

### 3. Injection

**O que buscar:**
- SQL injection
- NoSQL injection
- Command injection
- LDAP injection

**Patterns inseguros:**
```javascript
// BAD: SQL injection
const query = `SELECT * FROM users WHERE id = ${userId}`;

// GOOD: Parameterized query
const query = 'SELECT * FROM users WHERE id = ?';
db.query(query, [userId]);
```

### 4. Insecure Design

**O que buscar:**
- Missing security controls
- Weak password requirements
- No rate limiting
- Missing account lockout

### 5. Security Misconfiguration

**O que buscar:**
- Debug mode enabled
- Default credentials
- Unnecessary features enabled
- Missing security headers

**Headers recomendados:**
```
Content-Security-Policy: default-src 'self'
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
Strict-Transport-Security: max-age=31536000
```

### 6. Vulnerable Components

**O que buscar:**
- Outdated dependencies
- Known CVEs
- Unmaintained packages

**Verification:**
```bash
npm audit
npm outdated
```

### 7. Auth Failures

**O que buscar:**
- Weak password policies
- Missing MFA
- Session management issues
- Credential stuffing vulnerabilities

### 8. Software and Data Integrity Failures

**O que buscar:**
- Unsigned code
- Insecure deserialization
- CI/CD pipeline issues

### 9. Logging & Monitoring Failures

**O que buscar:**
- Missing audit logs
- Sensitive data in logs
- No alerting for suspicious activity

### 10. SSRF (Server-Side Request Forgery)

**O que buscar:**
- User-controlled URLs
- Webhook URLs without validation
- Internal resource access

---

## Security Patterns by Category

### Input Validation

| Tipo | Validação |
|------|-----------|
| Email | RFC 5322 compliance |
| URL | Protocol whitelist |
| Integer | Range check |
| String | Length, charset |
| File upload | Type, size, content |

### Authentication

| Aspect | Recommendation |
|--------|----------------|
| Passwords | bcrypt/scrypt/argon2 |
| Sessions | HttpOnly, Secure cookies |
| Tokens | JWT with short expiry |
| MFA | TOTP or WebAuthn |

### Authorization

| Pattern | Use Case |
|---------|----------|
| RBAC | Role-based access |
| ABAC | Attribute-based access |
| ACL | Resource-level control |

---

## Security Checklist

```markdown
### Authentication
- [ ] Password hashing used (bcrypt/argon2)
- [ ] Session management secure
- [ ] MFA available for sensitive operations
- [ ] Rate limiting on auth endpoints

### Authorization
- [ ] Every endpoint has auth check
- [ ] Resource ownership verified
- [ ] Role-based access implemented
- [ ] No IDOR vulnerabilities

### Input/Output
- [ ] Input validated and sanitized
- [ ] Output encoded for context
- [ ] File uploads secured
- [ ] SQL queries parameterized

### Data Protection
- [ ] Sensitive data encrypted at rest
- [ ] TLS for data in transit
- [ ] Secrets in environment variables
- [ ] No sensitive data in logs

### Dependencies
- [ ] npm audit clean
- [ ] No known CVEs
- [ ] Dependencies up to date
```
