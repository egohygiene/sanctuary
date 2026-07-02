# Modernization Report — Sanctuary Platform

> **Status:** Initial audit — June 2026
> **Parent document:** [Architecture Audit](audit.md)
>
> **Important:** This report identifies modernization opportunities only. No changes are performed as part of this audit.

---

## Summary

| Area | Opportunity | Priority |
|---|---|---|
| Skills consolidation | Resolve triplication; establish single source of truth | High |
| Dev Container Features | Adopt modular Dev Container Features for composable capabilities | High |
| Shell staging cleanup | Process legacy scripts from `.staging/` into `shell/bin/` or discard | High |
| MkDocs navigation | Enable explicit `nav:` configuration | Medium |
| Python tooling | Verify alignment with Poetry 2.x conventions | Medium |
| Knowledge garden publishing | Evaluate Quartz v4 maturity vs alternatives | Medium |
| Node workspace | Evaluate pnpm workspace justification | Low |
| Gitignore sync | Automate synchronization with upstream `github/gitignore` | Low |
| Action versions | Audit workflow action version pinning | Medium |
| Linting breadth | Review MegaLinter config for rule scope and performance | Low |

---

## Detailed Findings

### 1. Skills Consolidation (High)

**Current state:** GitHub Copilot skills exist in three locations — `skills/`, `.agents/skills/`, `.github/skills/` — with no documented single source of truth.

**Problem:** Any update to a skill requires updating it in all three locations. Without automation, the locations will drift. New contributors cannot determine where to add new skills.

**Modernization opportunity:**

- Designate `skills/` as the authoritative source.
- Introduce a build step or CI workflow that automatically propagates skills to `.github/skills/` and `.agents/skills/` from the canonical source.
- Alternatively, use filesystem symlinks if the deployment model allows.
- Document the chosen strategy in `skills/README.md` and `.github/copilot-instructions.md`.

**Blocking:** Must be resolved before extracting `skills/` as a standalone library (see [Extraction Candidates](extraction-candidates.md)).

---

### 2. Dev Container Features Adoption (High)

**Current state:** The `.devcontainer/` setup uses a custom Dockerfile (`Dockerfile`) for environment construction. The `.staging/realignment/devcontainer/` contains `features/` and `variants/` directories that were not carried forward into the active configuration.

**Problem:** A monolithic Dockerfile is harder to compose and reuse than modular Dev Container Features. The Dev Container Features specification (available since 2022, widely adopted in 2023–2024) enables capability modules that can be composed declaratively in `devcontainer.json`.

**Modernization opportunity:**

- Review the staged `features/` directory for capabilities worth extracting.
- Convert recurring Dockerfile patterns (e.g., tool installations, shell setup, dotfile configuration) into standalone Dev Container Features.
- Publish features to OCI registries for reuse across repositories.
- Reference features from `devcontainer.json` rather than building them into the Dockerfile.

