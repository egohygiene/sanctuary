#
# ============================================
# 🐟 EgoHygiene Runtime — Fish Layer
# ============================================
#
# Entry point for the Fish shell runtime within the
# Sanctuary shell platform.
#
# Responsibilities:
# - Register the Fish shell name
# - Extend Fish path variables to include runtime functions and completions
# - Source conf.d configuration fragments
#
# Usage:
#   Source this file from your ~/.config/fish/config.fish after setting
#   EGOHYGIENE_SHELL_ROOT to the absolute path of the shell/ directory:
#
#     set -gx EGOHYGIENE_SHELL_ROOT /path/to/sanctuary/shell
#     source $EGOHYGIENE_SHELL_ROOT/runtime/shells/fish/runtime.fish
#
# Notes:
# - This file is Fish-only; do not source it from Bash or Zsh.
# - Idempotent: safe to source multiple times.
# - No macOS-specific, Homebrew-specific, or tool-specific behavior here;
#   that belongs in platform or extension layers.
#

# --------------------------------------------
# 🛑 Dependency check
# --------------------------------------------
if not set -q EGOHYGIENE_SHELL_ROOT
    echo "[error] runtime.fish: EGOHYGIENE_SHELL_ROOT is not set" >&2
    return 1
end

# --------------------------------------------
# 🛑 Idempotency guard
# --------------------------------------------
if set -q EGOHYGIENE_RUNTIME_FISH_LOADED
    return 0
end

set -gx EGOHYGIENE_RUNTIME_FISH_LOADED true

# --------------------------------------------
# 🐚 Shell identity
# --------------------------------------------
set -gx EGOHYGIENE_SHELL_NAME fish

# --------------------------------------------
# 📁 Runtime root
# --------------------------------------------
set -l _fish_runtime_root $EGOHYGIENE_SHELL_ROOT/runtime/shells/fish

# --------------------------------------------
# 📦 Function and completion paths
#
# Prepend the runtime directories so that
# Sanctuary-provided functions and completions
# are available without symlinking to ~/.config/fish.
# --------------------------------------------
if not contains $_fish_runtime_root/functions $fish_function_path
    set -p fish_function_path $_fish_runtime_root/functions
end

if not contains $_fish_runtime_root/completions $fish_complete_path
    set -p fish_complete_path $_fish_runtime_root/completions
end

# --------------------------------------------
# ⚙️ conf.d fragments
#
# Source each .fish file under conf.d/ in
# lexicographic order, mirroring Fish's own
# conf.d auto-loading behaviour.
# --------------------------------------------
for _fish_conf in (command ls $_fish_runtime_root/conf.d/*.fish 2>/dev/null)
    if test -f $_fish_conf -a -r $_fish_conf
        source $_fish_conf
    end
end

set -e _fish_runtime_root
set -e _fish_conf
