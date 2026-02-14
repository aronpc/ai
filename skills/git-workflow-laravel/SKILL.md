---
name: git-workflow-laravel
description: Fluxo Git e commits atômicos para projetos Laravel seguindo Conventional Commits
license: MIT
compatibility: Requer Git, projetos Laravel
metadata:
  author: aronpc
  version: 1.0.0
  category: development
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
---

# Git Workflow Laravel

## Quando usar esta skill

Use esta skill sempre que:
- Antes de fazer commits
- Para revisar histórico de commits
- Para configurar pre-commit hooks
- Para gerenciar branches e feature branches
- Para configurar regras de merge e pull requests

## CRÍTICO: Commits Atômicos

**NUNCA commit como "Claude" ou "AI Assistant"** - commits são SEMPRE no nome do desenvolvedor.

### CRÍTICO: Regras de Mensagem de Commit

**NUNCA incluir** o seguinte em mensagens de commit:
- ❌ `🤖 Generated with [Claude Code](https://claude.com/claude-code)`
- ❌ `Co-Authored-By: Claude <noreply@anthropic.com>`
- ❌ Qualquer atribuição ou assinatura relacionada a AI

**Commits devem parecer como foram escritos por um desenvolvedor humano.**

### Regras de Commit

1. **Um commit = Uma mudança lógica**
    - Uma feature = um commit
    - Um bug fix = um commit
    - Um refactor = um commit

2. **Formato de Mensagem:**
   ```
   <type>: <descrição curta>

   <descrição detalhada se necessária>

   - Ponto de mudanças
   - Outra mudança
   ```

3. **Tipos de Commit:**
    - `feat:` Nova feature
    - `fix:` Bug fix
    - `refactor:` Refatoração de código
    - `docs:` Documentação
    - `test:` Testes
    - `chore:` Manutenção

4. **Quando Fazer Commit:**
    - Após completar uma feature
    - Após fixar um bug
    - Após adicionar testes
    - **Após rodar `composer fix` com sucesso**

## Workflow Git

```bash
# 1. Faça mudanças no código
# 2. Execute verificações de qualidade
composer fix
composer test

# 3. Stage apenas arquivos relacionados
git add app/Http/Controllers/Owner/StaffController.php
git add resources/js/pages/owner/staff/

# 4. Commit com mensagem descritiva
git commit -m "feat: Add StaffController with CRUD operations"

# 5. Atualize documentação em commit separado
git add IMPLEMENTATION.md
git commit -m "docs: Mark Staff Management as complete"
```

## Exemplos de Bons Commits

```bash
# ✅ GOOD - atômico, focado
git commit -m "feat: Add Staff Management CRUD

Implemented complete staff management system:
- StaffController with index, create, store, edit, update, destroy
- React pages: index, create, edit, businesses
- StaffForm reusable component
- Translations in EN, ES, PT-BR
- Plan limit enforcement"

# ✅ GOOD - documentação separada
git commit -m "docs: Update implementation progress for Staff Management"
```

## Exemplos de Commits Ruins

```bash
# ❌ BAD - muito grande, múltiplas features
git commit -m "Added everything"

# ❌ BAD - mensagem vaga
git commit -m "Fixed stuff"

# ❌ BAD - misturando features
git commit -m "Added staff management and fixed menu bug"
```

## Estrutura de Mensagem de Commit

### Formato Completo

```
<type>(<escopo>): <assunto>

<body>

<footer>
```

### Type (Obrigatório)

- `feat`: Nova feature
- `fix`: Bug fix
- `docs`: Mudanças na documentação
- `style`: Formatação, missing semi colons, etc (sem mudança de código)
- `refactor`: Refatoração de código
- `test`: Adicionando testes faltando ou corrigindo testes existentes
- `chore`: Atualização de tarefas de build, configuração, etc.

### Scope (Opcional)

O escopo deve indicar a área do código afetada:
- `controller`: Para controllers
- `model`: Para models
- `migration`: Para migrations
- `filament`: Para resources/pages Filament
- `i18n`: Para traduções
- `tests`: Para testes

### Subject (Obrigatório)

- Use tempo imperativo ("add" não "added" ou "adds")
- Não coloque primeira letra maiúscula
- Não termine com ponto (.)
- Limite de 72 caracteres

### Body (Opcional)

- Use tempo imperativo
- Inclue motivo do mudança e对比 com comportamento anterior
- Cada linha máxima de 72 caracteres

### Footer (Opcional)

- Referencie issues fechados
- Liste breaking changes

## Workflow de Branches

### Branch Strategy

