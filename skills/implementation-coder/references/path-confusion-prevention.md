# Path Confusion Prevention

Este documento descreve como evitar confusao com caminhos de arquivos durante a implementacao.

## O Problema

Agentes frequentemente ficam confusos sobre:

1. Onde estao trabalhando (CWD)
2. Caminhos relativos vs absolutos
3. Estrutura de worktrees
4. Caminhos de projetos diferentes

## Regras de Ouro

### Regra 1: Sempre Verifique o CWD

Antes de qualquer operacao de arquivo:

```bash
pwd
```

Nao assuma. Verifique.

### Regra 2: Prefira Caminhos Absolutos

**ERRADO** (relativo):
```php
// Nao assume que sabe onde esta
Read file_path="src/Model.php"
```

**CORRETO** (absoluto):
```php
// Caminho completo, sem ambiguidade
Read file_path="/home/user/projects/myapp/src/Model.php"
```

### Regra 3: Verifique Antes de Criar

Antes de criar arquivos:

```bash
# Verificar que o diretorio pai existe
ls -la /caminho/completo/do/diretorio/pai/

# Verificar que nao vai sobrescrever
ls -la /caminho/completo/do/arquivo/novo.php
```

## Cenarios Comuns de Confusao

### Cenario 1: Worktree Git

```bash
# Voce pode estar em:
/home/user/projects/myapp/                    # Main repo
/home/user/projects/myapp/.worktrees/feat-x/  # Worktree para feature X
/home/user/projects/myapp/.worktrees/fix-y/   # Worktree para fix Y

# Cada um tem seu proprio CWD e branch
```

**Como verificar**:
```bash
git worktree list
# Mostra todos os worktrees e onde estao
```

### Cenario 2: Projetos com Nomes Similares

```bash
/home/user/projects/myapp/          # Projeto principal
/home/user/projects/myapp-api/      # API separada
/home/user/projects/myapp-admin/    # Admin panel
```

**Como nao se perder**:
```bash
# Verifique o composer.json ou package.json
cat composer.json | grep '"name"'
```

### Cenario 3: Monorepos

```bash
/home/user/projects/monorepo/
├── packages/
│   ├── core/
│   ├── api/
│   └── web/
└── apps/
    ├── admin/
    └── mobile/
```

**Como navegar**:
```bash
# Sempre verifique onde esta
pwd

# Use caminhos absolutos para edicao
# /home/user/projects/monorepo/packages/core/src/Service.php
```

## Exemplos Praticos

### Exemplo 1: Lendo Arquivo

**Incorreto**:
```
Read file_path="app/Models/User.php"
```

**Correto**:
```bash
# Primeiro verifique onde esta
pwd
# Output: /home/user/projects/myapp

# Agora use o caminho absoluto
Read file_path="/home/user/projects/myapp/app/Models/User.php"
```

### Exemplo 2: Criando Novo Arquivo

**Incorreto**:
```
Write file_path="app/Services/NewService.php"
```

**Correto**:
```bash
# Verifique estrutura existente
ls -la /home/user/projects/myapp/app/Services/

# Crie com caminho absoluto
Write file_path="/home/user/projects/myapp/app/Services/NewService.php"
```

### Exemplo 3: Editando Arquivo

**Incorreto**:
```
Edit file_path="config/app.php"
```

**Correto**:
```bash
# Verifique que o arquivo existe
ls -la /home/user/projects/myapp/config/app.php

# Edite com caminho absoluto
Edit file_path="/home/user/projects/myapp/config/app.php"
```

## Checklist de Caminhos

Antes de operacoes de arquivo:

- [ ] Sei o CWD atual (`pwd`)
- [ ] Sei o caminho absoluto do arquivo
- [ ] Verifiquei que o diretorio/arquivo existe (ou nao existe)
- [ ] Nao estou assumindo caminho relativo
- [ ] Se em worktree, sei qual worktree

## Debug de Caminhos

### Script de Verificacao

```bash
#!/bin/bash
echo "=== PATH DEBUG ==="
echo "CWD: $(pwd)"
echo "Git Root: $(git rev-parse --show-toplevel 2>/dev/null || echo 'Not a git repo')"
echo "Branch: $(git branch --show-current 2>/dev/null || echo 'N/A')"
echo "Worktrees:"
git worktree list 2>/dev/null || echo "No worktrees"
echo "=================="
```

### Verificacao Rapida

```bash
# Tudo em um comando
echo "PWD: $(pwd) | GIT_ROOT: $(git rev-parse --show-toplevel 2>/dev/null) | BRANCH: $(git branch --show-current 2>/dev/null)"
```

## Anti-Patterns

### Anti-Pattern 1: Assumir Localizacao

```
# ERRADO: Assumir que esta na raiz do projeto
Read file_path="composer.json"
```

### Anti-Pattern 2: Caminhos Relativos em Scripts

```bash
# ERRADO: Relativo
php artisan test

# CORRETO: A partir do diretorio correto
cd /home/user/projects/myapp && php artisan test
```

### Anti-Pattern 3: Ignorar Worktrees

```bash
# ERRADO: Assumir que e o repo principal
git checkout main

# CORRETO: Verificar onde esta
git worktree list
git branch --show-current
```

## Boas Praticas

### 1. Sempre Comece com pwd

```bash
pwd
```

### 2. Use Caminhos Absolutos para IO

```
Read file_path="/caminho/absoluto/completo/arquivo.php"
Write file_path="/caminho/absoluto/completo/arquivo.php"
Edit file_path="/caminho/absoluto/completo/arquivo.php"
```

### 3. Verifique Antes de Agir

```bash
# Antes de ler
ls -la /caminho/absoluto/arquivo.php

# Antes de criar
ls -la /caminho/absoluto/diretorio/

# Antes de deletar
# TENHA CERTEZA ABSOLUTA
```

### 4. Documente Caminhos em Sessoes

```markdown
## Sessao de Trabalho
- Projeto: /home/user/projects/myapp
- Branch: feat/new-feature
- Worktree: N/A
- Arquivos modificados:
  - /home/user/projects/myapp/app/Models/User.php
  - /home/user/projects/myapp/app/Services/UserService.php
```
