#!/usr/bin/env bash
#
# ============================================
# 🌍 EgoHygiene Module — Environment
# ============================================
#
# Defines core environment behavior:
# - PATH orchestration
# - editor defaults
# - locale configuration
#
# Guarantees:
# - Idempotent
# - Depends on core + xdg + os
# - Deterministic PATH ordering
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_MODULE_ENVIRONMENT_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_MODULE_ENVIRONMENT_LOADED="true"

# --------------------------------------------
# 🛑 Dependency Checks
# --------------------------------------------
[[ -n "${XDG_DATA_HOME:-}" ]] || return 0
[[ -n "${XDG_CONFIG_HOME:-}" ]] || return 0

# --------------------------------------------
# 🌐 Locale & Language
# --------------------------------------------

export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-${LANG}}"

# --------------------------------------------
# ✏️ Editor Defaults
# --------------------------------------------

# Respect a user-selected editor.
if [[ -z "${EDITOR:-}" ]]; then
  if guard::has_command "nvim"; then
    export EDITOR="nvim"
  elif guard::has_command "vim"; then
    export EDITOR="vim"
  else
    export EDITOR="vi"
  fi
fi

export VISUAL="${VISUAL:-${EDITOR}}"

# --------------------------------------------
# 🧠 PATH Orchestration
# --------------------------------------------

export PATH="${PATH:-/usr/bin:/bin}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-${HOME}/.local/bin}"

mkdir -p "${XDG_BIN_HOME}"

# Prepend in reverse priority order because each successful call becomes first.
environment_path_candidates=(
  "${ASDF_DATA_DIR:-${XDG_DATA_HOME}/asdf}/shims"
  "${ASDF_DATA_DIR:-${XDG_DATA_HOME}/asdf}/bin"
  "${PYENV_ROOT:-${XDG_DATA_HOME}/pyenv}/bin"
  "${VOLTA_HOME:-${XDG_DATA_HOME}/volta}/bin"
  "${PIPX_BIN_DIR:-${XDG_DATA_HOME}/pipx/bin}"
  "${GOPATH:-${XDG_DATA_HOME}/go}/bin"
  "${CARGO_HOME:-${XDG_DATA_HOME}/cargo}/bin"
  "${PNPM_HOME:-${XDG_DATA_HOME}/pnpm}"
  "${XDG_BIN_HOME}"
  "${EGOHYGIENE_SHELL_ROOT}/bin"
)

for environment_path_candidate in "${environment_path_candidates[@]}"; do
  if [[ -d "${environment_path_candidate}" ]]; then
    core::path_prepend "${environment_path_candidate}"
  fi
done

unset environment_path_candidate
unset environment_path_candidates

# Project-local executable directories are intentionally opt-in. Adding the
# startup working directory to PATH makes PATH stale after `cd` and can execute
# an untrusted binary merely by entering a directory.
if [[ "${EGOHYGIENE_ENABLE_PROJECT_PATH:-0}" == "1" ]]; then
  for environment_project_path in "${PWD}/bin" "${PWD}/node_modules/.bin"; do
    if [[ -d "${environment_project_path}" ]]; then
      core::path_prepend "${environment_project_path}"
    fi
  done
  unset environment_project_path
fi

export CLICOLOR=1
export PYTHONUTF8=1
export PYTHONIOENCODING="UTF-8"
export POETRY_PREVIEW=1
export PIPENV_VENV_IN_PROJECT=1

# Colorize GCC warnings and errors.
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

export GHCUP_USE_XDG_DIRS="true"

# --------------------------------------------
# 🧹 Cleanup
# --------------------------------------------

# Nothing to clean — this defines state intentionally
