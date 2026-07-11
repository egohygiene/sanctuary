#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 📚 EgoHygiene Library — Bash Array Utilities
# ============================================
#
# Provides helpers for Bash array manipulation.
#
# Requires Bash 4+ for associative arrays (array::dedupe).
#
# Guarantees:
# - Idempotent
# - No side effects
# - Bash-only (not POSIX-portable)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_BASH_ARRAY_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_BASH_ARRAY_LOADED="true"

# --------------------------------------------
# 🔎 array::contains
#
# Check if an item exists in the given array.
#
# @arg $1 mixed  Needle (item to search for).
# @arg $@ array  Haystack (array elements).
#
# @exitcode 0  If the item is found.
# @exitcode 1  If the item is not found.
# @exitcode 2  If arguments are missing.
# --------------------------------------------
array::contains() {
  [[ $# -lt 2 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local query="${1:-}"
  shift

  local element
  for element in "${@}"; do
    [[ "${element}" == "${query}" ]] && return 0
  done

  return 1
}

# --------------------------------------------
# 🔎 array::dedupe
#
# Remove duplicate items from an array, preserving order.
#
# @arg $@ array  Input array elements.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Deduplicated newline-separated values.
# --------------------------------------------
array::dedupe() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  declare -A _seen
  local -a _unique
  local item

  for item in "$@"; do
    [[ -z "${item}" || -n "${_seen[${item}]:-}" ]] && continue
    _unique+=("${item}")
    _seen["${item}"]=1
  done

  printf '%s\n' "${_unique[@]}"
}

# --------------------------------------------
# 🔎 array::is_empty
#
# Check if an array is empty.
#
# @arg $@ array  Array elements.
#
# @exitcode 0  If the array is empty.
# @exitcode 1  If the array is not empty.
# --------------------------------------------
array::is_empty() {
  local -a _arr=("$@")
  [[ ${#_arr[@]} -eq 0 ]]
}

# --------------------------------------------
# 🔎 array::join
#
# Join array elements with a delimiter.
#
# @arg $1 string  Delimiter.
# @arg $@ array   Array elements.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Joined string.
#
# @example
#   array::join "," a b c  # outputs a,b,c
# --------------------------------------------
array::join() {
  [[ $# -lt 2 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local delimiter="${1}"
  shift

  printf "%s" "${1}"
  shift
  printf "%s" "${@/#/${delimiter}}"
  printf '\n'
}

# --------------------------------------------
# 🔎 array::reverse
#
# Return an array with elements in reverse order.
#
# @arg $@ array  Input array elements.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Reversed array, one element per line.
# --------------------------------------------
array::reverse() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local -a _arr=("$@")
  local min=0
  local max=$(( ${#_arr[@]} - 1 ))
  local tmp

  while [[ "${min}" -lt "${max}" ]]; do
    tmp="${_arr[${min}]}"
    _arr[${min}]="${_arr[${max}]}"
    _arr[${max}]="${tmp}"
    (( min++, max-- ))
  done

  printf '%s\n' "${_arr[@]}"
}

# --------------------------------------------
# 🔎 array::random_element
#
# Return a random element from an array.
#
# @arg $@ array  Input array elements.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout A randomly selected element.
# --------------------------------------------
array::random_element() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local -a _arr=("$@")
  printf '%s\n' "${_arr[RANDOM % $#]}"
}

# --------------------------------------------
# 🔎 array::sort
#
# Sort array elements from lowest to highest.
#
# @arg $@ array  Input array elements.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Sorted array, one element per line.
# --------------------------------------------
array::sort() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local -a _arr=("$@")
  local -a _sorted
  local _noglob

  _noglob="$(shopt -po noglob)"
  set -o noglob

  local IFS=$'\n'
  # shellcheck disable=SC2207
  _sorted=($(sort <<< "${_arr[*]}"))
  unset IFS

  eval "${_noglob}"

  printf '%s\n' "${_sorted[@]}"
}

# --------------------------------------------
# 🔎 array::rsort
#
# Sort array elements from highest to lowest (reverse).
#
# @arg $@ array  Input array elements.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Reverse-sorted array, one element per line.
# --------------------------------------------
array::rsort() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local -a _arr=("$@")
  local -a _sorted
  local _noglob

  _noglob="$(shopt -po noglob)"
  set -o noglob

  local IFS=$'\n'
  # shellcheck disable=SC2207
  _sorted=($(sort -r <<< "${_arr[*]}"))
  unset IFS

  eval "${_noglob}"

  printf '%s\n' "${_sorted[@]}"
}

# --------------------------------------------
# 🔎 array::bsort
#
# Bubble-sort an integer array from lowest to highest.
# Note: Does not work correctly on string arrays.
#
# @arg $@ array  Input integer array elements.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Sorted integer array, one element per line.
# --------------------------------------------
array::bsort() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local -a _arr=("$@")
  local tmp
  local i j

  for (( i = 0; i <= $(( ${#_arr[@]} - 2 )); ++i )); do
    for (( j = i + 1; j <= $(( ${#_arr[@]} - 1 )); ++j )); do
      if [[ ${_arr[i]} -gt ${_arr[j]} ]]; then
        tmp="${_arr[i]}"
        _arr[i]="${_arr[j]}"
        _arr[j]="${tmp}"
      fi
    done
  done

  printf '%s\n' "${_arr[@]}"
}

# --------------------------------------------
# 🔎 array::merge
#
# Merge two arrays by name reference.
# Pass the variable name of each array (not its value).
#
# @arg $1 string  Variable name of the first array (e.g. "arr1[@]").
# @arg $2 string  Variable name of the second array (e.g. "arr2[@]").
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Merged array, one element per line.
#
# @example
#   a=(1 2); b=(3 4)
#   array::merge "a[@]" "b[@]"
# --------------------------------------------
array::merge() {
  [[ $# -ne 2 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local -a _arr1=("${!1}")
  local -a _arr2=("${!2}")
  local -a _out=("${_arr1[@]}" "${_arr2[@]}")

  printf '%s\n' "${_out[@]}"
}
