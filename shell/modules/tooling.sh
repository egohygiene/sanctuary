#!/usr/bin/env bash
# shellcheck shell=bash
#
# XDG-aware developer-tool configuration shared by Bash and Zsh.
#
# Existing values always win. Stateful tools with legacy data are redirected
# only when their XDG target already exists or their legacy location does not;
# this prevents a shell reload from making existing credentials appear missing.

if [[ -n "${EGOHYGIENE_MODULE_TOOLING_LOADED:-}" ]]; then
  return 0
fi
export EGOHYGIENE_MODULE_TOOLING_LOADED="true"

[[ -n "${XDG_CONFIG_HOME:-}" ]] || return 0
[[ -n "${XDG_CACHE_HOME:-}" ]] || return 0
[[ -n "${XDG_DATA_HOME:-}" ]] || return 0
[[ -n "${XDG_STATE_HOME:-}" ]] || return 0

tooling::set_default() {
  local variable_name="${1:-}"
  local variable_value="${2:-}"
  local current_value=""

  case "${variable_name}" in
    "" | *[!A-Za-z0-9_]*) return 64 ;;
  esac

  eval "current_value=\${${variable_name}:-}"
  if [[ -z "${current_value}" ]]; then
    export "${variable_name}=${variable_value}"
  fi
}

tooling::set_xdg() {
  local variable_name="${1:-}"
  local xdg_path="${2:-}"
  local legacy_path="${3:-}"
  local current_value=""

  case "${variable_name}" in
    "" | *[!A-Za-z0-9_]*) return 64 ;;
  esac

  eval "current_value=\${${variable_name}:-}"
  [[ -z "${current_value}" ]] || return 0

  if [[ -n "${legacy_path}" && -e "${legacy_path}" && ! -e "${xdg_path}" ]]; then
    EGOHYGIENE_XDG_MIGRATION_WARNINGS="${EGOHYGIENE_XDG_MIGRATION_WARNINGS:+${EGOHYGIENE_XDG_MIGRATION_WARNINGS}:}${variable_name}"
    export EGOHYGIENE_XDG_MIGRATION_WARNINGS
    return 0
  fi

  export "${variable_name}=${xdg_path}"
}

# Version managers and language runtimes.
tooling::set_xdg "ASDF_DATA_DIR" "${XDG_DATA_HOME}/asdf" "${HOME}/.asdf"
tooling::set_xdg "PYENV_ROOT" "${XDG_DATA_HOME}/pyenv" "${HOME}/.pyenv"
tooling::set_xdg "RBENV_ROOT" "${XDG_DATA_HOME}/rbenv" "${HOME}/.rbenv"
tooling::set_xdg "NVM_DIR" "${XDG_DATA_HOME}/nvm" "${HOME}/.nvm"
tooling::set_xdg "VOLTA_HOME" "${XDG_DATA_HOME}/volta" "${HOME}/.volta"
tooling::set_default "PNPM_HOME" "${XDG_DATA_HOME}/pnpm"
tooling::set_xdg "CARGO_HOME" "${XDG_DATA_HOME}/cargo" "${HOME}/.cargo"
tooling::set_xdg "RUSTUP_HOME" "${XDG_DATA_HOME}/rustup" "${HOME}/.rustup"
tooling::set_default "GOPATH" "${XDG_DATA_HOME}/go"
tooling::set_default "GOMODCACHE" "${GOPATH:-${XDG_DATA_HOME}/go}/pkg/mod"
tooling::set_xdg "SDKMAN_DIR" "${XDG_DATA_HOME}/sdkman" "${HOME}/.sdkman"
tooling::set_default "GHCUP_USE_XDG_DIRS" "true"
tooling::set_default "STACK_ROOT" "${XDG_DATA_HOME}/stack"
tooling::set_default "CABAL_DIR" "${XDG_DATA_HOME}/cabal"
tooling::set_default "OPAMROOT" "${XDG_DATA_HOME}/opam"
tooling::set_default "DUB_HOME" "${XDG_DATA_HOME}/dub"
tooling::set_default "ELM_HOME" "${XDG_DATA_HOME}/elm"

