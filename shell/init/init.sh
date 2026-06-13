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

source "${EGOHYGIENE_SHELL_ROOT}/init/load-core.sh"
source "${EGOHYGIENE_SHELL_ROOT}/init/load-extensions.sh"
source "${EGOHYGIENE_SHELL_ROOT}/lib/modules.sh"

# --------------------------------------------
# 🚀 Bootstrap environment
# --------------------------------------------

source "${EGOHYGIENE_SHELL_ROOT}/init/bootstrap.sh"

# --------------------------------------------
# 🧪 Debug (optional)
# --------------------------------------------

if [[ "${EGOHYGIENE_SHELL_DEBUG:-0}" == "1" ]]; then
  source "${EGOHYGIENE_SHELL_ROOT}/init/debug.sh"
fi

# --------------------------------------------
# 🧹 Cleanup
# --------------------------------------------

unset EGOHYGIENE_SHELL_INIT_LOADED
