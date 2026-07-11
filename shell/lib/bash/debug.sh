#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 📚 EgoHygiene Library — Bash Debug Utilities
# ============================================
#
# Provides helpers for debugging Bash scripts.
#
# Requires Bash 4.3+ for nameref support (debug::print_array).
#
# Guarantees:
# - Idempotent
# - No side effects (debug::execute depends on caller's DEBUG variable)
# - Bash-only (not POSIX-portable)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_BASH_DEBUG_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_BASH_DEBUG_LOADED="true"

# --------------------------------------------
# 🔎 debug::print_array
#
# Print an array's key-value pairs for easier inspection.
# Pass the variable name of the array, not its value.
# Works for both indexed and associative arrays.
#
# Requires Bash 4.3+ (nameref via declare -n).
#
# @arg $1 string  Variable name of the array to print.
#
# @stdout Key=value pairs, one per line.
#
# @example
#   arr=(foo bar baz)
#   debug::print_array "arr"
#   # outputs:
#   # 0 = foo
#   # 1 = bar
#   # 2 = baz
# --------------------------------------------
debug::print_array() {
  declare -n _debug_arr="$1"
  local k
  for k in "${!_debug_arr[@]}"; do
    printf "%s = %s\n" "${k}" "${_debug_arr[${k}]}"
  done
}

# --------------------------------------------
# 🔎 debug::print_ansi
#
# Print a string with ANSI escape sequences displayed literally.
# Useful for inspecting strings that contain color codes.
#
# @arg $1 string  Input string containing ANSI escape sequences.
#
# @stdout The string with escape characters shown as \e.
#
# @example
#   txt="$(tput bold)Hello$(tput sgr0)"
#   debug::print_ansi "${txt}"
#   # outputs: \e[1mHello\e(B\e[m
# --------------------------------------------
debug::print_ansi() {
  printf "%s\n" "${1//$'\e'/\\e}"
}

# --------------------------------------------
# 🔎 debug::execute
#
# Execute a command, suppressing output unless DEBUG=true.
#
# @arg $@  Command and arguments to execute.
#
# @exitcode *  Exit code from the executed command.
#
# @stdout  Output from the command (only when DEBUG=true).
# @stderr  Error output from the command (only when DEBUG=true).
# --------------------------------------------
debug::execute() {
  if [[ "${DEBUG:-false}" == "true" ]]; then
    "$@"
  else
    "$@" >/dev/null 2>&1
  fi
}
