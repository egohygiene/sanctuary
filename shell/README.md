# shell

Canonical Sanctuary shell bootstrap and utility library.

## Architecture

```text
shell/
├── bin/             # User-facing commands exposed on PATH
├── init/            # Bootstrap entrypoints and orchestration
├── lib/core/        # Minimal reusable primitives and runtime detection
├── lib/extensions/  # Optional integrations loaded on demand
├── modules/         # Higher-level environment modules
└── tests/           # Bats coverage for bootstrap, modules, and commands
```

## Bootstrap flow

1. `shell/.shellrc` resolves `EGOHYGIENE_SHELL_ROOT`.
2. `shell/init/init.sh` loads core libraries, optional extensions, and the module loader.
3. `shell/init/bootstrap.sh` applies the canonical module order:
   `xdg → environment → tooling → history → privacy → cache`.
4. Shell-specific code is guarded by the detected runtime:
   - `lib/core/shell.sh` identifies the active shell as `bash`, `zsh`, or `unknown`
   - `lib/core/bash.sh` loads only for Bash sessions
   - shell-specific modules only load when a matching file exists in `modules/`

## Portability notes

- The bootstrap is intended to be sourced from Bash or Zsh.
- XDG directories default under `$HOME` and are created on demand.
- `XDG_RUNTIME_DIR` falls back to `/run/user/<uid>`, `TMPDIR`, or `/tmp`, which keeps local Linux, macOS, and devcontainer sessions working with the same entrypoint.
- Container-aware behavior is exposed through `os::is_container`, so devcontainers can share the canonical bootstrap without requiring a separate shell tree.

## Validation

Run the shell audit checks from the repository root:

```bash
shellcheck shell/**/*.sh shell/bin/* || true
bats shell/tests || true
```
