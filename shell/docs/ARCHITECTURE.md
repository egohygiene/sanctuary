# Architecture

The shell system separates policy from runtime syntax and operating-system
behavior.

```text
.shellrc
└── init/
    ├── core detection and shared libraries
    ├── shell runtime: Bash or Zsh
    ├── shared modules: XDG, environment, tooling, aliases, history, privacy
    └── platform runtime: Linux, Darwin, or Windows/MSYS
```

Fish uses `runtime/shells/fish/runtime.fish` and native `.fish` fragments. It
does not parse Bash.

## Boundaries

| Layer | Owns | Must not own |
| --- | --- | --- |
| `lib/core/` | Side-effect-light detection and reusable functions | User preferences |
| `modules/` | Cross-platform environment policy | OS-only commands |
| `runtime/shells/` | Shell options, syntax, functions, completions | OS assumptions |
| `platforms/` | OS paths and platform-only helpers | Shared policy |
| `lib/install/` | Download, checksum, extraction, and installation primitives | Tool metadata |
| `bin/` | User-facing commands and thin installer entrypoints | Login-shell side effects |

## Portability tiers

- Tier 1: Bash 3.2+ and Zsh 5+ on Linux and macOS.
- Tier 1: Fish 3+ through its native runtime.
- Tier 2: Bash under WSL, containers, and devcontainers.
- Tier 3: MSYS2/Git Bash. Native PowerShell is not a shell-runtime target.
- POSIX `sh` is used for selected executable scripts and libraries, but the
  interactive `.shellrc` intentionally rejects it.

## Safety rules

- Login startup never installs packages, prompts, invokes sudo, or mutates
  operating-system preferences.
- Only existing directories are added to PATH, except the user-owned XDG bin
  directory, which is created during bootstrap.
- The current directory is never on PATH by default.
- Stateful tools are not redirected away from existing legacy data.
- Telemetry opt-outs and update-check suppression are separate policies.
- Destructive system-hardening commands require dedicated, explicit CLIs.
