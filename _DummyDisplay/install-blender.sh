#!/bin/bash
set -e

VERSION="5.2.2"
INSTALL_DIR="/opt"

# wget -O "/tmp/blender-${VERSION}.tar.xz" \
# "https://www.blender.org/download/release/Blender5.2/blender-${VERSION}-linux-x64.tar.xz"
# Direct download link from HTML file/donate message
#
wget -O "/tmp/blender-${VERSION}.tar.xz" \
 "https://mirror.blender.org/release/Blender5.2/blender-${VERSION}-linux-x64.tar.xz"

sudo tar -xJf "/tmp/blender-${VERSION}.tar.xz" -C "$INSTALL_DIR"

sudo ln -sf \
"$INSTALL_DIR/blender-${VERSION}-linux-x64/blender" \
/usr/local/bin/blender

blender --version