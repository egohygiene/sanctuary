#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 🛡️ EgoHygiene Library — Guards & FS Helpers
# ============================================
#
# Provides defensive runtime checks via:
#   guard:: namespace → environment + validation
#   fs:: namespace    → filesystem helpers
#
# Guarantees:
#   - Idempotent (safe to source multiple times)
#   - Cross-platform (macOS, Linux)
#   - Fail-safe (never crashes shell)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_GUARDS_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_GUARDS_LOADED="true"

# --------------------------------------------
# 🔎 guard::has_command
#
# Return 0 if command exists in PATH
# --------------------------------------------
guard::has_command() {
  local command_name="$1"

  [[ -n "${command_name}" ]] || return 1
  command -v "${command_name}" >/dev/null 2>&1
}

# --------------------------------------------
# 📄 guard::file_exists
#
# Return 0 if path is a regular file
# --------------------------------------------
guard::file_exists() {
  local file_path="$1"

  [[ -n "${file_path}" ]] || return 1
  [[ -f "${file_path}" ]]
}

# --------------------------------------------
# 📁 guard::dir_exists
#
# Return 0 if path is a directory
# --------------------------------------------
guard::dir_exists() {
  local directory_path="$1"

  [[ -n "${directory_path}" ]] || return 1
  [[ -d "${directory_path}" ]]
}

# --------------------------------------------
# ⚙️ fs::is_executable
#
# Return 0 if file is executable
# --------------------------------------------
fs::is_executable() {
  local file_path="$1"

  [[ -n "${file_path}" ]] || return 1
  [[ -x "${file_path}" ]]
}

# --------------------------------------------
# 🧾 fs::has_shebang
#
# Return 0 if file starts with "#!"
# --------------------------------------------
fs::has_shebang() {
  local file_path="$1"

  [[ -f "${file_path}" ]] || return 1

  # Read first 2 bytes safely (portable)
  local file_prefix
  file_prefix="$(head -c 2 "${file_path}" 2>/dev/null || printf "")"

  [[ "${file_prefix}" == "#!" ]]
}
