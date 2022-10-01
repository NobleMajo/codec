#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

if [ -z "$1" ]; then
    echo "[CODEC_CLI][CLOSE]: No codec user defined!"
    exit 1
fi

echo "[CODEC_CLI][CLOSE]: Remove container for '$1'..."
docker rm -f "codec_$1" > /dev/null 2>&1
echo "[CODEC_CLI][CLOSE]: Container removed!"