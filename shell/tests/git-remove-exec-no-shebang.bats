#!/usr/bin/env bats

load test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
  TEST_REPO="${TEST_HOME}/repo"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

init_test_repo() {
  mkdir -p "${TEST_REPO}"
  git -C "${TEST_REPO}" init >/dev/null
}

@test "git-remove-exec-no-shebang prints help" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    git-remove-exec-no-shebang --help
  "

  [ "${status}" -eq 0 ]
  assert_output_contains "Usage:"
  assert_output_contains "git-remove-exec-no-shebang [options]"
}

@test "git-remove-exec-no-shebang prints version" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    git-remove-exec-no-shebang --version
  "

  [ "${status}" -eq 0 ]
  assert_line "git-remove-exec-no-shebang v2.0.0"
}

@test "git-remove-exec-no-shebang fails outside a git repository" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    cd '${TEST_HOME}'
    git-remove-exec-no-shebang
  "

  [ "${status}" -eq 1 ]
  assert_output_contains "[error] Not inside a Git repository."
}

@test "git-remove-exec-no-shebang strips exec bit from tracked files without a shebang" {
  init_test_repo

  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    cd '${TEST_REPO}'
    printf 'plain text\n' > notes.txt
    chmod +x notes.txt
    git add notes.txt
    git-remove-exec-no-shebang
    if [[ -x notes.txt ]]; then
      printf 'notes_exec=yes\n'
    else
      printf 'notes_exec=no\n'
    fi
  "

  [ "${status}" -eq 0 ]
  assert_output_contains "Removed exec bit: notes.txt"
  assert_output_contains "Stripped exec bit from 1 file(s)."
  assert_line "notes_exec=no"
}

@test "git-remove-exec-no-shebang preserves exec bit for shebang scripts" {
  init_test_repo

  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    cd '${TEST_REPO}'
    cat > script.sh <<'EOF'
#!/usr/bin/env bash
printf 'hello\n'
EOF
    chmod +x script.sh
    git add script.sh
    git-remove-exec-no-shebang
    if [[ -x script.sh ]]; then
      printf 'script_exec=yes\n'
    else
      printf 'script_exec=no\n'
    fi
  "

  [ "${status}" -eq 0 ]
  assert_output_contains "No invalid exec bits found."
  assert_line "script_exec=yes"
}

@test "git-remove-exec-no-shebang quiet mode suppresses per-file output" {
  init_test_repo

  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    cd '${TEST_REPO}'
    printf 'plain text\n' > notes.txt
    chmod +x notes.txt
    git add notes.txt
    git-remove-exec-no-shebang --quiet
  "

  [ "${status}" -eq 0 ]
  assert_output_contains "Stripped exec bit from 1 file(s)."
  if [[ "${output}" == *"Removed exec bit: notes.txt"* ]]; then
    printf 'unexpected per-file output:\n%s\n' "${output}" >&2
    return 1
  fi
}
