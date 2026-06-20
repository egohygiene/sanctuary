#!/usr/bin/env bats

load test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

@test "is-executable succeeds for a command on PATH" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    is-executable bash
  "

  [ "${status}" -eq 0 ]
}

@test "is-executable fails for a missing command on PATH" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    is-executable definitely-not-a-real-command
  "

  [ "${status}" -ne 0 ]
}

@test "is-executable succeeds for an executable file path" {
  TEST_BIN="${TEST_HOME}/bin/test-script"

  run_in_clean_shell "${TEST_HOME}" "
    mkdir -p '${TEST_HOME}/bin'
    printf '#!/usr/bin/env bash\necho ok\n' > '${TEST_BIN}'
    chmod +x '${TEST_BIN}'
    source '${REPO_ROOT}/.shellrc'
    is-executable '${TEST_BIN}'
  "

  [ "${status}" -eq 0 ]
}

@test "is-executable fails for a non-executable file path" {
  TEST_BIN="${TEST_HOME}/bin/test-script"

  run_in_clean_shell "${TEST_HOME}" "
    mkdir -p '${TEST_HOME}/bin'
    printf '#!/usr/bin/env bash\necho ok\n' > '${TEST_BIN}'
    chmod 0644 '${TEST_BIN}'
    source '${REPO_ROOT}/.shellrc'
    is-executable '${TEST_BIN}'
  "

  [ "${status}" -ne 0 ]
}
