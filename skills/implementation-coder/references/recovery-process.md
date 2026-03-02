# Recovery Process

Este documento descreve o processo de recuperacao quando voce fica preso durante a implementacao.

## Identificando Bloqueios

### Sinais de que voce esta preso

- Testes falhando repetidamente sem progresso
- Codigo ficando cada vez mais complexo
- Nao sabe qual o proximo passo
- Erro que nao consegue resolver apos 3 tentativas
- Precisa de informacoes que nao tem

### Marcador de Stuck

Use o marcador **STUCK** para sinalizar bloqueios:

```markdown
## STUCK: [Descricao do Problema]

**Onde**: arquivo.php:42
**Tentativas**: 3
**Erro**: Mensagem de erro especifica
**Contexto**: O que estava tentando fazer
**Hipoteses**: Possiveis causas identificadas
**Ajuda Necessaria**: O que precisa para continuar
```

## Loop de Recuperacao

### Step 1: Pare e Documente

Nao continue tentando a mesma coisa. Pare e escreva:

1. O que estava tentando fazer
2. Qual erro encontrou
3. O que ja tentou
4. O que suspeita ser a causa

### Step 2: Isolamento

Isole o problema:

```bash
# Criar teste minimo que reproduz o problema
php artisan test --filter=testeEspecifico

# Verificar logs
tail -f storage/logs/laravel.log

# Debug basico
dd($variavelProblema);
```

### Step 3: Abordagens Alternativas

Tente uma abordagem diferente:

| Abordagem Atual | Alternativa |
|-----------------|-------------|
| Implementacao complexa | Simplificar primeiro |
| Teste falhando | Escrever teste mais simples |
| Codigo nao funciona | Comecar do zero menor |
| Nao entende erro | Pesquisar mensagem exata |
| Logica complexa | Desenhar no papel primeiro |

### Step 4: Reducao de Escopo

Se nao consegue resolver tudo:

1. **Identifique o minimo** - O que e absolutamente necessario?
2. **Corte o opcional** - O que pode ficar para depois?
3. **Implemente o minimo** - Faca o basico funcionar
4. **Adicione depois** - Expanda gradualmente

### Step 5: Pedir Ajuda

Se apos 3 tentativas ainda esta preso:

```markdown
## HELP REQUEST

**Contexto**: Implementando feature X
**Bloqueio**: Erro Y ao fazer Z
**Tentativas**:
  1. Tentei A - resultado: R1
  2. Tentei B - resultado: R2
  3. Tentei C - resultado: R3

**Hipoteses**:
- Pode ser problema com W
- Talvez X esteja configurado errado

**Codigo Relevante**:
```php
// codigo aqui
```

**Logs/Erros**:
```
// logs aqui
```
```

## Recovery Patterns

### Pattern 1: Teste Falhando

```bash
# 1. Isole o teste
php artisan test --filter=nomeTeste

# 2. Veja o erro completo
php artisan test --filter=nomeTeste -v

# 3. Execute setup manualmente
php artisan migrate:fresh --seed

# 4. Se persistir, crie teste minimo
```

### Pattern 2: Dependency Hell

```bash
# 1. Limpe caches
composer clear-cache
php artisan clear-compiled
php artisan cache:clear

# 2. Reinstale dependencias
rm -rf vendor/
composer install

# 3. Regenerate autoload
composer dump-autoload
```

### Pattern 3: Migration Travada

```bash
# 1. Verifique estado
php artisan migrate:status

# 2. Rollback especifico
php artisan migrate:rollback --step=1

# 3. Se necessario, fresh
php artisan migrate:fresh --seed
```

### Pattern 4: Codigo Legado

```bash
# 1. Entenda antes
git log --oneline -10 -- arquivo.php
git blame arquivo.php

# 2. Faca mudancas minimas
# 3. Teste extensivamente
# 4. Documente decisoes
```

## Checklist de Recovery

Antes de desistir:

- [ ] Documentei o problema claramente
- [ ] Tentei pelo menos 3 abordagens
- [ ] Isolei o problema ao minimo
- [ ] Pesquisei a mensagem de erro
- [ ] Verifiquei documentacao relevante
- [ ] Considerei reducao de escopo
- [ ] Pedi ajuda com contexto completo

## Retomando Apos Recovery

Quando resolver o bloqueio:

1. **Documente a solucao** - Para referencia futura
2. **Atualize testes** - Garanta que cobre o caso
3. **Limpe codigo de debug** - Remova dd(), dumps, etc
4. **Continue do Step 8** - Self-Critique Checklist

## Prevencao de Bloqueios

### Boas Praticas

- **Commits frequentes** - Facil voltar
- **Testes primeiro** - Validar cedo
- **Passos pequenos** - Menos chance de erro
- **Documentar decisoes** - Lembrar depois
- **Revisar antes de continuar** - Pegar erros cedo

### Warning Signs

Pare e reavalie se:

- Esta gastando mais de 30min no mesmo problema
- Codigo esta ficando cada vez mais complexo
- Esta "chutando" solucoes sem entender
- Esta ignorando testes vermelhos
- Esta comentando codigo para fazer passar
