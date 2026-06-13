#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 📣 EgoHygiene Library — Structured Logging
# ============================================
#
# Provides structured console logging via the log:: namespace.
#
# Features:
# - Consistent formatting
# - stderr-only output (safe for pipelines)
# - Color support (optional)
# - Debug gating
#
# Guarantees:
# - Idempotent
# - Cross-platform
# - Fail-safe
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_LOGGING_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_LOGGING_LOADED="true"

# --------------------------------------------
# 🧠 Internal Formatter
# --------------------------------------------
#
# Usage:
#   log::__print "level" "color" "message"
#

log::__print() {
  local level="$1"
  local color_prefix="$2"
  local message="$3"

  # shellcheck disable=SC2059
  printf "%b[%s]%b %s\n" \
    "${color_prefix}" \
    "${level}" \
    "${COLOR_RESET:-}" \
    "${message}" >&2
}

# --------------------------------------------
# ℹ️ log::info
# --------------------------------------------
log::info() {
  log::__print "info" "${COLOR_BOLD_BLUE:-}" "$*"
}

# --------------------------------------------
# ⚠️ log::warn
# --------------------------------------------
log::warn() {
  log::__print "warn" "${COLOR_BOLD_YELLOW:-}" "$*"
}

# --------------------------------------------
# ❌ log::error
# --------------------------------------------
log::error() {
  log::__print "error" "${COLOR_BOLD_RED:-}" "$*"
}

# --------------------------------------------
# ✅ log::success
# --------------------------------------------
log::success() {
  log::__print "ok" "${COLOR_BOLD_GREEN:-}" "$*"
}

# --------------------------------------------
# 🐞 log::debug
# --------------------------------------------
#
# Only prints when debug mode is enabled
#
log::debug() {
  [[ "${EGOHYGIENE_SHELL_DEBUG:-0}" == "1" ]] || return 0
  log::__print "debug" "${COLOR_DIM:-}" "$*"
}
