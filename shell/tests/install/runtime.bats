#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  TEST_HOME="$(make_test_home)"
}

teardown() {
  rm -rf "${TEST_HOME}"
}

@test "install runtime loads shared install helpers" {
  run_in_clean_shell "${TEST_HOME}" "
    export EGOHYGIENE_SHELL_ROOT='${REPO_ROOT}'
    source '${REPO_ROOT}/lib/install/runtime.sh'
    declare -F install::platform::map_family >/dev/null
    declare -F install::package_manager::detect >/dev/null
    declare -F install::download::file >/dev/null
    declare -F install::checksum::verify >/dev/null
    declare -F install::archive::extract >/dev/null
    declare -F install::fs::install_executable >/dev/null
    declare -F install::github::main >/dev/null
    printf 'install_runtime=yes\n'
  "

  [ "${status}" -eq 0 ]
  assert_line "install_runtime=yes"
}

@test "install package manager detection prefers available package managers" {
  run_in_clean_shell "${TEST_HOME}" "
    export EGOHYGIENE_SHELL_ROOT='${REPO_ROOT}'
    mkdir -p '${TEST_HOME}/fake-bin'
    cat <<'EOF' > '${TEST_HOME}/fake-bin/apk'
#!/usr/bin/env bash
exit 0
EOF
    chmod +x '${TEST_HOME}/fake-bin/apk'
    export PATH='${TEST_HOME}/fake-bin'
    source '${REPO_ROOT}/lib/install/runtime.sh'
    printf 'manager=%s\n' \"\$(install::package_manager::detect)\"
  "

  [ "${status}" -eq 0 ]
  assert_line "manager=apk"
}

@test "github installer handles raw binary releases" {
  run_in_clean_shell "${TEST_HOME}" "
    export EGOHYGIENE_SHELL_ROOT='${REPO_ROOT}'
    source '${REPO_ROOT}/lib/install/runtime.sh'
    INSTALL_TOOL_NAME='shfmt'
    INSTALL_OWNER='mvdan'
    INSTALL_REPO='sh'
    INSTALL_ASSET_TEMPLATE='shfmt_v{{version}}_{{platform}}_{{arch}}'
    INSTALL_PLATFORM_LINUX='linux'
    INSTALL_PLATFORM_DARWIN='darwin'
    INSTALL_ARCH_X86_64='amd64'
    INSTALL_ARCH_ARM64='arm64'
    INSTALL_CHECKSUM_ASSET='sha256sums.txt'
    INSTALL_ARCHIVE_FORMAT='raw'
    INSTALL_BIN_NAME='shfmt'
    expected_checksum_url='https://github.com/mvdan/sh/releases/download/v9.9.9/sha256sums.txt'

    install::github::resolve_version() { printf '9.9.9\n'; }
    install::download::file() {
      local url=\"\$1\"
      local output_path=\"\$2\"

      if [[ \${url} == \${expected_checksum_url} ]]; then
        printf '%s\n' \"\${url}\" > '${TEST_HOME}/checksum-download-url.txt'
        printf 'expected-sha  shfmt_v9.9.9_linux_amd64\n' > \"\${output_path}\"
      else
        printf '%s\n' \"\${url}\" > '${TEST_HOME}/download-url.txt'
        cat <<'EOF' > \"\${output_path}\"
#!/usr/bin/env bash
printf 'shfmt version 9.9.9\n'
EOF
      fi
    }
    install::checksum::verify() {
      printf '%s|%s|%s\n' \"\$1\" \"\$2\" \"\$3\" > '${TEST_HOME}/checksum.txt'
    }

    install::github::main --install-dir '${TEST_HOME}/bin'

    printf 'download_url=%s\n' \"\$(cat '${TEST_HOME}/download-url.txt')\"
    printf 'checksum_call=%s\n' \"\$(cat '${TEST_HOME}/checksum.txt')\"
    [[ -x '${TEST_HOME}/bin/shfmt' ]] && printf 'installed=yes\n'
  "

  [ "${status}" -eq 0 ]
  assert_line "download_url=https://github.com/mvdan/sh/releases/download/v9.9.9/shfmt_v9.9.9_linux_amd64"
  assert_output_contains "checksum_call=sha256|"
  assert_line "installed=yes"
}

