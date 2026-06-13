#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 🔤 EgoHygiene Extension — Fonts
# ============================================
#
# Cross-platform font querying helpers.
#
# Guarantees:
# - Pure functions (stdout only)
# - No logging, no exits
# - Fail-soft (return non-zero if unsupported)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_EXT_FONTS_LOADED:-}" ]]; then
  return 0
fi
export EGOHYGIENE_EXT_FONTS_LOADED="true"

# --------------------------------------------
# 🔎 Internal helpers
# --------------------------------------------

_fonts__has() {
  command -v "$1" >/dev/null 2>&1
}

# Normalize output to: "Family Name: /path/to/file"
# --------------------------------------------

# --------------------------------------------
# 🐧 Linux (fontconfig)
# --------------------------------------------
fonts::list_linux() {
  _fonts__has fc-list || return 127

  # family: file
  fc-list : family file 2>/dev/null \
    | sed 's/,.*:/:/'  # pick first family if multiple
}

# --------------------------------------------
# 🍎 macOS
# --------------------------------------------
fonts::list_macos() {
  _fonts__has system_profiler || return 127

  system_profiler SPFontsDataType 2>/dev/null \
    | awk -F: '
      /^[[:space:]]*Full Name:/ {
        name=$2; gsub(/^[[:space:]]+/, "", name)
      }
      /^[[:space:]]*Location:/ {
        file=$2; gsub(/^[[:space:]]+/, "", file)
        if (name && file) {
          printf "%s: %s\n", name, file
          name=""; file=""
        }
      }'
}

# --------------------------------------------
# 🪟 Windows (via PowerShell)
# --------------------------------------------
fonts::list_windows() {
  _fonts__has powershell.exe || return 127

  powershell.exe -NoProfile -Command - <<'POWERSHELL' 2>/dev/null
    $key = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
    Get-ItemProperty $key | Get-Member -MemberType NoteProperty | ForEach-Object {
      $name = $_.Name
      $file = (Get-ItemPropertyValue $key $name)
      "$name: $file"
    }
POWERSHELL
}

# --------------------------------------------
# 🌍 Auto-detect
# --------------------------------------------
fonts::list_raw() {
  local os
  os="$(uname -s 2>/dev/null || printf "unknown")"

  case "${os}" in
    Linux)
      fonts::list_linux && return 0
      ;;
    Darwin)
      fonts::list_macos && return 0
      ;;
    MINGW*|MSYS*|CYGWIN*)
      fonts::list_windows && return 0
      ;;
  esac

  return 1
}

# --------------------------------------------
# 📦 Normalized API (preferred)
# --------------------------------------------
#
# Usage:
#   fonts::list
#
fonts::list() {
  fonts::list_raw
}

# --------------------------------------------
# 🧾 JSON Output (optional helper)
# --------------------------------------------
#
# Emits: [{"name":"...", "path":"..."}]
#
fonts::list_json() {
  fonts::list_raw \
    | awk -F': ' '
      BEGIN { print "[" }
      {
        printf "%s{\"name\":\"%s\",\"path\":\"%s\"}",
               (NR>1?",":""), $1, $2
      }
      END { print "]" }'
}
