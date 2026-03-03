---
name: @ideation/ui-ux
command: /aronpc:ideation:ui-ux
description: Descoberta de melhorias visuais com validação browser
version: 1.0.0
author: aronpc
license: MIT
category: ideation
triggers:
  - "melhorar UI"
  - "melhorar UX"
  - "análise visual"
  - "acessibilidade"
  - "design inconsistente"
  - "ux audit"
aliases:
  - ui-ux
  - ux
  - design
related:
  - @devops/mcp
  - @plan/spec
  - @ideation/codebase
  - @laravel/ux
compatibility: Qualquer projeto web
allowed-tools:
  - Read
  - Write
  - Bash
  - Grep
  - Glob
---

# @ideation/ui-ux

## Resumo
Identifica melhorias de UI/UX com validação visual usando browser automation.

## Skills Relacionadas

| Skill | Quando usar junto |
|-------|-------------------|
| `@devops/mcp` | Para validação visual com browser automation |
| `@plan/spec` | Para criar specs a partir das melhorias visuais |
| `@ideation/codebase` | Para combinar melhorias visuais e técnicas |
| `@laravel/ux` | Para implementar melhorias com Precognition/Prompts |

## Quando usar

Use esta skill quando precisar:
- Analisar UI/UX da aplicação visualmente
- Identificar problemas de acessibilidade
- Encontrar inconsistências de design
- Priorizar melhorias de interface

**Não use para:**
- Melhorias de código (use codebase-ideation)
- Revisão de PR (use github-pr-review)

---

## Princípio Chave

**Veja a app como usuários veem.**

Identifique friction points, inconsistências, e oportunidades de polish que melhoram a experiência do usuário.

---

## Browser Exploration

### Ferramentas Disponíveis
- Puppeteer MCP para automation
- Screenshots para verificação visual
- Console logs para erros

### Fases de Exploração

1. **Navegar** - Ir para página principal
2. **Capturar** - Screenshot do estado inicial
3. **Interagir** - Testar elementos interativos
4. **Verificar** - Checar erros de console
5. **Documentar** - Registrar descobertas

---

## Auditoria de Acessibilidade

### WCAG 2.2 - Verificações Rápidas

| Check | O que verificar |
|-------|-----------------|
| Contraste | Ratio >= 4.5:1 para texto normal |
| Keyboard | Todos elementos acessíveis por tab |
| ARIA | Labels apropriados |
| Alt text | Imagens com descrição |
| Forms | Labels associados |

### Problemas Comuns

- Focus states ausentes
- Contraste de cor insuficiente
- Labels de formulário ausentes
- Sem skip links
- Imagens sem alt text

---

## Consistência de Componentes

### O que Verificar

- [ ] Buttons com estilo consistente
- [ ] Inputs com mesmo padding/border
- [ ] Typography hierarchy correta
- [ ] Spacing consistente
- [ ] Colors seguindo design system

---

## Avaliação Esforço/Impacto

| Impacto | Esforço | Prioridade |
|---------|---------|------------|
| Alto | Baixo | **Fazer primeiro** |
| Alto | Alto | Planejar cuidado |
| Baixo | Baixo | Fazer se tempo |
| Baixo | Alto | Evitar |

---

## Formato de Output

```json
{
  "ui_ux_improvements": [
    {
      "id": "uiux-001",
      "title": "Add loading state to submit button",
      "description": "Show spinner during form submission",
      "category": "feedback",
      "effort": "trivial",
      "impact": "high",
      "affected_components": ["SubmitButton"],
      "screenshot": "path/to/screenshot.png"
    }
  ]
}
```

---

## Categorias de Melhoria

| Categoria | Exemplos |
|-----------|----------|
| Feedback | Loading, success, error states |
| Navigation | Breadcrumbs, back buttons |
| Forms | Validation, help text |
| Layout | Responsive, spacing |
| Accessibility | ARIA, contrast, keyboard |
| Performance | Perceived speed, skeletons |

---

## Referências

- `references/accessibility-audit.md` - WCAG checks detalhados
- `references/component-analysis.md` - Design system consistency
