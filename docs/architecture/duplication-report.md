# Duplication Report — Sanctuary Platform

> **Status:** Initial audit — June 2026
> **Parent document:** [Architecture Audit](audit.md)
>
> **Important:** This report identifies duplication for awareness only. No consolidation is performed as part of this audit.

---

## Summary

| Duplication Area | Severity | Affected Directories |
|---|---|---|
| Skills triplication | High | `skills/`, `.agents/skills/`, `.github/skills/` |
| Shell scripts and shell library | Medium | `shell/bin/`, `shell/lib/`, `.staging/realignment/scripts/`, `.staging/realignment/linux/shell/` |
| Dev Container configuration | Medium | `.devcontainer/`, `.staging/realignment/devcontainer/` |
| Linux system configuration | Medium | `workstation/linux/`, `.staging/realignment/linux/home/`, `.staging/realignment/misc/` |
| Gitignore templates | Low | `assets/gitignore/`, upstream `github/gitignore` |
| Obsidian/knowledge templates | Low | `garden/templates/`, `.staging/realignment/obsidian/` |
| Documentation tooling | Low | `docs/` (MkDocs), `garden/` (Obsidian + Quartz) |

---

## Detailed Findings

### 1. Skills Triplication (High)

GitHub Copilot skills exist in three separate locations within the repository:

**Location 1:** `skills/`

The root-level skills directory. Contains 80+ skill subdirectories, each with a `SKILL.md`. This appears to be the canonical source.

**Location 2:** `.agents/skills/`

An agent-specific skills path. Contains what appears to be the same set of skills as `skills/`. The relationship between `.agents/skills/` and `skills/` is unclear — it is unknown whether this is a copy, a symlink target, or a separate tree.

**Location 3:** `.github/skills/`

The GitHub Copilot CLI-registered skills path. This is the location from which GitHub Copilot CLI loads skills when invoked in this repository.

**Impact:**

- Maintaining skills in all three locations creates a risk of drift — a skill updated in `skills/` may not be reflected in `.github/skills/` or `.agents/skills/`.
- Engineers are unclear which location to modify when creating or updating a skill.
- Storage overhead is multiplied.

**Consolidation recommendation (for a future issue):**

Designate `skills/` as the single source of truth. Use a build step, symlinks, or a CI workflow to propagate skills to `.github/skills/` and `.agents/skills/`. Alternatively, evaluate whether all three paths serve distinct purposes and document the distinction explicitly.

---

### 2. Shell Scripts and Shell Library (Medium)

Shell functionality is spread across multiple locations:

| Location | Contents |
|---|---|
| `shell/bin/` | Curated, named CLI utilities (`cb`, `ghignore`, `ghprotect`, `generate-*`, `is-executable`, `sysinfo`) |
| `shell/lib/core/` | Core library (logging, guards, OS detection, colors) |
| `shell/lib/extensions/` | Extension library (history, privacy, XDG, tooling) |
| `workstation/shared/shell/` | Shell configuration (likely `.bashrc`, `.profile`, or similar dotfiles) |
| `.staging/realignment/scripts/` | Legacy unstructured shell scripts (bash, fish, hardening, install, etc.) |
| `.staging/realignment/linux/shell/` | Legacy Linux shell configuration |

**Impact:**

The active `shell/` directory is well-structured and intentional. The staging material contains legacy scripts that may duplicate capabilities already present in `shell/bin/` or `shell/lib/`. Until `.staging/` is processed, it is impossible to know how much functional overlap exists.

**Consolidation recommendation (for a future issue):**

Audit each script in `.staging/realignment/scripts/` against `shell/bin/` to identify:

- Scripts that duplicate an existing binary in `shell/bin/` → discard staged version.
- Scripts that provide unique functionality → migrate to `shell/bin/`.
- Scripts that are superseded by modern tooling → discard.

---

### 3. Dev Container Configuration (Medium)

| Location | Contents |
|---|---|
| `.devcontainer/` | Active, complete Dev Container configuration (Dockerfile, compose, JSON spec, lifecycle scripts) |
| `.staging/realignment/devcontainer/` | Staged Dev Container config with `features/` and `variants/` directories |

**Impact:**