| Branch | Propósito | Estabilidade |
|---------|------------|---------------|
| `main` | Produção | ✅ Sempre estável |
| `develop` | Desenvolvimento | ⚠️ Pode ser instável |
| `feature/*` | Features | 🔨 Em desenvolvimento |

### Criando Feature Branch

```bash
# Crie branch de feature a partir de develop
git checkout develop
git pull origin develop
git checkout -b feature/staff-management

# Trabalhe na feature
# ... faça mudanças ...

# Commit com mensagens apropriadas
git add .
git commit -m "feat: add staff controller"

# Push para origin
git push origin feature/staff-management

# Crie pull request para develop
```

### Merge Strategy

```bash
# ✅ GOOD - Squash and merge (develop -> main)
git checkout main
git merge develop --squash
git commit -m "release: v1.8.0"
git push origin main

# ✅ GOOD - Rebase feature branch antes de merge
git checkout feature/staff-management
git rebase develop
git push origin feature/staff-management --force
```

## Pull Requests

### Criando Pull Request

```bash
# Após push de feature branch
gh pr create \
  --title "feat: Add Staff Management" \
  --body "Implementa gestão completa de funcionários:

## Changes
- StaffController com operações CRUD
- Páginas React para list, create, edit
- StaffForm component reutilizável
- Traduções EN, ES, PT-BR
- Validação de limites de plano

## Testing
- [x] Testes unitários para Actions
- [x] Testes de feature para endpoints HTTP
- [x] Testes de Policies

## Checklist
- [x] Sem N+1 queries
- [x] Traduções completas
- [x] Documentação atualizada" \
  --base develop
```

### Revisando Pull Request

```bash
# List PRs
gh pr list

# Ver diff do PR
gh pr diff 123

# Adicionar revisor
gh pr edit 123 --add-reviewer @username

# Aprovar PR
gh pr review 123 --approve
```

## Solução de Problemas

### Commit Acidental de Arquivos Errados

```bash
# Remove arquivos do último commit mas mantenha mudanças
git reset HEAD~1 path/to/file.php

# Commit correto
git commit -m "fix: correct commit message"
```

### Editar Última Mensagem de Commit

```bash
git commit --amend -m "feat: corrected commit message"
```

### Reverter Commit

```bash
# Reverter commit mas manter histórico
git revert <commit-hash>

# Reverter merge
git revert -m 1 <merge-commit-hash>
```

### Reset para Remoto

```bash
# ATENÇÃO: Perde mudanças locais
git fetch origin
git reset --hard origin/main
```

## Melhores Práticas

### ✅ FAÇA

- Faça commits atômicos (uma mudança lógica por commit)
- Use mensagens descritivas seguindo Conventional Commits
- Separe documentação em commits próprios
- Execute `composer fix` e `composer test` antes de commitar
- Use feature branches para desenvolvimento
- Crie pull requests para revisão
- Mantenha histórico de commits limpo
- Use squash merge para integrar features

### ❌ NÃO FAÇA

- Não misture mudanças lógicas em um commit
- Não use mensagens vagas ("fix", "update", etc.)
- Não commite código que não passa nos testes
- Não commite arquivos gerados (.DS_Store, node_modules, etc.)
- Não faça commits diretos em main/develop
- Não force push em branches compartilhadas (sem razão muito boa)
- Não ignore conflitos de merge
- Não deixe branches velhas sem merge

## Checklist de Commit

Antes de fazer commit:

- [ ] `composer fix` executado com sucesso
- [ ] `composer test` passando
- [ ] Mudanças lógicas agrupadas
- [ ] Mensagem segue formato Conventional Commits
- [ ] Atribuição AI removida (se presente)
- [ ] Apenas arquivos relacionados stageados
- [ ] Documentação atualizada (veja `documentation-updates`)
- [ ] Sem dados sensíveis ou tokens

## Documentação e Git

**Integração com documentation-updates:**

Após implementar features, atualize a documentação em commits separados:

```bash
# Commit de código primeiro
git add app/ resources/
git commit -m "feat: Add Staff Management CRUD"

# Commit de documentação separadamente
git add IMPLEMENTATION.md CHECKPOINT.md
git commit -m "docs: Update implementation progress - Staff Management complete"
```

Veja `documentation-updates` para:
- Quando atualizar IMPLEMENTATION.md (sempre após cada feature)
- Quando atualizar CHECKPOINT.md (após marcos principais)
- Quando atualizar README.md (raramente, apenas mudanças significativas)
- Tracking de features em sprints (veja `sprint-management`)

## Referências

- [Conventional Commits](https://www.conventionalcommits.org/) - Especificação
