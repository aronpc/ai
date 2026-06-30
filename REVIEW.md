# Review Completo — Plugin `laravel-toolkit` (Claude Code)

**Data:** 2026-06-30
**Escopo:** Conformidade com a spec oficial do Claude Code, qualidade/consistência das 24 skills, e auditoria de agents, hooks, commands e documentação.
**Método:** Análise direta do repositório + 3 revisões especializadas paralelas (conformidade, conteúdo de skills, auditoria meta), com verificação de evidências `arquivo:linha`.

---

## Veredicto

> **O plugin NÃO instala/funciona corretamente como está** — há **3 problemas estruturais bloqueantes**. O **conteúdo das skills é bom em substância**, mas o conjunto está comprometido por **cross-references quebradas, inconsistências de versão e documentação meta que afirma coisas falsas** (um `CLAUDE.md` que não existe, 8 hooks "100% completos" que nunca executam, `strict: true` que na verdade é `false`).

| Dimensão | Estado |
|---|---|
| Estrutura do plugin (instalação) | 🔴 Não conforme — 3 bloqueantes |
| Identidade/nomes | 🔴 Tríplice e contraditória |
| Hooks | 🔴 Inertes (documentação decorativa) |
| Documentação meta (README/IMPLEMENTATION/CHECKPOINT) | 🔴 Afirmações falsas |
| Cross-references entre skills | 🔴 Quebradas em 19/24 |
| Conteúdo técnico das skills | 🟡 Bom, com alguns bugs e leaks de projeto |
| Commands (24) | 🟢 Consistentes (porém redundantes com skills) |
| Referências internas (`references/*.md`) | 🟢 Todas as 36 existem |

**Inventário:** 24 skills · 24 commands · 5 agents · 8 hooks · 1 script · repo 1,5 MB (dos quais `prompts.md` = 545 KB ≈ 36%).

---

## P0 — Bloqueantes (impedem o plugin de funcionar)

### P0.1 — `plugin.json` está no lugar errado
- **Atual:** `/plugin.json` (raiz). `.claude-plugin/` contém **apenas** `marketplace.json`.
- **Spec:** o manifest precisa estar em **`.claude-plugin/plugin.json`** (`code.claude.com/docs/en/plugins`). O Claude Code procura o manifest ali na descoberta; na raiz ele não é encontrado.
- **Correção:** `mv plugin.json .claude-plugin/plugin.json`.
- **Contexto histórico:** o git mostra que esse arquivo oscilou entre raiz e `.claude-plugin/` em ~14 commits de 2026-03-25, terminando num `revert` que o deixou na raiz. O revert foi motivado por uma limitação do **Desktop** ("External plugin sources are not yet supported"), **não** por um problema de estrutura — ou seja, o local foi deixado errado por engano.

### P0.2 — Identidade tríplice e namespace quebrado
Três nomes diferentes para o mesmo plugin:
- `plugin.json:2` → `"name": "aronpc"`
- `.claude-plugin/marketplace.json:2` → marketplace `"name": "aronpc-skills"`
- `marketplace.json:13` → plugin interno `"name": "laravel-toolkit"` ← **este é o que o runtime usa** (skills carregam como `laravel-toolkit:<skill>`)

Consequência: o README manda invocar `/aronpc:architecture` e `claude plugin add aronpc/ai` (`README.md:103,106,170-180`), mas o namespace real é **`/laravel-toolkit:architecture`**. Os exemplos do README **não funcionam**. Falta ainda `version` no `plugin.json`.

- **Correção:** escolher **um** nome (recomendado: `laravel-toolkit`), propagar para `plugin.json` + `marketplace.json` (plugin interno) + todos os exemplos do README, e adicionar `"version"` ao `plugin.json`.

