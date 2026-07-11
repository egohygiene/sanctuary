#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

# ----------------------------------------
# variable::is_array
# ----------------------------------------

@test "variable::is_array returns 0 for an indexed array" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    arr=(a b c)
    variable::is_array 'arr'
  "
  [ "${status}" -eq 0 ]
}

@test "variable::is_array returns 0 for an associative array" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    declare -A assoc=([x]=1)
    variable::is_array 'assoc'
  "
  [ "${status}" -eq 0 ]
}

@test "variable::is_array returns 1 for a scalar variable" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    scalar='hello'
    variable::is_array 'scalar'
  "
  [ "${status}" -eq 1 ]
}

@test "variable::is_array returns 1 for an empty argument" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    variable::is_array ''
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# variable::is_numeric
# ----------------------------------------

@test "variable::is_numeric returns 0 for a pure digit string" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    variable::is_numeric '1234'
  "
  [ "${status}" -eq 0 ]
}

@test "variable::is_numeric returns 1 for a string with letters" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    variable::is_numeric '12a4'
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# variable::is_int
# ----------------------------------------

@test "variable::is_int returns 0 for a positive integer with sign" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    variable::is_int '+1234'
  "
  [ "${status}" -eq 0 ]
}

@test "variable::is_int returns 0 for a negative integer" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    variable::is_int '-5'
  "
  [ "${status}" -eq 0 ]
}

@test "variable::is_int returns 1 for a float" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    variable::is_int '1.5'
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# variable::is_float
# ----------------------------------------

@test "variable::is_float returns 0 for a decimal number" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    variable::is_float '+1234.0'
  "
  [ "${status}" -eq 0 ]
}

@test "variable::is_float returns 1 for alphabetic input" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    variable::is_float 'abc'
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# variable::is_bool
# ----------------------------------------

@test "variable::is_bool returns 0 for 'true'" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    variable::is_bool 'true'
  "
  [ "${status}" -eq 0 ]
}

@test "variable::is_bool returns 0 for 'false'" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    variable::is_bool 'false'
  "
  [ "${status}" -eq 0 ]
}

@test "variable::is_bool returns 1 for 'yes'" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    variable::is_bool 'yes'
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# variable::is_empty_or_null
# ----------------------------------------

@test "variable::is_empty_or_null returns 0 for an empty string" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    variable::is_empty_or_null ''
  "
  [ "${status}" -eq 0 ]
}

@test "variable::is_empty_or_null returns 0 for the string 'null'" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    variable::is_empty_or_null 'null'
  "
  [ "${status}" -eq 0 ]
}

@test "variable::is_empty_or_null returns 1 for a non-empty string" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    variable::is_empty_or_null 'foo'
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# Idempotency
# ----------------------------------------

@test "variable library is idempotent when sourced twice" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/variable.sh'
    source '${REPO_ROOT}/lib/bash/variable.sh'
    declare -F variable::is_array >/dev/null
    printf 'loaded=yes\n'
  "
  [ "${status}" -eq 0 ]
  assert_line "loaded=yes"
}

# ----------------------------------------
# Integration: available after .shellrc
# ----------------------------------------

@test "variable functions are available after sourcing .shellrc" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    declare -F variable::is_array >/dev/null
    declare -F variable::is_numeric >/dev/null
    declare -F variable::is_empty_or_null >/dev/null
    printf 'variable_runtime=yes\n'
  "
  [ "${status}" -eq 0 ]
  assert_line "variable_runtime=yes"
}
