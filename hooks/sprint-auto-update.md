---
description: "Reminds to update sprint tracking when sprint files were modified during the session"
event: Stop
---

# Sprint Auto-Update Reminder

Quando o Claude Code finalizar uma resposta, verifique se arquivos de sprint foram modificados e se o tracking esta atualizado.

## Verificacoes

### 1. Sprint Files Modificados

Verifique se arquivos em `sprints/` foram modificados na sessao:
```bash
git diff --name-only -- 'sprints/*.md'
```

Se nenhum arquivo de sprint foi modificado, nao faca nada.

### 2. Tracking Atualizado

Se arquivos de sprint foram modificados:
1. Verifique se `sprints/tracking.md` tambem foi modificado
2. Se tracking NAO foi atualizado, emita lembrete:
   ```
   Arquivos de sprint foram modificados mas sprints/tracking.md pode estar desatualizado.
   Use /aronpc:sprint para atualizar o tracking.
   ```

### 3. Mudancas Nao Commitadas

Verifique se existem mudancas pendentes:
```bash
git status --short
```

Se houver mudancas nao commitadas, emita lembrete:
```
Existem [N] arquivos com mudancas nao commitadas.
```

## Comportamento

- NUNCA bloqueie - apenas lembretes
- Maximo 2 linhas de output
- Se nao houver sprints no projeto, nao emita nada
- Execute apenas se o projeto tiver diretorio `sprints/`
