#!/usr/bin/env bash
# shellcheck shell=bash
#
# Optional suppression of automatic update checks and notifications.
#
# This is intentionally separate from telemetry. Update checks can deliver
# security information, so this module is never enabled by default.

if [[ -n "${EGOHYGIENE_MODULE_UPDATE_CHECKS_LOADED:-}" ]]; then
  return 0
fi
export EGOHYGIENE_MODULE_UPDATE_CHECKS_LOADED="true"

export STRAPI_DISABLE_UPDATE_NOTIFICATION="true"
export POWERSHELL_UPDATECHECK="Off"
export PNPPOWERSHELL_UPDATECHECK="false"
export PULUMI_SKIP_UPDATE_CHECK="true"
export VAGRANT_BOX_UPDATE_CHECK_DISABLE="1"
export INFRACOST_SKIP_UPDATE_CHECK="true"
export HOMEBREW_NO_AUTO_UPDATE="1"
export STNOUPGRADE="1"
export DISABLE_AUTO_UPDATE="true"
export MM_SERVICESETTINGS_ENABLESECURITYFIXALERT="false"
export TYPO3_DISABLE_CORE_UPDATER="1"
export REDIRECT_TYPO3_DISABLE_CORE_UPDATER="1"
