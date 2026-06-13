#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# ⏱️ EgoHygiene Library — Time Helpers
# ============================================
#
# Provides portable, side-effect-free helpers for
# common shell time formats.
#
# Guarantees:
# - Idempotent
# - Cross-platform friendly
# - No logging
# - No exits (caller handles errors)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_TIME_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_TIME_LOADED="true"

# --------------------------------------------
# 🔎 Internal Helpers
# --------------------------------------------

time::__has_command() {
  command -v "$1" >/dev/null 2>&1
}

# --------------------------------------------
# 🕒 Unix Epoch Seconds (UTC)
# --------------------------------------------
time::epoch() {
  date -u '+%s'
}

# --------------------------------------------
# 🕒 Unix Epoch Milliseconds (UTC)
# --------------------------------------------
#
# Tries, in order:
# 1. EPOCHREALTIME (bash/zsh when available)
# 2. GNU date %3N
# 3. python3
# 4. perl Time::HiRes
# 5. second precision fallback
#
time::epoch_ms() {
  if [[ -n "${EPOCHREALTIME:-}" ]]; then
    local seconds fractional milliseconds

    seconds="${EPOCHREALTIME%.*}"
    fractional="${EPOCHREALTIME#*.}"
    fractional="${fractional%%[^0-9]*}"
    fractional="${fractional}000"
    milliseconds="${fractional:0:3}"

    printf '%s%03d\n' "${seconds}" "$((10#${milliseconds}))"
    return 0
  fi

  local date_epoch_ms

  date_epoch_ms="$(date '+%s%3N' 2>/dev/null || printf '')"
  if [[ "${date_epoch_ms}" =~ ^[0-9]+$ ]]; then
    printf '%s\n' "${date_epoch_ms}"
    return 0
  fi

  if time::__has_command "python3"; then
    python3 - <<'PY'
import time
print(int(time.time_ns() // 1_000_000))
PY
    return $?
  fi

  if time::__has_command "perl"; then
    perl -MTime::HiRes=time -e 'printf "%d\n", int(time() * 1000)'
    return $?
  fi

  local epoch_seconds
  epoch_seconds="$(time::epoch)" || return $?
  printf '%s000\n' "${epoch_seconds}"
}

# --------------------------------------------
# 📅 Local Timestamp
# --------------------------------------------
time::timestamp() {
  date '+%Y-%m-%d %H:%M:%S'
}

# --------------------------------------------
# 🌍 UTC Timestamp
# --------------------------------------------
time::utc_timestamp() {
  TZ=UTC date '+%Y-%m-%d %H:%M:%S'
}

# --------------------------------------------
# 🌍 ISO8601 UTC Timestamp
# --------------------------------------------
time::iso8601() {
  TZ=UTC date '+%Y-%m-%dT%H:%M:%SZ'
}