### P0.3 — Os 8 hooks são markdown inerte (nunca executam)
- Os arquivos `hooks/*.md` usam um frontmatter **inventado** (`event:`, `match_tool:`) que nenhum loader reconhece. **Não existe** `hooks/hooks.json` nem `settings.json`, e nem `plugin.json`/`marketplace.json` mencionam hooks.
- **Spec:** hooks só disparam se registrados em JSON (`hooks/hooks.json`) no formato `hooks > EVENTO > [{ matcher, hooks: [{ type, command }] }]` (`code.claude.com/docs/en/hooks`).
- **Impacto:** **zero guardrails ativos** — nenhum bloqueio de anti-pattern, nenhuma limpeza de atribuição AI, nenhum quality-gate de push, nenhum carregamento de contexto de sprint. Tudo isso é hoje texto decorativo.
- **Correção (escolher uma):**
  - **(a) Implementar de verdade:** criar `hooks/hooks.json` com `type: "command"` apontando para scripts shell reais (ex.: `pre-push-quality-gate` → roda `pint`/`phpstan`/`pest`; `laravel-convention-guard` → grep de padrões). Mover os `.md` atuais para `hooks/docs/` como especificação.
  - **(b) Ser honesto:** remover a alegação de que os hooks estão "implementados/100%" e marcá-los como "projetados, pendente de wiring".

---

## P1 — Afirmações falsas e inconsistências (corrigir junto com P0)

| # | Problema | Evidência | Correção |
|---|---|---|---|
| P1.1 | **`CLAUDE.md` não existe**, mas é citado como entregue | `README.md:160`, `IMPLEMENTATION.md:186`, `CHECKPOINT.md:54` | Criar o `CLAUDE.md` **ou** remover as 3 menções |
| P1.2 | **Versão divergente**: `4.0.0` (marketplace) vs `v5.0.0` (CHECKPOINT/IMPLEMENTATION) vs sem versão (plugin.json) | `marketplace.json:9`, `CHECKPOINT.md:1`, `IMPLEMENTATION.md:3` | Definir fonte única de verdade |
| P1.3 | **`strict: true` documentado, mas real é `false`** | `IMPLEMENTATION.md:174` vs `marketplace.json:16` | Corrigir a doc |
| P1.4 | **Estrutura documentada ≠ real** (README desenha `.claude-plugin/plugin.json`) | `README.md:147-148`, `IMPLEMENTATION.md:173` | Atualizar após mover o arquivo (P0.1) |
| P1.5 | **Cross-references quebradas em 19/24 skills** (~53 ocorrências): rodapés "Referências Cruzadas" e "Quando NÃO usar" usam nomes mortos (`laravel-architecture`, `laravel-testing-pest`, `spec-creation`, `github-pr-review`, `laravel-filament`…) | ex. `architecture:337-340`, `models:714-717`, `roadmap:42-43`, `qa:48-50` | Find/replace em massa para os nomes flat reais; remover `laravel-filament` (skill inexistente) |
| P1.6 | **Inconsistência de versões de stack** entre skills: `architecture`/`cicd` dizem PHP 8.5/Laravel 12; 9 outras dizem PHP 8.2/Laravel 11+; `enums` diz 8.1 | `architecture:5,44`, `cicd:63`, `models`, `testing` etc. | Padronizar a matriz de compatibilidade |
| P1.7 | **README se autocontradiz sobre Filament**: "3.x/4.x" vs "Filament 5" na mesma página | `README.md:35` vs `:66` | Unificar; **verificar se Filament 5 já existe** antes de fixar (Filament 4 é a base conhecida) |
| P1.8 | **Contagens "orquestra N skills" erradas em 4 de 5 agents** | `bugfix` (diz 7, tem 8), `refactor-safe` (diz 7, tem 5), `sprint-executor` (diz 7, tem 6), `pr-guard` (diz 6, tem 3) | Recontar ou listar as skills em vez de um número |

> **Nota factual:** em 2026-06, **PHP 8.5 e Laravel 12 existem**. O problema de P1.6/P1.7 **não** é "versão inexistente" — é a **inconsistência interna** e a auto-contradição do README. A única versão a confirmar manualmente é **Filament 5**.

---

## P2 — Qualidade de conteúdo das skills

