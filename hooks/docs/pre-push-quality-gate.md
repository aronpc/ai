---
description: "Runs Pint, PHPStan and Pest before allowing git push to prevent pushing failing code"
event: PreToolUse
match_tool: Bash
match_command: "git push"
---

# Pre-Push Quality Gate

Antes de permitir um `git push`, execute verificacoes de qualidade. Se qualquer verificacao falhar, BLOQUEIE o push.

## Verificacoes Obrigatorias

Execute as verificacoes na seguinte ordem (pare no primeiro erro):

### 1. Arquivos Perigosos

Verifique se algum dos arquivos staged contem dados sensiveis:
```bash
git diff origin/$(git branch --show-current)...HEAD --name-only
```

BLOQUEIE se encontrar:
- `.env` (exceto `.env.example`)
- Arquivos com `secret`, `credential`, `password` no nome
- Chaves privadas (`*.pem`, `*.key`)

### 2. Debug Code

Busque por codigo de debug nos arquivos alterados:
```bash
git diff origin/$(git branch --show-current)...HEAD -- '*.php'
```

BLOQUEIE se encontrar (fora de `tests/`):
- `dd(`
- `dump(`
- `ray(`
- `var_dump(`
- `print_r(`
- `console.log(`

### 3. Code Style (Pint)

```bash
./vendor/bin/pint --test
```

Se falhar, BLOQUEIE com mensagem:
```
Code style check falhou. Execute ./vendor/bin/pint para corrigir.
```

### 4. Static Analysis (PHPStan)

```bash
./vendor/bin/phpstan analyse --no-progress
```

Se falhar, BLOQUEIE com mensagem:
```
PHPStan encontrou erros. Corrija os erros acima antes de fazer push.
```

### 5. Testes (Pest)

```bash
./vendor/bin/pest --parallel --stop-on-failure
```

Se falhar, BLOQUEIE com mensagem:
```
Testes falharam. Corrija os testes antes de fazer push.
```

## Comportamento

- Se o projeto NAO tiver `vendor/bin/pint`, `vendor/bin/phpstan` ou `vendor/bin/pest`, PULE a verificacao correspondente (nao bloqueie)
- Verifique a existencia dos binarios antes de executar
- Timeout de 120 segundos para cada verificacao
- Se TODAS as verificacoes passarem, permita o push
- Reporte qual verificacao falhou com output relevante
