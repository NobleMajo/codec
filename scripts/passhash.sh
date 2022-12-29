#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

if [ -z "$1" ]; then
    echo "[CODEC_CLI][PASSHASH]: No codec user defined!"
    exit 1
fi

if [ -z "$2" ]; then
    echo "[CODEC_CLI][PASSHASH]: No password hash defined!"
    exit 1
fi

echo "[CODEC_CLI][PASSHASH]: Short hash..."
HASH="$2"
HASH=${HASH:0:64}

echo "[CODEC_CLI][PASSHASH]: Save startup arguments..."
docker rm -f codeccli-hash-helper > /dev/null 2>&1
docker run -it --rm \
    --name "codeccli-hash-helper" \
    -v "$CODEC_USER_DATA/.codec:/app" \
    ubuntu:22.04 \
        bash -c \
        "mkdir -p /app/ports \
        && echo -n '$HASH' > /app/ports/$1.hash"

echo "[CODEC_CLI][PASSHASH]: Set password hash..."
docker exec -it "codec_$1" codec -rh "$HASH"

echo "[CODEC_CLI][PASSHASH]: Password hash set!"
