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

fish_add_path --prepend --global $HOME/.local/bin
fish_add_path --prepend --global $HOME/bin
