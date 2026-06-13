#!/usr/bin/env bats

load test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

@test "environment module sets locale, editor, and user-level PATH entries" {
  run_in_clean_shell "${TEST_HOME}" "
    mkdir -p '${TEST_HOME}/.local/share/bin' '${TEST_HOME}/.local/bin'
    export EGOHYGIENE_SHELL_ROOT='${REPO_ROOT}'
    export PATH='/usr/bin:/bin'
    source '${REPO_ROOT}/init/load-core.sh'
    source '${REPO_ROOT}/modules/xdg.sh'
    source '${REPO_ROOT}/modules/environment.sh'
    printf 'lang=%s\n' \"\${LANG}\"
    printf 'lc_all=%s\n' \"\${LC_ALL}\"
    printf 'editor=%s\n' \"\${EDITOR}\"
    printf 'visual=%s\n' \"\${VISUAL}\"
    printf 'path=%s\n' \"\${PATH}\"
  "

  [ "${status}" -eq 0 ]
  assert_line "lang=en_US.UTF-8"
  assert_line "lc_all=en_US.UTF-8"
  assert_output_contains "editor="
  assert_output_contains "visual="
  assert_output_contains "path=${TEST_HOME}/.local/bin:${TEST_HOME}/.local/share/bin:${REPO_ROOT}/bin:"
}

@test "environment module adds the shell system bin directory to PATH" {
  run_in_clean_shell "${TEST_HOME}" "
    export EGOHYGIENE_SHELL_ROOT='${REPO_ROOT}'
    export PATH='/usr/bin:/bin'
    source '${REPO_ROOT}/init/load-core.sh'
    source '${REPO_ROOT}/modules/xdg.sh'
    source '${REPO_ROOT}/modules/environment.sh'
    command -v cb
  "

  [ "${status}" -eq 0 ]
  assert_line "${REPO_ROOT}/bin/cb"
}

@test "environment module respects existing LANG, LC_ALL, and VISUAL" {
  run_in_clean_shell "${TEST_HOME}" "
    export EGOHYGIENE_SHELL_ROOT='${REPO_ROOT}'
    export LANG='C.UTF-8'
    export LC_ALL='C'
    export VISUAL='code'
    source '${REPO_ROOT}/init/load-core.sh'
    source '${REPO_ROOT}/modules/xdg.sh'
    source '${REPO_ROOT}/modules/environment.sh'
    printf 'lang=%s\n' \"\${LANG}\"
    printf 'lc_all=%s\n' \"\${LC_ALL}\"
    printf 'visual=%s\n' \"\${VISUAL}\"
  "

  [ "${status}" -eq 0 ]
  assert_line "lang=C.UTF-8"
  assert_line "lc_all=C"
  assert_line "visual=code"
}

@test "environment module adds project-local bins ahead of system paths" {
  PROJECT_DIR="${TEST_HOME}/project"

  run_in_clean_shell "${TEST_HOME}" "
    mkdir -p '${PROJECT_DIR}/bin' '${PROJECT_DIR}/node_modules/.bin'
    export EGOHYGIENE_SHELL_ROOT='${REPO_ROOT}'
    export PATH='/usr/bin:/bin'
    cd '${PROJECT_DIR}'
    source '${REPO_ROOT}/init/load-core.sh'
    source '${REPO_ROOT}/modules/xdg.sh'
    source '${REPO_ROOT}/modules/environment.sh'
    printf 'path=%s\n' \"\${PATH}\"
  "

  [ "${status}" -eq 0 ]
  assert_output_contains "path=${PROJECT_DIR}/node_modules/.bin:${PROJECT_DIR}/bin:"
}
