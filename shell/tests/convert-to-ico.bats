#!/usr/bin/env bats

load test_helper.bash

setup() {
  bats_require_minimum_version 1.5.0
  TEST_HOME="$(make_test_home)"
  STUB_DIR="${TEST_HOME}/stubs"
  FIXTURE_DIR="${TEST_HOME}/fixtures"
  mkdir -p "${STUB_DIR}" "${FIXTURE_DIR}"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

@test "convert-to-ico prints help" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    convert-to-ico --help
  "

  [ "${status}" -eq 0 ]
  assert_output_contains "Usage:"
  assert_output_contains "convert-to-ico <image_file>"
}

@test "convert-to-ico prints version" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    convert-to-ico --version
  "

  [ "${status}" -eq 0 ]
  assert_line "convert-to-ico v1.1.0"
}

@test "convert-to-ico fails when argument is missing" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    convert-to-ico
  "

  [ "${status}" -eq 1 ]
  assert_output_contains "Expected exactly one argument: <image_file>"
}

@test "convert-to-ico fails when input file does not exist" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    convert-to-ico '${FIXTURE_DIR}/missing.png'
  "

  [ "${status}" -eq 2 ]
  assert_output_contains "File not found: ${FIXTURE_DIR}/missing.png"
}

@test "convert-to-ico fails when ImageMagick is unavailable" {
  run -127 env -i \
    HOME="${TEST_HOME}" \
    PATH="${REPO_ROOT}/bin:/usr/bin:/bin" \
    TMPDIR="${TMPDIR:-/tmp}" \
    /bin/bash --noprofile --norc -lc "
      printf 'fake image\n' > '${FIXTURE_DIR}/icon.png'
      convert-to-ico '${FIXTURE_DIR}/icon.png'
    "

  [ "${status}" -eq 127 ]
  assert_output_contains "ImageMagick not found"
}

@test "convert-to-ico prefers magick when available" {
  cat > "${STUB_DIR}/magick" <<'EOF'
#!/usr/bin/env bash
touch "$4"
EOF
  cat > "${STUB_DIR}/convert" <<EOF
#!/usr/bin/env bash
printf 'convert-should-not-run\n' > '${TEST_HOME}/convert-called.txt'
exit 99
EOF
  chmod +x "${STUB_DIR}/magick" "${STUB_DIR}/convert"

  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    printf 'fake image\n' > '${FIXTURE_DIR}/icon.png'
    export PATH='${STUB_DIR}:${REPO_ROOT}/bin:/usr/bin:/bin'
    convert-to-ico '${FIXTURE_DIR}/icon.png'
    printf 'output_exists=%s\n' \"\$([[ -f '${FIXTURE_DIR}/icon.ico' ]] && printf yes || printf no)\"
    printf 'convert_called=%s\n' \"\$([[ -f '${TEST_HOME}/convert-called.txt' ]] && printf yes || printf no)\"
  "

  [ "${status}" -eq 0 ]
  assert_output_contains "Using ImageMagick command: magick"
  assert_output_contains "Successfully created: ${FIXTURE_DIR}/icon.ico"
  assert_line "output_exists=yes"
  assert_line "convert_called=no"
}

@test "convert-to-ico falls back to convert when magick is unavailable" {
  cat > "${STUB_DIR}/convert" <<'EOF'
#!/usr/bin/env bash
touch "$4"
EOF
  chmod +x "${STUB_DIR}/convert"

  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    printf 'fake image\n' > '${FIXTURE_DIR}/icon.png'
    export PATH='${STUB_DIR}:${REPO_ROOT}/bin:/usr/bin:/bin'
    convert-to-ico '${FIXTURE_DIR}/icon.png'
    printf 'output_exists=%s\n' \"\$([[ -f '${FIXTURE_DIR}/icon.ico' ]] && printf yes || printf no)\"
  "

  [ "${status}" -eq 0 ]
  assert_output_contains "Using ImageMagick command: convert"
  assert_output_contains "Successfully created: ${FIXTURE_DIR}/icon.ico"
  assert_line "output_exists=yes"
}
