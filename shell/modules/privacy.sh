#!/usr/bin/env bash
#
# ============================================
# 🔒 EgoHygiene Module — Privacy & Telemetry
# ============================================
#
# Disables tracking, analytics, and telemetry
# across CLI tools and ecosystems.
#
# Guarantees:
# - Idempotent
# - Cross-platform safe
# - Optional toggle support
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_MODULE_PRIVACY_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_MODULE_PRIVACY_LOADED="true"

# --------------------------------------------
# 🛑 Feature Toggle
# --------------------------------------------
if [[ "${EGOHYGIENE_DISABLE_TELEMETRY:-1}" != "1" ]]; then
  return 0
fi

# --------------------------------------------
# 🌍 Global Standards
# --------------------------------------------

export DO_NOT_TRACK="1"
export NO_ANALYTICS="1"
export ANALYTICS="no"
export ADBLOCK="true"
export TELEMETRY_DISABLED="1"
export TELEMETRY_ENABLED="0"
export SQA_OPT_OUT="true"
export BUGGER_OFF="1"

# --------------------------------------------
# 🌐 Web / Node / Frontend
# --------------------------------------------

export GOTELEMETRY="off"
export YARN_ENABLE_TELEMETRY="false"
export NEXT_TELEMETRY_DISABLED="1"
export GATSBY_TELEMETRY_DISABLED="1"
export STORYBOOK_DISABLE_TELEMETRY="1"
export NUXT_TELEMETRY_DISABLED="1"
export VUEDX_TELEMETRY="off"
export STRAPI_TELEMETRY_DISABLED="true"
export STRAPI_DISABLE_UPDATE_NOTIFICATION="true"
export REACT_APP_WEBINY_TELEMETRY="false"
export NG_CLI_ANALYTICS="false"
export NG_CLI_ANALYTICS_SHARE="false"
export CARBON_TELEMETRY_DISABLED="1"
export HINT_TELEMETRY="off"
export DA_TEST_DISABLE_TELEMETRY="1"

# --------------------------------------------
# 🪟 .NET & Microsoft Ecosystem
# --------------------------------------------

export DOTNET_CLI_TELEMETRY_OPTOUT="1"
export DOTNET_EnableDiagnostics="0"
export DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT="1"
export MLDOTNET_CLI_TELEMETRY_OPTOUT="True"
export DOTNET_SVCUTIL_TELEMETRY_OPTOUT="1"
export MSSQL_CLI_TELEMETRY_OPTOUT="True"
export POWERSHELL_TELEMETRY_OPTOUT="1"
export POWERSHELL_UPDATECHECK="Off"
export PNPPOWERSHELL_DISABLETELEMETRY="true"
export PNPPOWERSHELL_UPDATECHECK="false"
export VSTEST_TELEMETRY_OPTEDIN="0"
export ORYX_DISABLE_TELEMETRY="true"
export BF_CLI_TELEMETRY="false"
export MOBILE_CENTER_TELEMETRY="off"
export APPCD_TELEMETRY="0"
export PROSE_TELEMETRY_OPTOUT="1"
export DisableTelemetry="True"
export RESTLER_TELEMETRY_OPTOUT="1"

# --------------------------------------------
# ☁️ Cloud / DevOps
# --------------------------------------------

