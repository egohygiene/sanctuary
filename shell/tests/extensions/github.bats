#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

@test "extension loader is available after init and github extension loads successfully" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    declare -F egohygiene_load_extension >/dev/null
    egohygiene_load_extension github
    declare -F github::latest_tag >/dev/null
    printf 'loader=yes\n'
    printf 'github_latest_tag=yes\n'
  "

  [ "${status}" -eq 0 ]
  assert_line "loader=yes"
  assert_line "github_latest_tag=yes"
}

@test "github extension is idempotent when loaded twice" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    egohygiene_load_extension github
    egohygiene_load_extension github
    declare -F github::latest_release_json >/dev/null
    declare -F github::latest_tag >/dev/null
    printf 'loaded_twice=yes\n'
  "

  [ "${status}" -eq 0 ]
  assert_line "loaded_twice=yes"
}

@test "github extension supports lazy loading without auto-loading by default" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    if declare -F github::latest_tag >/dev/null; then
      printf 'preloaded=yes\n'
    else
      printf 'preloaded=no\n'
    fi

    if ! declare -F github::latest_tag >/dev/null; then
      egohygiene_load_extension github
    fi

    declare -F github::latest_tag >/dev/null
    printf 'lazy_loaded=yes\n'
  "

  [ "${status}" -eq 0 ]
  assert_line "preloaded=no"
  assert_line "lazy_loaded=yes"
}

@test "github parsing helpers extract values from release json" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    egohygiene_load_extension github

    release_json='{
      \"tag_name\": \"v1.2.3\",
      \"tarball_url\": \"https://api.github.com/repos/example/project/tarball/v1.2.3\",
      \"published_at\": \"2026-04-17T12:00:00Z\"
    }'

    printf '%s\n' \"\${release_json}\" | github::latest_tag
    printf '%s\n' \"\${release_json}\" | github::tarball_url
    printf '%s\n' \"\${release_json}\" | github::published_at
  "

  [ "${status}" -eq 0 ]
  assert_line "v1.2.3"
  assert_line "https://api.github.com/repos/example/project/tarball/v1.2.3"
  assert_line "2026-04-17T12:00:00Z"
}

@test "github helpers fail fast on missing required arguments" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    egohygiene_load_extension github

    github::latest_release_json >/dev/null 2>&1
    printf 'latest_release_json_status=%s\n' \"\$?\"

    github::commit_sha_for_tag 'openai/openai' >/dev/null 2>&1
    printf 'commit_sha_for_tag_status=%s\n' \"\$?\"
  "

  [ "${status}" -eq 0 ]
  assert_line "latest_release_json_status=1"
  assert_line "commit_sha_for_tag_status=1"
}
