# Specialist Agents Reference

Descrição dos agentes especializados para análise de PRs.

---

## Security Agent

**Foco:** Vulnerabilidades de segurança

### Responsabilidades
- SQL/NoSQL injection detection
- XSS vulnerability detection
- Authentication/Authorization issues
- Sensitive data exposure
- Security misconfiguration
- Dependency vulnerabilities

### Triggers de Ativação
- Input handling changes
- Auth-related code changes
- Database query changes
- API endpoint changes
- Configuration changes

### Output Format
```json
{
  "agent": "security",
  "findings": [
    {
      "type": "vulnerability",
      "severity": "critical|high|medium|low",
      "category": "injection|xss|auth|...",
      "file": "path/to/file",
      "line": 42,
      "description": "Description",
      "evidence": "code snippet",
      "recommendation": "How to fix",
      "references": ["CWE-XXX", "OWASP-XXX"]
    }
  ]
}
```

---

## Quality Agent

**Foco:** Qualidade de código e maintainability

### Responsabilidades
- Code smell detection
- Complexity analysis
- SOLID principle violations
- DRY violations
- Test coverage gaps
- Documentation gaps

### Triggers de Ativação
- Large file changes
- Complex logic additions
- New functions/classes
- Test file changes

### Output Format
```json
{
  "agent": "quality",
  "findings": [
    {
      "type": "code_smell|complexity|...",
      "severity": "high|medium|low",
      "file": "path/to/file",
      "line": 42,
      "description": "Description",
      "evidence": "code snippet",
      "recommendation": "How to improve"
    }
  ]
}
```

---

## Logic Agent

**Foco:** Corretude e lógica de negócio

### Responsabilidades
- Logic correctness verification
- Edge case detection
- Error handling verification
- State management validation
- Business rule compliance

### Triggers de Ativação
- Business logic changes
- State management changes
- Conditional logic changes
- Error handling changes

### Output Format
```json
{
  "agent": "logic",
  "findings": [
    {
      "type": "logic_error|edge_case|...",
      "severity": "high|medium|low",
      "file": "path/to/file",
      "line": 42,
      "description": "Description",
      "evidence": "code snippet",
      "expected_behavior": "What should happen",
      "actual_behavior": "What happens"
    }
  ]
}
```

---

## Pattern Adherence Agent

**Foco:** Aderência a padrões do codebase

### Responsabilidades
- Pattern consistency verification
- Architecture compliance
- Naming convention checks
- Code structure validation
- Framework-specific patterns

### Triggers de Ativação
- New file creation
- New function/class addition
- Component structure changes
- API structure changes

### Output Format
```json
{
  "agent": "pattern_adherence",
  "findings": [
    {
      "type": "pattern_violation|naming|...",
      "severity": "medium|low",
      "file": "path/to/file",
      "line": 42,
      "description": "Description",
      "evidence": "code snippet",
      "expected_pattern": "What pattern to follow",
      "reference_file": "path/to/example/file"
    }
  ]
}
```

---

## Finding Validator Agent

**Foco:** Validação de todos os findings

### Responsabilidades
- Verify findings with actual code
- Check for mitigations
- Identify false positives
- Consolidate duplicate findings

### Validation Process
1. Read the actual file at the finding location
2. Get context around the flagged line
3. Verify the issue actually exists
4. Check for nearby mitigations
5. Confirm evidence is real code

### Output Format
```json
{
  "agent": "validator",
  "validation_results": [
    {
      "finding_id": "xxx",
      "status": "confirmed|dismissed|needs_review",
      "reason": "Why confirmed/dismissed",
      "additional_evidence": "code if needed"
    }
  ]
}
```

---

## Orchestrator Agent

**Foco:** Coordenação e síntese

### Responsabilidades
- Analyze PR context
- Detect triggers
- Delegate to specialists
- Synthesize results
- Generate final verdict

### Workflow
1. Phase 0: Understand intent
2. Phase 1: Trigger detection
3. Phase 2: Delegate to specialists
4. Phase 3: Collect findings
5. Phase 4: Validate findings
6. Phase 5: Synthesize and generate verdict
