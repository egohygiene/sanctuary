#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

# ----------------------------------------
# string::trim
# ----------------------------------------

@test "string::trim removes leading and trailing whitespace" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    string::trim '   Hello World!   '
  "
  [ "${status}" -eq 0 ]
  [ "${output}" = "Hello World!" ]
}

@test "string::trim returns 2 when arguments are missing" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    string::trim
  "
  [ "${status}" -eq 2 ]
}

# ----------------------------------------
# string::split
# ----------------------------------------

@test "string::split splits by delimiter" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    string::split 'a,b,c' ','
  "
  [ "${status}" -eq 0 ]
  assert_line "a"
  assert_line "b"
  assert_line "c"
}

# ----------------------------------------
# string::lstrip / string::rstrip
# ----------------------------------------

@test "string::lstrip removes prefix pattern" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    string::lstrip 'Hello World!' 'He'
  "
  [ "${status}" -eq 0 ]
  [ "${output}" = "llo World!" ]
}

@test "string::rstrip removes suffix pattern" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    string::rstrip 'Hello World!' 'd!'
  "
  [ "${status}" -eq 0 ]
  [ "${output}" = "Hello Worl" ]
}

# ----------------------------------------
# string::to_lower / string::to_upper
# ----------------------------------------

@test "string::to_lower converts to lowercase" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    string::to_lower 'HeLLo WoRLD'
  "
  [ "${status}" -eq 0 ]
  [ "${output}" = "hello world" ]
}

@test "string::to_upper converts to uppercase" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    string::to_upper 'hello world'
  "
  [ "${status}" -eq 0 ]
  [ "${output}" = "HELLO WORLD" ]
}

# ----------------------------------------
# string::contains
# ----------------------------------------

@test "string::contains returns 0 when substring is present" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    string::contains 'Hello World!' 'World'
  "
  [ "${status}" -eq 0 ]
}

@test "string::contains returns 1 when substring is absent" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    string::contains 'Hello World!' 'Foo'
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# string::starts_with
# ----------------------------------------

@test "string::starts_with returns 0 when prefix matches" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    string::starts_with 'Hello World!' 'He'
  "
  [ "${status}" -eq 0 ]
}

@test "string::starts_with returns 1 when prefix does not match" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    string::starts_with 'Hello World!' 'World'
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# string::ends_with
# ----------------------------------------

@test "string::ends_with returns 0 when suffix matches" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    string::ends_with 'Hello World!' 'd!'
  "
  [ "${status}" -eq 0 ]
}

# ----------------------------------------
# string::regex
# ----------------------------------------

@test "string::regex returns 0 when pattern matches" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    string::regex 'HELLO' '^[A-Z]*\$'
  "
  [ "${status}" -eq 0 ]
}

@test "string::regex returns 1 when pattern does not match" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    string::regex 'hello123' '^[A-Z]*\$'
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# Idempotency
# ----------------------------------------

@test "string library is idempotent when sourced twice" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/string.sh'
    source '${REPO_ROOT}/lib/bash/string.sh'
    declare -F string::trim >/dev/null
    printf 'loaded=yes\n'
  "
  [ "${status}" -eq 0 ]
  assert_line "loaded=yes"
}

# ----------------------------------------
# Integration: available after .shellrc
# ----------------------------------------

@test "string functions are available after sourcing .shellrc" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    declare -F string::trim >/dev/null
    declare -F string::to_lower >/dev/null
    declare -F string::contains >/dev/null
    printf 'string_runtime=yes\n'
  "
  [ "${status}" -eq 0 ]
  assert_line "string_runtime=yes"
}
