---
name: filament-check-pro
description: Executa filacheck, interpreta resultados e corrige problemas proativamente
license: MIT
compatibility: Requer Filament 4+ e Laravel 11+
metadata:
  author: aronpc
  version: 1.0.0
  category: development
  package: povilas/filament-check-pro
allowed-tools:
  - Read
  - Edit
  - Write
  - Bash
---

# Filament Check Pro

Esta skill **executa**, **interpreta** e **corrige proativamente** os problemas encontrados pelo [Filament Check Pro](https://github.com/povilaskorop/filament-check-pro).

## Comportamento esperado

Quando esta skill é invocada:

1. **Rodar** `php artisan filacheck --detailed`
2. **Entender** a saída e identificar problemas
3. **Corrigir** proativamente os arquivos afetados

## Fluxo de execução

```bash
# 1. Executar análise
php artisan filacheck --detailed

# 2. Tentar auto-fix primeiro
php artisan filacheck --fix --backup

# 3. Para problemas manuais, editar os arquivos diretamente
```

## Interpretação da saída

```
Scanning: /path/to/app/Filament

Deprecated Code
  ✓ deprecated-reactive           # OK, sem problemas
  ✗ deprecated-placeholder (5)    # 5 problemas para corrigir
    /path/to/file.php
      Line 42: The `Placeholder` component is deprecated
        → Use `TextEntry::make()->state()` instead

Performance
  ✗ table-defer-loading (20)     # 20 tabelas sem deferLoading()

Found 36 warning(s).
```

- **✓** = Sem problemas
- **✗ (N)** = N problemas encontrados
- **→** = Sugestão de correção (aplicar proativamente)

## Priorização de correções

1. **Alta prioridade** - Deprecated code (quebra em versões futuras)
2. **Média prioridade** - Performance (N+1 queries, loading)
3. **Baixa prioridade** - Best practices

## Padrões de correção mais comuns

### Placeholder → TextEntry
```php
// Substituir
Placeholder::make('xxx')->content('yyy')
// Por
TextEntry::make('xxx')->state('yyy')
```

### reactive() → live()
```php
// Substituir
->reactive()
// Por
->live()
```

### Adicionar deferLoading()
```php
public function table(Table $table): Table
{
    return $table
        ->columns([...])
        ->deferLoading(); // ADICIONAR ISTO
}
```

### Adicionar eager loading
```php
public function table(Table $table): Table
{
    return $table
        ->modifyQueryUsing(fn (Builder $query) => $query->with(['user', 'category']))
        ->columns([...]);
}
```

## Arquivos comuns com problemas

- `RelationManagers/*.php` → `deferLoading()`, eager loading
- `Resources/*/Schemas/*Form.php` → Components deprecated
- `Widgets/*.php` → Performance de queries
- `resources/views/filament/**/*.blade.php` → Custom theme

## Referências

- [Repositório oficial](https://github.com/povilaskorop/filament-check-pro)
