#!/usr/bin/env bash
# shellcheck shell=bash

if [[ -n "${EGOHYGIENE_LIB_INSTALL_GITHUB_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_INSTALL_GITHUB_LOADED="true"

install::template::render() {
  local template="$1"
  local version="${2:-}"
  local platform="${3:-}"
  local arch="${4:-}"
  local asset="${5:-}"
  local tag="${6:-}"

  template="${template//\{\{version\}\}/${version}}"
  template="${template//\{\{platform\}\}/${platform}}"
  template="${template//\{\{arch\}\}/${arch}}"
  template="${template//\{\{asset\}\}/${asset}}"
  template="${template//\{\{tag\}\}/${tag}}"

  printf "%s\n" "${template}"
}

install::github::release_asset_url() {
  local owner="$1"
  local repo="$2"
  local tag="$3"
  local asset="$4"

  printf "https://github.com/%s/%s/releases/download/%s/%s\n" \
    "${owner}" \
    "${repo}" \
    "${tag}" \
    "${asset}"
}

install::github::latest_version() {
  local owner="$1"
  local repo="$2"
  local strip_prefix="${3:-v}"
  local metadata_file
  local latest_tag

  metadata_file="$(mktemp "${TMPDIR:-/tmp}/egohygiene-release-XXXXXX")"
  install::download::file \
    "https://api.github.com/repos/${owner}/${repo}/releases/latest" \
    "${metadata_file}"

  latest_tag="$(
    grep -Eo '"tag_name"[[:space:]]*:[[:space:]]*"[^"]+"' "${metadata_file}" \
      | head -n 1 \
      | sed -E 's/.*"([^"]+)"$/\1/'
  )"
  rm -f "${metadata_file}"

  if [[ -z "${latest_tag}" ]]; then
    log::error "Unable to resolve latest release for ${owner}/${repo}"
    return 1
  fi

  if [[ -n "${strip_prefix}" && "${latest_tag}" == "${strip_prefix}"* ]]; then
    latest_tag="${latest_tag#"${strip_prefix}"}"
  fi

  printf "%s\n" "${latest_tag}"
}

install::github::resolve_version() {
  local owner="$1"
  local repo="$2"
  local requested_version="${3:-}"
  local strip_prefix="${4:-v}"

  if [[ -n "${requested_version}" ]]; then
    printf "%s\n" "${requested_version}"
    return 0
  fi

  install::github::latest_version "${owner}" "${repo}" "${strip_prefix}"
}

install::github::checksum_from_release() {
  local owner="$1"
  local repo="$2"
  local tag="$3"
  local checksum_asset="$4"
  local target_asset="$5"
  local checksum_file
  local expected_checksum

  checksum_file="$(mktemp "${TMPDIR:-/tmp}/egohygiene-checksum-XXXXXX")"

  if ! install::download::file \
    "$(install::github::release_asset_url "${owner}" "${repo}" "${tag}" "${checksum_asset}")" \
    "${checksum_file}" >/dev/null 2>&1; then
    rm -f "${checksum_file}"
    return 0
  fi

  expected_checksum="$(
    awk -v asset="${target_asset}" '
      {
        candidate = $NF
        sub(/^\.\//, "", candidate)
        sub(/^\*/, "", candidate)

        if (candidate == asset) {
          print $1
          exit
        }
      }
    ' "${checksum_file}"
  )"
  rm -f "${checksum_file}"

  printf "%s\n" "${expected_checksum}"
}

install::github::usage() {
  printf "Usage: install-%s [--version x.y.z] [--install-dir DIR] [--help]\n" "${INSTALL_TOOL_NAME}"
}

install::github::parse_args() {
  INSTALL_REQUESTED_VERSION="${INSTALL_VERSION:-}"
  INSTALL_TARGET_DIR="${INSTALL_INSTALL_DIR:-/usr/local/bin}"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --version)
        INSTALL_REQUESTED_VERSION="$2"
        shift 2
        ;;
      --install-dir)
        INSTALL_TARGET_DIR="$2"
        shift 2
        ;;
      --help|-h)
        install::github::usage
        return 64
        ;;
      *)
        log::error "Unknown argument: $1"
        install::github::usage >&2
        return 1
        ;;
    esac
  done
}

install::github::assert_config() {
  local required_config_vars=(
    "INSTALL_TOOL_NAME"
    "INSTALL_OWNER"
    "INSTALL_REPO"
    "INSTALL_ASSET_TEMPLATE"
  )
  local required_config_var_name

  for required_config_var_name in "${required_config_vars[@]}"; do
    if [[ -z "${!required_config_var_name:-}" ]]; then
      log::error "Missing installer configuration: ${required_config_var_name}"
      return 1
    fi
  done
}

