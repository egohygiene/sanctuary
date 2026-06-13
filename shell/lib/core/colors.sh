#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 🎨 EgoHygiene Library — Terminal Colors
# ============================================
#
# Provides ANSI color variables for logging and UI output.
#
# Behavior:
# - Enabled only when stderr is a TTY
# - Falls back to empty strings in non-interactive contexts
#
# Guarantees:
# - Idempotent
# - Cross-platform
# - Safe for CI / pipes
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_COLORS_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_COLORS_LOADED="true"

# --------------------------------------------
# 🧠 Detect Color Support (stderr-aware)
# --------------------------------------------

EGOHYGIENE_COLORS_ENABLED="0"

if [[ -t 2 ]] && [[ "${NO_COLOR:-}" != "1" ]]; then
  EGOHYGIENE_COLORS_ENABLED="1"
fi

export EGOHYGIENE_COLORS_ENABLED

# --------------------------------------------
# 🎨 Color Definitions
# --------------------------------------------

if [[ "${EGOHYGIENE_COLORS_ENABLED}" == "1" ]]; then
  COLOR_RESET="\033[0m"
  COLOR_BOLD="\033[1m"
  COLOR_DIM="\033[2m"

  COLOR_RED="\033[31m"
  COLOR_GREEN="\033[32m"
  COLOR_YELLOW="\033[33m"
  COLOR_BLUE="\033[34m"
  COLOR_MAGENTA="\033[35m"
  COLOR_CYAN="\033[36m"
  COLOR_WHITE="\033[37m"

  COLOR_BOLD_RED="\033[1;31m"
  COLOR_BOLD_GREEN="\033[1;32m"
  COLOR_BOLD_YELLOW="\033[1;33m"
  COLOR_BOLD_BLUE="\033[1;34m"
  COLOR_BOLD_CYAN="\033[1;36m"
else
  COLOR_RESET=""
  COLOR_BOLD=""
  COLOR_DIM=""

  COLOR_RED=""
  COLOR_GREEN=""
  COLOR_YELLOW=""
  COLOR_BLUE=""
  COLOR_MAGENTA=""
  COLOR_CYAN=""
  COLOR_WHITE=""

  COLOR_BOLD_RED=""
  COLOR_BOLD_GREEN=""
  COLOR_BOLD_YELLOW=""
  COLOR_BOLD_BLUE=""
  COLOR_BOLD_CYAN=""
fi

# --------------------------------------------
# 📦 Export Variables
# --------------------------------------------

export \
  COLOR_RESET COLOR_BOLD COLOR_DIM \
  COLOR_RED COLOR_GREEN COLOR_YELLOW COLOR_BLUE COLOR_MAGENTA COLOR_CYAN COLOR_WHITE \
  COLOR_BOLD_RED COLOR_BOLD_GREEN COLOR_BOLD_YELLOW COLOR_BOLD_BLUE COLOR_BOLD_CYAN
  