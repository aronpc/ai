# Changelog

Todas as mudanças notáveis deste projeto são documentadas aqui.
O formato segue [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/) e o
projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

## [5.0.0] - 2026-06-30

### Added
- `hooks/hooks.json` + 8 scripts shell executáveis em `hooks/scripts/` — antes os hooks eram apenas markdown inerte e nunca disparavam.
- `CLAUDE.md` com instruções para quem contribui no plugin.
- `CHANGELOG.md` e workflow de CI (`.github/workflows/ci.yml`) validando manifests, estrutura e scripts.
- Documentação de intenção dos hooks em `hooks/docs/`.

### Changed
- Manifesto movido para `.claude-plugin/plugin.json`; identidade unificada como `laravel-toolkit`.
- `marketplace.json` sem o array `skills` explícito (auto-descoberta) e com `strict: false`.
- Cross-references entre skills padronizadas para nomes flat (ex.: `architecture`, `testing`).
- Documentação alinhada: namespace de invocação `/laravel-toolkit:`, instalação, compatibilidade (PHP 8.2+, Laravel 11+, Filament 4.x).
- `metadata.version` das 24 skills alinhada ao release.

### Fixed
- `testing`: remove pacote inexistente; usa `pest --parallel` / `php artisan test`.
- `exceptions`: handler em `bootstrap/app.php` (Laravel 11+) e `Log` via import.
- `models`: corrige chave duplicada que impedia a compilação do exemplo.
- `enums`: `Rule::enum` documentado a partir do Laravel 9.23.
- `skill-auto-suggest` (keywords ausentes) e `pre-push-quality-gate` (guarda do `phpstan.neon`).
- Documentação interna: `CLAUDE.md` inexistente, versão divergente, `strict` incorreto e estrutura desatualizada.

### Removed
- 24 command wrappers redundantes que colidiam com as skills no namespace.
- `prompts.md` (dump auto-gerado de outro projeto, ~545 KB) e `scripts/migrate-skills.sh` (stub sem implementação).

## [4.0.0] - 2026-03

### Changed
- Marketplace simplificado para plugin único; command wrappers para autocomplete.

## [3.0.0] - 2026-02

### Changed
- Reestruturação das skills para formato flat (sem namespaces).

## [2.0.0] - 2026-02

### Changed
- Reestruturação semântica com namespaces (revertida na 3.0.0).

## [1.0.0] - 2026-01

### Added
- Primeira versão com as skills iniciais.
