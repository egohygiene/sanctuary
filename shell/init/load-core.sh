#!/usr/bin/env bash
#
# ============================================
# 📦 EgoHygiene Shell — Core Library Loader
# ============================================
#
# Loads foundational shell libraries in a strict,
# deterministic order.
#
# Responsibilities:
# - Load core libraries required by the system
# - Ensure predictable initialization order
# - Avoid side effects beyond sourcing files
#
# Notes:
# - Order matters — dependencies must be respected
# - Missing files are tolerated (non-fatal)
# - No module logic should exist here
#

# --------------------------------------------
# 🛑 Safety Check
# --------------------------------------------
if [[ -z "${EGOHYGIENE_SHELL_ROOT:-}" ]]; then
  printf "[error] load-core.sh: EGOHYGIENE_SHELL_ROOT is not set\n" >&2
  return 1
fi

# --------------------------------------------
# 📚 Core Library Load Order
# --------------------------------------------
#
# Order is intentional:
# 1. os       → environment detection
# 2. bash     → bash runtime introspection
# 3. colors   → terminal formatting
# 4. logging  → structured output
# 5. guards   → safety + assertions
# 6. core     → shared helpers
# 7. time     → time helpers
#

core_library_file_list=(
  "os.sh"
  "bash.sh"
  "colors.sh"
  "logging.sh"
  "guards.sh"
  "core.sh"
  "time.sh"
)

# --------------------------------------------
# 🔄 Load Libraries
# --------------------------------------------
for core_library_file in "${core_library_file_list[@]}"; do
  core_library_path="${EGOHYGIENE_SHELL_ROOT}/lib/core/${core_library_file}"

  if [[ -f "${core_library_path}" && -r "${core_library_path}" ]]; then
    # shellcheck disable=SC1090
    source "${core_library_path}"
  else
    printf "[warn] load-core.sh: missing core library: %s\n" "${core_library_file}" >&2
  fi
done

# --------------------------------------------
# 🧹 Cleanup
# --------------------------------------------
unset core_library_file
unset core_library_path
unset core_library_file_list
