#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

@test "bash helpers are available after sourcing the entrypoint" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    declare -F bash::version >/dev/null
    declare -F bash::major_version >/dev/null
    declare -F bash::minor_version >/dev/null
    declare -F bash::is_interactive >/dev/null
    declare -F bash::path >/dev/null
    declare -F bash::is_min_version >/dev/null
    printf 'bash_helpers=yes\n'
  "

  [ "${status}" -eq 0 ]
  assert_line "bash_helpers=yes"
}

@test "bash helpers report version and path information" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    printf 'version=%s\n' \"\$(bash::version)\"
    printf 'major=%s\n' \"\$(bash::major_version)\"
    printf 'minor=%s\n' \"\$(bash::minor_version)\"
    printf 'path=%s\n' \"\$(bash::path)\"
  "

  [ "${status}" -eq 0 ]
  assert_output_contains "version="
  assert_output_contains "major="
  assert_output_contains "minor="
  assert_output_contains "path="
}

@test "bash::is_interactive reports false in clean non-interactive test shells" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    if bash::is_interactive; then
      printf 'interactive=yes\n'
    else
      printf 'interactive=no\n'
    fi
  "

  [ "${status}" -eq 0 ]
  assert_line "interactive=no"
}

@test "bash::is_min_version matches the current bash version" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    current_major=\"\$(bash::major_version)\"
    current_minor=\"\$(bash::minor_version)\"

    if bash::is_min_version \"\${current_major}\" \"\${current_minor}\"; then
      printf 'exact_version=yes\n'
    fi

    if bash::is_min_version 999 0; then
      printf 'future_version=yes\n'
    else
      printf 'future_version=no\n'
    fi
  "

  [ "${status}" -eq 0 ]
  assert_line "exact_version=yes"
  assert_line "future_version=no"
}

@test "bash library is idempotent when sourced twice" {
  run_in_clean_shell "${TEST_HOME}" "
    export EGOHYGIENE_SHELL_ROOT='${REPO_ROOT}'
    source '${REPO_ROOT}/init/load-core.sh'
    source '${REPO_ROOT}/lib/core/bash.sh'
    source '${REPO_ROOT}/lib/core/bash.sh'
    declare -F bash::version >/dev/null
    printf 'bash_loaded_twice=yes\n'
  "

  [ "${status}" -eq 0 ]
  assert_line "bash_loaded_twice=yes"
}
