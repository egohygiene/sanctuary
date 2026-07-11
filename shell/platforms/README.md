# platforms

Reserved for operating-system runtime layers (for example `linux/`, `macos/`, `windows/`).

This directory is intentionally scaffolded only. Platform-specific behavior is loaded by
`shell/init/load-platform-runtime.sh` when a runtime module exists.
