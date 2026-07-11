#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 📚 EgoHygiene Library — Bash Miscellaneous Utilities
# ============================================
#
# Provides general-purpose helper functions that do not
# belong to a more specific module.
#
# Guarantees:
# - Idempotent
# - No side effects
# - Bash-only (not POSIX-portable)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_BASH_MISC_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_BASH_MISC_LOADED="true"

# --------------------------------------------
# 🔎 misc::is_terminal
#
# Return true if stdout is connected to a terminal.
#
# @exitcode 0  If stdout is a terminal.
# @exitcode 1  If stdout is not a terminal.
# --------------------------------------------
misc::is_terminal() {
  [[ -t 1 || -z "${TERM:-}" ]]
}

# --------------------------------------------
# 🔎 misc::check_internet_connection
#
# Return true if an internet connection is available.
# Uses curl to test connectivity against google.com (10s timeout).
#
# @exitcode 0  If internet is reachable.
# @exitcode 1  If internet is not reachable.
# --------------------------------------------
misc::check_internet_connection() {
  local result

  if misc::is_terminal; then
    result="$(sh -ic 'exec 3>&1 2>/dev/null; { curl --compressed -Is google.com 1>&3; kill 0; } | { sleep 10; kill 0; }' || :)"
  else
    result="$(curl --compressed -Is google.com -m 10 2>/dev/null || :)"
  fi

  [[ -n "${result}" ]]
}

# --------------------------------------------
# 🔎 misc::get_pid
#
# List process IDs matching a process name.
#
# @arg $1 string  Process name to search.
#
# @exitcode 0  If one or more matches are found.
# @exitcode 1  If no matches are found.
# @exitcode 2  If arguments are missing.
#
# @stdout Newline-separated list of matching PIDs.
# --------------------------------------------
misc::get_pid() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  pgrep "${1}"
}

# --------------------------------------------
# 🔎 misc::get_uid
#
# Get the numeric UID for a given username.
#
# @arg $1 string  Username to look up.
#
# @exitcode 0  If the user is found.
# @exitcode 1  If the user is not found.
# @exitcode 2  If arguments are missing.
#
# @stdout Numeric UID.
# --------------------------------------------
misc::get_uid() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local user_info

  user_info="$(id "${1}" 2>/dev/null)" || {
    printf "No user found with username: %s\n" "${1}" >&2
    return 1
  }

  printf "%s\n" "${user_info}" | sed -e 's/(.*$//' -e 's/^uid=//'
}

# --------------------------------------------
# 🔎 misc::generate_uuid
#
# Generate a random UUID (version 4).
# Uses RANDOM for entropy — suitable for non-cryptographic purposes.
# For cryptographic UUIDs, use uuidgen or /proc/sys/kernel/random/uuid.
#
# @exitcode 0  If successful.
#
# @stdout A randomly generated UUID string.
#
# @example
#   misc::generate_uuid  # outputs e.g. 65bc64d1-d355-4ffc-a9d9-dc4f3954c34c
# --------------------------------------------
misc::generate_uuid() {
  local C="89ab"
  local N B

  for (( N = 0; N < 16; ++N )); do
    B=$(( RANDOM % 256 ))

    case "${N}" in
      6)        printf '4%x'                                   "$(( B % 16 ))"  ;;
      8)        printf '%c%x'  "${C:RANDOM%${#C}:1}"           "$(( B % 16 ))"  ;;
      3|5|7|9)  printf '%02x-'                                 "${B}"           ;;
      *)        printf '%02x'                                  "${B}"           ;;
    esac
  done

  printf '\n'
}
