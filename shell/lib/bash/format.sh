#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 📚 EgoHygiene Library — Bash Format Utilities
# ============================================
#
# Provides output formatting helpers for terminal-facing scripts.
# These functions use COLUMNS and Bash string slicing, so they are
# not POSIX-portable.
#
# Note: The terminal window-size check is available as a standalone
# function (format::init_window_size) and is NOT called automatically
# on sourcing this file.
#
# Guarantees:
# - Idempotent
# - No automatic side effects on source
# - Bash-only (not POSIX-portable)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_BASH_FORMAT_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_BASH_FORMAT_LOADED="true"

# --------------------------------------------
# 🔎 format::init_window_size
#
# Enable dynamic terminal size tracking.
# Updates LINES and COLUMNS on SIGWINCH.
# Call this explicitly when COLUMNS-dependent functions are needed.
#
# @noargs
# --------------------------------------------
format::init_window_size() {
  shopt -s checkwinsize && (: && :)
  trap 'shopt -s checkwinsize; (:;:)' SIGWINCH
}

# --------------------------------------------
# 🔎 format::human_readable_seconds
#
# Format a duration given in seconds into a human-readable string.
#
# @arg $1 int  Number of seconds.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Human-readable duration string.
#
# @example
#   format::human_readable_seconds 356786
#   # outputs: 4 days 3 hours 6 minute(s) and 26 seconds
# --------------------------------------------
format::human_readable_seconds() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local total="${1}"
  local days=$(( total / 60 / 60 / 24 ))
  local hours=$(( total / 60 / 60 % 24 ))
  local minutes=$(( total / 60 % 60 ))
  local seconds=$(( total % 60 ))

  [[ "${days}" -gt 0 ]]    && printf '%d days ' "${days}"
  [[ "${hours}" -gt 0 ]]   && printf '%d hours ' "${hours}"
  [[ "${minutes}" -gt 0 ]] && printf '%d minute(s) ' "${minutes}"
  [[ "${days}" -gt 0 || "${hours}" -gt 0 || "${minutes}" -gt 0 ]] && printf 'and '
  printf '%d seconds\n' "${seconds}"
}

# --------------------------------------------
# 🔎 format::bytes_to_human
#
# Format a byte count into a human-readable size string.
#
# @arg $1 int  Size in bytes.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Human-readable size string (e.g. "2.19 KB").
#
# @example
#   format::bytes_to_human 2250  # outputs 2.19 KB
# --------------------------------------------
format::bytes_to_human() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local b="${1:-0}"
  local d=''
  local s=0
  local -a units=(Bytes {K,M,G,T,P,E,Y,Z}B)

  while (( b > 1024 )); do
    d="$(printf ".%02d" $(( b % 1024 * 100 / 1024 )))"
    b=$(( b / 1024 ))
    (( s++ ))
  done

  printf "%s\n" "${b}${d} ${units[${s}]}"
}

# --------------------------------------------
# 🔎 format::strip_ansi
#
# Remove ANSI escape sequences from a string.
#
# @arg $1 string  Input string containing ANSI escape codes.
#
# @exitcode 0  If successful.
#
# @stdout String with all ANSI escape sequences removed.
#
# @example
#   format::strip_ansi "\e[1mBold text\e[0m"  # outputs: Bold text
# --------------------------------------------
format::strip_ansi() {
  local tmp="${1}"
  local esc tpa re

  esc="$(printf "\x1b")"
  tpa="$(printf "\x28")"
  re="(.*)${esc}[\[${tpa}][0-9]*;*[mKB](.*)"

  while [[ "${tmp}" =~ ${re} ]]; do
    tmp="${BASH_REMATCH[1]}${BASH_REMATCH[2]}"
  done

  printf "%s\n" "${tmp}"
}

# --------------------------------------------
# 🔎 format::text_center
#
# Print text centered in the terminal width.
# Optionally surrounds the text with a fill character.
#
# @arg $1 string  Text to center.
# @arg $2 string  Fill character (optional, defaults to space).
#
# @exitcode 0  If successful.
# @exitcode 1  If arguments are missing.
#
# @stdout Centered, padded text.
#
# @example
#   format::text_center "Hello" "-"
# --------------------------------------------
format::text_center() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 1

  local input="${1}"
  local symbol="${2:- }"
  local no_ansi_out filler out
  local -i str_len filler_len i

  no_ansi_out="$(format::strip_ansi "${input}")"
  str_len=${#no_ansi_out}
  filler_len=$(( (COLUMNS - str_len) / 2 ))

  symbol="${symbol:0:1}"
  filler=""
  for (( i = 0; i < filler_len; i++ )); do
    filler+="${symbol}"
  done

  out="${filler}${input}${filler}"
  [[ $(( (COLUMNS - str_len) % 2 )) -ne 0 ]] && out+="${symbol}"
  printf "%s\n" "${out}"
}

# --------------------------------------------
# 🔎 format::report
#
# Print a formatted key-value report line with dot padding.
#
# @arg $1 string  Label text (left side).
# @arg $2 string  Status text (right side, placed inside brackets).
#
# @exitcode 0  If successful.
# @exitcode 1  If arguments are missing.
#
# @stdout Formatted report line.
#
# @example
#   format::report "Initialising" "Success"
#   # Initialising ...................................[ Success ]
# --------------------------------------------
format::report() {
  [[ $# -lt 2 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 1

  local symbol="."
  local input1="${1} "
  local input2="[ ${2} ]"
  local to_print hl hlout out

  to_print=$(( COLUMNS * 60 / 100 ))
  local y=$(( to_print - ( ${#input1} + ${#input2} ) ))
  hl="$(printf '%*s' "${y}" '')"
  hlout="${hl// /${symbol}}"
  out="${input1}${hlout}${input2}"

  printf "%s\n" "${out}"
}

# --------------------------------------------
# 🔎 format::trim_text_to_term
#
# Trim text to fit within the current terminal width.
# Accepts one or two text segments.
#
# @arg $1 string  First text segment.
# @arg $2 string  Second text segment (optional).
#
# @exitcode 0  If successful.
# @exitcode 1  If arguments are missing.
#
# @stdout Trimmed text.
# --------------------------------------------
format::trim_text_to_term() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 1

  local input1="${1}"
  local input2="${2:-}"
  local to_print out=""

  if [[ $# -eq 1 ]]; then
    to_print=$(( COLUMNS * 93 / 100 ))
    if [[ ${#input1} -gt ${to_print} ]]; then
      out="${input1:0:${to_print}}.."
    else
      out="${input1}"
    fi
  else
    to_print=$(( COLUMNS * 40 / 100 ))
    if [[ ${#input1} -gt ${to_print} ]]; then
      out+=" ${input1:0:${to_print}}.."
    else
      out+=" ${input1}"
    fi

    to_print=$(( COLUMNS * 53 / 100 ))
    if [[ ${#input2} -gt ${to_print} ]]; then
      out+="${input2:0:${to_print}}.. "
    else
      out+="${input2} "
    fi
  fi

  printf "%s\n" "${out}"
}
