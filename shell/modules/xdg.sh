#!/usr/bin/env bash
#
# ============================================
# 📁 EgoHygiene Module — XDG Base Directories
# ============================================
#
# Description:
#   Centralizes filesystem layout using the XDG Base Directory spec.
#   Redirects tool paths to keep $HOME clean and reproducible.
#
# Guarantees:
#   - Idempotent (safe to source multiple times)
#   - Cross-platform (Linux, macOS, containers)
#   - Respects pre-existing environment variables
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_MODULE_XDG_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_MODULE_XDG_LOADED="true"

# --------------------------------------------
# 📁 Core XDG Directories
# --------------------------------------------

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"

export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-${XDG_CONFIG_HOME}:/etc/xdg}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-${XDG_DATA_HOME}:/usr/local/share:/usr/share}"

# --------------------------------------------
# 🧠 Runtime Directory (XDG_RUNTIME_DIR)
# --------------------------------------------
#
# Priority:
#   1. Existing XDG_RUNTIME_DIR
#   2. Linux systemd: /run/user/<uid>
#   3. TMPDIR (macOS / portable fallback)
#   4. /tmp fallback
#

if [[ -z "${XDG_RUNTIME_DIR:-}" ]]; then
  current_user_id="$(id -u)"

  if [[ -d "/run/user/${current_user_id}" ]]; then
    export XDG_RUNTIME_DIR="/run/user/${current_user_id}"

  elif [[ -n "${TMPDIR:-}" && -d "${TMPDIR}" ]]; then
    export XDG_RUNTIME_DIR="${TMPDIR%/}/egohygiene-runtime-${current_user_id}"

  else
    export XDG_RUNTIME_DIR="/tmp/egohygiene-runtime-${current_user_id}"
  fi

  unset current_user_id
fi

# Ensure runtime dir exists with correct permissions (only if needed)
if [[ ! -d "${XDG_RUNTIME_DIR}" ]]; then
  mkdir -p "${XDG_RUNTIME_DIR}"
  chmod 700 "${XDG_RUNTIME_DIR}"
fi

# --------------------------------------------
# 📁 Ensure Base Directories Exist
# --------------------------------------------

mkdir -p \
  "${XDG_CONFIG_HOME}" \
  "${XDG_DATA_HOME}" \
  "${XDG_CACHE_HOME}" \
  "${XDG_STATE_HOME}"
