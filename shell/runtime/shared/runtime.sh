#!/usr/bin/env bash
#
# ============================================
# 📚 EgoHygiene Runtime — Shared Layer
# ============================================
#
# Shared runtime libraries loaded for every shell runtime.
#

if [[ -n "${EGOHYGIENE_RUNTIME_SHARED_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_RUNTIME_SHARED_LOADED="true"

shared_runtime_library_file_list=(
  "colors.sh"
  "logging.sh"
  "guards.sh"
  "core.sh"
  "time.sh"
)

for shared_runtime_library in "${shared_runtime_library_file_list[@]}"; do
  shared_runtime_library_path="${EGOHYGIENE_SHELL_ROOT}/lib/core/${shared_runtime_library}"

  if [[ -f "${shared_runtime_library_path}" && -r "${shared_runtime_library_path}" ]]; then
    # shellcheck disable=SC1090
    source "${shared_runtime_library_path}"
  else
    printf "[warn] shared runtime: missing library: %s\n" "${shared_runtime_library}" >&2
  fi
done

unset shared_runtime_library
unset shared_runtime_library_file_list
unset shared_runtime_library_path
