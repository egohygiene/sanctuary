#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 📚 EgoHygiene Library — Bash Collection Utilities
# ============================================
#
# Provides higher-order iteration functions for collections.
# Input can be a pipe, here-string, or file.
#
# Note: Functions in this module use eval to invoke named callbacks.
# The iteratee argument must be a trusted function name.
#
# Guarantees:
# - Idempotent
# - No side effects
# - Bash-only (not POSIX-portable)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_BASH_COLLECTION_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_BASH_COLLECTION_LOADED="true"

# --------------------------------------------
# 🔎 collection::each
#
# Invoke an iteratee function for each line of input.
# Stops and returns the iteratee's exit code on failure.
#
# @arg $1 string  Iteratee function name.
#
# @exitcode 0  If all iterations succeeded.
# @exitcode 2  If arguments are missing.
# @exitcode *  Exit code from the first failing iteratee call.
#
# @stdin  Newline-separated values.
# @stdout Output from each iteratee call.
# --------------------------------------------
collection::each() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local func="${1}"
  local IFS=$'\n'
  local it
  local ret

  while read -r it; do
    if [[ "${func}" == *'$'* ]]; then
      eval "${func}"
    else
      eval "${func}" "'${it}'"
    fi

    ret=$?
    [[ "${ret}" -ne 0 ]] && return "${ret}"
  done
}

# --------------------------------------------
# 🔎 collection::every
#
# Return true only if the iteratee returns true for every element.
# Stops at the first failure.
#
# @arg $1 string  Iteratee function name.
#
# @exitcode 0  If the iteratee returned true for all elements.
# @exitcode 1  If the iteratee returned false for any element.
# @exitcode 2  If arguments are missing.
#
# @stdin  Newline-separated values.
# --------------------------------------------
collection::every() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local func="${1}"
  local IFS=$'\n'
  local it

  while read -r it; do
    if [[ "${func}" == *'$'* ]]; then
      eval "${func}"
    else
      eval "${func}" "'${it}'"
    fi

    [[ $? -ne 0 ]] && return 1
  done

  return 0
}

# --------------------------------------------
# 🔎 collection::filter
#
# Return only elements for which the iteratee returns true.
#
# @arg $1 string  Iteratee function name.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdin  Newline-separated values.
# @stdout Filtered elements, one per line.
# --------------------------------------------
collection::filter() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local func="${1}"
  local IFS=$'\n'
  local it

  while read -r it; do
    if [[ "${func}" == *'$'* ]]; then
      eval "${func}"
    else
      eval "${func}" "'${it}'"
    fi

    [[ $? -eq 0 ]] && printf "%s\n" "${it}"
  done
}

# --------------------------------------------
# 🔎 collection::find
#
# Return the first element for which the iteratee returns true.
#
# @arg $1 string  Iteratee function name.
#
# @exitcode 0  If a match is found.
# @exitcode 1  If no match is found.
# @exitcode 2  If arguments are missing.
#
# @stdin  Newline-separated values.
# @stdout The first matching element.
# --------------------------------------------
collection::find() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local func="${1}"
  local IFS=$'\n'
  local it

  while read -r it; do
    if [[ "${func}" == *'$'* ]]; then
      eval "${func}"
    else
      eval "${func}" "'${it}'"
    fi

    if [[ $? -eq 0 ]]; then
      printf "%s\n" "${it}"
      return 0
    fi
  done

  return 1
}

# --------------------------------------------
# 🔎 collection::invoke
#
# Collect all input lines as arguments and invoke the function once.
#
# @arg $1 string  Function name to invoke.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
# @exitcode *  Exit code from the invoked function.
#
# @stdin  Newline-separated values (collected as arguments).
# @stdout Output from the invoked function.
# --------------------------------------------
collection::invoke() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local func="${1}"
  local -a args=()
  local it

  while read -r it; do
    args+=("${it}")
  done

  eval "${func}" "${args[@]}"
}

# --------------------------------------------
# 🔎 collection::map
#
# Apply an iteratee to each element and print the result.
# Stops and returns the iteratee's exit code on failure.
#
# @arg $1 string  Iteratee function name.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
# @exitcode *  Exit code from the first failing iteratee call.
#
# @stdin  Newline-separated values.
# @stdout Mapped output, one result per line.
# --------------------------------------------
collection::map() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local func="${1}"
  local IFS=$'\n'
  local it out
  local ret

  while read -r it; do
    if [[ "${func}" == *'$'* ]]; then
      out="$("${func}")"
    else
      out="$("${func}" "${it}")"
    fi

    ret=$?
    [[ "${ret}" -ne 0 ]] && return "${ret}"

    printf "%s\n" "${out}"
  done
}

# --------------------------------------------
# 🔎 collection::reject
#
# Return only elements for which the iteratee returns false.
# The inverse of collection::filter.
#
# @arg $1 string  Iteratee function name.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdin  Newline-separated values.
# @stdout Non-matching elements, one per line.
# --------------------------------------------
collection::reject() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local func="${1}"
  local IFS=$'\n'
  local it

  while read -r it; do
    if [[ "${func}" == *'$'* ]]; then
      eval "${func}"
    else
      eval "${func}" "'${it}'"
    fi

    [[ $? -ne 0 ]] && printf "%s\n" "${it}"
  done
}

# --------------------------------------------
# 🔎 collection::some
#
# Return true if the iteratee returns true for at least one element.
#
# @arg $1 string  Iteratee function name.
#
# @exitcode 0  If the iteratee matched at least one element.
# @exitcode 1  If no elements matched.
# @exitcode 2  If arguments are missing.
#
# @stdin  Newline-separated values.
# --------------------------------------------
collection::some() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local func="${1}"
  local IFS=$'\n'
  local it

  while read -r it; do
    if [[ "${func}" == *'$'* ]]; then
      eval "${func}"
    else
      eval "${func}" "'${it}'"
    fi

    [[ $? -eq 0 ]] && return 0
  done

  return 1
}
