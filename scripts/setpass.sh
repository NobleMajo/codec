#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

if [ -z "$1" ]; then
    echo "[CODEC_CLI][SETPASS]: No codec user defined!"
    exit 1
fi

if [ -z "$2" ]; then
    echo "[CODEC_CLI][SETPASS]: No password!"
    exit 1
fi

echo "[CODEC_CLI][PASSETPASSS]: Hash password..."
HASH="$(echo -n "$2" | sha256sum | cut -d' ' -f1)"

echo "[CODEC_CLI][SETPASS]: Set password hash..."
$CURRENT_DIR/passhash.sh $1 "$HASH"

echo "[CODEC_CLI][SETPASS]: Password set!"