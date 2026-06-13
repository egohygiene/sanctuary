#!/usr/bin/env bash
#
# ============================================
# 📦 EgoHygiene Shell — Module System
# ============================================
#
# Provides a deterministic, idempotent module loader.
#
# Responsibilities:
# - Load modules from modules/ directory
# - Ensure modules are only loaded once per session
# - Provide safe error handling
# - Track module state
#
# Design:
# - Modules are simple shell files
# - No implicit auto-loading
# - Explicit > implicit
#

# --------------------------------------------
# 🛑 Safety Check
# --------------------------------------------
if [[ -z "${EGOHYGIENE_SHELL_ROOT:-}" ]]; then
  printf "[error] modules.sh: EGOHYGIENE_SHELL_ROOT is not set\n" >&2
  return 1
fi

# --------------------------------------------
# 📊 Internal State
# --------------------------------------------
#
# Space-separated list of loaded modules
#
: "${EGOHYGIENE_SHELL_LOADED_MODULES:=}"

# --------------------------------------------
# 📦 Load Module
# --------------------------------------------
#
# Usage:
#   egohygiene_load_module "xdg"
#
# Behavior:
# - Loads module from modules/<name>.sh
# - Idempotent (loads once per session)
# - Safe (warns if missing, does not crash)
#
egohygiene_load_module() {
  local module_name="$1"
  local module_path="${EGOHYGIENE_SHELL_ROOT}/modules/${module_name}.sh"

  # ------------------------------------------
  # 🛑 Validate Input
  # ------------------------------------------
  if [[ -z "${module_name}" ]]; then
    printf "[error] egohygiene_load_module: missing module name\n" >&2
    return 1
  fi

  # ------------------------------------------
  # 🔁 Idempotency Check
  # ------------------------------------------
  case " ${EGOHYGIENE_SHELL_LOADED_MODULES} " in
    *" ${module_name} "*)
      return 0
      ;;
  esac

  # ------------------------------------------
  # 📂 Load Module
  # ------------------------------------------
  if [[ -f "${module_path}" && -r "${module_path}" ]]; then
    # Mark as loaded BEFORE sourcing (prevents recursion issues)
    EGOHYGIENE_SHELL_LOADED_MODULES="${EGOHYGIENE_SHELL_LOADED_MODULES:+${EGOHYGIENE_SHELL_LOADED_MODULES} }${module_name}"
    export EGOHYGIENE_SHELL_LOADED_MODULES

    # shellcheck disable=SC1090
    source "${module_path}"
  else
    printf "[warn] egohygiene_load_module: module not found: %s\n" "${module_name}" >&2
    return 1
  fi
}

# --------------------------------------------
# 📋 List Loaded Modules
# --------------------------------------------
egohygiene_list_loaded_modules() {
  printf "%s\n" "${EGOHYGIENE_SHELL_LOADED_MODULES}"
}

# --------------------------------------------
# 🔍 Check If Module Is Loaded
# --------------------------------------------
egohygiene_is_module_loaded() {
  local module_name="$1"

  case " ${EGOHYGIENE_SHELL_LOADED_MODULES} " in
    *" ${module_name} "*) return 0 ;;
    *) return 1 ;;
  esac
}

# --------------------------------------------
# 🧹 Cleanup (none — intentional)
# --------------------------------------------
#
# We DO NOT unset anything here because:
# - functions are part of the public API
# - module state must persist
#
