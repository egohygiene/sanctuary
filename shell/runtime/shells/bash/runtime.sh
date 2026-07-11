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

bash_runtime_library_path="${EGOHYGIENE_SHELL_ROOT}/lib/core/bash.sh"

if [[ -f "${bash_runtime_library_path}" && -r "${bash_runtime_library_path}" ]]; then
  # shellcheck disable=SC1090
  source "${bash_runtime_library_path}"
else
  printf "[warn] bash runtime: missing library: %s\n" "${bash_runtime_library_path}" >&2
fi

unset bash_runtime_library_path
