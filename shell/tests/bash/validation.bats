#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

# ----------------------------------------
# validation::email
# ----------------------------------------

@test "validation::email accepts a valid email address" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::email 'user@example.com'
  "
  [ "${status}" -eq 0 ]
}

@test "validation::email rejects an invalid email address" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::email 'not-an-email'
  "
  [ "${status}" -eq 1 ]
}

@test "validation::email returns 2 when arguments are missing" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::email
  "
  [ "${status}" -eq 2 ]
}

# ----------------------------------------
# validation::ipv4
# ----------------------------------------

@test "validation::ipv4 accepts a valid IPv4 address" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::ipv4 '192.168.1.1'
  "
  [ "${status}" -eq 0 ]
}

@test "validation::ipv4 rejects an out-of-range IPv4 address" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::ipv4 '255.255.255.256'
  "
  [ "${status}" -eq 1 ]
}

@test "validation::ipv4 rejects a non-numeric IP" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::ipv4 'a.b.c.d'
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# validation::ipv6
# ----------------------------------------

@test "validation::ipv6 accepts a valid IPv6 address" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::ipv6 '2001:db8:85a3:8d3:1319:8a2e:370:7348'
  "
  [ "${status}" -eq 0 ]
}

@test "validation::ipv6 accepts a double-colon abbreviated IPv6" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::ipv6 '::'
  "
  [ "${status}" -eq 0 ]
}

@test "validation::ipv6 rejects an invalid IPv6 address" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::ipv6 'fezy::1ff:fe23:4567:890a'
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# validation::alpha
# ----------------------------------------

@test "validation::alpha accepts a purely alphabetic string" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::alpha 'abcABC'
  "
  [ "${status}" -eq 0 ]
}

@test "validation::alpha rejects a string with digits" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::alpha 'abc123'
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# validation::alpha_num
# ----------------------------------------

@test "validation::alpha_num accepts an alphanumeric string" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::alpha_num 'abc123'
  "
  [ "${status}" -eq 0 ]
}

@test "validation::alpha_num rejects a string with special characters" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::alpha_num 'abc-123'
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# validation::alpha_dash
# ----------------------------------------

@test "validation::alpha_dash accepts alpha, dash, and underscore" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::alpha_dash 'abc-ABC_cD'
  "
  [ "${status}" -eq 0 ]
}

@test "validation::alpha_dash rejects digits" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::alpha_dash 'abc1'
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# validation::version_comparison
# ----------------------------------------

@test "validation::version_comparison returns 0 for equal versions" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::version_comparison '1.2.3' '1.2.3'
  "
  [ "${status}" -eq 0 ]
}

@test "validation::version_comparison returns 1 when first version is greater" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::version_comparison '2.0.0' '1.9.9'
  "
  [ "${status}" -eq 1 ]
}

@test "validation::version_comparison returns 2 when first version is less" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::version_comparison '1.0.0' '2.0.0'
  "
  [ "${status}" -eq 2 ]
}

@test "validation::version_comparison returns 3 when arguments are missing" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    validation::version_comparison '1.0.0'
  "
  [ "${status}" -eq 3 ]
}

# ----------------------------------------
# Idempotency
# ----------------------------------------

@test "validation library is idempotent when sourced twice" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/validation.sh'
    source '${REPO_ROOT}/lib/bash/validation.sh'
    declare -F validation::email >/dev/null
    printf 'loaded=yes\n'
  "
  [ "${status}" -eq 0 ]
  assert_line "loaded=yes"
}

# ----------------------------------------
# Integration: available after .shellrc
# ----------------------------------------

@test "validation functions are available after sourcing .shellrc" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    declare -F validation::email >/dev/null
    declare -F validation::ipv4 >/dev/null
    declare -F validation::version_comparison >/dev/null
    printf 'validation_runtime=yes\n'
  "
  [ "${status}" -eq 0 ]
  assert_line "validation_runtime=yes"
}
