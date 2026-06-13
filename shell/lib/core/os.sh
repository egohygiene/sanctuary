#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 🧠 EgoHygiene Library — OS Detection
# ============================================
#
# Provides OS detection and platform helpers via the os:: namespace.
#
# Exports:
#   OS_FAMILY   → darwin | linux | windows | unknown
#   OS_ARCH     → x86_64 | arm64 | etc
#   OS_DISTRO   → ubuntu | arch | etc (linux only, best-effort)
#   IS_CONTAINER → 1 | 0
#
# Guarantees:
#   - Idempotent (safe to source multiple times)
#   - Cross-platform (macOS, Linux, containers)
#   - Fail-soft (never crashes shell)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_OS_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_OS_LOADED="true"

# --------------------------------------------
# 🧠 OS Family Detection
# --------------------------------------------

_os_kernel="$(uname -s 2>/dev/null || printf "unknown")"

case "${_os_kernel}" in
  Darwin)               OS_FAMILY="darwin"  ;;
  Linux)                OS_FAMILY="linux"   ;;
  MINGW*|MSYS*|CYGWIN*) OS_FAMILY="windows" ;;
  *)                    OS_FAMILY="unknown" ;;
esac

export OS_FAMILY
unset _os_kernel

# --------------------------------------------
# 🧠 Architecture Detection
# --------------------------------------------

OS_ARCH="$(uname -m 2>/dev/null || printf "unknown")"
export OS_ARCH

# --------------------------------------------
# 🧠 Linux Distro Detection (Best Effort)
# --------------------------------------------

OS_DISTRO="unknown"

if [[ "${OS_FAMILY}" == "linux" ]]; then
  if [[ -f "/etc/os-release" ]]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    OS_DISTRO="${ID:-unknown}"
  fi
fi

export OS_DISTRO

# --------------------------------------------
# 🐳 Container Detection (Best Effort)
# --------------------------------------------

IS_CONTAINER="0"

if [[ -f "/.dockerenv" ]]; then
  IS_CONTAINER="1"
elif [[ -f "/proc/1/cgroup" ]] && grep -qE "docker|containerd|kubepods" /proc/1/cgroup 2>/dev/null; then
  IS_CONTAINER="1"
fi

export IS_CONTAINER

# --------------------------------------------
# 🔎 Public API — Detection Helpers
# --------------------------------------------

os::detect() {
  printf "%s\n" "${OS_FAMILY}"
}

os::arch() {
  printf "%s\n" "${OS_ARCH}"
}

os::distro() {
  printf "%s\n" "${OS_DISTRO}"
}

# --------------------------------------------
# 🔎 Public API — Boolean Checks
# --------------------------------------------

os::is_macos() {
  [[ "${OS_FAMILY}" == "darwin" ]]
}

os::is_linux() {
  [[ "${OS_FAMILY}" == "linux" ]]
}

os::is_windows() {
  [[ "${OS_FAMILY}" == "windows" ]]
}

os::is_wsl() {
  [[ "${OS_FAMILY}" == "linux" ]] && \
  [[ -f "/proc/version" ]] && \
  grep -qi "microsoft" /proc/version 2>/dev/null
}

os::is_container() {
  [[ "${IS_CONTAINER}" == "1" ]]
}

# --------------------------------------------
# 🧠 Human-Friendly Name
# --------------------------------------------

os::name() {
  if os::is_wsl; then
    printf "WSL"
  elif os::is_macos; then
    printf "macOS"
  elif os::is_linux; then
    printf "Linux"
  elif os::is_windows; then
    printf "Windows"
  else
    printf "unknown"
  fi
}
