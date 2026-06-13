#!/usr/bin/env bats

load test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

@test "cb is available on PATH after sourcing the shell entrypoint" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    command -v cb
  "

  [ "${status}" -eq 0 ]
  assert_line "${REPO_ROOT}/bin/cb"
}

@test "cb prints its version through PATH lookup" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    cb --version
  "

  [ "${status}" -eq 0 ]
  assert_line "cb v2.0.0"
}

@test "cb copies inline text using a stub clipboard backend" {
  STUB_DIR="${TEST_HOME}/stubs"
  CAPTURE_FILE="${TEST_HOME}/clipboard.txt"

  run_in_clean_shell "${TEST_HOME}" "
    mkdir -p '${STUB_DIR}'
    cat > '${STUB_DIR}/pbcopy' <<EOF
#!/usr/bin/env bash
cat > '${CAPTURE_FILE}'
EOF
    chmod +x '${STUB_DIR}/pbcopy'

    export PATH='${STUB_DIR}:/usr/bin:/bin'
    DEBUG=1 bash -x '${REPO_ROOT}/bin/cb' hello world >/dev/null 2>&1
    printf 'captured=%s\n' \"\$(cat '${CAPTURE_FILE}')\"
  "

  [ "${status}" -eq 0 ]
  assert_line "captured=hello world"
}
