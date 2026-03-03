# Referência de Validação de Database

Verificações de schema e dados.

## Passos

1. Verificar migrations existentes
2. Verificar aplicação de migrations
3. Schema corresponde aos models
4. Integridade dos dados

## Comandos

| Framework | Comando |
|-----------|---------|
| Django | python manage.py showmigrations |
| Prisma | npx prisma migrate status |
| Laravel | php artisan migrate:status |
| Rails | rails db:migrate:status |
