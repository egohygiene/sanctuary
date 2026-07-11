#!/usr/bin/env bash
# shellcheck shell=bash

if [[ -n "${EGOHYGIENE_LIB_INSTALL_DOWNLOAD_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_INSTALL_DOWNLOAD_LOADED="true"

install::download::file() {
  local url="$1"
  local destination_path="$2"

  mkdir -p "$(dirname "${destination_path}")"

  if guard::has_command curl; then
    curl \
      --fail \
      --silent \
      --show-error \
      --location \
      --retry 3 \
      --retry-all-errors \
      --connect-timeout 15 \
      --output "${destination_path}" \
      "${url}"
  elif guard::has_command wget; then
    wget \
      --quiet \
      --tries=3 \
      --timeout=15 \
      --output-document="${destination_path}" \
      "${url}"
  else
    log::error "Missing download dependency: curl or wget is required"
    return 1
  fi
}
