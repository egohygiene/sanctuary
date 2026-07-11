#!/usr/bin/env bash
# shellcheck shell=bash

if [[ -n "${EGOHYGIENE_LIB_INSTALL_FILESYSTEM_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_INSTALL_FILESYSTEM_LOADED="true"

install::fs::can_write_directory() {
  local destination_dir="$1"

  [[ -w "${destination_dir}" || ( ! -e "${destination_dir}" && -w "$(dirname "${destination_dir}")" ) ]]
}

install::fs::tempdir() {
  local base_tmpdir="${TMPDIR:-/tmp}"
  mktemp -d "${base_tmpdir%/}/egohygiene-install.XXXXXX"
}

install::fs::cleanup() {
  local path_to_remove="${1:-}"

  if [[ -n "${path_to_remove}" && -d "${path_to_remove}" ]]; then
    rm -rf -- "${path_to_remove}"
  fi
}

install::fs::install_executable() {
  local source_path="$1"
  local destination_dir="$2"
  local destination_name="${3:-$(basename "${source_path}")}"
  local destination_path="${destination_dir%/}/${destination_name}"

  if install::fs::can_write_directory "${destination_dir}"; then
    mkdir -p "${destination_dir}"
    install -m 0755 "${source_path}" "${destination_path}"
  elif guard::has_command sudo; then
    sudo mkdir -p "${destination_dir}"
    sudo install -m 0755 "${source_path}" "${destination_path}"
  else
    log::error "Cannot write to ${destination_dir}; rerun with elevated privileges"
    return 1
  fi

  printf "%s\n" "${destination_path}"
}