### Bugs de código (o exemplo não funciona / está desatualizado)
| Skill | Linha | Problema | Correção |
|---|---|---|---|
| `testing` | 492 | `composer require pestphp/pest-plugin-parallel` — **pacote inexistente** | Paralelismo é nativo: `./vendor/bin/pest --parallel` |
| `testing` | 497-499 | `use Pest\Parallel\Paratest; Paratest::process();` — **API inventada** | Remover o bloco |
| `testing` | 505,554,557 | `php artisan pest` — **comando inexistente** | `./vendor/bin/pest` ou `php artisan test` |
| `exceptions` | 325-328 | Estende `Foundation\Exceptions\Handler` / `app/Exceptions/Handler.php` — **removido no Laravel 11+** | Reescrever para `bootstrap/app.php` `->withExceptions(...)` |
| `models` | 325-327 | **Chave `{` duplicada** — não compila como mostrado | Remover a chave extra (versão correta existe em `:555-561`) |
| `enums` | 284 | "Rule::enum (Laravel 10+)" — foi adicionado no **9.23** | Ajustar para "Laravel 9.23+" |
| `exceptions` | 137 | `\Log::warning(...)` com FQN viola o próprio `standards` | `use ...Facades\Log;` + `Log::warning(...)` |

### Leak de projeto específico (SaaS multi-tenant de restaurante)
- **Problema (hardcoded como verdade):** `architecture:44-48` ("Stack: Laravel 12 + React + Inertia + Filament 5") e `architecture:73-81` / `exceptions:54-71` apresentam a árvore `app/` de **um SaaS específico** (`Business/`, `Tenant/`, `Billing/`, `Menu/`, `Order/`) como se fosse a estrutura canônica de "projetos Laravel".
- **Aceitável:** usar `Tenant`/`Business` como **exemplos** dentro de seções "Exemplo" (`actions`, `models`, `i18n`, `testing`, `ux`).
- **Correção:** generalizar a "Stack" e a árvore de diretórios para placeholders (`Domain1/`, `Domain2/`), mantendo o concreto só nos exemplos.

### Editorial / estrutura
- `architecture:66-67` — **linha literalmente duplicada** ("Commands são registrados automaticamente de `app/Console/Commands/`").
- `exceptions:358-372` — itens "NÃO FAÇA" listados sob o heading `✅ FAÇA` (falta o heading `❌ NÃO FAÇA`).
- `standards` se autocontradiz sobre sufixo `Enum`: regra "sem sufixo" (`:465`) vs exemplo `BusinessTypeEnum` (`:325`); idem `i18n:287`.
- **Progressive disclosure:** `models` (723), `i18n` (624), `ux` (622), `realtime` (611) são longas e **não têm** `references/` — candidatas a extrair exemplos longos para `references/`.

### Ruído no repositório
- **`prompts.md` (545 KB, 17.432 linhas)** é um dump auto-gerado de **outro projeto** ("Auto Claude", Python — `apps/backend/prompts/`). Não é skill/command/agent/hook, não é referenciado por nada do plugin, não está no `.gitignore`, e infla o repo em ~36%. As skills são, na prática, um **port PT-BR/Laravel desses prompts EN**.
  - **Correção:** remover do pacote distribuível (ou mover para fora e ignorar via `.gitignore`).

---

## P3 — Melhorias estratégicas

