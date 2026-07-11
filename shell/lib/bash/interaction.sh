#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 📚 EgoHygiene Library — Bash Interaction Utilities
# ============================================
#
# Provides helpers for interactive prompts and user input.
#
# Guarantees:
# - Idempotent
# - No side effects
# - Bash-only (uses read -r with Bash read behavior)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_BASH_INTERACTION_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_BASH_INTERACTION_LOADED="true"

# --------------------------------------------
# 🔎 interaction::prompt_yes_no
#
# Prompt the user with a yes/no question.
# Accepts an optional default answer.
#
# @arg $1 string  Question to display.
# @arg $2 string  Default answer: "yes" or "no" (optional).
#
# @exitcode 0  If the user responds with yes.
# @exitcode 1  If the user responds with no.
# @exitcode 2  If arguments are missing.
#
# @example
#   if interaction::prompt_yes_no "Continue?" "yes"; then
#     echo "Proceeding"
#   fi
# --------------------------------------------
interaction::prompt_yes_no() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local question="${1}"
  local default_answer=""
  local response=""

  case "${2:-}" in
    [yY] | [yY][eE][sS]) default_answer="y" ;;
    [nN] | [nN][oO])     default_answer="n" ;;
  esac

  while :; do
    printf "%s (y/n)? " "${question}"
    [[ -n "${default_answer}" ]] && printf "[%s] " "${default_answer}"

    read -r response
    [[ -z "${response}" ]] && response="${default_answer}"

    case "${response}" in
      [yY] | [yY][eE][sS]) response="y" ; break ;;
      [nN] | [nN][oO])     response="n" ; break ;;
      *) response="" ;;
    esac
  done

  [[ "${response}" == "y" ]]
}

# --------------------------------------------
# 🔎 interaction::prompt_response
#
# Prompt the user for a free-form text response.
# Accepts an optional default value.
# Pass "-" as the default to allow an empty response.
#
# @arg $1 string  Question to display.
# @arg $2 string  Default answer (optional).
#
# @exitcode 0  If the user provides a response.
# @exitcode 2  If arguments are missing.
#
# @stdout The user's answer (or the default if no response given).
#
# @example
#   dir="$(interaction::prompt_response "Install directory" "/usr/local")"
# --------------------------------------------
interaction::prompt_response() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local question="${1}"
  local default_answer="${2:-}"
  local response=""

  while :; do
    printf "%s ? " "${question}"
    [[ -n "${default_answer}" && "${default_answer}" != "-" ]] && printf "[%s] " "${default_answer}"

    read -r response

    if [[ -n "${response}" ]]; then
      break
    elif [[ -z "${response}" && -n "${default_answer}" ]]; then
      response="${default_answer}"
      break
    fi
  done

  [[ "${response}" == "-" ]] && response=""

  printf "%s\n" "${response}"
}
