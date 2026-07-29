#!/usr/bin/env bash
# shellcheck shell=bash

if [[ -n "${EGOHYGIENE_PLATFORM_LINUX_LOADED:-}" ]]; then
  return 0
fi
export EGOHYGIENE_PLATFORM_LINUX_LOADED="true"
export EGOHYGIENE_PLATFORM_RUNTIME="linux"

if [[ -d "/snap/bin" ]]; then
  core::path_append "/snap/bin"
fi

if [[ -d "/var/lib/snapd/desktop" ]]; then
  case ":${XDG_DATA_DIRS:-}:" in
    *":/var/lib/snapd/desktop:"*) ;;
    *) export XDG_DATA_DIRS="${XDG_DATA_DIRS:+${XDG_DATA_DIRS}:}/var/lib/snapd/desktop" ;;
  esac
fi

if [[ -r "${EGOHYGIENE_SHELL_ROOT}/platforms/linux/aliases.sh" ]]; then
  # shellcheck disable=SC1091
  source "${EGOHYGIENE_SHELL_ROOT}/platforms/linux/aliases.sh"
fi
