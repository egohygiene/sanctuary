#!/usr/bin/env bash
# shellcheck shell=bash
#
# Minimal MSYS2/Git Bash compatibility layer. Native PowerShell is outside the
# scope of this shell runtime.

if [[ -n "${EGOHYGIENE_PLATFORM_WINDOWS_LOADED:-}" ]]; then
  return 0
fi
export EGOHYGIENE_PLATFORM_WINDOWS_LOADED="true"
export EGOHYGIENE_PLATFORM_RUNTIME="windows"
