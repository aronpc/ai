# Referência de Detecção de Bugs

Padrões para identificar bug reports válidos.

## Padrões de Bug Report

**Requisitos para bug válido:**
- Descrição clara
- Esperado vs Atual
- Passos para reproduzir
- Informações de ambiente

**Indicadores:**
- Mensagens de erro
- Stack traces
- Screenshots
- Indicadores de regressão

## Avaliação de Severidade

| Severidade | Critérios |
|------------|-----------|
| Crítica | Perda de dados, segurança, sistema fora do ar |
| Alta | Feature quebrada, sem workaround |
| Média | Feature degradada, workaround existe |
| Baixa | Problema menor, cosmético |
