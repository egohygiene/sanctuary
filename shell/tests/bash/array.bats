#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

# ----------------------------------------
# array::contains
# ----------------------------------------

@test "array::contains finds an element in an array" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/array.sh'
    arr=(a b c)
    array::contains 'b' \"\${arr[@]}\"
  "
  [ "${status}" -eq 0 ]
}

@test "array::contains returns 1 when element is not found" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/array.sh'
    arr=(a b c)
    array::contains 'z' \"\${arr[@]}\"
  "
  [ "${status}" -eq 1 ]
}

@test "array::contains returns 2 when arguments are missing" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/array.sh'
    array::contains
  "
  [ "${status}" -eq 2 ]
}

# ----------------------------------------
# array::dedupe
# ----------------------------------------

@test "array::dedupe removes duplicate elements" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/array.sh'
    arr=(a b a c b)
    array::dedupe \"\${arr[@]}\"
  "
  [ "${status}" -eq 0 ]
  assert_line "a"
  assert_line "b"
  assert_line "c"
}

@test "array::dedupe preserves order" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/array.sh'
    array::dedupe x y z y x
  "
  [ "${status}" -eq 0 ]
  expected="$(printf 'x\ny\nz')"
  [ "${output}" = "${expected}" ]
}

# ----------------------------------------
# array::is_empty
# ----------------------------------------

@test "array::is_empty returns 0 for empty array" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/array.sh'
    arr=()
    array::is_empty \"\${arr[@]}\"
  "
  [ "${status}" -eq 0 ]
}

@test "array::is_empty returns 1 for non-empty array" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/array.sh'
    arr=(a b c)
    array::is_empty \"\${arr[@]}\"
  "
  [ "${status}" -eq 1 ]
}

# ----------------------------------------
# array::join
# ----------------------------------------

@test "array::join joins elements with delimiter" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/array.sh'
    array::join ',' a b c d
  "
  [ "${status}" -eq 0 ]
  assert_output_contains "a,b,c,d"
}

# ----------------------------------------
# array::reverse
# ----------------------------------------

@test "array::reverse reverses an array" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/array.sh'
    array::reverse 1 2 3 4 5
  "
  [ "${status}" -eq 0 ]
  expected="$(printf '5\n4\n3\n2\n1')"
  [ "${output}" = "${expected}" ]
}

# ----------------------------------------
# array::sort
# ----------------------------------------

@test "array::sort sorts array elements" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/array.sh'
    array::sort c a b
  "
  [ "${status}" -eq 0 ]
  expected="$(printf 'a\nb\nc')"
  [ "${output}" = "${expected}" ]
}

# ----------------------------------------
# array::bsort
# ----------------------------------------

@test "array::bsort bubble-sorts integers" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/array.sh'
    array::bsort 4 2 7 1
  "
  [ "${status}" -eq 0 ]
  expected="$(printf '1\n2\n4\n7')"
  [ "${output}" = "${expected}" ]
}

# ----------------------------------------
# array::merge
# ----------------------------------------

@test "array::merge combines two arrays" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/array.sh'
    a=(1 2)
    b=(3 4)
    array::merge 'a[@]' 'b[@]'
  "
  [ "${status}" -eq 0 ]
  assert_line "1"
  assert_line "3"
}

# ----------------------------------------
# Idempotency
# ----------------------------------------

@test "array library is idempotent when sourced twice" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/lib/bash/array.sh'
    source '${REPO_ROOT}/lib/bash/array.sh'
    declare -F array::contains >/dev/null
    printf 'loaded=yes\n'
  "
  [ "${status}" -eq 0 ]
  assert_line "loaded=yes"
}

# ----------------------------------------
# Integration: available after .shellrc
# ----------------------------------------

@test "array functions are available after sourcing .shellrc" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    declare -F array::contains >/dev/null
    declare -F array::dedupe >/dev/null
    declare -F array::join >/dev/null
    printf 'array_runtime=yes\n'
  "
  [ "${status}" -eq 0 ]
  assert_line "array_runtime=yes"
}
