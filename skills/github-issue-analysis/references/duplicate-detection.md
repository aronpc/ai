# Referência de Detecção de Duplicados

Algoritmo e thresholds para detecção de duplicados.

## Indicadores de Similaridade

| Nível | Indicadores |
|-------|-------------|
| Alto | Erros idênticos, mesmo stack trace |
| Médio | Descrição similar, mesma área |
| Baixo | Mesmas labels, mesmo autor |

## Thresholds

| Confiança | Ação |
|-----------|------|
| 90%+ | Marcar como duplicado |
| 80-89% | Necessita verificação |
| <80% | Não é duplicado |

## Processo

1. Extrair termos-chave
2. Buscar issues similares
3. Comparar descrições
4. Calcular score de similaridade
5. Marcar se acima do threshold
