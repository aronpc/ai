# CLAUDE.md — laravel-toolkit plugin

Instruções para agentes AI que trabalham **neste repositório** (o plugin em si, não os projetos-alvo das skills).

## O que é este repositório

Plugin do Claude Code distribuído via marketplace `aronpc-skills`. Contém **24 skills**, **5 agentes autônomos** e **8 hooks** para desenvolvimento Laravel. O nome do plugin é `laravel-toolkit`; a invocação das skills é `/laravel-toolkit:<skill>`.

## Estrutura

```text
.claude-plugin/
  plugin.json          # Manifesto do plugin (name: laravel-toolkit, version: 5.0.0)
  marketplace.json     # Manifesto do marketplace (name: aronpc-skills, strict: false)
skills/<nome>/
  SKILL.md             # Obrigatório — documentação principal da skill
  references/          # Opcional — documentação de referência adicional
agents/                # Definições dos 5 agentes autônomos
hooks/                 # hooks.json + scripts dos 8 hooks
```

## Convenções

- **Idioma:** todas as skills, agentes e hooks são escritos em PT-BR.
- **Frontmatter mínimo:** cada `SKILL.md` deve ter ao menos `name` e `description`.
- **Nomes flat sem prefixo:** use `architecture`, não `laravel-architecture`. O namespace já é dado pelo plugin (`laravel-toolkit:`).
- **Invocação:** `/laravel-toolkit:<skill>` — ex.: `/laravel-toolkit:architecture`.
- **Matriz de compatibilidade padrão:** PHP 8.2+, Laravel 11+. Declare explicitamente quando diferente.
- **Filament:** referenciar Filament 4.x (não Filament 5).

## Como adicionar uma skill nova

1. Criar diretório `skills/<nome>/`.
2. Criar `skills/<nome>/SKILL.md` com frontmatter `name` + `description` e o conteúdo da skill.
3. Adicionar `"./skills/<nome>"` à lista `skills` em `.claude-plugin/marketplace.json`.
4. A auto-descoberta do marketplace reconhece a skill na próxima instalação.

## Regras

- Não versionar dumps externos ou artefatos gerados por outros projetos (ex.: `prompts.md` de projetos-alvo).
- Não modificar `phpstan.neon` (regra global do workspace).
- Após qualquer mudança estrutural, manter **README.md**, **IMPLEMENTATION.md** e **CHECKPOINT.md** sincronizados com a realidade.
- Hooks vivem em `hooks/hooks.json` + scripts — não apenas como markdown descritivo.
- Instalação do plugin: `/plugin marketplace add aronpc/ai` seguido de `/plugin install laravel-toolkit@aronpc-skills`.
