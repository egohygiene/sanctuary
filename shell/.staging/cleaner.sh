#!/usr/bin/env bash

# Check for root privilages
if [[ $EUID -ne 0 ]]; then
    echo "run the ${!#} as root"
    exit 1
fi

function delete_dir_contents() {
  find "${1}" -xdev -depth -mindepth 1 -exec rm -Rf {} \;
}

# Clear thumbnail directory.
function clear_thumbnails() {
  rm --recursive --force "${HOME}/.cache/thumbnails/*"
}


# Clear bash history.
function clear_history() {
  history -c
}

# Clear clipboard.
function clear_clipboard() {
  xsel --clipboard --clear
}

# Empty trash.
function empty_trash() {
  rm --recursive --force "$HOME/.local/share/Trash/*"
}

# Disconnect from vpn.
function disconnect_vpn() {
  nordvpn disconnect
}

clear_thumbnails
#clear_history
#clear_clipboard
#empty_trash
#disconnect_vpn

