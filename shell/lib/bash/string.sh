#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 📚 EgoHygiene Library — Bash String Utilities
# ============================================
#
# Provides string manipulation helpers.
# Functions use Bash-specific parameter expansion where applicable,
# with fallbacks for older Bash versions where feasible.
#
# Guarantees:
# - Idempotent
# - No side effects
# - Bash-only (not POSIX-portable)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_BASH_STRING_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_BASH_STRING_LOADED="true"

# --------------------------------------------
# 🔎 string::trim
#
# Strip leading and trailing whitespace from a string.
#
# @arg $1 string  Input string.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Trimmed string.
#
# @example
#   string::trim "  Hello World!  "  # outputs: Hello World!
# --------------------------------------------
string::trim() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  : "${1#"${1%%[![:space:]]*}"}"
  : "${_%"${_##*[![:space:]]}"}"
  printf '%s\n' "$_"
}

# --------------------------------------------
# 🔎 string::split
#
# Split a string into parts by a delimiter.
#
# @arg $1 string  Input string.
# @arg $2 string  Delimiter.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Split parts, one per line.
#
# @example
#   string::split "a,b,c" ","
#   # outputs:
#   # a
#   # b
#   # c
# --------------------------------------------
string::split() {
  [[ $# -lt 2 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local -a _parts
  IFS=$'\n' read -d "" -ra _parts <<< "${1//$2/$'\n'}" || true
  printf '%s\n' "${_parts[@]}"
}

# --------------------------------------------
# 🔎 string::lstrip
#
# Strip a prefix pattern from the beginning of a string.
#
# @arg $1 string  Input string.
# @arg $2 string  Prefix pattern to strip.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Modified string.
#
# @example
#   string::lstrip "Hello World!" "He"  # outputs: llo World!
# --------------------------------------------
string::lstrip() {
  [[ $# -lt 2 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2
  printf '%s\n' "${1##$2}"
}

# --------------------------------------------
# 🔎 string::rstrip
#
# Strip a suffix pattern from the end of a string.
#
# @arg $1 string  Input string.
# @arg $2 string  Suffix pattern to strip.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Modified string.
#
# @example
#   string::rstrip "Hello World!" "d!"  # outputs: Hello Worl
# --------------------------------------------
string::rstrip() {
  [[ $# -lt 2 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2
  printf '%s\n' "${1%%$2}"
}

# --------------------------------------------
# 🔎 string::to_lower
#
# Convert a string to lowercase.
# Uses Bash 4+ parameter expansion; falls back to tr for older Bash.
#
# @arg $1 string  Input string.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Lowercased string.
#
# @example
#   string::to_lower "HellO"  # outputs: hello
# --------------------------------------------
string::to_lower() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  if [[ "${BASH_VERSINFO[0]:-0}" -ge 4 ]]; then
    printf '%s\n' "${1,,}"
  else
    printf '%s\n' "${1}" | tr '[:upper:]' '[:lower:]'
  fi
}

# --------------------------------------------
# 🔎 string::to_upper
#
# Convert a string to uppercase.
# Uses Bash 4+ parameter expansion; falls back to tr for older Bash.
#
# @arg $1 string  Input string.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Uppercased string.
#
# @example
#   string::to_upper "HellO"  # outputs: HELLO
# --------------------------------------------
string::to_upper() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  if [[ "${BASH_VERSINFO[0]:-0}" -ge 4 ]]; then
    printf '%s\n' "${1^^}"
  else
    printf '%s\n' "${1}" | tr '[:lower:]' '[:upper:]'
  fi
}

# --------------------------------------------
# 🔎 string::contains
#
# Check if a string contains a substring.
#
# @arg $1 string  Input string.
# @arg $2 string  Substring to search for.
#
# @exitcode 0  If the substring is found.
# @exitcode 1  If the substring is not found.
# @exitcode 2  If arguments are missing.
#
# @example
#   string::contains "Hello World!" "World"  # exits 0
# --------------------------------------------
string::contains() {
  [[ $# -lt 2 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2
  [[ "${1}" == *"${2}"* ]]
}

# --------------------------------------------
# 🔎 string::starts_with
#
# Check if a string starts with a given prefix.
#
# @arg $1 string  Input string.
# @arg $2 string  Prefix to check.
#
# @exitcode 0  If the string starts with the prefix.
# @exitcode 1  If the string does not start with the prefix.
# @exitcode 2  If arguments are missing.
#
# @example
#   string::starts_with "Hello World!" "He"  # exits 0
# --------------------------------------------
string::starts_with() {
  [[ $# -lt 2 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2
  [[ "${1}" == "${2}"* ]]
}

# --------------------------------------------
# 🔎 string::ends_with
#
# Check if a string ends with a given suffix.
#
# @arg $1 string  Input string.
# @arg $2 string  Suffix to check.
#
# @exitcode 0  If the string ends with the suffix.
# @exitcode 1  If the string does not end with the suffix.
# @exitcode 2  If arguments are missing.
#
# @example
#   string::ends_with "Hello World!" "d!"  # exits 0
# --------------------------------------------
string::ends_with() {
  [[ $# -lt 2 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2
  [[ "${1}" == *"${2}" ]]
}

# --------------------------------------------
# 🔎 string::regex
#
# Check if a string matches a regular expression.
#
# @arg $1 string  Input string.
# @arg $2 string  Regular expression pattern.
#
# @exitcode 0  If the string matches the regex.
# @exitcode 1  If the string does not match.
# @exitcode 2  If arguments are missing.
#
# @example
#   string::regex "HELLO" "^[A-Z]*$"  # exits 0
# --------------------------------------------
string::regex() {
  [[ $# -lt 2 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2
  [[ "${1}" =~ ${2} ]]
}
