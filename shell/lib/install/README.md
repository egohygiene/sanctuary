# install runtime

Sanctuary's installer runtime lives in `shell/lib/install/`, and the executable
installer entrypoints now live in `shell/bin/`.

## Installer families

The shell installers currently cluster into a small set of repeated patterns:

- GitHub release downloads with platform and architecture detection
- package manager installs (`apt`, `brew`, `pip`, and future distro-specific backends)
- source builds with checksum verification, extraction, install, and cleanup

That duplication now funnels through the shared install runtime in this
directory.

## Runtime layout

```text
shell/lib/install/
├── README.md           # installer runtime overview
├── runtime.sh          # shared entrypoint for installers
├── platform.sh         # OS and architecture mapping
├── package-manager.sh  # package manager detection
├── download.sh         # network fetch helpers with retries
├── checksum.sh         # SHA-256 / SHA-512 verification
├── archive.sh          # raw, tar.gz, tar.xz, and zip extraction
├── filesystem.sh       # temp directories, install, cleanup
└── github.sh           # GitHub Releases orchestration
```

## Thin-wrapper contract

Installers in `shell/bin/` should describe metadata and leave workflow details
to the runtime:

- tool name
- GitHub owner and repository
- release asset template
- platform and architecture mapping
- optional checksum asset
- optional archive member to install

## Runtime-backed wrappers

The following installer entrypoints currently use the shared runtime:

- `install-dust`
- `install-eza`
- `install-shfmt`
- `install-typos`

These wrappers intentionally stay small so that future migrations can reuse the
same runtime without re-implementing download, checksum, extraction, install,
logging, or cleanup behavior.
