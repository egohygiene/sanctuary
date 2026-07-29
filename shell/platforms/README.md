# Platform runtimes

Platform modules are loaded after the shared and shell-specific runtime.

| Runtime | Coverage |
| --- | --- |
| `linux/` | Linux distributions, containers, and WSL; Snap paths and Linux aliases |
| `darwin/` | macOS on Apple Silicon and Intel; Homebrew paths and macOS helpers |
| `windows/` | Best-effort MSYS2/Git Bash environment marker |

Platform modules must be safe to source repeatedly. Destructive operating-system
configuration belongs in an explicit command, never in a login-shell runtime.
