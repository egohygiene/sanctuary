# EgoHygiene shell

A portable, XDG-first shell runtime and CLI library for macOS, Linux, WSL,
containers, and Git Bash/MSYS.

## Install

Clone or copy this directory somewhere stable, then source the appropriate
entrypoint.

Bash:

```bash
source "/absolute/path/to/shell/.shellrc"
```

Zsh:

```zsh
source "/absolute/path/to/shell/.shellrc"
```

Fish:

```fish
set -gx EGOHYGIENE_SHELL_ROOT "/absolute/path/to/shell"
source "$EGOHYGIENE_SHELL_ROOT/runtime/shells/fish/runtime.fish"
```

Run the health check after installation:

```bash
shell-doctor --deep
```

## Architecture

```text
shell/
├── assets/           # Optional user-facing assets
├── bin/              # Standalone commands and installers
├── docs/             # Architecture, configuration, and migration notes
├── init/             # Bash/Zsh bootstrap orchestration
├── lib/core/         # Detection and reusable shell primitives
├── lib/install/      # Shared installer framework
├── modules/          # Cross-platform environment policy
├── platforms/        # Linux, macOS, and Git Bash/MSYS adapters
├── runtime/shells/   # Bash, Zsh, POSIX, and Fish runtime layers
└── tests/            # Bats integration and unit tests
```

See [architecture](docs/ARCHITECTURE.md) and
[configuration](docs/CONFIGURATION.md) for the layer contracts and feature
switches.

## Key behavior

- Correct XDG config, cache, data, state, and runtime directories.
- Deterministic, deduplicated PATH with user tools before system tools.
- No implicit current-directory or project-local PATH injection.
- XDG locations for major language, package, cloud, infrastructure, database,
  editor, Android, and media ecosystems.
- Existing stateful tool data is never hidden by an automatic redirect.
- Native Bash, Zsh, and Fish behavior with OS-specific adapters.
- Telemetry opt-outs enabled by default; update checks remain enabled by
  default.
- XDG-state shell, REPL, database, debugger, and pager histories.

## New maintenance commands

```bash
shell-doctor --deep
telemetry-opt-out --list
telemetry-opt-out --dry-run
install-packages --dry-run packages.txt
list-package-versions --format json
install-pyenv --dry-run
shell-banner
```

The original utility commands remain in `bin/`, including `cspell-dicts`,
`inject-subtitles`, `vpn-toggle`, `vscode-language-ids`, media tools, GitHub
helpers, and installer commands.

## Installer framework

Runtime-backed GitHub release installers share platform mapping, retries,
checksums, extraction, XDG destinations, and dry runs:

```bash
install-shfmt --dry-run
install-eza --version "0.23.0"
install-dust --install-dir "${XDG_BIN_HOME:-$HOME/.local/bin}"
```

Specialized source-build installers remain standalone because their dependency
and build flows are materially different. See
[`lib/install/README.md`](lib/install/README.md).

## Development

```bash
task syntax
task lint
task test
task doctor
task check
```

The `.todo/` staging directory has been retired. Its resolution is recorded in
[the migration log](docs/TODO-MIGRATION.md).
