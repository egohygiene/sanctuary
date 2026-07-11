#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 📚 EgoHygiene Library — Bash Date Utilities
# ============================================
#
# Provides date arithmetic and formatting helpers.
#
# Note: This module requires GNU date (e.g. via coreutils on Linux or
# Homebrew's `gdate` on macOS). Functions will fail gracefully on systems
# that ship only BSD date.
#
# For portable epoch/timestamp helpers, see: lib/core/time.sh
#
# Guarantees:
# - Idempotent
# - No side effects
# - Bash-only (not POSIX-portable)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_BASH_DATE_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_BASH_DATE_LOADED="true"

# --------------------------------------------
# 🔎 date::now
#
# Return the current Unix timestamp (UTC).
#
# @exitcode 0  If successful.
# @exitcode 1  If the date command fails.
#
# @stdout Current Unix timestamp (seconds since epoch).
# --------------------------------------------
date::now() {
  local now
  now="$(date --universal +%s)" || return $?
  printf "%s\n" "${now}"
}

# --------------------------------------------
# 🔎 date::to_epoch
#
# Convert a datetime string to a Unix timestamp.
#
# @arg $1 string  Datetime string in any format accepted by GNU date.
#
# @exitcode 0  If successful.
# @exitcode 1  If the conversion fails.
# @exitcode 2  If arguments are missing.
#
# @stdout Unix timestamp for the given datetime.
#
# @example
#   date::to_epoch "2020-07-07 18:38"  # outputs 1594143480
# --------------------------------------------
date::to_epoch() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local result
  result="$(date -d "${1}" +"%s")" || return $?
  printf "%s\n" "${result}"
}

# --------------------------------------------
# 🔎 date::format
#
# Format a Unix timestamp as a human-readable date string.
# Defaults to "YYYY-MM-DD HH:MM:SS" format.
#
# @arg $1 int     Unix timestamp.
# @arg $2 string  Format string (optional, defaults to "%F %T").
#
# @exitcode 0  If successful.
# @exitcode 1  If formatting fails.
# @exitcode 2  If arguments are missing.
#
# @stdout Formatted date string.
#
# @example
#   date::format "1594143480"           # 2020-07-07 18:38:00
#   date::format "1594143480" "%Y-%m-%d" # 2020-07-07
# --------------------------------------------
date::format() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local timestamp="${1}"
  local fmt="${2:-%F %T}"
  local out

  out="$(date -d "@${timestamp}" +"${fmt}")" || return $?
  printf "%s\n" "${out}"
}

# --------------------------------------------
# 🔎 date::add_days_from
#
# Add days to a Unix timestamp. Defaults to 1 day.
#
# @arg $1 int  Unix timestamp.
# @arg $2 int  Number of days to add (optional, defaults to 1).
#
# @exitcode 0  If successful.
# @exitcode 1  If the operation fails.
# @exitcode 2  If arguments are missing.
#
# @stdout Resulting Unix timestamp.
# --------------------------------------------
date::add_days_from() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local timestamp="${1}"
  local days="${2:-1}"
  local new_timestamp

  new_timestamp="$(date -d "$(date -d "@${timestamp}" '+%F %T')+${days} day" +'%s')" || return $?
  printf "%s\n" "${new_timestamp}"
}

# --------------------------------------------
# 🔎 date::add_weeks_from
#
# Add weeks to a Unix timestamp. Defaults to 1 week.
#
# @arg $1 int  Unix timestamp.
# @arg $2 int  Number of weeks to add (optional, defaults to 1).
#
# @exitcode 0  If successful.
# @exitcode 1  If the operation fails.
# @exitcode 2  If arguments are missing.
#
# @stdout Resulting Unix timestamp.
# --------------------------------------------
date::add_weeks_from() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local timestamp="${1}"
  local weeks="${2:-1}"
  local new_timestamp

  new_timestamp="$(date -d "$(date -d "@${timestamp}" '+%F %T')+${weeks} week" +'%s')" || return $?
  printf "%s\n" "${new_timestamp}"
}

# --------------------------------------------
# 🔎 date::add_months_from
#
# Add months to a Unix timestamp. Defaults to 1 month.
#
# @arg $1 int  Unix timestamp.
# @arg $2 int  Number of months to add (optional, defaults to 1).
#
# @exitcode 0  If successful.
# @exitcode 1  If the operation fails.
# @exitcode 2  If arguments are missing.
#
# @stdout Resulting Unix timestamp.
# --------------------------------------------
date::add_months_from() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local timestamp="${1}"
  local months="${2:-1}"
  local new_timestamp

  new_timestamp="$(date -d "$(date -d "@${timestamp}" '+%F %T')+${months} month" +'%s')" || return $?
  printf "%s\n" "${new_timestamp}"
}

# --------------------------------------------
# 🔎 date::add_years_from
#
# Add years to a Unix timestamp. Defaults to 1 year.
#
# @arg $1 int  Unix timestamp.
# @arg $2 int  Number of years to add (optional, defaults to 1).
#
# @exitcode 0  If successful.
# @exitcode 1  If the operation fails.
# @exitcode 2  If arguments are missing.
#
# @stdout Resulting Unix timestamp.
# --------------------------------------------
date::add_years_from() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local timestamp="${1}"
  local years="${2:-1}"
  local new_timestamp

  new_timestamp="$(date -d "$(date -d "@${timestamp}" '+%F %T')+${years} year" +'%s')" || return $?
  printf "%s\n" "${new_timestamp}"
}