**Reference:** [containers.dev/features](https://containers.dev/features)

---

### 3. Shell Staging Cleanup (High)

**Current state:** `.staging/realignment/scripts/` contains a large collection of legacy unstructured shell scripts covering installation, hardening, utilities, and platform-specific automation. These predate the current `shell/` framework.

**Problem:** Legacy scripts do not benefit from the structured logging, error handling, and OS detection in `shell/lib/`. They represent technical debt and potential security risk (e.g., hardcoded paths, missing input validation).

**Modernization opportunity:**

- Audit each script against the current `shell/bin/` inventory.
- For scripts providing unique, still-relevant functionality: migrate to `shell/bin/` using the `shell/lib/` framework.
- For scripts covering capabilities now handled by package managers or modern tooling: discard.
- For scripts that are genuinely historical curiosities: archive with comments rather than deleting.

---

### 4. MkDocs Navigation Configuration (Medium)

**Current state:** `mkdocs.yml` has the `nav:` key commented out (`# nav:`). MkDocs is operating in automatic navigation mode, generating navigation from the file system.

**Problem:** Automatic navigation order is alphabetical by filename. As `docs/` grows, the navigation structure will become less intentional. The architecture documents added in this audit would appear before other content due to alphabetical ordering unless filenames are carefully chosen.

**Modernization opportunity:**

- Uncomment and populate the `nav:` key in `mkdocs.yml`.
- Define explicit section hierarchy: e.g., Overview → Architecture → Copilot → Generated.
- Add navigation entries for new `docs/architecture/` documents.

---

### 5. Python Tooling Alignment (Medium)

**Current state:** `pyproject.toml` uses the `[tool.poetry]` section and `poetry.toml` with a local virtualenv. Poetry 2.x was released in 2024 with significant changes to configuration conventions.

**Problem:** If `pyproject.toml` was written against Poetry 1.x conventions, some fields may behave differently under Poetry 2.x. Specifically, Poetry 2.x changed the behavior of `dynamic` fields and the group dependency specification.

**Modernization opportunity:**

- Run `poetry check` to validate the current configuration.
- Review the `[tool.poetry.dependencies]` section against Poetry 2.x migration notes.
- Update `pyproject.toml` to use `[project]` standard metadata where compatible.

---

### 6. Knowledge Garden Publishing (Medium)

**Current state:** `garden/quartz/` integrates Quartz for garden publishing. The version of Quartz in use is not confirmed from the audit.

**Quartz versions:**
- Quartz v3: Older, Hugo-based pipeline.
- Quartz v4: Major rewrite (2023), uses a custom Vite-based pipeline. More active maintenance. Breaking change from v3.

**Problem:** If `garden/quartz/` is on Quartz v3, upgrading to v4 requires a migration. Staying on v3 means using an increasingly outdated publishing pipeline.

**Modernization opportunity:**

- Confirm the Quartz version in use.
- If on v3, plan a migration to v4.
- Evaluate whether Quartz v4 publishing meets the garden's publishing requirements or whether an alternative (e.g., Obsidian Publish, static export via MkDocs) better fits the overall documentation strategy.

---

### 7. Node/pnpm Workspace Evaluation (Low)

**Current state:** `pnpm-workspace.yaml` and `package.json` establish a pnpm workspace at the repository root. The `package.json` references `private: true` and the workspace structure is minimal.

**Problem:** A pnpm workspace at the root creates a `node_modules/` installation expectation and `pnpm-lock.yaml` for a repository that is primarily a platform configuration repository rather than a JavaScript application. The added complexity is only justified if there are multiple active Node.js workspaces consuming shared dependencies.

**Modernization opportunity:**

- Audit which directories under `templates/` or `garden/` justify the pnpm workspace.
- If only one workspace exists (e.g., `templates/applications/react-vite/`), evaluate whether a root-level pnpm workspace is necessary or whether the template should be standalone.
- If the workspace is intended to grow, document which future packages it will contain.

---

### 8. Gitignore Upstream Synchronization (Low)

**Current state:** `assets/gitignore/` contains language-specific gitignore templates. These are likely sourced from the `github/gitignore` repository but have no mechanism to receive upstream updates.

**Problem:** Gitignore templates accumulate new entries as ecosystems evolve (new build tools, IDEs, caches). A static copy will become stale.

**Modernization opportunity:**

- Add a Dependabot configuration for `assets/gitignore/` that syncs from upstream, or
- Replace the static copy with a reference to the canonical GitHub API endpoint used by `shell/bin/ghignore`.
- Document the provenance of each file.

---

### 9. GitHub Actions Version Pinning (Medium)

**Current state:** GitHub Actions workflows in `.github/workflows/` reference actions with version tags (e.g., `actions/checkout@v7`).

**Problem:** Version tags (e.g., `@v7`) point to a mutable tag; the underlying commit can change. Best practice for security is to pin actions to a specific commit SHA.

**Modernization opportunity:**

- Audit all action references in `.github/workflows/`.
- Pin each action to an immutable commit SHA alongside a human-readable version comment.
- Configure Dependabot to keep pinned SHA versions current.

**Reference:** GitHub Security Hardening documentation; `actionlint` (already configured via `.github/actionlint.yaml`).

---

### 10. MegaLinter Configuration Review (Low)

**Current state:** `lint/config/` contains per-language MegaLinter configuration for over 50 languages and platforms.

**Problem:** A broad linting configuration runs many linters that may not apply to the current repository contents. This increases CI runtime and creates noise from false-positive findings in irrelevant language categories.

**Modernization opportunity:**

- Audit which language linters are actively used vs which are inherited from MegaLinter defaults.
- Disable or adjust linters for languages not present in the repository.
- Review the MegaLinter version in use; MegaLinter v8 introduced significant changes from v7.

---

## Deprecated Tooling Inventory

| Tool/Pattern | Status | Notes |
|---|---|---|
| Legacy shell scripts in `.staging/` | Deprecated | Superseded by `shell/lib/` and `shell/bin/` |
| Unstructured Dockerfile configuration | Outdated | Dev Container Features preferred |
| MkDocs auto-navigation | Outdated convention | Explicit `nav:` preferred for growing docs |
| Mutable action version tags | Security risk | Immutable SHA pinning preferred |

---

## Evidence

- `skills/` — Root skills directory
- `.agents/skills/` — Duplicate skills location
- `.github/skills/` — Third skills location
- `.devcontainer/Dockerfile` — Monolithic Dockerfile
- `.staging/realignment/devcontainer/features/` — Unused staged features
- `.staging/realignment/scripts/` — Legacy shell scripts
- `mkdocs.yml` — `# nav:` commented out
- `pyproject.toml` — Poetry configuration
- `poetry.toml` — Local virtualenv configuration
- `garden/quartz/` — Quartz publishing integration
- `pnpm-workspace.yaml` — Root-level pnpm workspace
- `package.json` — Root Node package definition
- `assets/gitignore/` — Static gitignore template collection
- `.github/workflows/` — Action version references
- `lint/config/` — MegaLinter language configuration directories
- `.github/actionlint.yaml` — Action linting configuration
