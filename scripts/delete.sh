#!/bin/bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

if [ -z "$1" ]; then
    echo "[CODEC_CLI][DELETE]: No codec user defined!"
    exit 1
fi

if [ "$2" != "-f" ] && [ "$2" != "--force" ]; then
    echo "[CODEC_CLI][DELETE]: Delete the codec user '$1'?"
    echo "Type 'y' to delete the codec user '$1'"
    echo "Userdata at:'$CODEC_USER_DATA/$1/.codec'"
    read INPUT_VALUE
    if [ "$INPUT_VALUE" != "y" ]; then
        echo "Abort because input was not 'y'!"
        exit 1
    fi
fi

$CURRENT_DIR/close.sh "$1"

echo "[CODEC_CLI][DELETE]: Delete '$1'..."
docker run -it --rm \
    -v "$CODEC_USER_DATA:/app" \
    ubuntu:22.04 \
        rm -rf "/app/$1"


echo "[CODEC_CLI][DELETE]: Delete ports cache for '$1'..."
docker run -it --rm \
    --name "codeccli-$1-port-helper" \
    -v "$CODEC_USER_DATA/.codec:/app" \
    ubuntu:22.04 \
        bash -c \
        "rm -rf /app/ports/$1.start.port \
        && rm -rf /app/ports/$1.count.port \
        && rm -rf /app/args/$1.extra.args \
        && rm -rf /app/hash/$1.hash"

echo "[CODEC_CLI][DELETE]: User '$1' deleted!"
