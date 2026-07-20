#!/usr/bin/env bash
#
# ============================================
# 🧰 EgoHygiene Module — Tooling Configuration
# ============================================
#
# Configures language runtimes, package managers,
# and developer tooling paths.
#
# Guarantees:
# - Idempotent
# - Cross-platform safe
# - Depends on core + xdg + os modules
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_MODULE_TOOLING_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_MODULE_TOOLING_LOADED="true"

# --------------------------------------------
# 🛑 Dependency Checks
# --------------------------------------------
[[ -n "${XDG_CONFIG_HOME:-}" ]] || return 0
[[ -n "${XDG_CACHE_HOME:-}" ]] || return 0
[[ -n "${XDG_DATA_HOME:-}" ]] || return 0
[[ -n "${OS_FAMILY:-}" ]] || return 0

# --------------------------------------------
# 🍺 Homebrew / Linuxbrew
# --------------------------------------------

brew_prefix=""

if os::is_linux; then
  brew_prefix="/home/linuxbrew/.linuxbrew"
elif os::is_macos; then
  # Apple Silicon
  if [[ -d "/opt/homebrew" ]]; then
    brew_prefix="/opt/homebrew"
  # Intel macOS
  elif [[ -d "/usr/local/Homebrew" ]] || [[ -d "/usr/local/bin" ]]; then
    brew_prefix="/usr/local"
  fi
fi

if [[ -n "${brew_prefix}" && -d "${brew_prefix}" ]]; then
  core::path_prepend "${brew_prefix}/bin"
  core::path_prepend "${brew_prefix}/sbin"

  # man / info paths (safe prepend)
  if [[ -d "${brew_prefix}/share/man" ]]; then
    export MANPATH="${brew_prefix}/share/man:${MANPATH:-}"
  fi

  if [[ -d "${brew_prefix}/share/info" ]]; then
    export INFOPATH="${brew_prefix}/share/info:${INFOPATH:-}"
  fi
fi

unset brew_prefix

# --------------------------------------------
# 🔁 Version Managers
# --------------------------------------------

export ASDF_DIR="${XDG_DATA_HOME}/asdf"
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
export RBENV_ROOT="${XDG_DATA_HOME}/rbenv"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export STACK_ROOT="${XDG_DATA_HOME}/stack"
export GHCUP_USE_XDG_DIRS="true"
export SDKMAN_DIR="${XDG_DATA_HOME}/sdkman"
export NVM_DIR="${XDG_DATA_HOME}/nvm"
export N_PREFIX="${XDG_DATA_HOME}/n"
export VOLTA_HOME="${XDG_DATA_HOME}/volta"
export PNPM_HOME="${XDG_DATA_HOME}/pnpm"

# --------------------------------------------
# 🐍 Python & Ruby
# --------------------------------------------

export PYTHONPATH="${XDG_DATA_HOME}/python/lib"
export PIP_CACHE_DIR="${XDG_CACHE_HOME}/pip"
export PIPX_HOME="${XDG_DATA_HOME}/pipx"
export PIPX_BIN_DIR="${PIPX_HOME}/bin"
export POETRY_HOME="${XDG_DATA_HOME}/poetry"
export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME}/bundle"

# --------------------------------------------
# 🟢 Golang
# --------------------------------------------

export GOPATH="${XDG_DATA_HOME}/go"
export GOMODCACHE="${GOPATH}/pkg/mod"

# --------------------------------------------
# 🟢 JavaScript / Node
# --------------------------------------------

export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/.npmrc"

# Global npm binaries
if [[ -d "${XDG_DATA_HOME}/npm/bin" ]]; then
  core::path_prepend "${XDG_DATA_HOME}/npm/bin"
fi

# --------------------------------------------
# ☕ JVM & .NET
# --------------------------------------------

export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"
export M2_HOME="${XDG_DATA_HOME}/mvn/.mvn"
export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"
export NUGET_PACKAGES="${XDG_DATA_HOME}/nuget/packages"

# --------------------------------------------
# 🧪 Developer Tools
# --------------------------------------------

