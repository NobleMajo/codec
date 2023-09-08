#!/bin/bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

echo "[CODEC_CLI][INSTALL]: Need super user rights to install codeccli..."
sudo echo "[CODEC_CLI][INSTALL]: Super user access granted!"

echo "test: $CODEC_BIN_INSTALL_PATH/codeccli"
echo "test2: $CODEC_CLI_PATH $CODEC_BIN_INSTALL_PATH/codeccli"

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
