#!/usr/bin/env bash
#
# ============================================
# 🌍 EgoHygiene Module — Environment
# ============================================
#
# Defines core environment behavior:
# - PATH orchestration
# - editor defaults
# - locale configuration
#
# Guarantees:
# - Idempotent
# - Depends on core + xdg + os
# - Deterministic PATH ordering
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_MODULE_ENVIRONMENT_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_MODULE_ENVIRONMENT_LOADED="true"

# --------------------------------------------
# 🛑 Dependency Checks
# --------------------------------------------
[[ -n "${XDG_DATA_HOME:-}" ]] || return 0
[[ -n "${XDG_CONFIG_HOME:-}" ]] || return 0

# --------------------------------------------
# 🌐 Locale & Language
# --------------------------------------------

export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-${LANG}}"

# --------------------------------------------
# ✏️ Editor Defaults
# --------------------------------------------

# Prefer modern editors if available
if guard::has_command "nvim"; then
  export EDITOR="nvim"
elif guard::has_command "vim"; then
  export EDITOR="vim"
else
  export EDITOR="vi"
fi

export VISUAL="${VISUAL:-${EDITOR}}"

# --------------------------------------------
# 🧠 PATH Orchestration
# --------------------------------------------

# Ensure PATH exists
export PATH="${PATH:-/usr/bin:/bin}"

# --------------------------------------------
# 🧩 User-Level Binaries (Highest Priority)
# --------------------------------------------

core::path_prepend "${EGOHYGIENE_SHELL_ROOT}/bin"
core::path_prepend "${XDG_DATA_HOME}/bin"
core::path_prepend "${HOME}/.local/bin"

# Language/tool-specific bins
core::path_prepend "${XDG_DATA_HOME}/pnpm"
core::path_prepend "${XDG_DATA_HOME}/cargo/bin"
core::path_prepend "${XDG_DATA_HOME}/go/bin"

# --------------------------------------------
# 🧪 Dev / Project Overrides
# --------------------------------------------

core::path_prepend "${PWD}/bin"
core::path_prepend "${PWD}/node_modules/.bin"

# --------------------------------------------
# 🏗️ System-Level (Lowest Priority)
# --------------------------------------------

# macOS system paths (safe no-op on Linux)
core::path_append "/usr/local/bin"
core::path_append "/usr/bin"
core::path_append "/bin"
core::path_append "/usr/sbin"
core::path_append "/sbin"

# --------------------------------------------
# 🧠 Container Awareness
# --------------------------------------------

if os::is_container; then
  # Containers often need simpler PATHs
  core::path_append "/usr/local/sbin"
fi

# --------------------------------------------
# 🧹 Cleanup
# --------------------------------------------

# Nothing to clean — this defines state intentionally