1. **`scripts/migrate-skills.sh` é um stub morto** — define o mapa de 24 skills (nomes → namespaces `@laravel/…`) e só faz `echo`. Remover, ou completar se a migração de namespaces for adiante.
2. **`INTEGRATION-MAP.md` e `RESTRUCTURE-PLAN.md` usam nomenclatura morta** (`laravel-architecture`, `roadmap-strategy`, `implementation-coder`…) que não corresponde aos diretórios flat reais. Como os agents mandam "seguir o INTEGRATION-MAP", isso confunde. Atualizar ou marcar como histórico.
3. **Decisão sobre `commands/`** — pela spec, "custom commands foram merged into skills" e skills de plugin já são auto-descobertas como `/plugin:skill`. Os 24 wrappers são **redundantes** (dobram a manutenção). Recomendado **remover** `commands/` após confirmar o namespace; manter só se houver razão deliberada.
4. **Simplificar frontmatter das skills** — `compatibility`, `metadata`, `category` (e provavelmente `allowed-tools`) não fazem parte do schema oficial de skills e tendem a ser ignorados. Reduzir ao essencial (`name` + `description`); confirmar `allowed-tools` antes de remover.
5. **Adicionar `name:` (e opcional `model:`) aos 5 agents** — hoje só têm `description` + `tools`.
6. **CI de validação do próprio plugin** — GitHub Action rodando `claude plugin validate` + lint de frontmatter YAML + checagem de cross-references, para impedir regressões como as de P1.5.
7. **Versionamento real** — `CHANGELOG.md` + alinhar versão do plugin × versão das skills (hoje todas `1.0.0` vs plugin `4.0.0`).
8. **Reintegrar `filament-check-pro`** (removida; branch `feat/filament-check-pro-skill`) — pendência aberta no CHECKPOINT.
9. **Decisão de produto: genérico vs projeto-específico** — se o objetivo é distribuição pública, vale separar o conhecimento genérico de Laravel do conhecimento do SaaS de restaurante do autor.

---

## Roadmap de execução

**Fase 1 — Desbloquear (P0, ~30 min):**
1. `mv plugin.json .claude-plugin/plugin.json`
2. Unificar nome → `laravel-toolkit` em `plugin.json` + `marketplace.json`; adicionar `version`
3. Decidir hooks: criar `hooks/hooks.json` real **ou** rebaixar as alegações
4. Validar: `claude plugin validate` / instalar via CLI e testar `/laravel-toolkit:architecture`

**Fase 2 — Verdade na documentação (P1, ~1 h):**
5. Criar `CLAUDE.md` ou remover menções; corrigir versão única; corrigir `strict`; atualizar árvore do README e exemplos de invocação `/laravel-toolkit:`
6. Find/replace em massa das cross-references (19 arquivos)
7. Padronizar matriz de compatibilidade; resolver contradição Filament
8. Corrigir contagens dos agents

**Fase 3 — Conteúdo (P2, ~2-3 h):**
9. Corrigir os 7 bugs de código (testing, exceptions, models, enums)
10. Generalizar leaks de projeto em `architecture`/`exceptions`
11. Limpezas editoriais; mover `prompts.md` para fora; extrair `references/` das skills longas

**Fase 4 — Estratégico (P3, contínuo):**
12. CI de validação, CHANGELOG, decidir sobre `commands/` e namespaces, reintegrar filament-check-pro

---

## Pontos fortes (o que está bom)

- As 24 skills existem com `SKILL.md`, e **todos os 36 `references/*.md` citados existem** — boa higiene de links internos.
- `enums` é exemplar (cobre os 7 traits do archtechx com exemplos idiomáticos); `standards` é fiel às diretrizes Spatie.
- Frontmatter consistente entre as 24 skills; tabelas "Skills Relacionadas" do topo usam nomes corretos.
- Os 24 commands são 1:1 com as skills, template uniforme, sem refs órfãs.
- Skills genéricas (`docs`, `codebase`, `planner`, `roadmap`, `issues`, `workflow`, `pr-review`, `spec`) honram `compatibility: Qualquer projeto` e não vazam o SaaS.

---

## Referências oficiais consultadas

| Tópico | URL |
|---|---|
| Plugins | https://code.claude.com/docs/en/plugins |
| Plugins Reference | https://code.claude.com/docs/en/plugins-reference |
| Hooks | https://code.claude.com/docs/en/hooks |
| Skills | https://code.claude.com/docs/en/skills |
| Subagents | https://code.claude.com/docs/en/sub-agents |
| Marketplaces | https://code.claude.com/docs/en/plugin-marketplaces |
