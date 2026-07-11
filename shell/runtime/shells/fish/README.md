# Fish Shell Runtime

First-class Fish shell support for the Sanctuary shell platform.

---

## Location

```text
shell/runtime/shells/fish/
├── runtime.fish        # Entry point — source this from ~/.config/fish/config.fish
├── conf.d/
│   ├── environment.fish    # XDG paths, locale, editor, PATH
│   └── abbreviations.fish  # Git and shell abbreviations
├── functions/
│   ├── abbrex.fish         # Expand an abbreviation in a pipeline
│   ├── clear.fish          # clear + greeting
│   ├── fish_greeting.fish  # Minimal startup greeting
│   ├── fish_prompt.fish    # Minimal two-segment prompt
│   ├── ls.fish             # ls with colour
│   └── week.fish           # ISO week number
└── completions/
    └── (add completions here)
```

---

## Bootstrap

Add the following two lines to your `~/.config/fish/config.fish`:

```fish
set -gx EGOHYGIENE_SHELL_ROOT /path/to/sanctuary/shell
source $EGOHYGIENE_SHELL_ROOT/runtime/shells/fish/runtime.fish
```

Replace `/path/to/sanctuary/shell` with the absolute path to the `shell/`
directory of your Sanctuary clone.

### What happens at startup

1. `runtime.fish` guards against double-loading via `EGOHYGIENE_RUNTIME_FISH_LOADED`.
2. `EGOHYGIENE_SHELL_NAME` is set to `fish`.
3. The `functions/` and `completions/` subdirectories are prepended to
   `fish_function_path` and `fish_complete_path` respectively.
4. Each `conf.d/*.fish` file is sourced in lexicographic order:
   - `environment.fish` — XDG variables, locale, editor, user PATH entries
   - `abbreviations.fish` — inline-expanding abbreviations for git and common tasks

---

## Architecture

This runtime sits at the **Shell Runtime** layer of the Sanctuary stack:

```
Bootstrap
  ↓
Shared Runtime       (runtime/shared/)
  ↓
Shell Runtime        (runtime/shells/fish/)   ← this layer
  ↓
Platform Runtime     (platforms/  — future)
  ↓
Extensions           (lib/extensions/)
  ↓
Modules              (modules/)
```

The Fish runtime is intentionally Fish-native.  It does not attempt to mirror
Bash syntax or source POSIX shell files.

---

## Configuration

### Silence the greeting

```fish
set -U fish_greeting ''
```

### Replace the prompt

Delete or override `functions/fish_prompt.fish`, or run:

```
fish_config prompt
```

### Disable abbreviations

Comment out or remove `conf.d/abbreviations.fish`, or unset individual
abbreviations with `abbr --erase`.

---

## Extension points

| Layer | How to extend |
|---|---|
| Environment variables | Add a new `conf.d/` fragment |
| Functions | Add a `.fish` file to `functions/` |
| Completions | Add a `.fish` file to `completions/` |
| Abbreviations | Append to `conf.d/abbreviations.fish` |

---

## Source material

Migrated and modernized from `.staging/fish shell/fish/`.

| Staged file | Decision | Reason |
|---|---|---|
| `config.fish` | Rewritten | Replaced macOS/Homebrew paths with XDG env conf.d fragment |
| `fishfile` | Removed | Empty; plugin management is user responsibility |
| `functions/abbrex.fish` | Migrated | Modernized with `string` builtins |
| `functions/clear.fish` | Migrated | Unchanged behaviour |
| `functions/emptytrash.fish` | Removed | macOS-specific; violates no-OS-specific-behavior constraint |
| `functions/fish_greeting.fish` | Rewritten | Simplified; removed ASCII art |
| `functions/fish_prompt.fish` | Rewritten | Removed legacy caret redirections and nested event handlers |
| `functions/fisher.fish` | Removed | Outdated (v3.2.11); Fisher is now installed via `curl` |
| `functions/forrepos.fish` | Removed | Opinionated `~/repos` convention; not part of shared runtime |
| `functions/ls.fish` | Migrated | Kept |
| `functions/manp.fish` | Removed | macOS-specific (`open -a Preview`) |
| `functions/mvnpurge.fish` | Removed | Too application-specific |
| `functions/pubkey.fish` | Removed | macOS-specific (`pbcopy`) |
| `functions/repo.fish` | Removed | Opinionated `~/repos` convention |
| `functions/repodir.fish` | Removed | Opinionated `~/repos` convention |
| `functions/setup.fish` | Rewritten | Abbreviations extracted to `conf.d/abbreviations.fish` |
| `functions/update.fish` | Removed | macOS/Homebrew-specific |
| `functions/week.fish` | Migrated | Kept |
| `completions/repo.fish` | Removed | Depended on removed `repo` function |
| `completions/repodir.fish` | Removed | Depended on removed `repodir` function |
| `setup.sh` | Removed | Replaced by runtime.fish integration model |