install::github::main() {
  local parse_status
  local version
  local platform
  local arch
  local tag
  local asset
  local checksum
  local tmpdir
  local artifact_path
  local extract_dir
  local archive_member
  local source_path
  local install_path
  local destination_name
  local archive_format
  local -a verify_args=()

  install::github::assert_config || return 1

  install::github::parse_args "$@"
  parse_status=$?
  if [[ "${parse_status}" -ne 0 ]]; then
    if [[ "${parse_status}" -eq 64 ]]; then
      return 0
    fi
    return "${parse_status}"
  fi

  version="$(
    install::github::resolve_version \
      "${INSTALL_OWNER}" \
      "${INSTALL_REPO}" \
      "${INSTALL_REQUESTED_VERSION:-}" \
      "${INSTALL_VERSION_PREFIX_TO_STRIP:-v}"
  )" || return 1

  platform="$(
    install::platform::map_family \
      "${INSTALL_PLATFORM_LINUX:-linux}" \
      "${INSTALL_PLATFORM_DARWIN:-darwin}" \
      "${INSTALL_PLATFORM_WINDOWS:-windows}"
  )" || return 1

  arch="$(
    install::platform::map_arch \
      "${INSTALL_ARCH_X86_64:-amd64}" \
      "${INSTALL_ARCH_ARM64:-arm64}" \
      "${INSTALL_ARCH_ARMV7:-armv7}" \
      "${INSTALL_ARCH_ARMV6:-armv6}" \
      "${INSTALL_ARCH_386:-386}"
  )" || return 1

  tag="$(
    install::template::render \
      "${INSTALL_TAG_TEMPLATE:-v{{version}}}" \
      "${version}" \
      "${platform}" \
      "${arch}"
  )"
  asset="$(
    install::template::render \
      "${INSTALL_ASSET_TEMPLATE}" \
      "${version}" \
      "${platform}" \
      "${arch}" \
      "" \
      "${tag}"
  )"

  tmpdir="$(install::fs::tempdir)"
  EGOHYGIENE_INSTALL_RUNTIME_TMPDIR="${tmpdir}"
  trap 'install::fs::cleanup "${EGOHYGIENE_INSTALL_RUNTIME_TMPDIR:-}"' EXIT

  artifact_path="${tmpdir}/${asset}"
  extract_dir="${tmpdir}/extract"
  archive_format="${INSTALL_ARCHIVE_FORMAT:-$(install::archive::format "${artifact_path}")}"
  destination_name="${INSTALL_BIN_NAME:-${INSTALL_TOOL_NAME}}"

  log::info "Downloading ${INSTALL_TOOL_NAME} ${version} (${platform}/${arch})"
  install::download::file \
    "$(install::github::release_asset_url "${INSTALL_OWNER}" "${INSTALL_REPO}" "${tag}" "${asset}")" \
    "${artifact_path}"

  if [[ -n "${INSTALL_CHECKSUM_ASSET:-}" ]]; then
    checksum="$(
      install::github::checksum_from_release \
        "${INSTALL_OWNER}" \
        "${INSTALL_REPO}" \
        "${tag}" \
        "${INSTALL_CHECKSUM_ASSET}" \
        "${asset}"
    )"

    if [[ -n "${checksum}" ]]; then
      install::checksum::verify "${INSTALL_CHECKSUM_ALGORITHM:-sha256}" "${artifact_path}" "${checksum}"
    else
      log::warn "Skipping checksum verification for ${asset}; no matching checksum entry found"
    fi
  fi

  if [[ -n "${INSTALL_ARCHIVE_MEMBER_TEMPLATE:-}" ]]; then
    archive_member="$(
      install::template::render \
        "${INSTALL_ARCHIVE_MEMBER_TEMPLATE}" \
        "${version}" \
        "${platform}" \
        "${arch}" \
        "${asset}" \
        "${tag}"
    )"
  else
    archive_member=""
  fi

  if [[ "${archive_format}" == "raw" ]]; then
    source_path="${artifact_path}"
  else
    install::archive::extract "${artifact_path}" "${extract_dir}" "${archive_member}" "${archive_format}"
    if [[ -n "${archive_member}" ]]; then
      source_path="${extract_dir}/${archive_member}"

      if [[ ! -f "${source_path}" ]]; then
        source_path="${extract_dir}/${archive_member##*/}"
      fi
    else
      source_path="${extract_dir}/${destination_name}"
    fi
  fi

  if [[ ! -f "${source_path}" ]]; then
    log::error "Expected installable asset was not found: ${source_path}"
    return 1
  fi

  install_path="$(
    install::fs::install_executable \
      "${source_path}" \
      "${INSTALL_TARGET_DIR}" \
      "${destination_name}"
  )" || return 1

  if declare -p INSTALL_VERIFY_ARGS >/dev/null 2>&1; then
    # INSTALL_VERIFY_ARGS is optional and may not be defined by every wrapper.
    # shellcheck disable=SC2206
    verify_args=("${INSTALL_VERIFY_ARGS[@]}")
  fi

  if [[ "${#verify_args[@]}" -gt 0 ]]; then
    "${install_path}" "${verify_args[@]}"
  fi

  log::success "Installed ${INSTALL_TOOL_NAME} ${version} to ${install_path}"

  install::fs::cleanup "${tmpdir}"
  unset EGOHYGIENE_INSTALL_RUNTIME_TMPDIR
  trap - EXIT
}
