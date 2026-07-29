# Legacy migration record

The former `.todo/` staging tree was fully resolved in version 2.0.0.

| Legacy source | Resolution |
| --- | --- |
| `aliases` | Curated into `modules/aliases.sh` and platform alias modules |
| `apps-bin-path.sh` | Integrated into `platforms/linux/runtime.sh` |
| `.data` | Valid XDG exports integrated into `modules/tooling.sh` |
| `.environment` | Safe persistent actions became `telemetry-opt-out` |
| `disable-telemetry.sh`, `toptout` | Consolidated into `modules/privacy.sh` and `telemetry-opt-out` |
| `install_pyenv.sh` | Rebuilt as `install-pyenv` |
| `apt_install_package_list.sh` | Rebuilt as cross-platform `install-packages` |
| `list_package_versions.sh` | Rebuilt as cross-platform `list-package-versions` |
| `90-banner.sh`, `banner.txt` | Rebuilt as `shell-banner`; asset moved to `assets/` |
| `.macos` | Preserved as non-executable `platforms/darwin/legacy/defaults.sh` |

The following scripts were rejected and removed because integrating them would
make the library capable of silently destroying a host:

- recursive deletion of `sudo`, `su`, ownership tools, and other core commands;
- deletion of system cron directories;
- purging APT and recursively deleting paths whose names contain `apt`.

Obsolete duplicate ImageMagick, Lynis, and PDAL installers were removed in
favor of their maintained extensionless commands. The old Google Cloud script
was removed because it used the retired `apt-key` workflow.
