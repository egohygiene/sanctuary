# Responsibility Matrix — Sanctuary Platform

> **Status:** Initial audit — June 2026
> **Parent document:** [Architecture Audit](audit.md)

This matrix maps every major responsibility area in Sanctuary to a classification and an ownership recommendation. It is intended to make architectural boundaries explicit and to guide future scoping decisions.

---

## Classification Definitions

| Classification | Meaning |
|---|---|
| **Foundational** | Core infrastructure that other Sanctuary areas depend on; must be stable before other areas can be extracted or evolved |
| **Shared** | Cross-cutting concerns that support multiple consumers but are not the primary identity of Sanctuary |
| **Implementation-specific** | Configuration or code tied to a specific platform, operating system, or tool |
| **Historical** | Material that existed in a prior repository and has not yet been formally integrated or classified |
| **Candidate for extraction** | Could eventually become its own standalone repository under the Ego Hygiene organization |

---

## Responsibility Areas

### Engineering Infrastructure

| Sub-area | Directory | Classification | Notes |
|---|---|---|---|
| GNU Make library | `automation/make/` | Foundational | Reusable across repositories; stable API surface |
| Task runner | `Taskfile.yml`, `.taskfile/` | Foundational | Wraps make and common workflows |
| GitHub Actions workflows | `.github/workflows/` | Foundational | Drives CI/CD for all repository activity |
| Custom GitHub Actions | `.github/actions/` | Foundational | Composite actions for reuse across workflows |
| Dependency management | `.github/dependabot.yml` | Foundational | Automated dependency updates |
| License compliance | `REUSE.toml`, `.github/workflows/reuse.yml` | Foundational | REUSE SPDX compliance enforcement |
| CodeQL analysis | `.github/codeql.yml` | Foundational | Static security analysis |

---

### Workstation Configuration

| Sub-area | Directory | Classification | Notes |
|---|---|---|---|
| Linux system configuration | `workstation/linux/` | Implementation-specific | Tied to specific Linux distributions and hardware |
| macOS configuration | `workstation/macos/` | Implementation-specific | Tied to macOS and Homebrew |
| Cross-platform shell config | `workstation/shared/shell/` | Shared | Terminal config shared across OS types |
| Cross-platform terminal tools | `workstation/shared/` | Shared | `alacritty`, `aria2`, `readline` configs |

---

### Shell Framework

| Sub-area | Directory | Classification | Notes |
|---|---|---|---|
| Shell runtime detection | `shell/lib/core/shell.sh` | Foundational | Required for all other shell modules |
| Core shell library | `shell/lib/core/` | Foundational | Colors, guards, logging, OS detection, time |
| Extension shell library | `shell/lib/extensions/` | Shared | History, privacy, XDG, caching, tooling |
| Module loader | `shell/lib/modules.sh` | Foundational | Loads shell modules |
| Shell modules | `shell/modules/` | Shared | Optional capability modules |
| Bootstrap scripts | `shell/init/` | Foundational | Entry points for shell initialization |
| Shell utilities | `shell/bin/` | Shared | Standalone CLI tools |
| Shell test suite | `shell/tests/` | Foundational | Bats-based tests for shell library |

---

### Developer Environment

| Sub-area | Directory | Classification | Notes |
|---|---|---|---|
| Dev Container specification | `.devcontainer/devcontainer.json` | Foundational | Primary container environment definition |
| Container image | `.devcontainer/Dockerfile` | Foundational | Base image for the development container |
| Container compose | `.devcontainer/devcontainer.yml` | Foundational | Multi-service compose configuration |
| Container lifecycle scripts | `.devcontainer/scripts/` | Foundational | Setup and initialization scripts |

---

### Project Templates

| Sub-area | Directory | Classification | Notes |
|---|---|---|---|
| React Vite application template | `templates/applications/react-vite/` | Candidate for extraction | Could become part of a standalone `templates` repository |
| Python Poetry template | `templates/poetry/` | Shared | Reusable Python project bootstrap |
| Changeset templates | `templates/changesets/` | Shared | Changelog and versioning templates |
| Community governance template | `templates/community/GOVERNANCE.md` | Shared | Standardized governance documentation |
| Research paper template | `templates/paper/` | Shared | LaTeX/document paper template |

---

### Reusable Assets

| Sub-area | Directory | Classification | Notes |
|---|---|---|---|
| Emoji assets | `assets/emojis/` | Foundational | Large canonical emoji set; sourced from GitHub emoji data |
| Font assets | `assets/fonts/` | Foundational | Developer fonts |
| Gitignore templates | `assets/gitignore/` | Shared | Language-specific `.gitignore` templates; partially mirrors upstream `github/gitignore` |
| License texts | `assets/licenses/` | Foundational | Common open-source license text files |
| Shields/badges | `assets/shields/` | Shared | Repository badge assets |
| Terminal configuration | `assets/terminal/` | Implementation-specific | Terminal-specific assets |
| Windows assets | `assets/windows/` | Implementation-specific | Windows-specific configurations |

---

### Documentation