# Python, Ruby, Java, and .NET.
tooling::set_default "PIP_CACHE_DIR" "${XDG_CACHE_HOME}/pip"
tooling::set_default "PIP_CONFIG_FILE" "${XDG_CONFIG_HOME}/pip/pip.conf"
tooling::set_default "PIPX_HOME" "${XDG_DATA_HOME}/pipx"
tooling::set_default "PIPX_BIN_DIR" "${XDG_DATA_HOME}/pipx/bin"
tooling::set_default "POETRY_HOME" "${XDG_DATA_HOME}/poetry"
tooling::set_default "UV_CACHE_DIR" "${XDG_CACHE_HOME}/uv"
tooling::set_default "IPYTHONDIR" "${XDG_CONFIG_HOME}/ipython"
tooling::set_default "JUPYTER_CONFIG_DIR" "${XDG_CONFIG_HOME}/jupyter"
tooling::set_default "PYTHONSTARTUP" "${XDG_CONFIG_HOME}/python/pythonrc"
tooling::set_default "GEM_HOME" "${XDG_DATA_HOME}/gem"
tooling::set_default "BUNDLE_USER_CONFIG" "${XDG_CONFIG_HOME}/bundle"
tooling::set_default "BUNDLE_USER_CACHE" "${XDG_CACHE_HOME}/bundle"
tooling::set_default "BUNDLE_USER_PLUGIN" "${XDG_DATA_HOME}/bundle"
tooling::set_default "GRADLE_USER_HOME" "${XDG_DATA_HOME}/gradle"
tooling::set_default "MAVEN_USER_HOME" "${XDG_DATA_HOME}/maven"
tooling::set_default "DOTNET_CLI_HOME" "${XDG_DATA_HOME}/dotnet"
tooling::set_default "NUGET_PACKAGES" "${XDG_CACHE_HOME}/nuget/packages"

# JavaScript and web tooling.
tooling::set_default "NPM_CONFIG_USERCONFIG" "${XDG_CONFIG_HOME}/npm/npmrc"
tooling::set_default "YARN_CACHE_FOLDER" "${XDG_CACHE_HOME}/yarn"
tooling::set_default "YARN_GLOBAL_FOLDER" "${XDG_DATA_HOME}/yarn"
tooling::set_default "DENO_DIR" "${XDG_CACHE_HOME}/deno"
tooling::set_default "BUN_INSTALL" "${XDG_DATA_HOME}/bun"

# Cloud, infrastructure, and containers.
tooling::set_xdg "DOCKER_CONFIG" "${XDG_CONFIG_HOME}/docker" "${HOME}/.docker"
tooling::set_xdg "GNUPGHOME" "${XDG_DATA_HOME}/gnupg" "${HOME}/.gnupg"
tooling::set_xdg "AWS_CONFIG_FILE" "${XDG_CONFIG_HOME}/aws/config" "${HOME}/.aws/config"
tooling::set_xdg "AWS_SHARED_CREDENTIALS_FILE" "${XDG_CONFIG_HOME}/aws/credentials" "${HOME}/.aws/credentials"
tooling::set_default "AZURE_CONFIG_DIR" "${XDG_DATA_HOME}/azure"
tooling::set_default "CLOUDSDK_CONFIG" "${XDG_CONFIG_HOME}/gcloud"
tooling::set_default "KUBECACHEDIR" "${XDG_CACHE_HOME}/kube"
tooling::set_default "K9SCONFIG" "${XDG_CONFIG_HOME}/k9s"
tooling::set_default "MINIKUBE_HOME" "${XDG_DATA_HOME}/minikube"
tooling::set_default "VAGRANT_HOME" "${XDG_DATA_HOME}/vagrant"
tooling::set_default "ANSIBLE_HOME" "${XDG_DATA_HOME}/ansible"
tooling::set_default "ANSIBLE_CONFIG" "${XDG_CONFIG_HOME}/ansible/ansible.cfg"
tooling::set_default "TERRAGRUNT_DOWNLOAD" "${XDG_CACHE_HOME}/terragrunt"
tooling::set_default "TF_PLUGIN_CACHE_DIR" "${XDG_CACHE_HOME}/terraform/plugin-cache"
tooling::set_default "PULUMI_HOME" "${XDG_DATA_HOME}/pulumi"

