#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 🐙 EgoHygiene Library — GitHub Helpers
# ============================================
#
# Pure GitHub API helpers.
#
# Guarantees:
# - No side effects
# - No logging
# - No exits (caller handles errors)
# - Safe to compose in pipelines
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_GITHUB_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_GITHUB_LOADED="true"

# --------------------------------------------
# 🔎 Internal Helpers
# --------------------------------------------

_github__require_arg() {
  [[ -n "${1:-}" ]] || return 1
}

_github__has_command() {
  command -v "$1" >/dev/null 2>&1
}

# --------------------------------------------
# 🌐 Fetch Latest Release JSON
#
# Usage:
#   github::latest_release_json "owner/repo"
# --------------------------------------------
github::latest_release_json() {
  local repository="$1"

  _github__require_arg "${repository}" || return 1
  _github__has_command curl || return 127

  curl --silent --show-error --location \
    "https://api.github.com/repos/${repository}/releases/latest"
}

# --------------------------------------------
# 🏷 Extract Latest Tag (stdin JSON)
#
# Usage:
#   github::latest_release_json repo | github::latest_tag
# --------------------------------------------
github::latest_tag() {
  _github__has_command jq || return 127

  jq --raw-output '.tag_name // empty'
}

# --------------------------------------------
# 📦 Extract Tarball URL (stdin JSON)
# --------------------------------------------
github::tarball_url() {
  _github__has_command jq || return 127

  jq --raw-output '.tarball_url // empty'
}

# --------------------------------------------
# 🕒 Extract Published Date (stdin JSON)
# --------------------------------------------
github::published_at() {
  _github__has_command jq || return 127

  jq --raw-output '.published_at // empty'
}

# --------------------------------------------
# 🔗 Resolve Commit SHA for Tag
#
# Usage:
#   github::commit_sha_for_tag "owner/repo" "v1.2.3"
# --------------------------------------------
github::commit_sha_for_tag() {
  local repository="$1"
  local tag="$2"

  _github__require_arg "${repository}" || return 1
  _github__require_arg "${tag}" || return 1
  _github__has_command git || return 127

  git ls-remote "https://github.com/${repository}.git" "refs/tags/${tag}" \
    | cut -f1
}
