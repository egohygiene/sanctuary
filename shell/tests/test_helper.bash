#!/usr/bin/env bash

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Used by Bats test files after `load test_helper.bash`.
# shellcheck disable=SC2034
REPO_ROOT="$(cd "${TESTS_DIR}/.." && pwd)"

make_test_home() {
  local base_tmpdir="${TMPDIR:-/tmp}"
  mktemp -d "${base_tmpdir%/}/egohygiene-tests.XXXXXX"
}

run_in_clean_shell() {
  local test_home="$1"
  local shell_command="$2"

  run env -i \
    HOME="${test_home}" \
    PATH="${PATH}" \
    TMPDIR="${TMPDIR:-/tmp}" \
    /bin/bash --noprofile --norc -lc "${shell_command}"
}

run_in_clean_zsh() {
  local test_home="$1"
  local shell_command="$2"

  if ! command -v zsh >/dev/null 2>&1; then
    skip "zsh is not installed"
  fi

  run env -i \
    HOME="${test_home}" \
    PATH="${PATH}" \
    TMPDIR="${TMPDIR:-/tmp}" \
    zsh -fc "${shell_command}"
}

assert_line() {
  local expected_line="$1"

  # Bats provides the `output` variable.
  # shellcheck disable=SC2154
  if ! grep -Fqx "${expected_line}" <<<"${output}"; then
    printf 'expected line not found: %s\nfull output:\n%s\n' "${expected_line}" "${output}" >&2
    return 1
  fi
}

assert_output_contains() {
  local expected_fragment="$1"

  # Bats provides the `output` variable.
  # shellcheck disable=SC2154
  if [[ "${output}" != *"${expected_fragment}"* ]]; then
    printf 'expected output to contain: %s\nfull output:\n%s\n' "${expected_fragment}" "${output}" >&2
    return 1
  fi
}
