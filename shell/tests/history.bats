#!/usr/bin/env bats

load test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

@test "history module configures bash history under XDG state" {
  run_in_clean_shell "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    printf 'shell=%s\n' \"\${EGOHYGIENE_SHELL_NAME}\"
    printf 'histfile=%s\n' \"\${HISTFILE}\"
    printf 'histsize=%s\n' \"\${HISTSIZE}\"
    [[ -d \${HOME}/.local/state/bash ]] && printf 'history_dir=yes\n'
  "

  [ "${status}" -eq 0 ]
  assert_line "shell=bash"
  assert_line "histfile=${TEST_HOME}/.local/state/bash/history"
  assert_line "histsize=10000"
  assert_line "history_dir=yes"
}

@test "history module configures zsh history without loading bash helpers" {
  run_in_clean_zsh "${TEST_HOME}" "
    source '${REPO_ROOT}/.shellrc'
    printf 'shell=%s\n' \"\${EGOHYGIENE_SHELL_NAME}\"
    # Verify bash.sh helpers are not loaded in Zsh sessions.
    if [[ -n \"\${EGOHYGIENE_LIB_BASH_LOADED:-}\" ]]; then
      printf 'bash_helpers=yes\n'
    else
      printf 'bash_helpers=no\n'
    fi
    printf 'histfile=%s\n' \"\${HISTFILE}\"
    printf 'savehist=%s\n' \"\${SAVEHIST}\"
    [[ -d \${HOME}/.local/state/zsh ]] && printf 'history_dir=yes\n'
  "

  [ "${status}" -eq 0 ]
  assert_line "shell=zsh"
  assert_line "bash_helpers=no"
  assert_line "histfile=${TEST_HOME}/.local/state/zsh/history"
  assert_line "savehist=10000"
  assert_line "history_dir=yes"
}
