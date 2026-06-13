#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

@test "time helpers are available after sourcing the entrypoint" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    declare -F time::epoch >/dev/null
    declare -F time::epoch_ms >/dev/null
    declare -F time::timestamp >/dev/null
    declare -F time::utc_timestamp >/dev/null
    declare -F time::iso8601 >/dev/null
    printf 'time_helpers=yes\n'
  "

  [ "${status}" -eq 0 ]
  assert_line "time_helpers=yes"
}

@test "time helpers return expected output shapes" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'

    epoch=\"\$(time::epoch)\"
    epoch_ms=\"\$(time::epoch_ms)\"
    timestamp=\"\$(time::timestamp)\"
    utc_timestamp=\"\$(time::utc_timestamp)\"
    iso8601=\"\$(time::iso8601)\"

    [[ \${epoch} =~ ^[0-9]{10,}$ ]] && printf 'epoch_format=yes\n'
    [[ \${epoch_ms} =~ ^[0-9]{13,}$ ]] && printf 'epoch_ms_format=yes\n'
    [[ \${timestamp} =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}\ [0-9]{2}:[0-9]{2}:[0-9]{2}$ ]] && printf 'timestamp_format=yes\n'
    [[ \${utc_timestamp} =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}\ [0-9]{2}:[0-9]{2}:[0-9]{2}$ ]] && printf 'utc_timestamp_format=yes\n'
    [[ \${iso8601} =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z$ ]] && printf 'iso8601_format=yes\n'
  "

  [ "${status}" -eq 0 ]
  assert_line "epoch_format=yes"
  assert_line "epoch_ms_format=yes"
  assert_line "timestamp_format=yes"
  assert_line "utc_timestamp_format=yes"
  assert_line "iso8601_format=yes"
}

@test "time epoch milliseconds are at least second precision times one thousand" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'

    epoch=\"\$(time::epoch)\"
    epoch_ms=\"\$(time::epoch_ms)\"

    if (( epoch_ms >= epoch * 1000 )); then
      printf 'epoch_ms_floor=yes\n'
    fi
  "

  [ "${status}" -eq 0 ]
  assert_line "epoch_ms_floor=yes"
}

@test "time library is idempotent when sourced twice" {
  run_in_clean_shell "${TEST_HOME}" "
    export EGOHYGIENE_SHELL_ROOT='${REPO_ROOT}'
    source '${REPO_ROOT}/init/load-core.sh'
    source '${REPO_ROOT}/lib/core/time.sh'
    source '${REPO_ROOT}/lib/core/time.sh'
    declare -F time::iso8601 >/dev/null
    printf 'time_loaded_twice=yes\n'
  "

  [ "${status}" -eq 0 ]
  assert_line "time_loaded_twice=yes"
}
