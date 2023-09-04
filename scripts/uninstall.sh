#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

source $CURRENT_DIR/vars.sh

echo "[CODEC_CLI][UNINSTALL]: Need super user rights to uninstall codeccli..."
sudo echo "[CODEC_CLI][UNINSTALL]: Super user access granted!"

if [ "$1" != "-f" ] && [ "$1" != "--force" ]; then
    echo "[CODEC_CLI][UNINSTALL]: Uninstall codeccli?"
    echo "If you want to uninstall codec enter 'y'."
    read INPUT_VALUE
    if [ "$INPUT_VALUE" != "y" ]; then
        echo "Abort uninstall!"
        exit 1
    fi
fi

echo "[CODEC_CLI][UNINSTALL]: Uninstall codeccli..."
sudo rm -rf $CODEC_INSTALL_PATH/codeccli

echo "[CODEC_CLI][UNINSTALL]: Done!"
