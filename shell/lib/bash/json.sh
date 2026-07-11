#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 📚 EgoHygiene Library — Bash JSON Utilities
# ============================================
#
# Provides simple JSON key extraction.
# For complex JSON processing, use jq instead.
#
# Guarantees:
# - Idempotent
# - No side effects
# - Bash-only (not POSIX-portable)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_BASH_JSON_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_BASH_JSON_LOADED="true"

# --------------------------------------------
# 🔎 json::get_value
#
# Extract a scalar value from JSON by key name.
# Input can be a pipe, here-string, or file redirect.
#
# For complex JSON, prefer jq.
#
# @arg $1 string  Key name to extract.
# @arg $2 int     Occurrence index (optional, defaults to 1).
#
# @exitcode 0  If the key is found.
# @exitcode 2  If arguments are missing.
#
# @stdin  JSON string.
# @stdout Extracted value.
#
# @example
#   echo '{"id":"123","name":"foo"}' | json::get_value "id"
#   # outputs: 123
#
#   json::get_value "id" <<< '{"id":"123"}'
#   # outputs: 123
# --------------------------------------------
json::get_value() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local key="${1}"
  local occurrence="${2:-1}"

  # shellcheck disable=SC2312
  LC_ALL=C grep -o "\"${key}\":.*" \
    | sed \
        -e "s/.*\"${key}\": //" \
        -e 's/[",]*$//' \
        -e 's/["]*$//' \
        -e 's/[,]*$//' \
        -e 's/^"//' \
        -n \
        -e "${occurrence}p"
}
