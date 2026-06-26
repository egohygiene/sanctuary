#!/usr/bin/env sh

# Original author: Michalis Georgiou <mechmg93@gmail.comr>
# Modified by Andrew http://www.webupd8.org <andrew@webupd8.org>
# Current version by Kassius Iacchus https://github.com/iacchus/

# Depends on: `wget`
#
# Install `wget` on Debian/Ubuntu with:
# apt install wget

# Usage:
#
# 0. Copy the contents of this script to a text file named,
#    for example, "install_fonts.sh".
#
# 1. Make this file executable with the command:
#    chmod +x install_fonts.sh
#
# 2. Run it with:
#    ./install_fonts.sh

_wgeturl="https://github.com/google/fonts/archive/main.tar.gz"
_gf="google-fonts"

echo "Connecting to Github server to download fonts..."
wget $_wgeturl -O $_gf.tar.gz

echo "Extracting the downloaded archive..."
tar -zxvf $_gf.tar.gz

echo "Creating the /usr/share/fonts/truetype/$_gf folder"
sudo mkdir -p /usr/share/fonts/truetype/$_gf

echo "Installing all .ttf fonts in /usr/share/fonts/truetype/$_gf"
find $PWD/fonts-main/ -name "*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || echo "An error occured, please run this script again."

echo "Updating the font cache"
fc-cache -f

echo "Done. Now you can delete the tarball file $_gf.tar.gz if you wish."
