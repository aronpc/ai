#!/bin/bash
# Script para atualizar frontmatter das skills

# Mapeamento de nomes antigos para novos
declare -A SKILL_MAP=(
    # Laravel
    ["laravel-architecture"]="@laravel/architecture"
    ["laravel-models"]="@laravel/models"
    ["laravel-enums"]="@laravel/enums"
    ["laravel-exceptions"]="@laravel/exceptions"
    ["laravel-actions-events"]="@laravel/actions"
    ["laravel-i18n"]="@laravel/i18n"
    ["laravel-ux"]="@laravel/ux"
    ["laravel-realtime"]="@laravel/realtime"
    ["laravel-testing-pest"]="@laravel/testing"
    ["laravel-coding-standards"]="@laravel/standards"
    # GitHub
    ["github-pr-review"]="@github/pr-review"
    ["github-issue-analysis"]="@github/issues"
    ["git-workflow-laravel"]="@github/workflow"
    # DevOps
    ["cicd-github-actions"]="@devops/cicd"
    ["mcp-validation"]="@devops/mcp"
    # Planning
    ["sprint-management"]="@planning/sprint"
    ["spec-creation"]="@planning/spec"
    ["implementation-planner"]="@planning/planner"
    ["roadmap-strategy"]="@planning/roadmap"
    # Ideation
    ["codebase-ideation"]="@ideation/codebase"
    ["ui-ux-ideation"]="@ideation/ui-ux"
    # Quality
    ["qa-validation"]="@quality/qa"
    ["documentation-updates"]="@quality/docs"
    # Dev
    ["implementation-coder"]="@dev/coder"
)

echo "Skills mapeadas: ${#SKILL_MAP[@]}"
