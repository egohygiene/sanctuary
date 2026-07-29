#!/usr/bin/env bats

load test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

@test "telemetry-opt-out lists actions without mutating tools" {
  run "${REPO_ROOT}/bin/telemetry-opt-out" --list
  [ "${status}" -eq 0 ]
  assert_output_contains "flutter"
  assert_output_contains "netlify"
}

@test "install-packages dry run ignores comments and preserves package specs" {
  cat > "${TEST_HOME}/packages.txt" <<'EOF'
# Base tools
curl
git=1.2.3 # pinned
EOF

  run "${REPO_ROOT}/bin/install-packages" \
    --manager apt \
    --dry-run \
    --no-update \
    "${TEST_HOME}/packages.txt"

  [ "${status}" -eq 0 ]
  assert_output_contains "packages: 2"
  assert_output_contains "apt-get install --yes --no-install-recommends curl git=1.2.3"
}

@test "install-pyenv dry run uses the XDG data target" {
  run env \
    HOME="${TEST_HOME}" \
    XDG_DATA_HOME="${TEST_HOME}/data" \
    "${REPO_ROOT}/bin/install-pyenv" \
    --dry-run \
    --no-plugins

  [ "${status}" -eq 0 ]
  assert_output_contains "pyenv root: ${TEST_HOME}/data/pyenv"
}

@test "shell-banner renders explicit files" {
  printf "TEST BANNER\n" > "${TEST_HOME}/banner.txt"

  run "${REPO_ROOT}/bin/shell-banner" \
    --file "${TEST_HOME}/banner.txt" \
    --logo-only

  [ "${status}" -eq 0 ]
  assert_line "TEST BANNER"
}
