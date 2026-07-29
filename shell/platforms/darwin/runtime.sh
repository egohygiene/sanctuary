#!/usr/bin/env bash
# shellcheck shell=bash

if [[ -n "${EGOHYGIENE_PLATFORM_DARWIN_LOADED:-}" ]]; then
  return 0
fi
export EGOHYGIENE_PLATFORM_DARWIN_LOADED="true"
export EGOHYGIENE_PLATFORM_RUNTIME="darwin"

for darwin_path in "/opt/homebrew/bin" "/opt/homebrew/sbin" "/usr/local/bin" "/usr/local/sbin"; do
  if [[ -d "${darwin_path}" ]]; then
    core::path_append "${darwin_path}"
  fi
done
unset darwin_path

if [[ -r "${EGOHYGIENE_SHELL_ROOT}/platforms/darwin/aliases.sh" ]]; then
  # shellcheck disable=SC1091
  source "${EGOHYGIENE_SHELL_ROOT}/platforms/darwin/aliases.sh"
fi
