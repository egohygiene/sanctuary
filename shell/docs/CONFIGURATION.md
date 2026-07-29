# Configuration

All switches are optional and may be exported before sourcing `.shellrc`.

| Variable | Default | Effect |
| --- | --- | --- |
| `EGOHYGIENE_DISABLE_TELEMETRY` | `1` | Enables environment-based telemetry opt-outs |
| `EGOHYGIENE_DISABLE_UPDATE_CHECKS` | `0` | Suppresses selected update checks and notifications |
| `EGOHYGIENE_ENABLE_PROJECT_PATH` | `0` | Adds the startup directory's `bin/` and `node_modules/.bin` |
| `EGOHYGIENE_ENABLE_SAFETY_ALIASES` | `0` | Adds interactive `cp`, `mv`, and `rm` aliases |
| `EGOHYGIENE_ENABLE_EXPERIMENTAL` | `0` | Loads `modules/experimental.sh` when present |
| `EGOHYGIENE_HISTORY_SIZE` | `50000` | Sets Bash, Zsh, database, and REPL history limits |
| `EGOHYGIENE_SHELL_DEBUG` | `0` | Enables runtime debug diagnostics |
| `XDG_BIN_HOME` | `$HOME/.local/bin` | User-owned executable destination |

Existing environment values win. For stateful tools, the runtime also detects
legacy locations such as `~/.docker`, `~/.aws`, and `~/.gnupg`. It will not
redirect those tools to an empty XDG directory. Run `shell-doctor` after
sourcing the runtime to see migration warnings.

Suppressing update checks is intentionally independent from disabling
telemetry:

```bash
export EGOHYGIENE_DISABLE_TELEMETRY="1"
export EGOHYGIENE_DISABLE_UPDATE_CHECKS="0"
source "/path/to/shell/.shellrc"
```
