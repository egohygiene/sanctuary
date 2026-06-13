#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 🧠 EgoHygiene Library — Core Utilities
# ============================================
#
# Provides foundational helpers used across the system.
#
# Scope:
# - PATH management
# - basic command detection
#
# Guarantees:
# - Idempotent
# - Side-effect minimal (only PATH mutation when explicitly called)
# - Cross-platform safe
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_CORE_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_CORE_LOADED="true"

# --------------------------------------------
# 📦 core::path_prepend
#
# Prepend directory to PATH if:
# - it exists
# - it is not already in PATH
# --------------------------------------------
core::path_prepend() {
  local directory_path="$1"

  [[ -n "${directory_path}" ]] || return 0
  [[ -d "${directory_path}" ]] || return 0

  case ":${PATH:-}:" in
    *":${directory_path}:"*) ;;
    *)
      if [[ -n "${PATH:-}" ]]; then
        export PATH="${directory_path}:${PATH}"
      else
        export PATH="${directory_path}"
      fi
      ;;
  esac
}

# --------------------------------------------
# 📦 core::path_append
#
# Append directory to PATH if:
# - it exists
# - it is not already in PATH
# --------------------------------------------
core::path_append() {
  local directory_path="$1"

  [[ -n "${directory_path}" ]] || return 0
  [[ -d "${directory_path}" ]] || return 0

  case ":${PATH:-}:" in
    *":${directory_path}:"*) ;;
    *)
      if [[ -n "${PATH:-}" ]]; then
        export PATH="${PATH}:${directory_path}"
      else
        export PATH="${directory_path}"
      fi
      ;;
  esac
}

# --------------------------------------------
# ⚠️ core::has_cmd (legacy)
#
# Deprecated: prefer guard::has_command
# --------------------------------------------
core::has_cmd() {
  local command_name="$1"

  [[ -n "${command_name}" ]] || return 1
  command -v "${command_name}" >/dev/null 2>&1
}
