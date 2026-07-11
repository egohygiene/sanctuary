#!/usr/bin/env bats

load test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

@test "entrypoint bootstrap loads the expected core modules" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    printf 'root=%s\n' \"\${EGOHYGIENE_SHELL_ROOT}\"
    printf 'runtime_environment=%s\n' \"\${EGOHYGIENE_RUNTIME_ENVIRONMENT}\"
    printf 'platform_runtime=%s\n' \"\${EGOHYGIENE_PLATFORM_RUNTIME:-none}\"
    printf 'modules=%s\n' \"\${EGOHYGIENE_SHELL_LOADED_MODULES}\"
  "

  [ "${status}" -eq 0 ]
  assert_line "root=${REPO_ROOT}"
  assert_line "runtime_environment=local"
  assert_line "platform_runtime=none"
  assert_line "modules=xdg environment tooling history privacy cache"
}

@test "entrypoint bootstrap is safe to source twice" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    first_path=\${PATH}
    source '${REPO_ROOT}/.shellrc'
    printf 'modules=%s\n' \"\${EGOHYGIENE_SHELL_LOADED_MODULES}\"
    printf 'path_stable=%s\n' \"\$([[ \${PATH} == \${first_path} ]] && printf true || printf false)\"
  "

  [ "${status}" -eq 0 ]
  assert_line "modules=xdg environment tooling history privacy cache"
  assert_line "path_stable=true"
}

@test "entrypoint bootstrap creates the expected XDG directory tree under a custom HOME" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    printf 'config=%s\n' \"\${XDG_CONFIG_HOME}\"
    printf 'data=%s\n' \"\${XDG_DATA_HOME}\"
    printf 'cache=%s\n' \"\${XDG_CACHE_HOME}\"
    printf 'state=%s\n' \"\${XDG_STATE_HOME}\"
    [[ -d \${XDG_CONFIG_HOME} ]] && printf 'config_exists=true\n'
    [[ -d \${XDG_DATA_HOME} ]] && printf 'data_exists=true\n'
    [[ -d \${XDG_CACHE_HOME} ]] && printf 'cache_exists=true\n'
    [[ -d \${XDG_STATE_HOME} ]] && printf 'state_exists=true\n'
  "

  [ "${status}" -eq 0 ]
  assert_line "config=${TEST_HOME}/.config"
  assert_line "data=${TEST_HOME}/.local/share"
  assert_line "cache=${TEST_HOME}/.cache"
  assert_line "state=${TEST_HOME}/.local/state"
  assert_line "config_exists=true"
  assert_line "data_exists=true"
  assert_line "cache_exists=true"
  assert_line "state_exists=true"
}
