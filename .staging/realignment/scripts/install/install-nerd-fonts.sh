#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

################################################################################
# 🧠 Configuration
################################################################################

NERD_FONTS_VERSION="v3.4.0"
NERD_FONTS_BASE_DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/download"

# Default curated list (safe, high-signal fonts)
NERD_FONTS_DEFAULT_FONT_LIST=(
  "JetBrainsMono"
  "FiraCode"
  "Hack"
  "Meslo"
)

################################################################################
# 🖥️ Platform Detection
################################################################################

OPERATING_SYSTEM="$(uname)"

if [[ "${OPERATING_SYSTEM}" == "Darwin" ]]; then
  FONT_INSTALL_DIRECTORY="${HOME}/Library/Fonts"
elif [[ "${OPERATING_SYSTEM}" == "Linux" ]]; then
  FONT_INSTALL_DIRECTORY="${HOME}/.local/share/fonts"
else
  echo "❌ Unsupported operating system: ${OPERATING_SYSTEM}"
  exit 1
fi

################################################################################
# 🎯 Argument Parsing
################################################################################

INSTALL_ALL_FONTS="false"

for ARGUMENT in "$@"; do
  case "${ARGUMENT}" in
    --install-all-fonts)
      INSTALL_ALL_FONTS="true"
      ;;
    *)
      echo "❌ Unknown argument: ${ARGUMENT}"
      exit 1
      ;;
  esac
done

################################################################################
# 📦 Utilities
################################################################################

function command_exists() {
  command -v "$1" >/dev/null 2>&1
}

function ensure_required_commands() {
  local required_commands=("curl" "unzip")

  for command_name in "${required_commands[@]}"; do
    if ! command_exists "${command_name}"; then
      echo "❌ Required command not found: ${command_name}"
      echo "👉 Please install it and re-run the script."
      exit 1
    fi
  done
}

function create_temp_directory() {
  mktemp -d
}

function remove_directory_safely() {
  local target_directory_path="$1"

  if [[ -d "${target_directory_path}" ]]; then
    rm -rf "${target_directory_path}"
  fi
}

################################################################################
# 🔍 Determine Font List
################################################################################

function fetch_all_font_names_from_github_release() {
  curl --silent \
    "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/tags/${NERD_FONTS_VERSION}" \
    | grep '"name":' \
    | grep '.zip' \
    | sed 's/.*"name": "\(.*\)\.zip".*/\1/'
}

if [[ "${INSTALL_ALL_FONTS}" == "true" ]]; then
  echo "🔄 Fetching full font list from Nerd Fonts release ${NERD_FONTS_VERSION}..."
  FONT_LIST="$(fetch_all_font_names_from_github_release)"
else
  echo "✨ Using curated font list..."
  FONT_LIST="${NERD_FONTS_DEFAULT_FONT_LIST[*]}"
fi

################################################################################
# 🔎 Idempotency Check
################################################################################

function font_already_installed() {
  local font_name="$1"

  find "${FONT_INSTALL_DIRECTORY}" -type f -iname "*${font_name}*" 2>/dev/null | grep -q .
}

################################################################################
# 📥 Download + Install
################################################################################

function install_font() {
  local font_name="$1"

  if font_already_installed "${font_name}"; then
    echo "⏭️  Skipping ${font_name} (already installed)"
    return
  fi

  echo "⬇️ Installing font: ${font_name}"

  local download_url="${NERD_FONTS_BASE_DOWNLOAD_URL}/${NERD_FONTS_VERSION}/${font_name}.zip"
  local temp_directory
  temp_directory="$(create_temp_directory)"

  curl \
    --location \
    --fail \
    --output "${temp_directory}/${font_name}.zip" \
    "${download_url}"

  unzip \
    -q \
    "${temp_directory}/${font_name}.zip" \
    -d "${temp_directory}"

  find "${temp_directory}" \
    -type f \
    -name "*.ttf" \
    -exec cp {} "${FONT_INSTALL_DIRECTORY}" \;

  remove_directory_safely "${temp_directory}"

  echo "✅ Installed ${font_name}"
}

################################################################################
# 🚀 Main Execution
################################################################################

ensure_required_commands

echo "📁 Font install directory: ${FONT_INSTALL_DIRECTORY}"
echo "📦 Nerd Fonts version: ${NERD_FONTS_VERSION}"
echo ""

for font_name in ${FONT_LIST}; do
  install_font "${font_name}"
done

################################################################################
# 🧹 Linux font cache refresh
################################################################################

if [[ "${OPERATING_SYSTEM}" == "Linux" ]]; then
  if command_exists "fc-cache"; then
    echo "🔄 Refreshing font cache..."
    fc-cache -f
  fi
fi

################################################################################
# 🎉 Done
################################################################################

echo ""
echo "🎉 Nerd Fonts installation complete!"
