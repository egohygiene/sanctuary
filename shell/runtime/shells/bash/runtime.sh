#!/usr/bin/env bash
#
# ============================================
# 🐚 EgoHygiene Runtime — Bash Layer
# ============================================
#

if [[ -n "${EGOHYGIENE_RUNTIME_BASH_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_RUNTIME_BASH_LOADED="true"

runtime_library_path="${EGOHYGIENE_SHELL_ROOT}/lib/core/bash.sh"

if [[ -f "${runtime_library_path}" && -r "${runtime_library_path}" ]]; then
  # shellcheck disable=SC1090
  source "${runtime_library_path}"
else
  printf "[warn] bash runtime: missing library: %s\n" "${runtime_library_path}" >&2
fi

unset runtime_library_path
