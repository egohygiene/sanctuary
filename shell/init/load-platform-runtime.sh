#!/usr/bin/env bash
#
# ============================================
# 🖥️ EgoHygiene Runtime — Platform Layer Loader
# ============================================
#
# Loads optional operating-system runtime modules after shell runtime.
# This loader intentionally does not implement platform behavior yet.
#

if [[ -n "${EGOHYGIENE_PLATFORM_RUNTIME_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_PLATFORM_RUNTIME_LOADED="true"

if [[ -z "${EGOHYGIENE_SHELL_ROOT:-}" ]]; then
  printf "[error] load-platform-runtime.sh: EGOHYGIENE_SHELL_ROOT is not set\n" >&2
  return 1
fi

platform_runtime_family="${OS_FAMILY:-}"
if [[ -z "${platform_runtime_family}" ]] && declare -F os::detect >/dev/null; then
  platform_runtime_family="$(os::detect)"
fi
platform_runtime_family="${platform_runtime_family:-unknown}"

platforms_root="${EGOHYGIENE_SHELL_ROOT}/platforms"
platform_runtime_path="${platforms_root}/${platform_runtime_family}/runtime.sh"

if [[ -f "${platform_runtime_path}" && -r "${platform_runtime_path}" ]]; then
  # shellcheck disable=SC1090
  source "${platform_runtime_path}"
else
  export EGOHYGIENE_PLATFORM_RUNTIME="none"
fi

unset platform_runtime_path
unset platform_runtime_family
unset platforms_root
