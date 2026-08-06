# Ego Hygiene Task System

The root `Taskfile.yml` is intentionally a routing table. Reusable behavior
lives in focused modules beneath `.engineering/tasks`, and complex shell logic
lives in `.engineering/scripts`.

## Architecture

| Module | Namespace | Responsibility |
| --- | --- | --- |
| `project.yml` | Flattened | Default listing, version, platform, and core doctor tasks |
| `app.yml` | Flattened | Flutter setup, dependencies, generation, checks, tests, runs, and builds |
| `agents.yml` | `agents:` | OpenCode, Ollama, model, and Mindcap operations |
| `copilot.yml` | `copilot:` | Copilot hook validation and tests |
| `git.yml` | `git:` | Read-only Git inspection helpers |
| `lint.yml` | `lint:` | MegaLinter orchestration and descriptor subsets |
| `security.yml` | `security:` | Host-security auditing with Lynis |

The project and application modules are flattened so existing commands such as
`task test`, `task generate`, and `task ci:local` continue to work. Specialized
operations stay namespaced, such as `task lint:changed` and
`task agents:doctor`.

## Core commands

```console
task
task --list
task version
task doctor
task platform
task setup
task ci:local
```

Use `task --summary TASK_NAME` for the longer safety or usage notes attached to
a task.

## Safety conventions

- Public tasks have descriptions and appear in `task --list`.
- Shared validation helpers are marked `internal` and remain hidden.
- Destructive reset behavior requires `CONFIRM_RESET=yes`.
- Cleanup runs from the verified Flutter application directory.
- Host-specific build tasks use Task's `platforms` support and are skipped on
  incompatible systems.
- Includes are required. Missing committed modules are treated as configuration
  failures rather than silently ignored.
- Task controls color automatically; the root no longer forces color into logs.
- Security and quality reports are written beneath `.engineering/reports`.

## Adding a module

Create `.engineering/tasks/example.yml`:

```yaml
---
# yaml-language-server: $schema=https://taskfile.dev/schema.json

version: "3"

tasks:
  doctor:
    desc: Validate the example toolchain
    preconditions:
      - sh: command -v example >/dev/null 2>&1
        msg: example is not installed or is not available on PATH.
    cmds:
      - example --version
```

Then add one line to the root include table:

```yaml
includes:
  example: ".engineering/tasks/example.yml"
```

The task becomes `task example:doctor`.

Use `flatten: true` only for intentional root-level project commands. Ordinary
tool or domain modules should retain a namespace.

## Variable overrides

Paths and pinned tool versions use Task's `default` function, allowing a caller
or CI job to override them:

```console
task lint:all MEGALINTER_VERSION=v9
task test APP_DIR=/absolute/path/to/app
```

## References

- [Task documentation](https://taskfile.dev/docs/)
- [Task include guide](https://taskfile.dev/docs/guide#including-other-taskfiles)
- [Task schema reference](https://taskfile.dev/docs/reference/schema)
- [Task style guide](https://taskfile.dev/docs/styleguide)

