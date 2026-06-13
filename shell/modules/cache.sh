#!/usr/bin/env bash
#
# ============================================
# 🗂️ EgoHygiene Module — Cache Management
# ============================================
#
# Redirects tool-specific caches and artifacts
# into XDG-compliant locations.
#
# Guarantees:
# - Idempotent
# - Requires XDG module
# - Cross-platform safe
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_MODULE_CACHE_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_MODULE_CACHE_LOADED="true"

# --------------------------------------------
# 🛑 Dependency Check (XDG required)
# --------------------------------------------
if [[ -z "${XDG_CACHE_HOME:-}" ]]; then
  return 0
fi

# Ensure STATE fallback is always defined
EGOHYGIENE_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"

# --------------------------------------------
# 🧰 Development & Languages
# --------------------------------------------

export SONARLINT_USER_HOME="${XDG_CACHE_HOME}/sonarlint"
export NODE_COMPILER_CACHE="${XDG_CACHE_HOME}/node/compiler"
export YARN_CACHE_FOLDER="${XDG_CACHE_HOME}/yarn"
export PUB_CACHE="${XDG_CACHE_HOME}/pub-cache"
export KSCRIPT_CACHE_DIR="${XDG_CACHE_HOME}/kscript"
export EM_CACHE="${XDG_CACHE_HOME}/emscripten/cache"
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle"
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem"

# --------------------------------------------
# 🐍 Python Ecosystem
# --------------------------------------------

export PYTHON_EGG_CACHE="${XDG_CACHE_HOME}/python-eggs"
export PEX_ROOT="${XDG_CACHE_HOME}/pex"
export MYPY_CACHE_DIR="${XDG_CACHE_HOME}/mypy"
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"
export RUFF_CACHE_DIR="${XDG_CACHE_HOME}/ruff"
export SOLARGRAPH_CACHE="${XDG_CACHE_HOME}/solargraph"

# --------------------------------------------
# 🎮 Hardware & Graphics
# --------------------------------------------

export __GL_SHADER_DISK_CACHE_PATH="${XDG_CACHE_HOME}/nv"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"

# --------------------------------------------
# 🍺 Homebrew
# --------------------------------------------

export HOMEBREW_CACHE="${XDG_CACHE_HOME}/homebrew"
export HOMEBREW_TEMP="${XDG_CACHE_HOME}/homebrew/tmp"
export HOMEBREW_LOGS="${EGOHYGIENE_STATE_HOME}/homebrew"

# --------------------------------------------
# 🖥️ Shell & UI Tools
# --------------------------------------------

export STARSHIP_CACHE="${XDG_CACHE_HOME}/starship"
export XMONAD_CACHE_DIR="${XDG_CACHE_HOME}/xmonad"

export XCOMPOSECACHE="${XDG_CACHE_HOME}/X11/xcompose"
export ALTUSERXSESSION="${XDG_CACHE_HOME}/X11/Xsession"
export USERXSESSION="${XDG_CACHE_HOME}/X11/xsession"
export USERXSESSIONRC="${XDG_CACHE_HOME}/X11/xsessionrc"
export ICEAUTHORITY="${XDG_CACHE_HOME}/ICEauthority"

# --------------------------------------------
# 🧩 Miscellaneous
# --------------------------------------------

export CALIBRE_CACHE_DIRECTORY="${XDG_CACHE_HOME}/calibre"
export DVDCSS_CACHE="${XDG_CACHE_HOME}/dvdcss"
export SINGULARITY_CACHEDIR="${XDG_CACHE_HOME}/singularity"
