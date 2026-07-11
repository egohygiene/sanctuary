#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 📚 EgoHygiene Library — Bash Validation Utilities
# ============================================
#
# Provides input validation helpers using Bash regex (=~).
#
# Guarantees:
# - Idempotent
# - No side effects
# - Bash-only (not POSIX-portable)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_BASH_VALIDATION_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_BASH_VALIDATION_LOADED="true"

# --------------------------------------------
# 🔎 validation::email
#
# Validate whether a string is a valid email address.
#
# @arg $1 string  Value to validate.
#
# @exitcode 0  If valid.
# @exitcode 1  If not a valid email address.
# @exitcode 2  If arguments are missing.
#
# @example
#   validation::email "user@example.com"  # exits 0
#   validation::email "not-an-email"      # exits 1
# --------------------------------------------
validation::email() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local re="^([A-Za-z]+[A-Za-z0-9]*\+?((\.|\-|\_)?[A-Za-z]+[A-Za-z0-9]*)*)@(([A-Za-z0-9]+)+((\.|\-|\_)?([A-Za-z0-9]+)+)*)+\.([A-Za-z]{2,})+$"
  [[ "${1}" =~ ${re} ]]
}

# --------------------------------------------
# 🔎 validation::ipv4
#
# Validate whether a string is a valid IPv4 address.
#
# @arg $1 string  Value to validate.
#
# @exitcode 0  If valid.
# @exitcode 1  If not a valid IPv4 address.
# @exitcode 2  If arguments are missing.
#
# @example
#   validation::ipv4 "192.168.1.1"  # exits 0
#   validation::ipv4 "999.999.999.999"  # exits 1
# --------------------------------------------
validation::ipv4() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local ip="${1}"
  local IFS=.
  # shellcheck disable=SC2206
  local -a octets=(${ip})
  local octet

  [[ "${ip}" =~ ^[0-9]+(\.[0-9]+){3}$ ]] || return 1

  for octet in "${octets[@]}"; do
    [[ "${octet}" -gt 255 ]] && return 1
  done

  return 0
}

# --------------------------------------------
# 🔎 validation::ipv6
#
# Validate whether a string is a valid IPv6 address.
#
# @arg $1 string  Value to validate.
#
# @exitcode 0  If valid.
# @exitcode 1  If not a valid IPv6 address.
# @exitcode 2  If arguments are missing.
# --------------------------------------------
validation::ipv6() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local ip="${1}"
  local re="^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|\
([0-9a-fA-F]{1,4}:){1,7}:|\
([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|\
([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|\
([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|\
([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|\
([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|\
[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|\
:((:[0-9a-fA-F]{1,4}){1,7}|:)|\
fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|\
::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|\
([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$"

  [[ "${ip}" =~ ${re} ]]
}

# --------------------------------------------
# 🔎 validation::alpha
#
# Validate whether a value contains only alphabetic characters.
#
# @arg $1 string  Value to validate.
#
# @exitcode 0  If valid.
# @exitcode 1  If the value contains non-alpha characters.
# @exitcode 2  If arguments are missing.
#
# @example
#   validation::alpha "abcABC"  # exits 0
#   validation::alpha "abc123"  # exits 1
# --------------------------------------------
validation::alpha() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2
  [[ "${1}" =~ ^[[:alpha:]]+$ ]]
}

# --------------------------------------------
# 🔎 validation::alpha_num
#
# Validate whether a value contains only alphanumeric characters.
#
# @arg $1 string  Value to validate.
#
# @exitcode 0  If valid.
# @exitcode 1  If the value contains non-alphanumeric characters.
# @exitcode 2  If arguments are missing.
#
# @example
#   validation::alpha_num "abc123"  # exits 0
#   validation::alpha_num "abc-123" # exits 1
# --------------------------------------------
validation::alpha_num() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2
  [[ "${1}" =~ ^[[:alnum:]]+$ ]]
}

# --------------------------------------------
# 🔎 validation::alpha_dash
#
# Validate whether a value contains only alpha characters, dashes, and underscores.
#
# @arg $1 string  Value to validate.
#
# @exitcode 0  If valid.
# @exitcode 1  If the value contains disallowed characters.
# @exitcode 2  If arguments are missing.
#
# @example
#   validation::alpha_dash "abc-ABC_cD"  # exits 0
#   validation::alpha_dash "abc 123"     # exits 1
# --------------------------------------------
validation::alpha_dash() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2
  [[ "${1}" =~ ^[[:alpha:]_-]+$ ]]
}

# --------------------------------------------
# 🔎 validation::version_comparison
#
# Compare two version number strings.
#
# @arg $1 string  First version (e.g. "1.2.3").
# @arg $2 string  Second version (e.g. "1.2.3").
#
# @exitcode 0  If versions are equal.
# @exitcode 1  If $1 is greater than $2.
# @exitcode 2  If $1 is less than $2.
# @exitcode 3  If arguments are missing.
# @exitcode 4  If either argument is not a valid version string.
#
# @example
#   validation::version_comparison "2.0.0" "1.9.9"  # exits 1 ($1 > $2)
#   validation::version_comparison "1.0.0" "1.0.0"  # exits 0 (equal)
#   validation::version_comparison "1.0.0" "2.0.0"  # exits 2 ($1 < $2)
# --------------------------------------------
validation::version_comparison() {
  [[ $# -lt 2 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 3

  local re="^[.0-9]*$"
  [[ "${1}" =~ ${re} ]] || { printf "Invalid argument: %s\n" "${1}" && return 4; }
  [[ "${2}" =~ ${re} ]] || { printf "Invalid argument: %s\n" "${2}" && return 4; }

  [[ "${1}" == "${2}" ]] && return 0

  local IFS=.
  local -a ver1 ver2
  read -r -a ver1 <<< "${1}"
  read -r -a ver2 <<< "${2}"

  local i
  for (( i = ${#ver1[@]}; i < ${#ver2[@]}; i++ )); do
    ver1[i]=0
  done

  for (( i = 0; i < ${#ver1[@]}; i++ )); do
    [[ -z "${ver2[i]:-}" ]] && ver2[i]=0

    if (( 10#${ver1[i]} > 10#${ver2[i]} )); then
      return 1
    fi
    if (( 10#${ver1[i]} < 10#${ver2[i]} )); then
      return 2
    fi
  done

  return 0
}
