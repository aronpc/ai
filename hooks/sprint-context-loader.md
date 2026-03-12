---
description: "Loads active sprint context at session start, showing current progress and next task"
event: SessionStart
---

# Sprint Context Loader

Ao iniciar uma sessao do Claude Code, carregue o contexto do sprint ativo para dar visibilidade imediata ao desenvolvedor.

## Verificacoes

### 1. Detectar Sprint Ativo

1. Verifique se existe `sprints/tracking.md` no projeto
2. Se NAO existir, nao faca nada (silencioso)
3. Se existir, leia o arquivo e busque por sprints com status "Em Andamento" ou emoji correspondente

### 2. Carregar Detalhes

Se encontrar sprint ativo:
1. Leia o arquivo do sprint (ex: `sprints/001-nome.md`)
2. Conte tarefas completas (`- [x]`) vs total (`- [ ]` + `- [x]`)
3. Identifique a proxima tarefa pendente
4. Calcule progresso percentual

### 3. Reportar

Emita um resumo conciso:

```
Sprint ativo: [Nome do Sprint] ([X/Y] tarefas - [Z]%)
Proxima tarefa: [descricao da tarefa]
Use /aronpc:sprint para gerenciar o sprint.
```

### 4. Mudancas Pendentes

Verifique tambem:
```bash
git status --short
```

Se houver mudancas nao commitadas, adicione:
```
Atencao: [N] arquivos com mudancas nao commitadas.
```

## Comportamento

- Output maximo de 4 linhas
- Se nao houver sprint ativo, nao emita nada
- NAO bloqueie - apenas informativo
- Execute rapido (timeout de 5 segundos)
