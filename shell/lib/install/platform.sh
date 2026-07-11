#!/usr/bin/env bash
# shellcheck shell=bash

if [[ -n "${EGOHYGIENE_LIB_INSTALL_PLATFORM_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_INSTALL_PLATFORM_LOADED="true"

install::platform::family() {
  printf "%s\n" "${OS_FAMILY:-$(os::detect)}"
}

install::platform::arch() {
  printf "%s\n" "${OS_ARCH:-$(os::arch)}"
}

install::platform::map_family() {
  local linux_name="${1:-linux}"
  local darwin_name="${2:-darwin}"
  local windows_name="${3:-windows}"
  local family

  family="$(install::platform::family)"

  case "${family}" in
    linux) printf "%s\n" "${linux_name}" ;;
    darwin) printf "%s\n" "${darwin_name}" ;;
    windows) printf "%s\n" "${windows_name}" ;;
    *)
      log::error "Unsupported operating system: ${family}"
      return 1
      ;;
  esac
}

install::platform::map_arch() {
  local amd64_name="${1:-amd64}"
  local arm64_name="${2:-arm64}"
  local armv7_name="${3:-armv7}"
  local armv6_name="${4:-armv6}"
  local x86_name="${5:-386}"
  local arch

  arch="$(install::platform::arch)"

  case "${arch}" in
    x86_64|amd64) printf "%s\n" "${amd64_name}" ;;
    aarch64|arm64) printf "%s\n" "${arm64_name}" ;;
    armv7l|armv7) printf "%s\n" "${armv7_name}" ;;
    armv6l|armv6) printf "%s\n" "${armv6_name}" ;;
    i386|i686) printf "%s\n" "${x86_name}" ;;
    *)
      log::error "Unsupported architecture: ${arch}"
      return 1
      ;;
  esac
}
