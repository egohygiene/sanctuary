# Make Automation Library

Historical Makefile automation utilities.

## Status

Maintenance Mode

Taskfile is the preferred automation interface.

## Purpose

Preserve reusable Makefile patterns and utilities for:

- reference
- migration
- compatibility
- future extraction

## Future

Selected functionality may be migrated into:

- Taskfile
- shell libraries
- GitHub Actions
- devcontainer tooling

## Architecture Review

The library is intentionally modular. `Makefile` is the user-facing entrypoint and
imports `project.mk`, which imports `common.mk`. `common.mk` provides shared
helpers and imports foundational modules.

### Module Inventory and Responsibilities

| Module | Responsibility | Notes |
| --- | --- | --- |
| `Makefile` | Primary targets (`help`, `all`, diagnostics, utility entrypoints) | Entrypoint for manual use |
| `project.mk` | Project-scoped variables and tool wrappers | Environment/tool discovery and task helpers |
| `common.mk` | Shared helper functions and safety checks | Enforces minimum GNU Make version |
| `os.mk` | OS/runtime detection and portability defaults | Sets command abstractions (`RM`, `WHICH`, etc.) |
| `colors.mk` | ANSI color and formatting constants/functions | Output formatting helpers |
| `gmsl.mk` | GNU Make Standard Library helpers | Third-party function library |
| `utils.mk` | Legacy utility module placeholder | Candidate for consolidation |
| `variables.mk` | Legacy variable module placeholder | Candidate for consolidation |

### Dependency Relationships

```text
Makefile
  └── project.mk
      └── common.mk
          ├── os.mk
          ├── colors.mk
          └── gmsl.mk
```

`utils.mk` and `variables.mk` are currently detached from the primary include
chain and are retained for compatibility review.

## Extension Points

- Add new reusable helpers in `common.mk` when they are cross-cutting.
- Add project-specific variables/wrappers in `project.mk`.
- Add user-facing orchestration targets in `Makefile`.
- Prefer `os.mk` for portability shims instead of inlining platform checks.

## Migration Opportunities

The following patterns are good candidates to migrate over time while preserving
the Make library for compatibility:

- **Taskfile**: user-facing orchestration targets and lightweight diagnostics.
- **Shell libraries**: cross-tool helper functions that are not Make-specific.
- **GitHub Actions**: CI-only checks and environment validation tasks.

## Dead Code / Debt Candidates

- `utils.mk` and `variables.mk` are legacy placeholders and should be either:
  - consolidated into a single documented module, or
  - removed after confirming no downstream usage.
- `project.mk` still carries historical project-specific constants that should be
  split into repository-agnostic and project-local layers during migration.

## Future Roadmap

1. Keep Make include paths canonical and self-contained in this directory.
2. Incrementally extract CI-facing tasks to GitHub Actions.
3. Migrate day-to-day developer tasks to Taskfile (while preserving Make parity
   for compatibility).
4. Remove or consolidate detached legacy modules after usage audit.
