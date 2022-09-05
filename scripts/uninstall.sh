#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

if [ -z "$CODEC_INSTALL_PATH" ]; then 
    CODEC_INSTALL_PATH="/usr/bin"
fi

echo "Need super user rights to uninstall codeccli..."
sudo echo "Super user access granted!"

if [ "$1" != "-f" ] && [ "$1" != "--force" ]; then
    echo "If you want to uninstall codec enter 'y'."
    read INPUT_VALUE
    if [ "$INPUT_VALUE" != "y" ]; then
        echo "Abort uninstall!"
        exit 1
    fi
fi

echo "Uninstall codeccli..."
sudo rm -rf $CODEC_INSTALL_PATH/codeccli

echo "Done!"