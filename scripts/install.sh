#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))
CODEC_CLI_PATH=$(realpath "$CURRENT_DIR/../codeccli")

if [ -z "$CODEC_INSTALL_PATH" ]; then 
    CODEC_INSTALL_PATH="/usr/bin"
fi

echo "Need super user rights to install codeccli..."
sudo echo "Super user access granted!"

echo "Install codeccli..."
sudo rm -rf $CODEC_INSTALL_PATH/codeccli
sudo ln -s $CODEC_CLI_PATH $CODEC_INSTALL_PATH/codeccli

if [ "$1" != "-f" ] && [ "$1" != "--force" ]; then
    echo "If you also want to build and cache the newest codec image enter 'y'."
    read INPUT_VALUE
    if [ "$INPUT_VALUE" == "y" ]; then
        $CODEC_CLI_PATH build
    fi
fi

echo "Done!"