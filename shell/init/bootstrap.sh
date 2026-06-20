#!/usr/bin/env bash
#
# ============================================
# 🚀 EgoHygiene Shell — Bootstrap Sequence
# ============================================
#
# Defines the default module load order and environment behavior.
#
# Responsibilities:
# - Load core modules in deterministic order
# - Apply environment configuration
# - Remain simple, explicit, and debuggable
#
# Notes:
# - This is the "personality" layer of the shell
# - Order matters
# - No complex logic — just orchestration
#

# --------------------------------------------
# 🛑 Safety Check
# --------------------------------------------
if [[ -z "${EGOHYGIENE_SHELL_ROOT:-}" ]]; then
  printf "[error] bootstrap.sh: EGOHYGIENE_SHELL_ROOT is not set\n" >&2
  return 1
fi

# --------------------------------------------
# 🧭 Base Environment Modules
# --------------------------------------------
#
# These define fundamental system behavior.
#

egohygiene_load_module "xdg"
egohygiene_load_module "environment"

# --------------------------------------------
# 🧰 Tooling & UX Modules
# --------------------------------------------

egohygiene_load_module "tooling"
egohygiene_load_module "history"
egohygiene_load_module "privacy"
egohygiene_load_module "cache"

# --------------------------------------------
# 🖥️ Shell-Specific Module
# --------------------------------------------
#
# Load a shell-specific module only when one exists for
# the detected runtime.
#

if [[ -n "${EGOHYGIENE_SHELL_NAME:-}" ]]; then
  shell_module_path="${EGOHYGIENE_SHELL_ROOT}/modules/${EGOHYGIENE_SHELL_NAME}.sh"

  if [[ -f "${shell_module_path}" && -r "${shell_module_path}" ]]; then
    egohygiene_load_module "${EGOHYGIENE_SHELL_NAME}"
  fi

  unset shell_module_path
fi

# --------------------------------------------
# 🧪 Optional / Experimental Modules
# --------------------------------------------
#
# Toggle via environment variables
#

if [[ "${EGOHYGIENE_ENABLE_EXPERIMENTAL:-0}" == "1" ]]; then
  egohygiene_load_module "experimental"
fi

# --------------------------------------------
# 🧹 Cleanup
# --------------------------------------------

# Intentionally minimal — bootstrap defines state