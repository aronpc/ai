# Plan Structure Schema

Schema JSON completo para `implementation_plan.json`.

---

## Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["spec_id", "workflow_type", "phases", "verification_strategy"],
  "properties": {
    "spec_id": {
      "type": "string",
      "description": "ID da especificação relacionada"
    },
    "workflow_type": {
      "type": "string",
      "enum": ["feature", "refactor", "investigation", "migration", "simple"],
      "description": "Tipo de workflow"
    },
    "title": {
      "type": "string",
      "description": "Título do plano"
    },
    "description": {
      "type": "string",
      "description": "Descrição geral do plano"
    },
    "phases": {
      "type": "array",
      "items": {
        "$ref": "#/definitions/phase"
      }
    },
    "verification_strategy": {
      "$ref": "#/definitions/verification_strategy"
    },
    "context": {
      "type": "object",
      "properties": {
        "affected_files": {
          "type": "array",
          "items": {"type": "string"}
        },
        "dependencies": {
          "type": "array",
          "items": {"type": "string"}
        },
        "risks": {
          "type": "array",
          "items": {"type": "string"}
        }
      }
    },
    "metadata": {
      "type": "object",
      "properties": {
        "created_at": {"type": "string", "format": "date-time"},
        "updated_at": {"type": "string", "format": "date-time"},
        "author": {"type": "string"},
        "estimated_effort": {
          "type": "string",
          "enum": ["trivial", "small", "medium", "large", "complex"]
        }
      }
    }
  },
  "definitions": {
    "phase": {
      "type": "object",
      "required": ["id", "name", "subtasks"],
      "properties": {
        "id": {"type": "integer", "minimum": 0, "maximum": 7},
        "name": {"type": "string"},
        "description": {"type": "string"},
        "subtasks": {
          "type": "array",
          "items": {"$ref": "#/definitions/subtask"}
        }
      }
    },
    "subtask": {
      "type": "object",
      "required": ["id", "title", "status"],
      "properties": {
        "id": {"type": "string", "pattern": "^st-\\d+-\\d+$"},
        "title": {"type": "string"},
        "description": {"type": "string"},
        "status": {
          "type": "string",
          "enum": ["pending", "in_progress", "completed", "blocked", "skipped"]
        },
        "files": {
          "type": "array",
          "items": {"type": "string"}
        },
        "verification": {"type": "string"},
        "notes": {"type": "string"},
        "blocked_by": {"type": "string"},
        "completed_at": {"type": "string", "format": "date-time"}
      }
    },
    "verification_strategy": {
      "type": "object",
      "required": ["type"],
      "properties": {
        "type": {
          "type": "string",
          "enum": ["command", "api", "browser", "e2e", "manual", "none"]
        },
        "command": {"type": "string"},
        "expected_output": {"type": "string"},
        "timeout_ms": {"type": "integer"},
        "base_url": {"type": "string"},
        "endpoints": {"type": "array"},
        "steps": {"type": "array"},
        "checklist": {"type": "array"},
        "note": {"type": "string"}
      }
    }
  }
}
```

---

## Exemplo Completo

```json
{
  "spec_id": "spec-add-user-profile",
  "workflow_type": "feature",
  "title": "Add User Profile Feature",
  "description": "Implement user profile page with avatar upload and bio editing",
  "phases": [
    {
      "id": 0,
      "name": "Pre-Planning",
      "subtasks": [
        {
          "id": "st-0-1",
          "title": "Load spec and understand requirements",
          "status": "completed",
          "completed_at": "2024-01-15T10:00:00Z"
        },
        {
          "id": "st-0-2",
          "title": "Review existing user model",
          "status": "completed",
          "files": ["src/models/User.ts"]
        }
      ]
    },
    {
      "id": 1,
      "name": "Analysis",
      "subtasks": [
        {
          "id": "st-1-1",
          "title": "Map affected files",
          "status": "completed",
          "files": [
            "src/models/User.ts",
            "src/api/users.ts",
            "src/components/Profile.tsx"
          ]
        },
        {
          "id": "st-1-2",
          "title": "Check file upload patterns",
          "status": "completed",
          "notes": "Use existing S3 upload utility"
        }
      ]
    },
    {
      "id": 3,
      "name": "Implementation",
      "subtasks": [
        {
          "id": "st-3-1",
          "title": "Add avatar and bio fields to User model",
          "status": "in_progress",
          "files": ["src/models/User.ts", "prisma/schema.prisma"]
        },
        {
          "id": "st-3-2",
          "title": "Create profile update API endpoint",
          "status": "pending",
          "files": ["src/api/users.ts"]
        },
        {
          "id": "st-3-3",
          "title": "Build profile UI component",
          "status": "pending",
          "files": ["src/components/Profile.tsx"]
        },
        {
          "id": "st-3-4",
          "title": "Add avatar upload with S3",
          "status": "pending",
          "files": ["src/utils/upload.ts"]
        }
      ]
    },
    {
      "id": 4,
      "name": "Testing",
      "subtasks": [
        {
          "id": "st-4-1",
          "title": "Add unit tests for profile API",
          "status": "pending",
          "files": ["tests/api/users.test.ts"]
        },
        {
          "id": "st-4-2",
          "title": "Test avatar upload flow",
          "status": "pending"
        }
      ]
    }
  ],
  "verification_strategy": {
    "type": "browser",
    "base_url": "http://localhost:3000",
    "steps": [
      "Navigate to /profile",
      "Upload avatar image",
      "Edit bio text",
      "Save changes",
      "Verify profile updated"
    ]
  },
  "context": {
    "affected_files": [
      "src/models/User.ts",
      "src/api/users.ts",
      "src/components/Profile.tsx",
      "prisma/schema.prisma"
    ],
    "dependencies": ["S3 bucket for avatars"],
    "risks": ["Large file uploads", "Image processing edge cases"]
  },
  "metadata": {
    "created_at": "2024-01-15T09:00:00Z",
    "updated_at": "2024-01-15T10:30:00Z",
    "author": "auto-claude",
    "estimated_effort": "medium"
  }
}
```

---

## Status Transitions

```
pending → in_progress → completed
                   ↘ blocked → pending
                   ↘ skipped
```

### Status Definitions

| Status | Descrição |
|--------|-----------|
| `pending` | Ainda não iniciado |
| `in_progress` | Sendo trabalhado |
| `completed` | Finalizado com sucesso |
| `blocked` | Bloqueado por dependência |
| `skipped` | Não será implementado |
