# Workflow Guidance

Este documento fornece orientacoes especificas para diferentes tipos de implementacao.

## Feature Workflow

### Caracteristicas

Implementacao de novas funcionalidades que adicionam valor ao usuario.

### Checklist Pre-Implementacao

- [ ] Requisitos claros e documentados
- [ ] Design/UI aprovado (se aplicavel)
- [ ] Criterios de aceitacao definidos
- [ ] Impacto em codigo existente mapeado
- [ ] Estrategia de testes definida

### Workflow Especifico

#### 1. Setup Inicial

```bash
# Criar branch descritivo
git checkout -b feat/nome-da-feature

# Verificar ambiente
php artisan migrate --pretend
php artisan test
```

#### 2. Implementacao por Camadas

Ordem recomendada:

1. **Database/Migrations** - Estrutura de dados primeiro
   ```bash
   php artisan make:migration create_nome_table
   php artisan migrate
   ```

2. **Models** - Modelos e relacionamentos
   ```bash
   php artisan make:model Nome
   ```

3. **Services/Business Logic** - Logica de negocio
   ```bash
   # Criar em app/Services/
   ```

4. **HTTP/API Layer** - Controllers, Requests
   ```bash
   php artisan make:controller NomeController
   php artisan make:request NomeRequest
   ```

5. **Frontend/Views** - Interface do usuario
   ```bash
   # Blade: resources/views/
   # Vue/React: resources/js/
   ```

6. **Tests** - Testes em paralelo com implementacao
   ```bash
   php artisan make:test NomeTest
   php artisan make:test NomeTest --unit
   ```

#### 3. Verificacoes Especificas

```bash
# Testes da feature
php artisan test --filter=NomeFeature

# Teste manual
php artisan serve
# Abrir navegador e testar fluxo completo

# Verificar performance
# - Queries N+1?
# - Indices necessarios?
```

#### 4. Documentacao

- [ ] Atualizar README se feature visivel
- [ ] Documentar API endpoints (se aplicavel)
- [ ] Adicionar comentarios em codigo complexo

### Exemplo de Commits

```bash
git commit -m "feat: adiciona sistema de notificacoes

- Cria tabela de notificacoes
- Implementa NotificationService
- Adiciona endpoints de API
- Cria testes de feature e unitarios"
```

---

## Investigation Workflow

### Caracteristicas

Investigacao de bugs, problemas de performance ou comportamento inesperado.

### Checklist Pre-Investigacao

- [ ] Bug reproduzivel consistentemente?
- [ ] Ambiente identificado (local/staging/prod)?
- [ ] Logs e erros coletados?
- [ ] Impacto mapeado?

### Workflow Especifico

#### 1. Coleta de Informacoes

```bash
# Logs
tail -100 storage/logs/laravel.log

# Queries lentas (se logando)
grep "slow" storage/logs/laravel.log

# Erros recentes
grep -i "error\|exception" storage/logs/laravel.log | tail -50
```

#### 2. Reproducao

```bash
# Isolar o problema
php artisan tinker
>>> // Reproduzir o bug aqui

# Ou criar teste que reproduz
php artisan make:test BugInvestigationTest
```

#### 3. Hipoteses e Testes

Documente cada hipotese:

```markdown
## Hipotese 1: [Descricao]
- Razao: Por que suspeita disso
- Teste: Como vai verificar
- Resultado: O que descobriu

## Hipotese 2: [Descricao]
...
```

#### 4. Root Cause Analysis

Quando encontrar a causa:

```markdown
## Root Cause

**Problema**: Descricao do bug
**Causa**: O que realmente causava
**Solucao**: O que precisa ser feito
**Prevencao**: Como evitar no futuro
```

#### 5. Fix Implementation

```bash
git checkout -b fix/nome-do-bug

# Implementar correcao
# ...

# Testes especificos
php artisan test --filter=BugRelatedTest

# Regression tests
php artisan test
```

### Exemplo de Commits

```bash
git commit -m "fix: corrige N+1 queries em lista de usuarios

- Adiciona eager loading de relacionamentos
- Cria indice composto para otimizacao
- Adiciona teste de regressao"
```

---

## Refactor Workflow

### Caracteristicas

Reescrita de codigo existente sem mudar comportamento externo.

### Checklist Pre-Refactor

- [ ] Testes existentes passando?
- [ ] Cobertura de testes adequada?
- [ ] Escopo do refactor definido?
- [ ] Risco de breaking changes avaliado?

### Workflow Especifico

#### 1. Baseline

```bash
# Garantir que testes passam
php artisan test

# Medir cobertura atual (se disponivel)
php artisan test --coverage
```

#### 2. Refactoring Steps

**Regra de Ouro**: Um refactor de cada vez, testando apos cada um.

Tipos de refactor comuns:

| Tipo | Descricao | Risco |
|------|-----------|-------|
| Rename | Renomear variaveis/metodos | Baixo |
| Extract | Extrair metodo/classe | Baixo |
| Inline | Inline de metodo/variavel | Medio |
| Move | Mover entre arquivos | Medio |
| Replace | Substituir algoritmo | Alto |

#### 3. Verificacao Continua

```bash
# Apos cada mudanca
php artisan test

# Se falhar, REVERTA imediatamente
git checkout -- .
```

#### 4. Commits Granulares

Cada tipo de refactor = commit separado:

```bash
git commit -m "refactor: extrai metodo processPayment"

git commit -m "refactor: renomeia variaveis para maior clareza"

git commit -m "refactor: move logica para service dedicado"
```

#### 5. Verificacao Final

- [ ] Todos testes passando?
- [ ] Comportamento inalterado?
- [ ] Codigo mais limpo/legivel?
- [ ] Performance mantida ou melhorada?

### Exemplo de Commits

```bash
git commit -m "refactor: reorganiza servicos de pagamento

- Extrai PaymentProcessorInterface
- Move logica especifica para classes dedicadas
- Melhora nomeacao de metodos
- Mantem comportamento existente 100%"
```

---

## Quadro Comparativo

| Aspecto | Feature | Investigation | Refactor |
|---------|---------|---------------|----------|
| Foco | Adicionar | Descobrir | Melhorar |
| Testes | Criar novos | Reproduzir bug | Manter existentes |
| Commits | Novo codigo | Fixes | Reorganizacao |
| Risco | Medio | Baixo (se só investigar) | Medio-Alto |
| Documentacao | Nova | Root cause | Mudancas de estrutura |

## Dicas Gerais por Tipo

### Feature

- Comece pelo que é mais difícil
- Teste cedo e frequentemente
- Peça feedback visual (se UI)

### Investigation

- Nao assuma nada
- Documente cada descoberta
- Reproduza antes de tentar corrigir

### Refactor

- Pequenos passos
- Teste apos cada mudanca
- Nao mude comportamento

## Warning Signs por Tipo

### Feature

- Feature creep (escopo crescendo)
- Testes complexos demais
- Muitas dependencias

### Investigation

- Assumir causa sem evidencia
- Tentar corrigir antes de entender
- Ignorar logs/dados

### Refactor

- Mudando comportamento
- Testes quebrando
- Refactor muito grande de uma vez
