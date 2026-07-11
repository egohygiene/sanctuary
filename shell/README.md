# shell

Canonical Sanctuary shell bootstrap and utility library.

## Architecture

```text
shell/
├── bin/             # User-facing commands exposed on PATH
├── init/            # Bootstrap entrypoints and orchestration
├── lib/core/        # Runtime detection primitives and compatibility libraries
├── lib/extensions/  # Optional integrations loaded on demand
├── runtime/         # Shared and shell-specific runtime layers
├── modules/         # Higher-level environment modules
├── platforms/       # Reserved for future OS-specific runtime layers
└── tests/           # Bats coverage for bootstrap, modules, and commands
```

## Bootstrap flow

1. `shell/.shellrc` resolves `EGOHYGIENE_SHELL_ROOT`.
2. `shell/init/load-core.sh` performs deterministic runtime staging:
   - environment detection (`EGOHYGIENE_RUNTIME_ENVIRONMENT`)
   - OS detection (`lib/core/os.sh`)
   - shell detection (`lib/core/shell.sh`)
   - shared runtime (`runtime/shared/runtime.sh`)
   - shell runtime (`runtime/shells/<shell>/runtime.sh`)
3. `shell/init/load-platform-runtime.sh` loads an optional future platform runtime.
4. `shell/init/load-extensions.sh` loads optional extensions.
5. `shell/init/bootstrap.sh` applies the canonical module order:
   `xdg → environment → tooling → history → privacy → cache`.
6. Shell-specific code is guarded by the detected runtime:
   - `lib/core/shell.sh` identifies the active shell as `bash`, `zsh`, or `unknown`
   - `runtime/shells/bash/runtime.sh` loads Bash-only helpers
   - shell-specific modules only load when a matching file exists in `modules/`

## Fish shell

Fish shell is supported through a standalone Fish-native runtime that does not
use the Bash bootstrap path.

```text
runtime/shells/fish/
├── runtime.fish        # Entry point — source from ~/.config/fish/config.fish
├── conf.d/             # Auto-loaded configuration fragments
├── functions/          # Fish functions
└── completions/        # Fish completions
```

See [`runtime/shells/fish/README.md`](runtime/shells/fish/README.md) for
integration instructions and a full migration summary.

## Portability notes

- The bootstrap is intended to be sourced from Bash or Zsh.
- XDG directories default under `$HOME` and are created on demand.
- The existing XDG module keeps runtime, config, data, cache, and state directories portable across local shells and devcontainer sessions.
- Container-aware behavior is exposed through `os::is_container`, so devcontainers can share the canonical bootstrap without requiring a separate shell tree.

## Validation

Run the shell audit checks from the repository root:

```bash
shellcheck shell/**/*.sh shell/bin/* || true
bats shell/tests || true
```
