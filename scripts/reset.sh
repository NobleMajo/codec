#!/bin/bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

if [ -z "$1" ]; then
    echo "[CODEC_CLI][RESET]: No codec user defined!"
    exit 1
fi

if [ "$2" != "-f" ] && [ "$2" != "--force" ]; then
    echo "[CODEC_CLI][RESET]: Reset codec user data of '$1'?"
    echo "Type 'y' to delete the codec user '$1'"
    echo "Userdata at:'$CODEC_USER_DATA/$1/.codec'"
    read INPUT_VALUE
    if [ "$INPUT_VALUE" != "y" ]; then
        echo "Abort because input was not 'y'!"
        exit 1
    fi
fi

$CURRENT_DIR/close.sh "$1"

echo "Delete '/codec/.codec' for '$1'..."
docker run -it --rm \
    -v "$CODEC_USER_DATA/$1:/app" \
    ubuntu:22.04 \
        bash -c 'mv "/app/.codec/vscode-server.yaml" "/vscode-server.yaml" \
        && rm -rf "/app/.codec/*" \
        && mv "/vscode-server.yaml" "/app/.codec/"'

