#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Update the package list
sudo apt update

# Install build tools
sudo apt install -y build-essential autoconf git libtool pkg-config

# Install ImageMagick dependencies for maximum format support
sudo apt install -y libjpeg-dev libpng-dev libtiff-dev libgif-dev libwebp-dev \
                     libopenjp2-7-dev libraw-dev libheif-dev libavif-dev \
                     libfreetype-dev libfontconfig1-dev libxml2-dev libx11-dev \
                     libxext-dev libxft-dev libbz2-dev liblzma-dev libzip-dev \
                     libopenexr-dev liblqr-1-0-dev libgs-dev libminidjvu-dev \
                     libwmf-dev libopenexr-dev librsvg2-dev libcairo2-dev \
                     libpango1.0-dev libperl-dev libwmf-dev libuemf-dev libwmf-bin \
                     libfftw3-dev liblcms2-dev libmagickcore-dev libmagickwand-dev

# Optional: Ghostscript for PDF support
sudo apt install -y ghostscript

# Clone the ImageMagick repository
git clone https://github.com/ImageMagick/ImageMagick.git
cd ImageMagick

# Configure the build with all features enabled
./configure --with-modules --enable-shared --with-perl --with-gslib \
            --with-wmf --with-rsvg --with-webp --with-openexr --with-heic --with-raw \
            --with-fftw --with-fontconfig --with-freetype --with-lqr --with-lcms \
            --with-x --enable-hdri

# Build and install ImageMagick
cores=$(nproc)
make "-j${cores}" # Compile using all available cores
sudo make install

# Configure dynamic linker run-time bindings
sudo ldconfig

echo "ImageMagick installation completed successfully."
