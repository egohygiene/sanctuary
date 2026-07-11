#!/usr/bin/env bash
# shellcheck shell=bash

if [[ -n "${EGOHYGIENE_LIB_INSTALL_ARCHIVE_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_INSTALL_ARCHIVE_LOADED="true"

install::archive::format() {
  local archive_path="$1"

  case "${archive_path}" in
    *.tar.gz|*.tgz) printf "tar.gz\n" ;;
    *.tar.xz|*.txz) printf "tar.xz\n" ;;
    *.zip) printf "zip\n" ;;
    *) printf "raw\n" ;;
  esac
}

install::archive::extract() {
  local archive_path="$1"
  local destination_dir="$2"
  local member_path="${3:-}"
  local archive_format="${4:-}"
  local copied_path

  archive_format="${archive_format:-$(install::archive::format "${archive_path}")}"
  mkdir -p "${destination_dir}"

  case "${archive_format}" in
    raw)
      if [[ -n "${member_path}" ]]; then
        log::error "Raw assets do not support archive member extraction"
        return 1
      fi

      copied_path="${destination_dir}/$(basename "${member_path:-${archive_path}}")"
      cp "${archive_path}" "${copied_path}"
      ;;
    tar.gz)
      if [[ -n "${member_path}" ]]; then
        tar -xzf "${archive_path}" -C "${destination_dir}" "${member_path}"
      else
        tar -xzf "${archive_path}" -C "${destination_dir}"
      fi
      ;;
    tar.xz)
      if [[ -n "${member_path}" ]]; then
        tar -xJf "${archive_path}" -C "${destination_dir}" "${member_path}"
      else
        tar -xJf "${archive_path}" -C "${destination_dir}"
      fi
      ;;
    zip)
      if [[ -n "${member_path}" ]]; then
        unzip -q "${archive_path}" "${member_path}" -d "${destination_dir}"
      else
        unzip -q "${archive_path}" -d "${destination_dir}"
      fi
      ;;
    *)
      log::error "Unsupported archive format: ${archive_format}"
      return 1
      ;;
  esac
}