# --------------------------------------------
# 🔎 date::sub_days_from
#
# Subtract days from a Unix timestamp. Defaults to 1 day.
#
# @arg $1 int  Unix timestamp.
# @arg $2 int  Number of days to subtract (optional, defaults to 1).
#
# @exitcode 0  If successful.
# @exitcode 1  If the operation fails.
# @exitcode 2  If arguments are missing.
#
# @stdout Resulting Unix timestamp.
# --------------------------------------------
date::sub_days_from() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local timestamp="${1}"
  local days="${2:-1}"
  local new_timestamp

  new_timestamp="$(date -d "$(date -d "@${timestamp}" '+%F %T') ${days} days ago" +'%s')" || return $?
  printf "%s\n" "${new_timestamp}"
}

# --------------------------------------------
# 🔎 date::sub_weeks_from
#
# Subtract weeks from a Unix timestamp. Defaults to 1 week.
#
# @arg $1 int  Unix timestamp.
# @arg $2 int  Number of weeks to subtract (optional, defaults to 1).
#
# @exitcode 0  If successful.
# @exitcode 1  If the operation fails.
# @exitcode 2  If arguments are missing.
#
# @stdout Resulting Unix timestamp.
# --------------------------------------------
date::sub_weeks_from() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local timestamp="${1}"
  local weeks="${2:-1}"
  local new_timestamp

  new_timestamp="$(date -d "$(date -d "@${timestamp}" '+%F %T') ${weeks} weeks ago" +'%s')" || return $?
  printf "%s\n" "${new_timestamp}"
}

# --------------------------------------------
# 🔎 date::sub_months_from
#
# Subtract months from a Unix timestamp. Defaults to 1 month.
#
# @arg $1 int  Unix timestamp.
# @arg $2 int  Number of months to subtract (optional, defaults to 1).
#
# @exitcode 0  If successful.
# @exitcode 1  If the operation fails.
# @exitcode 2  If arguments are missing.
#
# @stdout Resulting Unix timestamp.
# --------------------------------------------
date::sub_months_from() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local timestamp="${1}"
  local months="${2:-1}"
  local new_timestamp

  new_timestamp="$(date -d "$(date -d "@${timestamp}" '+%F %T') ${months} months ago" +'%s')" || return $?
  printf "%s\n" "${new_timestamp}"
}

# --------------------------------------------
# 🔎 date::sub_years_from
#
# Subtract years from a Unix timestamp. Defaults to 1 year.
#
# @arg $1 int  Unix timestamp.
# @arg $2 int  Number of years to subtract (optional, defaults to 1).
#
# @exitcode 0  If successful.
# @exitcode 1  If the operation fails.
# @exitcode 2  If arguments are missing.
#
# @stdout Resulting Unix timestamp.
# --------------------------------------------
date::sub_years_from() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local timestamp="${1}"
  local years="${2:-1}"
  local new_timestamp

  new_timestamp="$(date -d "$(date -d "@${timestamp}" '+%F %T') ${years} years ago" +'%s')" || return $?
  printf "%s\n" "${new_timestamp}"
}

# --------------------------------------------
# 🔎 date::sub_hours_from
#
# Subtract hours from a Unix timestamp. Defaults to 1 hour.
#
# @arg $1 int  Unix timestamp.
# @arg $2 int  Number of hours to subtract (optional, defaults to 1).
#
# @exitcode 0  If successful.
# @exitcode 1  If the operation fails.
# @exitcode 2  If arguments are missing.
#
# @stdout Resulting Unix timestamp.
# --------------------------------------------
date::sub_hours_from() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local timestamp="${1}"
  local hours="${2:-1}"
  local new_timestamp

  new_timestamp="$(date -d "$(date -d "@${timestamp}" '+%F %T') ${hours} hours ago" +'%s')" || return $?
  printf "%s\n" "${new_timestamp}"
}

# --------------------------------------------
# 🔎 date::sub_minutes_from
#
# Subtract minutes from a Unix timestamp. Defaults to 1 minute.
#
# @arg $1 int  Unix timestamp.
# @arg $2 int  Number of minutes to subtract (optional, defaults to 1).
#
# @exitcode 0  If successful.
# @exitcode 1  If the operation fails.
# @exitcode 2  If arguments are missing.
#
# @stdout Resulting Unix timestamp.
# --------------------------------------------
date::sub_minutes_from() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local timestamp="${1}"
  local minutes="${2:-1}"
  local new_timestamp

  new_timestamp="$(date -d "$(date -d "@${timestamp}" '+%F %T') ${minutes} minutes ago" +'%s')" || return $?
  printf "%s\n" "${new_timestamp}"
}

# --------------------------------------------
# 🔎 date::sub_seconds_from
#
# Subtract seconds from a Unix timestamp. Defaults to 1 second.
#
# @arg $1 int  Unix timestamp.
# @arg $2 int  Number of seconds to subtract (optional, defaults to 1).
#
# @exitcode 0  If successful.
# @exitcode 1  If the operation fails.
# @exitcode 2  If arguments are missing.
#
# @stdout Resulting Unix timestamp.
# --------------------------------------------
date::sub_seconds_from() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local timestamp="${1}"
  local seconds="${2:-1}"
  local new_timestamp

  new_timestamp="$(date -d "$(date -d "@${timestamp}" '+%F %T') ${seconds} seconds ago" +'%s')" || return $?
  printf "%s\n" "${new_timestamp}"
}