| Sub-area | Directory | Classification | Notes |
|---|---|---|---|
| Documentation site | `docs/` | Foundational | MkDocs Material site published to GitHub Pages |
| Architecture documentation | `docs/architecture/` | Foundational | This audit and related documents |
| Generated intelligence | `docs/generated/` | Shared | Auto-generated repository tree and visualization |
| Copilot documentation | `docs/copilot/` | Shared | GitHub Copilot configuration documentation |
| MkDocs site configuration | `mkdocs.yml` | Foundational | Site structure, themes, and extensions |

---

### Knowledge Garden

| Sub-area | Directory | Classification | Notes |
|---|---|---|---|
| Obsidian vault | `garden/` | Shared | Personal knowledge base integrated into docs site |
| Quartz integration | `garden/quartz/` | Shared | Static site generator for garden publishing |
| Note templates | `garden/templates/` | Shared | Obsidian-compatible note templates |

---

### AI Skills

| Sub-area | Directory | Classification | Notes |
|---|---|---|---|
| Root skills library | `skills/` | Candidate for extraction | Large library of Copilot skills; potential standalone repository |
| Agent skills | `.agents/skills/` | Candidate for extraction | Duplicate of `skills/`; consolidation needed first |
| GitHub-native skills | `.github/skills/` | Foundational | Skills registered with GitHub Copilot CLI |
| Copilot instructions | `.github/copilot-instructions.md` | Foundational | Repository-level AI context |

---

### Linting and Quality

| Sub-area | Directory | Classification | Notes |
|---|---|---|---|
| MegaLinter configuration | `lint/config/` | Foundational | Per-language linting rules |
| MegaLinter invocation | `scripts/megalinter.sh` (root `scripts/`) | Foundational | Entry point for local linting |
| Action linting | `.github/actionlint.yaml` | Foundational | Validates GitHub Actions workflow syntax |

---

### Repository Governance

| Sub-area | Directory/File | Classification | Notes |
|---|---|---|---|
| Code ownership | `.github/CODEOWNERS` | Foundational | Defines review requirements |
| Issue templates | `.github/ISSUE_TEMPLATE/` | Foundational | Standardized issue creation |
| Pull request template | `.github/PULL_REQUEST_TEMPLATE.md` | Foundational | Standardized PR description |
| Contributing guide | `CONTRIBUTORS.md` | Foundational | Contributor onboarding |
| Code of conduct | `CODE_OF_CONDUCT.md` | Foundational | Community behavior standards |
| Support documentation | `SUPPORT.md` | Foundational | Contributor support information |
| Funding configuration | `.github/FUNDING.yml` | Shared | Optional sponsor links |

---

### Historical Material

| Sub-area | Directory | Classification | Notes |
|---|---|---|---|
| Legacy GitHub Actions | `.staging/realignment/actions/` | Historical | Review for merge into `.github/workflows/` |
| Legacy Dev Container | `.staging/realignment/devcontainer/` | Historical | Review for merge into `.devcontainer/` |
| Application source | `.staging/realignment/egohygiene/` | Historical | Move to product repository |
| Flutter code | `.staging/realignment/flutter-foundation/` | Historical | Move to product repository |
| Homelab config | `.staging/realignment/homelab-private/` | Historical | Move to private infrastructure repository |
| LaTeX config | `.staging/realignment/latex/` | Historical | Evaluate merge with `templates/paper/` |
| Legacy Linux config | `.staging/realignment/linux/` | Historical | Evaluate merge with `workstation/linux/` |
| Miscellaneous configs | `.staging/realignment/misc/` | Historical | Per-item evaluation required |
| Obsidian template | `.staging/realignment/obsidian/` | Historical | Evaluate merge with `garden/templates/` |
| Research papers | `.staging/realignment/papers/` | Historical | Archive in separate private repository |
| Legacy shell scripts | `.staging/realignment/scripts/` | Historical | Evaluate per-script against `shell/bin/` |
| Task files | `.staging/realignment/tasks/` | Historical | Evaluate merge with root `Taskfile.yml` |
| Universal app configs | `.staging/realignment/universal/` | Historical | Evaluate merge with `workstation/shared/` |
| Website source | `.staging/realignment/website/` | Historical | Move to web product repository |

---

## Evidence

- `automation/make/Makefile` — Make library entry point
- `automation/make/README.md` — Library documentation
- `.github/workflows/` — All CI/CD workflow definitions
- `shell/lib/core/shell.sh` — Shell runtime detection
- `shell/init/load-core.sh` — Bootstrap entry point
- `.devcontainer/devcontainer.json` — Dev Container spec
- `workstation/linux/` — Linux workstation directories
- `workstation/macos/homebrew/` — macOS Homebrew config
- `templates/applications/react-vite/` — Application template
- `skills/` — Copilot skills library (root)
- `.agents/skills/` — Agents skills directory
- `.github/skills/` — GitHub-native skills
- `lint/config/` — MegaLinter config directories
- `.staging/realignment/` — Historical material
- `REUSE.toml` — License compliance
- `CODE_OF_CONDUCT.md`, `CONTRIBUTORS.md`, `SUPPORT.md` — Governance documents
