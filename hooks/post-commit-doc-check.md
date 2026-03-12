---
description: "Warns when code is committed without updating IMPLEMENTATION.md documentation"
event: PostToolUse
match_tool: Bash
match_command: "git commit"
---

# Post-Commit Documentation Check

Apos cada `git commit`, verifique se a documentacao foi atualizada conforme necessario.

## Verificacoes

### 1. Codigo sem Documentacao

Execute `git diff HEAD~1 --name-only` e analise:

- Se arquivos em `app/`, `resources/`, `routes/`, `database/` foram modificados:
  - Verifique se `IMPLEMENTATION.md` tambem foi modificado neste commit OU em um dos ultimos 3 commits
  - Se NAO foi atualizado, emita aviso:
    ```
    Codigo foi commitado mas IMPLEMENTATION.md nao foi atualizado.
    Use /aronpc:docs para atualizar a documentacao.
    Lembre-se: documentacao deve ser commitada separadamente do codigo.
    ```

### 2. Conventional Commits

Verifique a mensagem do ultimo commit com `git log -1 --format=%s`:

- Deve comecar com um prefixo valido: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`, `style:`, `perf:`, `ci:`, `build:`
- Se NAO segue o padrao, emita aviso:
  ```
  Commit message nao segue Conventional Commits.
  Formato esperado: tipo: descricao
  Exemplos: feat: add user CRUD, fix: correct validation error
  ```

### 3. Sprint Tracking

- Se existe `sprints/` no projeto E arquivos de codigo foram commitados:
  - Verifique se algum arquivo em `sprints/` foi atualizado recentemente
  - Se nao, emita lembrete:
    ```
    Lembre-se de atualizar o sprint tracking se esta tarefa faz parte de um sprint ativo.
    ```

## Comportamento

- Este hook NUNCA bloqueia - apenas emite avisos informativos
- Avisos devem ser concisos (maximo 3 linhas cada)
- NAO emita avisos para commits com prefixo `docs:` ou `chore:`
