# Shell Migration Pass 001 Inventory

This directory contains historical migration candidates, not canonical shell modules.

## Audit Results

| Staged file | Purpose (summary) | Decision | Notes |
| --- | --- | --- | --- |
| `apps-bin-path.sh` | Add `/snap/bin`, set `XDG_DATA_DIRS` defaults | Deferred | Linux distro bootstrap behavior; evaluate against `modules/environment.sh` later. |
| `backup-container.sh` | Docker/devcontainer image backup | Deferred | Container backup workflow, not shell bootstrap core. |
| `backup.sh` | Docker volume/config backup | Deferred | Operational script; separate container tooling migration. |
| `cb` | Clipboard helper | Removed | Duplicates canonical `shell/bin/cb`. |
| `check_health.sh` | Homelab service health checks | Deferred | Host-specific service checks. |
| `colors.sh` | ANSI color helpers | Removed | Duplicates canonical `shell/lib/core/colors.sh`. |
| `devcontainer.sh` | VS Code devcontainer CLI wrapper | Deferred | Version-pinned extension path; needs redesign. |
| `devtools.sh` | Dev tool installer script | Deferred | Overlaps with staged `setup-asdf`; keep for future consolidation. |
| `encrypt_volume.sh` | gocryptfs wrapper | Deferred | Host path assumptions need portability guards. |
| `environment.sh` | dotenv wrapper | Removed | Canonical environment behavior lives in `shell/modules/environment.sh`. |
| `freeze-apt` | Reproducible apt snapshot metadata | Deferred | Linux-only packaging flow, not yet integrated. |
| `freeze-github-release` | Release archive checksum generation | Deferred | Useful utility, pending module/command fit. |
| `generate-password` | Password generation CLI | Removed | Duplicates canonical `shell/bin/generate-password`. |
| `generate-pwa-icons` | Generate favicon/PWA icon assets | Deferred | Project build utility, not shell bootstrap. |
| `get_pdf_title.py` | PDF title extraction | Deferred | Python dependency-heavy utility; separate migration. |
| `ghlabels` | GitHub label management | Deferred | Candidate for standalone automation command. |
| `git-summary.sh` | Git activity reporting | Deferred | Reporting utility, not shell bootstrap core. |
| `github-latest-release` | Latest release metadata fetch | Deferred | Potentially overlaps `freeze-github-release`. |
| `is-executable` | Command/path executability check | Removed | Promoted as canonical `shell/bin/is-executable`. |
| `is-macos` | macOS detection | Removed | Duplicates `os::is_macos` in `shell/lib/core/os.sh`. |
| `json-pretty` | jq JSON formatter | Deferred | Candidate command migration in later pass. |
| `list-fonts` | Cross-platform font listing | Deferred | Desktop environment utility. |
| `list-packages` | APT package inventory | Deferred | Linux-specific package script. |
| `megalinter.sh` | MegaLinter wrapper | Deferred | Tooling command candidate; requires normalization. |
| `nuke-docker` | Docker cleanup utility | Deferred | Safety-sensitive ops utility; defer. |
| `os.sh` | OS detection helpers | Removed | Duplicates canonical `shell/lib/core/os.sh`. |
| `pandoc_emoji_filter.py` | Pandoc emoji conversion filter | Deferred | Documentation build utility, not shell core. |
| `pipes` | Terminal animation | Deferred | Optional toy utility; no core shell value. |
| `pre-shutdown` | Pre-shutdown host hook | Deferred | User-specific host behavior. |
| `process_files.py` | Experimental document processing abstractions | Deferred | Prototype code, not integrated utility. |
| `record-audio` | Python audio recorder | Deferred | Platform/audio backend specific utility. |
| `reinstall_google_drive.sh` | Reinstall Google Drive on macOS | Deferred | Mac-only workstation maintenance script. |
| `remove_password_pdf` | Remove PDF password via Ghostscript | Deferred | Useful standalone utility candidate. |
| `run_discovery` | GitHub org repo export script | Deferred | External API workflow script. |
| `set-sys-uid-max` | Mutate `/etc/login.defs` UID/GID limits | Deferred | System-mutating Linux admin script. |
| `setup-asdf` | asdf-based dev tool setup | Deferred | Overlaps staged `devtools.sh`; consolidate in later pass. |
| `setup-git-aliases.sh` | Configure git aliases | Deferred | User preference script, not shell bootstrap. |
| `storybook.sh` | Storybook launch wrapper | Deferred | Project-specific frontend helper. |
| `sysinfo` | System info command | Removed | Duplicates canonical `shell/bin/sysinfo`. |
| `system_os` | OS family name output | Removed | Duplicates canonical `shell/lib/core/os.sh`. |
| `tailwind-config-viewer.sh` | Tailwind config viewer wrapper | Deferred | Frontend tooling utility. |
| `uninstall_google_drive.sh` | Uninstall Google Drive on macOS | Deferred | Mac-only workstation maintenance script. |
