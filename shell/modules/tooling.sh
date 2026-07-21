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
export GEM_HOME="${XDG_DATA_HOME}/ruby/gems"
export BUNDLE_USER_PLUGIN="${GEM_HOME}/bundle"
export BUNDLE_USER_CONFIG="${GEM_HOME}/config"
export YARN_GLOBAL_FOLDER="${XDG_DATA_HOME}/yarn"

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
export VS_CODE_HOME_DIR="${XDG_DATA_HOME}/vscode"
export VS_CODE_DATA_DIR="${VS_CODE_HOME_DIR}/data"
export VS_CODE_EXTENSIONS_DIR="${VS_CODE_HOME_DIR}/extensions"

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
export VLC_DATA_HOME="${XDG_DATA_HOME}/vlc"
export VLC_DATA_PATH="${VLC_DATA_HOME}/data"
export VLC_PLUGIN_PATH="${VLC_DATA_HOME}/plugins"
export VLCRC="${VLC_DATA_HOME}/vlcrc"
export KODI_DATA="${XDG_DATA_HOME}/kodi"
export GPODDER_DOWNLOAD_DIR="${XDG_DATA_HOME}/gpodder/downloads"
export FFMPEG_DATADIR="${XDG_DATA_HOME}/ffmpeg"
export TEXLIVE_INSTALL_PREFIX="${XDG_DATA_HOME}/texlive"
export TEXMFHOME="${TEXLIVE_INSTALL_PREFIX}/texmf"
export TEXMFVAR="${TEXLIVE_INSTALL_PREFIX}/.texlive/texmf-var"
export TEXMFCONFIG="${TEXLIVE_INSTALL_PREFIX}/.texlive/texmf-config"

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
export FCEUX_HOME="${XDG_DATA_HOME}/fceux"
export KODI_DATA="${XDG_DATA_HOME}/kodi"
export OPAMROOT="${XDG_DATA_HOME}/opam"
export NB_DIR="${XDG_DATA_HOME}/nb"
export ANKI_DIR="${XDG_DATA_HOME}/anki"
export UNISON="${XDG_DATA_HOME}/unison"
export SINCE="${XDG_DATA_HOME}/since"
export GRIPHOME="${XDG_DATA_HOME}/grip"
export ELECTRUMDIR="${XDG_DATA_HOME}/electrum"
export VOLTA_HOME="${XDG_DATA_HOME}/volta"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/.password-store"
export SDKMAN_DIR="${XDG_DATA_HOME}/sdkman"
export DISTCC_DIR="${XDG_DATA_HOME}/distcc"
export KERAS_HOME="${XDG_DATA_HOME}/keras"
export LEIN_HOME="${XDG_DATA_HOME}/lein"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
export VAGRANT_HOME="${XDG_DATA_HOME}/vagrant"
export VAGRANT_ALIAS_FILE="${VAGRANT_HOME}/aliases"
export CABAL_DIR="${XDG_DATA_HOME}/cabal"
export BINDLEPATH="${XDG_DATA_HOME}/bindle"
export WORKON_HOME="${XDG_DATA_HOME}/workon"
export IMAPFILTER_HOME="${XDG_DATA_HOME}/imapfilter"
export _Z_DATA="${XDG_DATA_HOME}/z"
export CRAWL_DIR="${XDG_DATA_HOME}/crawl/"
export R_HOME_USER="${XDG_DATA_HOME}/R"
export R_PROFILE_USER="${R_HOME_USER}/profile"
export TEXMACS_HOME_PATH="${XDG_DATA_HOME}/texmacs"
export DOT_SAGE="${XDG_DATA_HOME}/sagemath/sage"
export ABOOK_DATA="${XDG_DATA_HOME}/abook/addressbook"
export GQSTATE="${XDG_DATA_HOME}/gq/gq-state"
export MUJOCO_PY_MUJOCO_PATH="${XDG_DATA_HOME}/mujoco"
export BLENDER_HOME_DIR="${XDG_DATA_HOME}/blender"
export BLENDER_USER_RESOURCES="${XDG_DATA_HOME}/resources/blender"
export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${TERMINFO}:/usr/share/terminfo"
export MAXIMA_USERDIR="${XDG_DATA_HOME}/maxima"