# Editors, shells, and terminal tools.
tooling::set_xdg "ZDOTDIR" "${XDG_CONFIG_HOME}/zsh" "${HOME}/.zshrc"
tooling::set_default "STARSHIP_CONFIG" "${XDG_CONFIG_HOME}/starship.toml"
tooling::set_default "STARSHIP_CACHE" "${XDG_CACHE_HOME}/starship"
tooling::set_default "RIPGREP_CONFIG_PATH" "${XDG_CONFIG_HOME}/ripgrep/config"
tooling::set_default "INPUTRC" "${XDG_CONFIG_HOME}/readline/inputrc"
tooling::set_default "SCREENRC" "${XDG_CONFIG_HOME}/screen/screenrc"
tooling::set_default "WGETRC" "${XDG_CONFIG_HOME}/wget/wgetrc"
tooling::set_default "CURL_HOME" "${XDG_CONFIG_HOME}/curl"
tooling::set_default "TERMINFO" "${XDG_DATA_HOME}/terminfo"
tooling::set_default "_Z_DATA" "${XDG_DATA_HOME}/z/data"
tooling::set_default "WAKATIME_HOME" "${XDG_CONFIG_HOME}/wakatime"

# Databases and data tools.
tooling::set_default "PSQLRC" "${XDG_CONFIG_HOME}/postgresql/psqlrc"
tooling::set_default "PGPASSFILE" "${XDG_CONFIG_HOME}/postgresql/pgpass"
tooling::set_default "PGSERVICEFILE" "${XDG_CONFIG_HOME}/postgresql/pg_service.conf"
tooling::set_default "REDISCLI_RCFILE" "${XDG_CONFIG_HOME}/redis/redisclirc"
tooling::set_default "IPFS_PATH" "${XDG_DATA_HOME}/ipfs"
tooling::set_default "PLATFORMIO_CORE_DIR" "${XDG_DATA_HOME}/platformio"
tooling::set_default "JULIA_DEPOT_PATH" "${XDG_DATA_HOME}/julia"

# Media and creative tooling.
tooling::set_default "CALIBRE_CONFIG_DIRECTORY" "${XDG_CONFIG_HOME}/calibre"
tooling::set_default "CALIBRE_CACHE_DIRECTORY" "${XDG_CACHE_HOME}/calibre"
tooling::set_default "CALIBRE_TEMP_DIR" "${XDG_RUNTIME_DIR}/calibre"
tooling::set_default "MPV_HOME" "${XDG_CONFIG_HOME}/mpv"
tooling::set_default "FFMPEG_DATADIR" "${XDG_DATA_HOME}/ffmpeg"
tooling::set_default "BLENDER_USER_RESOURCES" "${XDG_DATA_HOME}/blender"
tooling::set_default "WINEPREFIX" "${XDG_DATA_HOME}/wine"

# Android, Dart, and Flutter.
tooling::set_xdg "ANDROID_USER_HOME" "${XDG_DATA_HOME}/android" "${HOME}/.android"
tooling::set_default "ANDROID_HOME" "${XDG_DATA_HOME}/android/sdk"
tooling::set_default "ANDROID_SDK_ROOT" "${ANDROID_HOME:-${XDG_DATA_HOME}/android/sdk}"
tooling::set_default "ANDROID_AVD_HOME" "${XDG_DATA_HOME}/android/avd"
tooling::set_default "ANALYZER_STATE_LOCATION_OVERRIDE" "${XDG_STATE_HOME}/dart/analysis-server"
tooling::set_default "PUB_CACHE" "${XDG_CACHE_HOME}/dart-pub"
tooling::set_default "FLUTTER_HOME" "${XDG_DATA_HOME}/flutter"

# Existing Homebrew installations are platform-aware and do not require
# evaluating `brew shellenv` on every interactive shell startup.
tooling_brew_prefix=""
if os::is_linux && [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
  tooling_brew_prefix="/home/linuxbrew/.linuxbrew"
elif os::is_macos && [[ -d "/opt/homebrew" ]]; then
  tooling_brew_prefix="/opt/homebrew"
elif os::is_macos && [[ -d "/usr/local/Homebrew" ]]; then
  tooling_brew_prefix="/usr/local"
fi

if [[ -n "${tooling_brew_prefix}" ]]; then
  [[ -d "${tooling_brew_prefix}/sbin" ]] && core::path_prepend "${tooling_brew_prefix}/sbin"
  [[ -d "${tooling_brew_prefix}/bin" ]] && core::path_prepend "${tooling_brew_prefix}/bin"
  tooling::set_default "HOMEBREW_CACHE" "${XDG_CACHE_HOME}/homebrew"
  tooling::set_default "HOMEBREW_LOGS" "${XDG_STATE_HOME}/homebrew/logs"
  tooling::set_default "HOMEBREW_TEMP" "${XDG_RUNTIME_DIR}/homebrew"
fi

unset tooling_brew_prefix
