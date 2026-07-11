#!/usr/bin/env bash
#
# ============================================
# 📦 EgoHygiene Shell — Runtime Loader
# ============================================
#
# Loads runtime layers in a strict, deterministic order:
# environment → os → shell → shared runtime → shell runtime
#
# Responsibilities:
# - Detect the execution environment category
# - Load runtime detection primitives
# - Source shared runtime libraries
# - Source shell-specific runtime libraries
#
# Notes:
# - Order matters — dependencies must be respected
# - Missing files are tolerated (non-fatal)
# - No module bootstrap logic should exist here
#

# --------------------------------------------
# 🛑 Safety Check
# --------------------------------------------
if [[ -z "${EGOHYGIENE_SHELL_ROOT:-}" ]]; then
  printf "[error] load-core.sh: EGOHYGIENE_SHELL_ROOT is not set\n" >&2
  return 1
fi

# --------------------------------------------
# 🌐 Environment Detection
# --------------------------------------------
if [[ -n "${GITHUB_ACTIONS:-}" ]]; then
  EGOHYGIENE_RUNTIME_ENVIRONMENT="ci"
elif [[ -n "${CODESPACES:-}" ]]; then
  EGOHYGIENE_RUNTIME_ENVIRONMENT="codespaces"
elif [[ -n "${DEVCONTAINER:-}" || -n "${REMOTE_CONTAINERS:-}" ]]; then
  EGOHYGIENE_RUNTIME_ENVIRONMENT="devcontainer"
elif [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
  EGOHYGIENE_RUNTIME_ENVIRONMENT="wsl"
else
  EGOHYGIENE_RUNTIME_ENVIRONMENT="local"
fi
export EGOHYGIENE_RUNTIME_ENVIRONMENT

# --------------------------------------------
# 🧠 Runtime Detection Primitives
# --------------------------------------------
detection_library_file_list=(
  "os.sh"
  "shell.sh"
)

# --------------------------------------------
# 🔄 Load Detection Libraries
# --------------------------------------------
for detection_library_file in "${detection_library_file_list[@]}"; do
  detection_library_path="${EGOHYGIENE_SHELL_ROOT}/lib/core/${detection_library_file}"

  if [[ -f "${detection_library_path}" && -r "${detection_library_path}" ]]; then
    # shellcheck disable=SC1090
    source "${detection_library_path}"
  else
    printf "[warn] load-core.sh: missing runtime detection library: %s\n" "${detection_library_file}" >&2
  fi
done

# --------------------------------------------
# 📚 Shared Runtime
# --------------------------------------------
shared_runtime_path="${EGOHYGIENE_SHELL_ROOT}/runtime/shared/runtime.sh"

if [[ -f "${shared_runtime_path}" && -r "${shared_runtime_path}" ]]; then
  # shellcheck disable=SC1090
  source "${shared_runtime_path}"
else
  printf "[warn] load-core.sh: missing shared runtime: %s\n" "${shared_runtime_path}" >&2
fi

# --------------------------------------------
# 🐚 Shell Runtime
# --------------------------------------------
if [[ -z "${EGOHYGIENE_SHELL_NAME:-}" ]]; then
  EGOHYGIENE_SHELL_NAME="unknown"
  export EGOHYGIENE_SHELL_NAME
fi

posix_shell_runtime_path="${EGOHYGIENE_SHELL_ROOT}/runtime/shells/posix/runtime.sh"
if [[ -f "${posix_shell_runtime_path}" && -r "${posix_shell_runtime_path}" ]]; then
  # shellcheck disable=SC1090
  source "${posix_shell_runtime_path}"
else
  printf "[warn] load-core.sh: missing shell runtime: %s\n" "${posix_shell_runtime_path}" >&2
fi

shell_runtime_path="${EGOHYGIENE_SHELL_ROOT}/runtime/shells/${EGOHYGIENE_SHELL_NAME}/runtime.sh"

if [[ -f "${shell_runtime_path}" && -r "${shell_runtime_path}" ]]; then
  # shellcheck disable=SC1090
  source "${shell_runtime_path}"
elif [[ "${EGOHYGIENE_SHELL_NAME}" != "unknown" ]]; then
  printf "[warn] load-core.sh: missing shell runtime: %s\n" "${shell_runtime_path}" >&2
fi

# --------------------------------------------
# 🧹 Cleanup
# --------------------------------------------
unset detection_library_file
unset detection_library_file_list
unset detection_library_path
unset shared_runtime_path
unset posix_shell_runtime_path
unset shell_runtime_path
