---
description: "Detects missing tenant scoping in Models, Actions and Controllers to prevent data leaks in multi-tenant apps"
event: PreToolUse
match_tool: Write,Edit
---

# Tenancy Safety Check

Antes de escrever/editar codigo em projetos Laravel multi-tenant, verifique se o tenant scoping esta correto para prevenir vazamento de dados entre tenants.

## Deteccao de Multi-Tenancy

Primeiro, verifique se o projeto usa multi-tenancy:
1. Busque por `tenant_id` em migrations
2. Busque por `BelongsToTenant`, `HasTenant`, ou trait de tenancy
3. Busque por middleware de tenant ou pacotes como `stancl/tenancy`, `spatie/laravel-multitenancy`

Se o projeto NAO usa multi-tenancy, NAO aplique este hook.

## Verificacoes (apenas para projetos multi-tenant)

### 1. Models sem Tenant Scope

Se um Model esta sendo criado/editado em `app/Models/`:
- Verifique se a tabela tem `tenant_id` (busque na migration correspondente)
- Se tem `tenant_id`, o Model DEVE ter:
  - Trait de tenant scoping (ex: `BelongsToTenant`)
  - OU global scope que filtra por tenant
  - OU `$fillable` incluindo `tenant_id` com relacao definida
- Se FALTANDO: **AVISE** "Este Model pertence a um tenant mas nao tem scoping configurado. Adicione a trait BelongsToTenant ou um global scope."

### 2. Queries sem Tenant Filter

Se codigo em Actions ou Controllers contem queries:
- `Model::all()` em model com tenant → **AVISE**: "Query sem filtro de tenant. Use o scope de tenant ou filtre por tenant_id."
- `Model::find($id)` sem verificacao de tenant → **AVISE**: "Verifique se o registro pertence ao tenant atual."
- `Model::where(...)` sem `tenant_id` em model com tenant → **AVISE**

### 3. Policies sem Verificacao de Tenant

Se uma Policy esta sendo criada/editada:
- Verifique se os metodos de autorizacao comparam o `tenant_id` do recurso com o tenant do usuario
- Se FALTANDO: **AVISE** "Policy deve verificar se o recurso pertence ao tenant do usuario."

## Comportamento

- NAO bloqueie - apenas avise (developer pode ter razoes para queries cross-tenant)
- Aplique APENAS a arquivos em `app/Models/`, `app/Actions/`, `app/Http/Controllers/`, `app/Policies/`
- NAO aplique a commands, seeders, ou admin panels que podem precisar de acesso cross-tenant
- Se nao conseguir determinar se o projeto e multi-tenant, nao emita nada
