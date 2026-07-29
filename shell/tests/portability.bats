#!/usr/bin/env bats

load test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

@test "Bash and Zsh resolve the same policy and PATH prefix" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    printf 'bash|%s|%s|%s\n' \
      \"\${EGOHYGIENE_PLATFORM_RUNTIME}\" \
      \"\${DO_NOT_TRACK}\" \
      \"\${PATH%%:*}\"
  "
  [ "${status}" -eq 0 ]
  assert_line "bash|linux|1|${REPO_ROOT}/bin"

  run_in_clean_zsh "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    printf 'zsh|%s|%s|%s\n' \
      \"\${EGOHYGIENE_PLATFORM_RUNTIME}\" \
      \"\${DO_NOT_TRACK}\" \
      \"\${PATH%%:*}\"
  "
  [ "${status}" -eq 0 ]
  assert_line "zsh|linux|1|${REPO_ROOT}/bin"
}

@test "bootstrap preserves legacy stateful tool data" {
  run_in_clean_shell "${TEST_HOME}" "
    mkdir -p '${TEST_HOME}/.docker'
    source '${REPO_ROOT}/.shellrc'
    printf 'docker=%s\n' \"\${DOCKER_CONFIG:-legacy-default}\"
    printf 'warnings=%s\n' \"\${EGOHYGIENE_XDG_MIGRATION_WARNINGS:-}\"
  "

  [ "${status}" -eq 0 ]
  assert_line "docker=legacy-default"
  assert_output_contains "warnings=DOCKER_CONFIG"
}

@test "update-check suppression is independent from telemetry opt-out" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    printf 'telemetry=%s\n' \"\${DO_NOT_TRACK}\"
    printf 'updates=%s\n' \"\${HOMEBREW_NO_AUTO_UPDATE:-enabled}\"
  "

  [ "${status}" -eq 0 ]
  assert_line "telemetry=1"
  assert_line "updates=enabled"

  run_in_clean_shell "${TEST_HOME}" "
    export EGOHYGIENE_DISABLE_UPDATE_CHECKS='1'
    source '${REPO_ROOT}/.shellrc'
    printf 'updates=%s\n' \"\${HOMEBREW_NO_AUTO_UPDATE}\"
  "

  [ "${status}" -eq 0 ]
  assert_line "updates=1"
}
