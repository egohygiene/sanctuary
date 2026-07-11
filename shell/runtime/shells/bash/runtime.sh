#!/usr/bin/env bash
#
# ============================================
# 🐚 EgoHygiene Runtime — Bash Layer
# ============================================
#
# Loads Bash-specific libraries.
# Non-Bash shells never source this file, so all
# functionality here may safely use Bash-only features.
#

if [[ -n "${EGOHYGIENE_RUNTIME_BASH_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_RUNTIME_BASH_LOADED="true"

# --------------------------------------------
# 📦 Core Bash Library
#
# Bash introspection helpers (version, interactive,
# path, minimum-version check).
# --------------------------------------------
_bash_runtime_lib="${EGOHYGIENE_SHELL_ROOT}/lib/core/bash.sh"

if [[ -f "${_bash_runtime_lib}" && -r "${_bash_runtime_lib}" ]]; then
  # shellcheck disable=SC1090
  source "${_bash_runtime_lib}"
else
  printf "[warn] bash runtime: missing library: %s\n" "${_bash_runtime_lib}" >&2
fi

unset _bash_runtime_lib

# --------------------------------------------
# 📦 Bash Runtime Libraries
#
# Load all Bash-specific utility modules.
# --------------------------------------------
_bash_runtime_libs=(
  array.sh
  collection.sh
  date.sh
  debug.sh
  file.sh
  format.sh
  interaction.sh
  json.sh
  misc.sh
  string.sh
  terminal.sh
  validation.sh
  variable.sh
)

for _bash_runtime_lib in "${_bash_runtime_libs[@]}"; do
  _bash_runtime_lib_path="${EGOHYGIENE_SHELL_ROOT}/lib/bash/${_bash_runtime_lib}"

  if [[ -f "${_bash_runtime_lib_path}" && -r "${_bash_runtime_lib_path}" ]]; then
    # shellcheck disable=SC1090
    source "${_bash_runtime_lib_path}"
  else
    printf "[warn] bash runtime: missing library: %s\n" "${_bash_runtime_lib}" >&2
  fi
done

unset _bash_runtime_lib
unset _bash_runtime_lib_path
unset _bash_runtime_libs