@test "github installer extracts archive members before install" {
  run_in_clean_shell "${TEST_HOME}" "
    export EGOHYGIENE_SHELL_ROOT='${REPO_ROOT}'
    source '${REPO_ROOT}/lib/install/runtime.sh'
    INSTALL_TOOL_NAME='dust'
    INSTALL_OWNER='bootandy'
    INSTALL_REPO='dust'
    INSTALL_ASSET_TEMPLATE='dust-v{{version}}-{{arch}}-{{platform}}.tar.gz'
    INSTALL_PLATFORM_LINUX='unknown-linux-gnu'
    INSTALL_PLATFORM_DARWIN='apple-darwin'
    INSTALL_ARCH_X86_64='x86_64'
    INSTALL_ARCH_ARM64='aarch64'
    INSTALL_ARCHIVE_FORMAT='tar.gz'
    INSTALL_ARCHIVE_MEMBER_TEMPLATE='dust-v{{version}}-{{arch}}-{{platform}}/dust'
    INSTALL_BIN_NAME='dust'

    install::github::resolve_version() { printf '1.2.3\n'; }
    install::download::file() {
      local url=\"\$1\"
      local output_path=\"\$2\"

      printf '%s\n' \"\${url}\" > '${TEST_HOME}/archive-download-url.txt'
      mkdir -p '${TEST_HOME}/archive-root/dust-v1.2.3-x86_64-unknown-linux-gnu'
      cat <<'EOF' > '${TEST_HOME}/archive-root/dust-v1.2.3-x86_64-unknown-linux-gnu/dust'
#!/usr/bin/env bash
printf 'dust 1.2.3\n'
EOF
      tar -czf \"\${output_path}\" -C '${TEST_HOME}/archive-root' 'dust-v1.2.3-x86_64-unknown-linux-gnu'
    }

    install::github::main --install-dir '${TEST_HOME}/bin'

    printf 'download_url=%s\n' \"\$(cat '${TEST_HOME}/archive-download-url.txt')\"
    [[ -x '${TEST_HOME}/bin/dust' ]] && printf 'installed=yes\n'
  "

  [ "${status}" -eq 0 ]
  assert_line "download_url=https://github.com/bootandy/dust/releases/download/v1.2.3/dust-v1.2.3-x86_64-unknown-linux-gnu.tar.gz"
  assert_line "installed=yes"
}

@test "runtime-backed install wrappers resolve shell root from shell/bin" {
  run_in_clean_shell "${TEST_HOME}" "
    for tool in dust eza shfmt typos; do
      unset EGOHYGIENE_SHELL_ROOT
      source '${REPO_ROOT}/bin/install-'\${tool} --help || true
      printf '%s_root=%s\n' \"\${tool}\" \"\${EGOHYGIENE_SHELL_ROOT}\"
    done
  "

  [ "${status}" -eq 0 ]
  assert_output_contains "Usage: install-dust [--version x.y.z] [--install-dir DIR] [--help]"
  assert_output_contains "Usage: install-eza [--version x.y.z] [--install-dir DIR] [--help]"
  assert_output_contains "Usage: install-shfmt [--version x.y.z] [--install-dir DIR] [--help]"
  assert_output_contains "Usage: install-typos [--version x.y.z] [--install-dir DIR] [--help]"
  assert_line "dust_root=${REPO_ROOT}"
  assert_line "eza_root=${REPO_ROOT}"
  assert_line "shfmt_root=${REPO_ROOT}"
  assert_line "typos_root=${REPO_ROOT}"
}
