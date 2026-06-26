# Extraction Candidates — Sanctuary Platform

> **Status:** Initial audit — June 2026
> **Parent document:** [Architecture Audit](audit.md)
>
> **Important:** This document identifies potential future extractions only. No extraction should be performed as a result of this audit. Each identified extraction requires a separate, scoped implementation issue.

---

## Classification Definitions

| Classification | Meaning |
|---|---|
| **Remain in Sanctuary** | Tightly coupled to Sanctuary's platform identity; extraction would fragment without benefit |
| **Possible extraction** | Could stand alone eventually, but dependencies and maturity need more work first |
| **Likely extraction** | Self-contained enough that extraction is a clear future benefit; lower coupling to the rest of Sanctuary |
| **Should remain internal** | Governance or identity material that is inherently repository-specific |

---

## Extraction Candidates

### `shell/` — Likely Extraction

**Current state:** A modular, testable shell framework with a core library, extension library, module loader, CLI utilities, and Bats test suite.

**Self-containedness:** High. `shell/` has no hard dependencies on other Sanctuary directories. It depends only on standard POSIX/Bash and optional external tools (`openssl`, `gh`, `tree`).

**Potential standalone name:** `egohygiene/shell` or similar.

**Extraction prerequisites:**
- Define a clear public API (which files are "stable" entry points).
- Establish a versioning strategy (semantic version tags).
- Verify all shell tests pass independently.
- Determine how downstream consumers (`.devcontainer/`, `workstation/`) would reference the extracted library (e.g., git submodule, package manager, curl-install).

**Risk:** Low. The shell library is already well-structured. The primary risk is breaking `.devcontainer/` and `workstation/` if they have implicit path-based dependencies on `shell/` being co-located.

**Recommendation:** Target this extraction after Phase 2 consolidation (resolving staging shell script overlap).

---

### `skills/` — Likely Extraction

**Current state:** A large library (80+ skills) of GitHub Copilot CLI skill prompts, each in its own subdirectory with a `SKILL.md`.

**Self-containedness:** Very high. Skills are Markdown prompts with no runtime dependencies on any other Sanctuary code.

**Potential standalone name:** `egohygiene/copilot-skills` or `egohygiene/skills`.

**Extraction prerequisites:**
- Resolve the triplication between `skills/`, `.agents/skills/`, and `.github/skills/`. Decide which location is authoritative; use symlinks or a build step for the others.
- Establish a versioning or tagging strategy for the skills library.
- Update GitHub Copilot CLI configuration to point to the extracted repository.

**Risk:** Low. Skills are purely declarative. The main risk is the triplication issue creating drift between locations.

**Recommendation:** Consolidation (resolving triplication) should precede extraction. Extraction after Phase 1.

---

### `automation/make/` — Possible Extraction

**Current state:** A composable GNU Make library with modules for OS detection, color output, project utilities, and common patterns.

**Self-containedness:** High. Pure Makefile — no external runtime dependencies.

**Potential standalone name:** `egohygiene/makelib` or similar.

**Extraction prerequisites:**
- Determine how other repositories would consume the library (submodule, `curl | bash`, copy-on-create).
- Define a versioning strategy for Make modules.
- Verify that current Sanctuary `Taskfile.yml` references are not tightly coupled to a specific path.

**Risk:** Low-medium. GNU Make include paths are path-sensitive. Extraction requires a defined distribution strategy.

**Recommendation:** Extract only after the shell library extraction proves the distribution model.

---

### `templates/` — Possible Extraction

**Current state:** Project scaffolding templates for React Vite, Python Poetry, changesets, community governance, and paper authoring.

**Self-containedness:** Medium. Templates themselves are self-contained, but the collection is sparse and would benefit from more coverage before becoming a standalone offering.

**Potential standalone name:** `egohygiene/templates` or as part of a broader `egohygiene/scaffold` tool.

**Extraction prerequisites:**
- Expand template coverage to justify a standalone repository.
- Decide on a template rendering strategy (raw copy vs. scaffold tooling like Cookiecutter or Plop).
- Evaluate whether the community governance template (`GOVERNANCE.md`) belongs here or in a separate governance repository.

**Risk:** Low. Templates have no runtime coupling. Risk is primarily organizational.

**Recommendation:** Possible extraction in Phase 4 after coverage is expanded.

---

### `garden/` — Possible Extraction

**Current state:** A personal knowledge garden implemented as an Obsidian vault with Quartz publishing integration.

**Self-containedness:** High. The garden is functionally independent of all other Sanctuary components. It is tied to this repository primarily for convenience.

**Potential standalone name:** `egohygiene/garden` or `egohygiene/knowledge`.

**Extraction prerequisites:**
- Determine whether the garden is meant to be a personal repository or an organizational one.
- Separate personal journal/health notes from organizational knowledge if both categories exist.
- Verify Quartz publishing integration can operate from a standalone repository.

**Risk:** Low. The garden has no dependencies on other Sanctuary directories.

**Recommendation:** Possible extraction if the garden grows beyond what is appropriate for an engineering platform repository. The current embedding is acceptable given the garden's small size.

---

## Directories That Should Remain in Sanctuary

### `assets/`

Assets are the most foundational layer. Extracting them would create a trivial dependency that adds complexity without benefit. Keep in Sanctuary; reference from other directories.

### `workstation/`

Workstation configuration is tightly coupled to the specific tooling and hardware context of Sanctuary's primary users. It is implementation-specific, not reusable in isolation.

### `.devcontainer/`

The Dev Container is the containerized representation of Sanctuary's platform. It must stay co-located with the platform configuration it references.

### `lint/`

MegaLinter configuration is highly coupled to the specific Sanctuary repository structure and technology mix. It is not generic enough to stand alone as a library.

### `docs/`

Documentation is intrinsically tied to this repository's identity and GitHub Pages deployment. It should not be extracted.

---

## Directories That Should Remain Internal

### `.github/`

GitHub-native configuration (workflows, issue templates, CODEOWNERS, Copilot instructions) is inherently repository-specific. While individual workflow _patterns_ can be extracted as reusable Actions, the `.github/` directory itself belongs in Sanctuary.

---

## Summary Table

| Directory | Classification | Extraction Priority |
|---|---|---|
| `shell/` | Likely extraction | High — after Phase 2 |
| `skills/` | Likely extraction | High — after Phase 1 consolidation |
| `automation/make/` | Possible extraction | Medium — after shell extraction |
| `templates/` | Possible extraction | Low — after coverage expansion |
| `garden/` | Possible extraction | Low — only if needed |
| `assets/` | Remain in Sanctuary | — |
| `workstation/` | Remain in Sanctuary | — |
| `.devcontainer/` | Remain in Sanctuary | — |
| `lint/` | Remain in Sanctuary | — |
| `docs/` | Remain in Sanctuary | — |
| `.github/` | Should remain internal | — |

---

## Evidence

- `shell/lib/core/shell.sh` — Shell library core, self-contained
- `shell/tests/` — Bats tests show standalone testability
- `skills/` — 80+ skill directories; purely Markdown
- `.agents/skills/` — Duplicate skill location
- `.github/skills/` — Third skill location
- `automation/make/Makefile` — Pure GNU Make, no runtime deps
- `automation/make/README.md` — Existing documentation
- `templates/applications/react-vite/` — Template structure
- `garden/quartz/` — Publishing integration
- `REUSE.toml` — License compliance per-file tracking
