---
description: "Blocks Laravel anti-patterns at write time: Services instead of Actions, env() outside config, DB facade, missing strict_types"
event: PreToolUse
match_tool: Write,Edit
---

# Laravel Convention Guard

Antes de permitir a escrita/edicao de um arquivo PHP em projeto Laravel, verifique as convencoes abaixo. Se alguma violacao for encontrada, BLOQUEIE a operacao e explique o problema.

## Regras de Bloqueio (MUST FIX)

### 1. Services Pattern Proibido
Se o arquivo esta sendo criado em `app/Services/` ou a classe contem `Service` no nome:
- **BLOQUEIE**: "Use Actions pattern em vez de Services. Crie em app/Actions/ seguindo lorisleiva/laravel-actions. Veja skill architecture."

### 2. env() Fora de Config
Se o codigo contem `env(` e o arquivo NAO esta em `config/`:
- **BLOQUEIE**: "Nunca use env() fora de config/. Use config() para acessar valores de configuracao."

### 3. Credenciais Hardcoded
Se o codigo contem strings que parecem API keys, tokens, senhas ou secrets:
- **BLOQUEIE**: "Credenciais hardcoded detectadas. Use variaveis de ambiente via config()."

## Regras de Aviso (SHOULD FIX)

### 4. DB Facade
Se o codigo contem `DB::` (exceto em migrations):
- **AVISE**: "Prefira Model::query() em vez de DB:: facade para manter type-safety e scopes."

### 5. Strict Types Ausente
Se o arquivo PHP nao contem `declare(strict_types=1)`:
- **AVISE**: "Adicione declare(strict_types=1) no inicio do arquivo."

### 6. Controller com Logica de Negocio
Se um Controller (arquivo em `app/Http/Controllers/`) contem mais de 20 linhas em um metodo:
- **AVISE**: "Controllers devem ser thin. Extraia logica de negocio para Actions."

### 7. Nomenclatura Incorreta
Verifique naming conventions:
- Controllers devem terminar em `Controller`
- Actions devem terminar com verbo (ex: `CreateUser`, `UpdateOrder`)
- Models devem ser singular PascalCase
- Se incorreto: **AVISE** com o nome correto

## Aplicacao

- Aplique APENAS a arquivos PHP em projetos Laravel (verifique se existe `artisan` na raiz)
- NAO aplique a arquivos de teste (pasta `tests/`)
- NAO aplique a migrations (pasta `database/migrations/`)
- NAO aplique a arquivos de config (pasta `config/`)