export CARGO_HOME="${XDG_DATA_HOME}/cargo"





export REDISCLI_RCFILE="${XDG_CONFIG_HOME}/redis/redisclirc"
export PSQL_HOME_USER="${XDG_CONFIG_HOME}/pg"
export PSQLRC="${PSQL_HOME_USER}/psqlrc"
export PGPASSFILE="${PSQL_HOME_USER}/pgpass"
export PGSERVICEFILE="${PSQL_HOME_USER}/pg_service.conf"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export TRAVIS_CONFIG_PATH="${XDG_CONFIG_HOME}/travis"
export BOTO_CONFIG="${XDG_CONFIG_HOME}/boto"
export EM_CONFIG="${XDG_CONFIG_HOME}/emscripten/config"
export GR_PREFS_PATH="${XDG_CONFIG_HOME}/gnuradio"
export IRBRC="${XDG_CONFIG_HOME}/irb/irbrc"
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"
export OCTAVE_SITE_INITFILE="${XDG_CONFIG_HOME}/octave/octaverc"
export EASYOCR_MODULE_PATH="${XDG_CONFIG_HOME}/EasyOCR"
export LYNX_CFG_PATH="${XDG_CONFIG_HOME}/lynx.cfg"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship.toml"
export SINGULARITY_CONFIGDIR="${XDG_CONFIG_HOME}/singularity"
export WAKATIME_HOME="${XDG_CONFIG_HOME}/wakatime"
export TS3_CONFIG_DIR="${XDG_CONFIG_HOME}/ts3client"
export X3270PRO="${XDG_CONFIG_HOME}/x3270/config"
export C3270PRO="${XDG_CONFIG_HOME}/c3270/config"
export TIGRC_USER="${XDG_CONFIG_HOME}/tig/tigrc"
export GQRC="${XDG_CONFIG_HOME}/gq/gqrc"
export CABAL_CONFIG="${XDG_CONFIG_HOME}/cabal/config"
export CLAWS_MAIL_CONFIG="${XDG_CONFIG_HOME}/claw-mails"
export CD_BOOKMARK_FILE="${XDG_CONFIG_HOME}/cd-bookmark/bookmarks"
export CONKY_CONFIG="${XDG_CONFIG_HOME}/conky/conkyrc"
export SVN_CONFIG_DIR="${XDG_CONFIG_HOME}/subversion"
export K9SCONFIG="${XDG_CONFIG_HOME}/k9s"
export AZURE_CONFIG_DIR="${XDG_CONFIG_HOME}/azure"
export MATHEMATICA_USERBASE="${XDG_CONFIG_HOME}/mathematica"
export XMONAD_CONFIG_DIR="${XDG_CONFIG_HOME}/xmonad"
export X_CONFIG_HOME="${XDG_CONFIG_HOME}/X11"
export XINITRC="${X_CONFIG_HOME}/xinitrc"
export XSERVERRC="${X_CONFIG_HOME}/xserverrc"
export XCOMPOSEFILE="${XDG_CONFIG_HOME}/xcompose"
export VIMPERATOR_RUNTIME="${XDG_CONFIG_HOME}/vimperator"
export VIMPERATOR_INIT=":source ${VIMPERATOR_RUNTIME}/vimperatorrc"
export ELINKS_CONFDIR="${XDG_CONFIG_HOME}/elinks"
export CIN_CONFIG="${XDG_CONFIG_HOME}/cinelerra/bcast5"
export BINDLERC="${XDG_CONFIG_HOME}/bindlerc"
export DICTD_RC="${XDG_CONFIG_HOME}/dictd/dictrc"
export ABOOK_RC="${XDG_CONFIG_HOME}/abook/abookrc"
export RECOLL_CONFDIR="${XDG_CONFIG_HOME}/recoll"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch/.notmuch-config"
export UNCRUSTIFY_CONFIG="${XDG_CONFIG_HOME}/uncrustify/uncrustify.cfg"
export GETIPLAYERUSERPREFS="${XDG_CONFIG_HOME}/get_iplayer"

