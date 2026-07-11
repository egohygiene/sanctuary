#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 📚 EgoHygiene Library — Bash Terminal Utilities
# ============================================
#
# Provides terminal detection and control helpers.
#
# Guarantees:
# - Idempotent
# - No side effects
# - Bash-only (not POSIX-portable)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_BASH_TERMINAL_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_BASH_TERMINAL_LOADED="true"

# --------------------------------------------
# 🔎 terminal::is_term
#
# Return true if stdout is connected to a terminal.
#
# @exitcode 0  If stdout is a terminal.
# @exitcode 1  If stdout is not a terminal.
# --------------------------------------------
terminal::is_term() {
  [[ -t 1 || -z "${TERM:-}" ]]
}

# --------------------------------------------
# 🔎 terminal::detect_profile
#
# Detect the shell profile RC file for the current user.
# Returns the path to .bashrc, .zshrc, or .profile.
#
# @exitcode 0  If a profile file is detected.
# @exitcode 1  If no compatible profile file is found.
#
# @stdout Path to the detected shell profile file.
# --------------------------------------------
terminal::detect_profile() {
  local current_shell="${SHELL##*/}"
  local detected_profile

  case "${current_shell}" in
    bash) detected_profile="${HOME}/.bashrc"   ;;
    zsh)  detected_profile="${HOME}/.zshrc"    ;;
    *)
      if [[ -f "${HOME}/.profile" ]]; then
        detected_profile="${HOME}/.profile"
      else
        printf "No compatible shell profile file found\n" >&2
        return 1
      fi
      ;;
  esac

  printf "%s\n" "${detected_profile}"
}

# --------------------------------------------
# 🔎 terminal::clear_line
#
# Clear one or more lines above the current cursor position.
# Only has effect when stdout is a terminal.
#
# @arg $1 int  Number of lines to clear (optional, defaults to 1).
#
# @exitcode 0  Always.
#
# @stdout ANSI clear-line sequence (only when in a terminal).
# --------------------------------------------
terminal::clear_line() {
  if terminal::is_term; then
    local lines="${1:-1}"
    printf "\033[%sA\033[2K" "${lines}"
  fi
}

# --------------------------------------------
# 🔎 terminal::load_dircolors
#
# Load dircolors configuration for colored ls output.
# Respects a custom .dircolors file at ${USER_SYS_CONFIG}/.dircolors
# if that path is set, otherwise loads system defaults.
#
# @exitcode 0  Always.
# --------------------------------------------
terminal::load_dircolors() {
  if [[ -x /usr/bin/dircolors ]]; then
    if [[ -r "${USER_SYS_CONFIG:-}/.dircolors" ]]; then
      eval "$(dircolors -b "${USER_SYS_CONFIG}/.dircolors")"
    else
      eval "$(dircolors -b)"
    fi
  fi
}
