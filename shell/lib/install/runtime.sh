#!/usr/bin/env bash
# shellcheck shell=bash

if [[ -n "${EGOHYGIENE_LIB_INSTALL_RUNTIME_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_INSTALL_RUNTIME_LOADED="true"

if [[ -z "${EGOHYGIENE_SHELL_ROOT:-}" ]]; then
  EGOHYGIENE_SHELL_ROOT="$(
    cd "$(dirname "${BASH_SOURCE[0]}")/../.." >/dev/null 2>&1 && pwd
  )"
  export EGOHYGIENE_SHELL_ROOT
fi

install_core_library_files=(
  "colors.sh"
  "guards.sh"
  "logging.sh"
  "os.sh"
)

for install_core_library_file in "${install_core_library_files[@]}"; do
  install_core_library_path="${EGOHYGIENE_SHELL_ROOT}/lib/core/${install_core_library_file}"

  if [[ -f "${install_core_library_path}" && -r "${install_core_library_path}" ]]; then
    # shellcheck disable=SC1090
    source "${install_core_library_path}"
  else
    printf "[warn] install runtime: missing core library: %s\n" "${install_core_library_file}" >&2
  fi
done

install_runtime_library_files=(
  "platform.sh"
  "package-manager.sh"
  "download.sh"
  "checksum.sh"
  "archive.sh"
  "filesystem.sh"
  "github.sh"
)

for install_runtime_library_file in "${install_runtime_library_files[@]}"; do
  install_runtime_library_path="${EGOHYGIENE_SHELL_ROOT}/lib/install/${install_runtime_library_file}"

  if [[ -f "${install_runtime_library_path}" && -r "${install_runtime_library_path}" ]]; then
    # shellcheck disable=SC1090
    source "${install_runtime_library_path}"
  else
    printf "[warn] install runtime: missing install library: %s\n" "${install_runtime_library_file}" >&2
  fi
done

unset install_core_library_file
unset install_core_library_files
unset install_core_library_path
unset install_runtime_library_file
unset install_runtime_library_files
unset install_runtime_library_path
