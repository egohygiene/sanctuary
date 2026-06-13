#!/usr/bin/env bash
#
# ============================================
# 🔌 EgoHygiene — Extension Loader
# ============================================
#
# Loads optional libraries from lib/extensions/
#
# Behavior:
# - explicit opt-in
# - safe to call multiple times
#

if [[ -n "${EGOHYGIENE_EXTENSIONS_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_EXTENSIONS_LOADED="true"

if [[ -z "${EGOHYGIENE_SHELL_ROOT:-}" ]]; then
  printf "[error] load-extensions.sh: EGOHYGIENE_SHELL_ROOT is not set\n" >&2
  return 1
fi

egohygiene_load_extension() {
  local extension_name="$1"

  [[ -n "${extension_name}" ]] || return 1

  local extension_path="${EGOHYGIENE_SHELL_ROOT}/lib/extensions/${extension_name}.sh"

  if [[ -f "${extension_path}" ]]; then
    # shellcheck disable=SC1090
    source "${extension_path}"
  else
    printf "[warn] extension not found: %s\n" "${extension_name}" >&2
    return 1
  fi
}
