# Regras Detalhadas do Filament Check Pro

## Todas as Regras Disponíveis

### Deprecated Code

| Regra | Descrição | Severidade |
|-------|-----------|------------|
| `deprecated-reactive` | Uso do método `reactive()` | Alta |
| `deprecated-action-form` | Uso de `form()` em Actions | Alta |
| `deprecated-filter-form` | Uso de Filter Form deprecated | Alta |
| `deprecated-placeholder` | Componente `Placeholder` deprecated | Alta |
| `deprecated-mutate-form-data-using` | Uso de `mutateFormDataUsing()` antigo | Média |
| `deprecated-empty-label` | Uso de `label()` vazio | Baixa |
| `deprecated-forms-set` | Uso de `Forms::set()` deprecated | Alta |
| `deprecated-image-column-size` | Uso de `size()` em ImageColumn | Média |
| `deprecated-notification-action-namespace` | Namespace de Actions em notifications | Baixa |

### Performance

| Regra | Descrição | Impacto |
|-------|-----------|---------|
| `too-many-columns` | Table com >15 colunas | UX |
| `table-defer-loading` | Table sem `deferLoading()` | Alto |
| `table-missing-eager-loading` | Table sem eager loading em relacionamentos | Crítico |
| `large-option-list-searchable` | SelectList grande sem searchable | Médio |

### Best Practices

| Regra | Descrição | Benefício |
|-------|-----------|-----------|
| `string-icon-instead-of-enum` | Usar strings para icons | Compatibilidade |
| `string-font-weight-instead-of-enum` | Usar strings para font-weight | Compatibilidade |
| `unnecessary-unique-ignore-record` | `unique()` desnecessário em updates | Limpeza |
| `custom-theme-needed` | Blade com Tailwind sem tema | UX |

## Exemplos de Correção

### 1. RelationManager com múltiplos problemas

**Antes:**
```php
class PhotosRelationManager extends RelationManager
{
    public function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('title'),
                ImageColumn::make('url')->size(40),
                TextColumn::make('user.name'), // N+1 query
                Placeholder::make('count')
                    ->content(fn () => $this->ownerRecord->photos->count()),
            ]);
    }
}
```

**Depois:**
```php
class PhotosRelationManager extends RelationManager
{
    public function table(Table $table): Table
    {
        return $table
            ->modifyQueryUsing(fn (Builder $query) => $query->with('user'))
            ->deferLoading()
            ->columns([
                TextColumn::make('title'),
                ImageColumn::make('url')->size(40), // Removido se v4+
                TextColumn::make('user.name'),
                TextEntry::make('count')
                    ->state(fn () => $this->ownerRecord->photos->count()),
            ]);
    }
}
```

### 2. Form com components deprecated

**Antes:**
```php
return $form
    ->schema([
        TextInput::make('email')
            ->reactive()
            ->afterStateUpdated(fn ($state, callable $set) => $set('username', Str::slug($state))),
        Placeholder::make('preview')
            ->content(fn (callable $get) => $get('email')),
    ]);
```

**Depois:**
```php
return $form
    ->schema([
        TextInput::make('email')
            ->live()
            ->afterStateUpdated(fn ($state, callable $set) => $set('username', Str::slug($state))),
        TextEntry::make('preview')
            ->state(fn (callable $get) => $get('email')),
    ]);
```

## Cheatsheet de Migração v3 → v4/v5

| v3 | v4/v5 |
|----|-------|
| `->reactive()` | `->live()` |
| `Placeholder::make()` | `TextEntry::make()->state()` |
| `Forms\set()` | `Livewire\wire()->set()` |
| `Icons::*` | `'heroicon-o-*'` |
| `->size()` em ImageColumn | Remover ou usar CSS |
| `->mutateFormDataUsing()` em Resource | Em Create/EditPage |

## Links Úteis

- [Upgrade Guide v4](https://filamentphp.com/docs/4.x/upgrade)
- [Upgrade Guide v5](https://filamentphp.com/docs/5.x/upgrade)
- [Performance Optimization](https://filamentphp.com/docs/3.x/tables/installation#defer-loading)
- [Eager Loading](https://filamentphp.com/docs/3.x/queries/eloquent-relationships)