The staged devcontainer material introduces `features/` and `variants/` that the active `.devcontainer/` does not yet use. These may represent a more modular approach that was not carried forward. Leaving the staged material unprocessed creates uncertainty.

**Consolidation recommendation (for a future issue):**

Review `.staging/realignment/devcontainer/features/` and `variants/`. Determine if any features represent genuinely reusable Dev Container capabilities that should be incorporated into `.devcontainer/` or published as Dev Container Features.

---

### 4. Linux System Configuration (Medium)

| Location | Contents |
|---|---|
| `workstation/linux/` | Active, structured Linux workstation config (audio, Bluetooth, fonts, GPU, systemd, etc.) |
| `.staging/realignment/linux/home/` | Legacy Linux dotfiles |
| `.staging/realignment/linux/shell/` | Legacy Linux shell configuration |
| `.staging/realignment/misc/` | Additional Linux-adjacent miscellaneous configs |

**Impact:**

Configuration relevant to the same platform (Linux) is distributed across at least four locations. Any configuration not migrated from `.staging/` to `workstation/linux/` creates a risk of an incomplete workstation setup.

**Consolidation recommendation (for a future issue):**

Audit each file in `.staging/realignment/linux/` against `workstation/linux/`. Migrate anything unique and not superseded; discard everything that is covered.

---

### 5. Gitignore Templates (Low)

| Location | Contents |
|---|---|
| `assets/gitignore/` | Language-specific `.gitignore` template files |
| Upstream `github/gitignore` | Canonical source for many of the same templates |

**Impact:**

If the templates in `assets/gitignore/` are direct copies of the upstream `github/gitignore` repository, they will drift over time without a mechanism to synchronize with upstream updates.

**Consolidation recommendation (for a future issue):**

Determine the provenance of each file in `assets/gitignore/`. For templates that are pure copies of upstream, consider either:
- Removing them and referencing upstream directly (via `shell/bin/ghignore` which already exists), or
- Adding a Dependabot or automated sync to keep them current.

---

### 6. Obsidian and Knowledge Templates (Low)

| Location | Contents |
|---|---|
| `garden/templates/` | Active Obsidian note templates |
| `.staging/realignment/obsidian/PARA_Starter_Kit_v2/` | Legacy PARA methodology Obsidian starter kit |

**Impact:**

If the PARA Starter Kit contains note templates not yet incorporated into `garden/templates/`, they represent either an opportunity to enrich the garden or material that has been superseded.

**Consolidation recommendation (for a future issue):**

Review the staged PARA Starter Kit. Extract any templates not already present in `garden/templates/`; discard the rest.

---

### 7. Documentation Tooling (Low)

| Location | Purpose |
|---|---|
| `docs/` (MkDocs + Material) | Structured reference documentation published via GitHub Pages |
| `garden/` (Obsidian + Quartz) | Personal knowledge garden with separate Quartz publishing pipeline |

**Impact:**

This is an intentional duality rather than accidental duplication — the two systems serve different audiences and authoring workflows. However, the boundary between what belongs in `docs/` vs `garden/` is not formally defined, which could lead to content placed in the wrong location.

**Recommendation:**

Document the intended distinction:
- `docs/` → Reference documentation for the engineering platform (architecture, conventions, how-to guides).
- `garden/` → Personal knowledge, research notes, reflections, and exploratory content.

---

## Evidence

- `skills/` — 80+ skills directories at repository root
- `.agents/skills/` — Parallel skills directory under agents
- `.github/skills/` — GitHub Copilot CLI skills path
- `shell/bin/` — Curated CLI utilities
- `shell/lib/` — Shell library
- `.staging/realignment/scripts/` — Legacy shell scripts
- `.staging/realignment/linux/shell/` — Legacy Linux shell config
- `.devcontainer/` — Active Dev Container configuration
- `.staging/realignment/devcontainer/` — Staged Dev Container with features
- `workstation/linux/` — Active Linux workstation config
- `.staging/realignment/linux/home/` — Legacy Linux dotfiles
- `assets/gitignore/` — Gitignore template collection
- `shell/bin/ghignore` — Shell utility for fetching gitignore templates
- `garden/templates/` — Active Obsidian note templates
- `.staging/realignment/obsidian/PARA_Starter_Kit_v2/` — Legacy Obsidian kit
