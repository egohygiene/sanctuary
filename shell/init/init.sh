#!/usr/bin/env bash
#
# ============================================
# 🔧 EgoHygiene Shell — Core Initialization
# ============================================

# --------------------------------------------
# 🛑 Prevent duplicate initialization
# --------------------------------------------
if [[ -n "${EGOHYGIENE_SHELL_INIT_LOADED}" ]]; then
  return 0
fi

export EGOHYGIENE_SHELL_INIT_LOADED="true"

# --------------------------------------------
# 📦 Load core systems
# --------------------------------------------

# shellcheck disable=SC1091
source "${EGOHYGIENE_SHELL_ROOT}/init/load-core.sh"
# shellcheck disable=SC1091
source "${EGOHYGIENE_SHELL_ROOT}/init/load-extensions.sh"
# shellcheck disable=SC1091
source "${EGOHYGIENE_SHELL_ROOT}/lib/modules.sh"

# --------------------------------------------
# 🚀 Bootstrap environment
# --------------------------------------------

# shellcheck disable=SC1091
source "${EGOHYGIENE_SHELL_ROOT}/init/bootstrap.sh"

# --------------------------------------------
# 🧪 Debug (optional)
# --------------------------------------------

if [[ "${EGOHYGIENE_SHELL_DEBUG:-0}" == "1" ]]; then
  debug_script="${EGOHYGIENE_SHELL_ROOT}/init/debug.sh"

  if [[ -f "${debug_script}" && -r "${debug_script}" ]]; then
    # shellcheck disable=SC1090
    source "${debug_script}"
  else
    printf "[warn] init.sh: debug requested but script missing: %s\n" "${debug_script}" >&2
  fi

  unset debug_script
fi

# --------------------------------------------
# 🧹 Cleanup
# --------------------------------------------

unset EGOHYGIENE_SHELL_INIT_LOADED
