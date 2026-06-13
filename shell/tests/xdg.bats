#!/usr/bin/env bats

load test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

@test "xdg module sets defaults and creates directories" {
  run_in_clean_shell "${TEST_HOME}" "
    export EGOHYGIENE_SHELL_ROOT='${REPO_ROOT}'
    source '${REPO_ROOT}/init/load-core.sh'
    source '${REPO_ROOT}/modules/xdg.sh'
    printf 'config=%s\n' \"\${XDG_CONFIG_HOME}\"
    printf 'data=%s\n' \"\${XDG_DATA_HOME}\"
    printf 'cache=%s\n' \"\${XDG_CACHE_HOME}\"
    printf 'state=%s\n' \"\${XDG_STATE_HOME}\"
    printf 'runtime=%s\n' \"\${XDG_RUNTIME_DIR}\"
    [[ -d \${XDG_RUNTIME_DIR} ]] && printf 'runtime_exists=true\n'
    printf 'runtime_mode=%s\n' \"\$(stat -f '%Lp' \"\${XDG_RUNTIME_DIR}\" 2>/dev/null || stat -c '%a' \"\${XDG_RUNTIME_DIR}\")\"
  "

  [ "${status}" -eq 0 ]
  assert_line "config=${TEST_HOME}/.config"
  assert_line "data=${TEST_HOME}/.local/share"
  assert_line "cache=${TEST_HOME}/.cache"
  assert_line "state=${TEST_HOME}/.local/state"
  assert_line "runtime_exists=true"
  assert_output_contains "runtime="
  assert_line "runtime_mode=700"
}

@test "xdg module respects preconfigured XDG directories" {
  run_in_clean_shell "${TEST_HOME}" "
    export EGOHYGIENE_SHELL_ROOT='${REPO_ROOT}'
    export XDG_CONFIG_HOME='${TEST_HOME}/custom/config'
    export XDG_CACHE_HOME='${TEST_HOME}/custom/cache'
    export XDG_DATA_HOME='${TEST_HOME}/custom/data'
    export XDG_STATE_HOME='${TEST_HOME}/custom/state'
    source '${REPO_ROOT}/init/load-core.sh'
    source '${REPO_ROOT}/modules/xdg.sh'
    printf 'config=%s\n' \"\${XDG_CONFIG_HOME}\"
    printf 'cache=%s\n' \"\${XDG_CACHE_HOME}\"
    printf 'data=%s\n' \"\${XDG_DATA_HOME}\"
    printf 'state=%s\n' \"\${XDG_STATE_HOME}\"
  "

  [ "${status}" -eq 0 ]
  assert_line "config=${TEST_HOME}/custom/config"
  assert_line "cache=${TEST_HOME}/custom/cache"
  assert_line "data=${TEST_HOME}/custom/data"
  assert_line "state=${TEST_HOME}/custom/state"
}

@test "xdg module is idempotent when sourced twice" {
  run_in_clean_shell "${TEST_HOME}" "
    export EGOHYGIENE_SHELL_ROOT='${REPO_ROOT}'
    source '${REPO_ROOT}/init/load-core.sh'
    source '${REPO_ROOT}/modules/xdg.sh'
    first_runtime=\${XDG_RUNTIME_DIR}
    source '${REPO_ROOT}/modules/xdg.sh'
    printf 'runtime_stable=%s\n' \"\$([[ \${XDG_RUNTIME_DIR} == \${first_runtime} ]] && printf true || printf false)\"
  "

  [ "${status}" -eq 0 ]
  assert_line "runtime_stable=true"
}
