#!/usr/bin/env bash
# shellcheck shell=bash
#
# ============================================
# 📚 EgoHygiene Library — Bash File Utilities
# ============================================
#
# Provides helpers for file and directory operations.
#
# Note: For basic file/directory existence checks, see: lib/core/guards.sh
# Note: For directory creation and ownership, see: lib/core/core.sh
#
# Guarantees:
# - Idempotent
# - No side effects (functions do not modify state unless explicitly called)
# - Bash-only (not POSIX-portable)
#

# --------------------------------------------
# 🛑 Idempotency Guard
# --------------------------------------------
if [[ -n "${EGOHYGIENE_LIB_BASH_FILE_LOADED:-}" ]]; then
  return 0
fi

export EGOHYGIENE_LIB_BASH_FILE_LOADED="true"

# --------------------------------------------
# 🔎 file::make_temp_file
#
# Create a temporary file with a random name.
# The file is automatically deleted when the script exits.
#
# @exitcode 0  If successful.
# @exitcode 1  If the file cannot be created.
#
# @stdout Path to the created temporary file.
# --------------------------------------------
file::make_temp_file() {
  local temp_file

  if type -p mktemp &>/dev/null; then
    temp_file="$(mktemp -u)"
  else
    temp_file="${PWD}/$((RANDOM * 2)).tmp"
  fi

  # shellcheck disable=SC2064
  trap "rm -f '${temp_file}'" EXIT
  printf "%s\n" "${temp_file}"
}

# --------------------------------------------
# 🔎 file::make_temp_dir
#
# Create a temporary directory with a random name.
#
# @arg $1 string  Directory name prefix.
# @arg $2 string  Set to any value to auto-remove on exit (optional).
#
# @exitcode 0  If successful.
# @exitcode 1  If the directory cannot be created.
# @exitcode 2  If arguments are missing.
#
# @stdout Path to the created temporary directory.
# --------------------------------------------
file::make_temp_dir() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local prefix="${1}"
  local auto_remove="${2:-}"
  local temp_dir

  temp_dir="$(mktemp -d 2>/dev/null || mktemp -d -t "${prefix}")"

  if [[ -n "${auto_remove}" ]]; then
    # shellcheck disable=SC2064
    trap "rm -rf '${temp_dir}'" EXIT
  fi

  printf "%s\n" "${temp_dir}"
}

# --------------------------------------------
# 🔎 file::name
#
# Extract the filename (with extension) from a path.
#
# @arg $1 string  File path.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Filename with extension.
#
# @example
#   file::name "/path/to/test.md"  # outputs test.md
# --------------------------------------------
file::name() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2
  printf "%s\n" "${1##*/}"
}

# --------------------------------------------
# 🔎 file::basename
#
# Extract the base name (without extension) from a path.
#
# @arg $1 string  File path.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Base name without extension.
#
# @example
#   file::basename "/path/to/test.md"  # outputs test
# --------------------------------------------
file::basename() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local filename="${1##*/}"
  printf "%s\n" "${filename%.*}"
}

# --------------------------------------------
# 🔎 file::extension
#
# Extract the file extension from a path.
#
# @arg $1 string  File path.
#
# @exitcode 0  If successful.
# @exitcode 1  If no extension is found.
# @exitcode 2  If arguments are missing.
#
# @stdout File extension (without the leading dot).
#
# @example
#   file::extension "/path/to/test.md"  # outputs md
# --------------------------------------------
file::extension() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local filename="${1##*/}"
  local ext="${filename##*.}"

  [[ "${filename}" == "${ext}" ]] && return 1

  printf "%s\n" "${ext}"
}

# --------------------------------------------
# 🔎 file::dirname
#
# Extract the directory portion from a file path.
#
# @arg $1 string  File path.
#
# @exitcode 0  If successful.
# @exitcode 2  If arguments are missing.
#
# @stdout Directory path.
#
# @example
#   file::dirname "/path/to/test.md"  # outputs /path/to
# --------------------------------------------
file::dirname() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local tmp="${1:-.}"

  [[ "${tmp}" != *[!/]* ]] && printf '/\n' && return

  tmp="${tmp%%"${tmp##*[!/]}"}"

  [[ "${tmp}" != */* ]] && printf '.\n' && return

  tmp="${tmp%/*}"
  tmp="${tmp%%"${tmp##*[!/]}"}"

  printf '%s\n' "${tmp:-/}"
}

# --------------------------------------------
# 🔎 file::full_path
#
# Resolve the absolute path of a file or directory.
#
# @arg $1 string  Relative or absolute path.
#
# @exitcode 0  If successful.
# @exitcode 1  If the path does not exist.
# @exitcode 2  If arguments are missing.
#
# @stdout Absolute path.
# --------------------------------------------
file::full_path() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local input="${1}"

  if [[ -f "${input}" ]]; then
    printf "%s/%s\n" "$(cd "$(file::dirname "${input}")" && pwd)" "${input##*/}"
  elif [[ -d "${input}" ]]; then
    printf "%s\n" "$(cd "${input}" && pwd)"
  else
    return 1
  fi
}

# --------------------------------------------
# 🔎 file::mime_type
#
# Get the MIME type of a file or directory.
# Requires `mimetype` or `file` to be available.
#
# @arg $1 string  Path to file or directory.
#
# @exitcode 0  If successful.
# @exitcode 1  If the path does not exist.
# @exitcode 2  If arguments are missing.
# @exitcode 3  If neither `mimetype` nor `file` is available.
#
# @stdout MIME type string.
#
# @example
#   file::mime_type "script.sh"  # outputs application/x-shellscript
# --------------------------------------------
file::mime_type() {
  [[ $# -eq 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  if [[ ! -f "${1}" && ! -d "${1}" ]]; then
    return 1
  fi

  if type -p mimetype &>/dev/null; then
    mimetype --output-format %m "${1}"
  elif type -p file &>/dev/null; then
    file --brief --mime-type "${1}"
  else
    return 3
  fi
}

# --------------------------------------------
# 🔎 file::contains_text
#
# Check if a file contains a given pattern.
#
# @arg $1 string  Path to the file.
# @arg $2 string  Search pattern (or regular expression for grep).
#
# @exitcode 0  If the pattern is found.
# @exitcode 1  If the pattern is not found.
# @exitcode 2  If arguments are missing.
# --------------------------------------------
file::contains_text() {
  [[ $# -lt 2 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

  local file="${1}"
  local pattern="${2}"

  grep -q "${pattern}" "${file}"
}

# --------------------------------------------
# 🔎 file::owner
#
# Get the owner username of a file or directory.
#
# @arg $1 string  Path to the file or directory.
#
# @exitcode 0  If successful.
# @exitcode 1  If the path does not exist.
#
# @stdout Owner username.
# --------------------------------------------
file::owner() {
  local path="${1}"

  if [[ ! -e "${path}" ]]; then
    return 1
  fi

  stat -c '%U' "${path}" 2>/dev/null || stat -f '%Su' "${path}" 2>/dev/null
}

# --------------------------------------------
# 🔎 file::is_empty_dir
#
# Return true if a directory exists and is empty.
#
# @arg $1 string  Path to the directory.
#
# @exitcode 0  If the directory is empty or does not exist.
# @exitcode 1  If the directory is not empty.
# --------------------------------------------
file::is_empty_dir() {
  local dir="${1:?Missing directory argument}"

  if [[ ! -e "${dir}" || -z "$(ls -A "${dir}")" ]]; then
    return 0
  fi

  return 1
}
