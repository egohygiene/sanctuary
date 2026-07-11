#!/bin/sh
#
# ============================================
# 📚 EgoHygiene Runtime — Shared Layer
# ============================================
#
# Shared runtime libraries loaded for every shell runtime.
#

if [ -n "${EGOHYGIENE_RUNTIME_SHARED_LOADED:-}" ]; then
  return 0
fi

export EGOHYGIENE_RUNTIME_SHARED_LOADED="true"

shared_runtime_library_files="colors.sh logging.sh guards.sh core.sh time.sh"

for shared_runtime_library_file in ${shared_runtime_library_files}; do
  shared_runtime_library_path="${EGOHYGIENE_SHELL_ROOT}/lib/core/${shared_runtime_library_file}"

  if [ -f "${shared_runtime_library_path}" ] && [ -r "${shared_runtime_library_path}" ]; then
    # shellcheck disable=SC1090
    . "${shared_runtime_library_path}"
  else
    printf "[warn] shared runtime: missing library: %s\n" "${shared_runtime_library_file}" >&2
  fi
done

unset shared_runtime_library_file
unset shared_runtime_library_files
unset shared_runtime_library_path