export CLOUDSDK_CORE_DISABLE_USAGE_REPORTING="true"
export AZURE_CORE_COLLECT_TELEMETRY="0"
export SAM_CLI_TELEMETRY="0"
export WERF_TELEMETRY="0"
export PULUMI_SKIP_UPDATE_CHECK="true"
export SLS_TRACKING_DISABLED="1"
export SLS_TELEMETRY_DISABLED="1"
export VAGRANT_CHECKPOINT_DISABLE="1"
export VAGRANT_BOX_UPDATE_CHECK_DISABLE="1"
export ARM_DISABLE_TERRAFORM_PARTNER_ID="true"
export KICS_COLLECT_TELEMETRY="0"
export INFRACOST_SELF_HOSTED_TELEMETRY="false"
export INFRACOST_SKIP_UPDATE_CHECK="true"
export STRIPE_CLI_TELEMETRY_OPTOUT="1"
export SF_DISABLE_TELEMETRY="true"
export SFDX_DISABLE_TELEMETRY="true"
export EARTHLY_DISABLE_ANALYTICS="1"
export NUKE_TELEMETRY_OPTOUT="1"
export DECK_ANALYTICS="off"
export APOLLO_TELEMETRY_DISABLED="1"
export SALTO_TELEMETRY_DISABLE="1"
export TEEM_DISABLE="true"
export F5_ALLOW_TELEMETRY="false"
export CHEF_TELEMETRY_OPT_OUT="1"
export DASH_DISABLE_TELEMETRY="1"
export PANTS_ANONYMOUS_TELEMETRY_ENABLED="false"
export HOOKDECK_CLI_TELEMETRY_OPTOUT="1"
export BATECT_ENABLE_TELEMETRY="false"
export SKU_TELEMETRY="false"
export TUIST_STATS_OPT_OUT="1"
export AUTOMATEDLAB_TELEMETRY_OPTIN="0"
export AUTOMATEDLAB_TELEMETRY_OPTOUT="1"

# --------------------------------------------
# 📦 Package Managers
# --------------------------------------------

export HOMEBREW_NO_ANALYTICS="1"
export HOMEBREW_NO_ANALYTICS_THIS_RUN="1"
export HOMEBREW_NO_AUTO_UPDATE="1"
export COCOAPODS_DISABLE_STATS="true"
export ALIBUILD_NO_ANALYTICS="1"
export CHOOSENIM_NO_ANALYTICS="1"
export FASTLANE_OPT_OUT_USAGE="YES"

# --------------------------------------------
# 🗄️ Data / ML / DB
# --------------------------------------------

export INFLUXD_REPORTING_DISABLED="true"
export HASURA_GRAPHQL_ENABLE_TELEMETRY="false"
export MEILI_NO_ANALYTICS="true"
export FEAST_TELEMETRY="False"
export MELTANO_DISABLE_TRACKING="True"
export QUILT_DISABLE_USAGE_METRICS="True"
export DAGSTER_DISABLE_TELEMETRY="1"
export CUBEJS_TELEMETRY="false"
export RASA_TELEMETRY_ENABLED="false"
export ALLOW_UI_ANALYTICS="false"
export NC_DISABLE_TELE="1"
export ONE_CODEX_NO_TELEMETRY="True"
export ROCKSET_CLI_TELEMETRY_OPTOUT="1"
export DISABLE_QUICKWIT_TELEMETRY="1"

# --------------------------------------------
# 🧩 Miscellaneous
# --------------------------------------------

export STNOUPGRADE="1"
export PEX_VERBOSE="0"
export CALIBRE_SHOW_DEPRECATION_WARNINGS="0"
export MPV_VERBOSE="0"
export MPV_LEAK_REPORT="0"
export CANVAS_LMS_STATS_COLLECTION="opt_out"
export TELEMETRY_OPT_IN=""
export ET_NO_TELEMETRY="ANY_VALUE"
export MSLAB_TELEMETRY_LEVEL="None"
export ARDUINO_METRICS_ENABLED="false"
export LYNX_ANALYTICS="0"
export CHECKPOINT_DISABLE="1"
export SCOUT_DISABLE="1"
export DISABLE_CRASH_REPORT="1"
export DISABLE_AUTO_UPDATE="true"
export SUGGESTIONS_OPT_OUT="1"
export AUTOMAGICA_NO_TELEMETRY="1"
export MM_LOGSETTINGS_ENABLEDIAGNOSTICS="false"
export MM_SERVICESETTINGS_ENABLESECURITYFIXALERT="false"
export TYPO3_DISABLE_CORE_UPDATER="1"
export REDIRECT_TYPO3_DISABLE_CORE_UPDATER="1"
export REPORTPORTAL_CLIENT_JS_NO_ANALYTICS="true"

# --------------------------------------------
# 🧠 OS-Specific Rules
# --------------------------------------------

if os::is_linux; then
  export IG_PRO_OPT_OUT="YES"
fi
