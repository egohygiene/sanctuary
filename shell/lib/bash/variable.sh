#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 📚 EgoHygiene Library — Bash Variable Utilities
# ============================================
#
# Provides helpers for variable type introspection.
#
# Guarantees:
# - Idempotent
# - No side effects
# - Bash-only (not POSIX-portable)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_BASH_VARIABLE_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_BASH_VARIABLE_LOADED="true"

# --------------------------------------------
# 🔎 variable::is_array
#
# Return true if a named variable is an array (indexed or associative).
# Pass the variable name, not its value.
#
# @arg $1 string  Variable name to check.
#
# @exitcode 0  If the variable is an array.
# @exitcode 1  If the variable is not an array or the name is empty.
#
# @example
#   arr=("a" "b")
#   variable::is_array "arr"  # exits 0
# --------------------------------------------
variable::is_array() {
  [[ -z "${1:-}" ]] && return 1
  declare -p "${1}" 2>/dev/null | grep -q 'declare \-[aA]'
}

# --------------------------------------------
# 🔎 variable::is_numeric
#
# Return true if a value contains only digits (0-9).
#
# @arg $1 mixed  Value to check.
#
# @exitcode 0  If the value is numeric.
# @exitcode 1  If the value is not numeric.
#
# @example
#   variable::is_numeric "1234"  # exits 0
#   variable::is_numeric "12a4"  # exits 1
# --------------------------------------------
variable::is_numeric() {
  [[ "${1:-}" =~ ^[0-9]+$ ]]
}

# --------------------------------------------
# 🔎 variable::is_int
#
# Return true if a value is an integer (optional leading + or -).
#
# @arg $1 mixed  Value to check.
#
# @exitcode 0  If the value is an integer.
# @exitcode 1  If the value is not an integer.
#
# @example
#   variable::is_int "+1234"  # exits 0
#   variable::is_int "-5"     # exits 0
#   variable::is_int "1.5"    # exits 1
# --------------------------------------------
variable::is_int() {
  [[ "${1:-}" =~ ^[+-]?[0-9]+$ ]]
}

# --------------------------------------------
# 🔎 variable::is_float
#
# Return true if a value is a float or integer
# (optional leading sign, optional decimal part).
#
# @arg $1 mixed  Value to check.
#
# @exitcode 0  If the value is a float.
# @exitcode 1  If the value is not a float.
#
# @example
#   variable::is_float "+1234.0"  # exits 0
#   variable::is_float "1.5"      # exits 0
#   variable::is_float "abc"      # exits 1
# --------------------------------------------
variable::is_float() {
  [[ "${1:-}" =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]
}

# --------------------------------------------
# 🔎 variable::is_bool
#
# Return true if a value is exactly "true" or "false".
#
# @arg $1 mixed  Value to check.
#
# @exitcode 0  If the value is a boolean string.
# @exitcode 1  If the value is not a boolean string.
#
# @example
#   variable::is_bool "true"   # exits 0
#   variable::is_bool "false"  # exits 0
#   variable::is_bool "yes"    # exits 1
# --------------------------------------------
variable::is_bool() {
  [[ "${1:-}" == "true" || "${1:-}" == "false" ]]
}

# --------------------------------------------
# 🔎 variable::is_true
#
# Return true if a value represents a truthy state.
# Accepts "true" (string) or 0 (numeric).
#
# @arg $1 mixed  Value to check.
#
# @exitcode 0  If the value is truthy.
# @exitcode 1  If the value is not truthy.
#
# @example
#   variable::is_true "true"  # exits 0
#   variable::is_true 0       # exits 0
#   variable::is_true "false" # exits 1
# --------------------------------------------
variable::is_true() {
  [[ "${1:-}" == "true" || "${1:-}" -eq 0 ]] 2>/dev/null
}

# --------------------------------------------
# 🔎 variable::is_false
#
# Return true if a value represents a falsy state.
# Accepts "false" (string) or 1 (numeric).
#
# @arg $1 mixed  Value to check.
#
# @exitcode 0  If the value is falsy.
# @exitcode 1  If the value is not falsy.
#
# @example
#   variable::is_false "false"  # exits 0
#   variable::is_false 1        # exits 0
#   variable::is_false "true"   # exits 1
# --------------------------------------------
variable::is_false() {
  [[ "${1:-}" == "false" || "${1:-}" -eq 1 ]] 2>/dev/null
}

# --------------------------------------------
# 🔎 variable::is_empty_or_null
#
# Return true if a value is empty or the string "null".
#
# @arg $1 mixed  Value to check.
#
# @exitcode 0  If the value is empty or "null".
# @exitcode 1  If the value is non-empty and not "null".
#
# @example
#   variable::is_empty_or_null ""     # exits 0
#   variable::is_empty_or_null "null" # exits 0
#   variable::is_empty_or_null "foo"  # exits 1
# --------------------------------------------
variable::is_empty_or_null() {
  [[ -z "${1:-}" || "${1:-}" == "null" ]]
}
