#!/usr/bin/env bash
# shellcheck shell=bash

if [[ -n "${EGOHYGIENE_LIB_INSTALL_CHECKSUM_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_INSTALL_CHECKSUM_LOADED="true"

install::checksum::calculate() {
  local algorithm="$1"
  local file_path="$2"

  case "${algorithm}" in
    sha256)
      if guard::has_command sha256sum; then
        sha256sum "${file_path}" | awk '{print $1}'
      elif guard::has_command shasum; then
        shasum -a 256 "${file_path}" | awk '{print $1}'
      elif guard::has_command openssl; then
        openssl dgst -sha256 "${file_path}" | awk '{print $2}'
      else
        log::error "No SHA-256 utility found"
        return 1
      fi
      ;;
    sha512)
      if guard::has_command sha512sum; then
        sha512sum "${file_path}" | awk '{print $1}'
      elif guard::has_command shasum; then
        shasum -a 512 "${file_path}" | awk '{print $1}'
      elif guard::has_command openssl; then
        openssl dgst -sha512 "${file_path}" | awk '{print $2}'
      else
        log::error "No SHA-512 utility found"
        return 1
      fi
      ;;
    *)
      log::error "Unsupported checksum algorithm: ${algorithm}"
      return 1
      ;;
  esac
}

install::checksum::verify() {
  local algorithm="$1"
  local file_path="$2"
  local expected_checksum="$3"
  local actual_checksum

  actual_checksum="$(install::checksum::calculate "${algorithm}" "${file_path}")" || return 1

  if [[ "${actual_checksum}" != "${expected_checksum}" ]]; then
    log::error "Checksum mismatch (${algorithm}) for ${file_path}"
    log::error "expected=${expected_checksum}"
    log::error "actual=${actual_checksum}"
    return 1
  fi

  log::info "Verified ${algorithm} checksum for $(basename "${file_path}")"
}
