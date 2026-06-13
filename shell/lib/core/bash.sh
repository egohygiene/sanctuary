#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 🐚 EgoHygiene Library — Bash Introspection
# ============================================
#
# Provides Bash runtime introspection helpers.
#
# Guarantees:
# - Idempotent
# - No side effects
# - Safe when Bash is not present
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_BASH_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_BASH_LOADED="true"

# --------------------------------------------
# 🔎 bash::version
#
# Full version string
# --------------------------------------------
bash::version() {
  printf "%s\n" "${BASH_VERSION:-unknown}"
}

# --------------------------------------------
# 🔎 bash::major_version
# --------------------------------------------
bash::major_version() {
  printf "%s\n" "${BASH_VERSINFO[0]:-0}"
}

# --------------------------------------------
# 🔎 bash::minor_version
# --------------------------------------------
bash::minor_version() {
  printf "%s\n" "${BASH_VERSINFO[1]:-0}"
}

# --------------------------------------------
# 🔎 bash::is_interactive
# --------------------------------------------
bash::is_interactive() {
  [[ $- == *i* ]]
}

# --------------------------------------------
# 🔎 bash::path
#
# Path to current bash binary
# --------------------------------------------
bash::path() {
  if [[ -n "${BASH:-}" ]]; then
    printf "%s\n" "${BASH}"
  else
    command -v bash 2>/dev/null || return 1
  fi
}

# --------------------------------------------
# 🔎 bash::is_min_version
#
# Usage:
#   bash::is_min_version 4 4
# --------------------------------------------
bash::is_min_version() {
  local required_major="$1"
  local required_minor="$2"

  local current_major="${BASH_VERSINFO[0]:-0}"
  local current_minor="${BASH_VERSINFO[1]:-0}"

  if (( current_major > required_major )); then
    return 0
  fi

  if (( current_major == required_major && current_minor >= required_minor )); then
    return 0
  fi

  return 1
}
