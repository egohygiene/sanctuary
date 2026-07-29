#
# ============================================
# 🌍 EgoHygiene — Fish Environment
# ============================================
#
# Configures fundamental environment variables
# following the XDG Base Directory specification.
#
# Mirrors the shared environment concepts used across
# the Sanctuary shell platform while using Fish-native
# syntax and patterns.
#
# Loaded automatically by runtime.fish.
#

# --------------------------------------------
# 🛑 Idempotency guard
# --------------------------------------------
if set -q EGOHYGIENE_FISH_ENV_LOADED
    return 0
end

set -gx EGOHYGIENE_FISH_ENV_LOADED true

# --------------------------------------------
# 📁 XDG Base Directories
# --------------------------------------------

if not set -q XDG_CONFIG_HOME
    set -gx XDG_CONFIG_HOME $HOME/.config
end

if not set -q XDG_CACHE_HOME
    set -gx XDG_CACHE_HOME $HOME/.cache
end

if not set -q XDG_DATA_HOME
    set -gx XDG_DATA_HOME $HOME/.local/share
end

if not set -q XDG_STATE_HOME
    set -gx XDG_STATE_HOME $HOME/.local/state
end

if not set -q XDG_CONFIG_DIRS
    set -gx XDG_CONFIG_DIRS /etc/xdg
end

if not set -q XDG_DATA_DIRS
    set -gx XDG_DATA_DIRS /usr/local/share /usr/share
end

# --------------------------------------------
# 🌐 Locale
# --------------------------------------------

if not set -q LANG
    set -gx LANG en_US.UTF-8
end

if not set -q LC_ALL
    set -gx LC_ALL $LANG
end

# --------------------------------------------
# 🖥️ Terminal
# --------------------------------------------

if not set -q TERM
    set -gx TERM xterm-256color
end

# --------------------------------------------
# ✏️ Editor
# --------------------------------------------

if not set -q EDITOR
    if command -q nvim
        set -gx EDITOR nvim
    else if command -q vim
        set -gx EDITOR vim
    else
        set -gx EDITOR vi
    end
end

if not set -q VISUAL
    set -gx VISUAL $EDITOR
end

# --------------------------------------------
# 🗂️ PATH — user directories
#
# Prepend user-local bin directories so they
# take precedence over system paths.
# fish_add_path is idempotent: it only adds a
# path if it is not already present.
# --------------------------------------------

if not set -q XDG_BIN_HOME
    set -gx XDG_BIN_HOME $HOME/.local/bin
end

mkdir -p $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_BIN_HOME

fish_add_path --prepend --global $XDG_DATA_HOME/asdf/shims
fish_add_path --prepend --global $XDG_DATA_HOME/pyenv/bin
fish_add_path --prepend --global $XDG_DATA_HOME/volta/bin
fish_add_path --prepend --global $XDG_DATA_HOME/pipx/bin
fish_add_path --prepend --global $XDG_DATA_HOME/go/bin
fish_add_path --prepend --global $XDG_DATA_HOME/cargo/bin
fish_add_path --prepend --global $XDG_DATA_HOME/pnpm
fish_add_path --prepend --global $XDG_BIN_HOME
fish_add_path --prepend --global $EGOHYGIENE_SHELL_ROOT/bin

set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx GOPATH $XDG_DATA_HOME/go
set -gx PNPM_HOME $XDG_DATA_HOME/pnpm
set -gx PYENV_ROOT $XDG_DATA_HOME/pyenv
set -gx VOLTA_HOME $XDG_DATA_HOME/volta
set -gx PIP_CACHE_DIR $XDG_CACHE_HOME/pip
set -gx PIPX_HOME $XDG_DATA_HOME/pipx
set -gx PIPX_BIN_DIR $XDG_DATA_HOME/pipx/bin
set -gx UV_CACHE_DIR $XDG_CACHE_HOME/uv
