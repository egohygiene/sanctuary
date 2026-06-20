#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 🐚 EgoHygiene Library — Shell Detection
# ============================================
#
# Detects the active shell runtime and exposes
# helpers for shell-specific branching.
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_SHELL_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_SHELL_LOADED="true"

if [[ -n "${BASH_VERSION:-}" ]]; then
  EGOHYGIENE_SHELL_NAME="bash"
elif [[ -n "${ZSH_VERSION:-}" ]]; then
  EGOHYGIENE_SHELL_NAME="zsh"
else
  EGOHYGIENE_SHELL_NAME="${EGOHYGIENE_SHELL_NAME:-unknown}"
fi

export EGOHYGIENE_SHELL_NAME

shell::name() {
  printf "%s\n" "${EGOHYGIENE_SHELL_NAME:-unknown}"
}

shell::is_bash() {
  [[ "${EGOHYGIENE_SHELL_NAME:-unknown}" == "bash" ]]
}

shell::is_zsh() {
  [[ "${EGOHYGIENE_SHELL_NAME:-unknown}" == "zsh" ]]
}
