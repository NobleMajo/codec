#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))
CODEC_CLI_PATH=$(realpath "$CURRENT_DIR/../codeccli")

if [ -z "$CODEC_BIT_INSTALL_PATH" ]; then 
    CODEC_BIN_INSTALL_PATH="/usr/bin"
fi

echo "[CODEC_CLI][INSTALL]: Need super user rights to install codeccli..."
sudo echo "[CODEC_CLI][INSTALL]: Super user access granted!"

echo "[CODEC_CLI][INSTALL]: Install codeccli..."
sudo rm -rf $CODEC_BIN_INSTALL_PATH/codeccli
sudo ln -s $CODEC_CLI_PATH $CODEC_BIN_INSTALL_PATH/codeccli

if [ "$1" != "-i" ] && [ "$1" != "--image" ]; then
    echo "[CODEC_CLI][INSTALL]: Build codec image?"
    echo "If you also want to build and cache the newest codec image enter 'y'."
    read INPUT_VALUE
    if [ "$INPUT_VALUE" == "y" ]; then
        $CURRENT_DIR/build.sh -s
    fi
fi

echo "[CODEC_CLI][INSTALL]: Done!"