export VS_CODE_DATA_DIR="${XDG_DATA_HOME}/vscode/data"
export VS_CODE_EXTENSIONS_DIR="${XDG_DATA_HOME}/vscode/extensions"
export ANALYZER_STATE_LOCATION_OVERRIDE="${XDG_DATA_HOME}/dart/.dartServer"
export PLATFORMIO_CORE_DIR="${XDG_DATA_HOME}/platformio"
export EM_PORTS="${XDG_DATA_HOME}/emscripten/cache"
export CCACHE_DIR="${XDG_DATA_HOME}/ccache"

# --------------------------------------------
# 🖥️ Shell & Terminal Tools
# --------------------------------------------

export OSH="${XDG_DATA_HOME}/oh-my-bash"
export ZSH="${XDG_DATA_HOME}/oh-my-zsh"
export ZPLUG_HOME="${XDG_DATA_HOME}/zplug"
export TERMINFO="${XDG_DATA_HOME}/terminfo"
export _Z_DATA="${XDG_DATA_HOME}/z/data"

# --------------------------------------------
# 🏗️ Infrastructure & System Tools
# --------------------------------------------

export MINIKUBE_HOME="${XDG_DATA_HOME}/minikube"
export IPFS_PATH="${XDG_DATA_HOME}/ipfs"
export VAGRANT_HOME="${XDG_DATA_HOME}/vagrant"
export FLATPAK_USER_DIR="${XDG_DATA_HOME}/flatpak"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# --------------------------------------------
# 🎧 Media & Creative Tools
# --------------------------------------------

export AUDACITY_PATH="${XDG_DATA_HOME}/audacity"
export BLENDER_USER_RESOURCES="${XDG_DATA_HOME}/blender"
export VLC_PLUGIN_PATH="${XDG_DATA_HOME}/vlc/plugins"
export VLC_DATA_PATH="${XDG_DATA_HOME}/vlc/data"
export KODI_DATA="${XDG_DATA_HOME}/kodi"
export GPODDER_DOWNLOAD_DIR="${XDG_DATA_HOME}/gpodder/downloads"

# --------------------------------------------
# 🧩 Personal & Miscellaneous Tools
# --------------------------------------------

export AB_DATA="${XDG_DATA_HOME}/abook/addressbook"
export ANKI_DIR="${XDG_DATA_HOME}/anki"
export LEDGER_FILE="${XDG_DATA_HOME}/hledger/.hledger.journal"
export NB_DIR="${XDG_DATA_HOME}/nb"
export WINEPREFIX="${XDG_DATA_HOME}/wine"
export BOGOFILTER_DIR="${XDG_DATA_HOME}/bogofilter"

export FLUTTER_HOME="${XDG_DATA_HOME}/flutter"
export STACK_ROOT="${XDG_DATA_HOME}/stack"
export IPFS_PATH="${XDG_DATA_HOME}/ipfs"
export PLATFORMIO_CORE_DIR="${XDG_DATA_HOME}/platformio"
export DUB_HOME="${XDG_DATA_HOME}/dub"
export ELM_HOME="${XDG_DATA_HOME}/elm"
export GPODDER_HOME="${XDG_DATA_HOME}/gpodder"
export OMNISHARPHOME="${XDG_DATA_HOME}/omnisharp"
export PARALLEL_HOME="${XDG_DATA_HOME}/parallel"
export GRIPHOME="${XDG_DATA_HOME}/grip"
export DOT_SAGE="${XDG_DATA_HOME}/sage"
export W3M_DIR="${XDG_DATA_HOME}/w3m"
export PARALLEL_HOME="${XDG_DATA_HOME}/.parallel"
export ZPLUG_HOME="${XDG_DATA_HOME}/zplug"
export IPYTHONDIR="${XDG_DATA_HOME}/ipython"
export MPLAYER_HOME="${XDG_DATA_HOME}/mplayer"
export MEDNAFEN_HOME="${XDG_DATA_HOME}/mednafen"
export WEECHAT_HOME="${XDG_DATA_HOME}/weechat"
export KDEHOME="${XDG_DATA_HOME}/kde"
export DOOMDIR="${XDG_DATA_HOME}/doom"
export CGDB_DIR="${XDG_DATA_HOME}/cgdb"
export ANSIBLE_HOME="${XDG_DATA_HOME}/ansible"
export ATOM_HOME="${XDG_DATA_HOME}/atom"
export XMONAD_DATA_DIR="${XDG_DATA_HOME}/xmonad"
export NBRC_PATH="${XDG_CONFIG_HOME}/nbrc"




