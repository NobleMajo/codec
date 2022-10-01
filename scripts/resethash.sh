#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

if [ -z "$1" ]; then
    echo "[CODEC_CLI][RESETHASH]: No codec user defined!"
    exit 1
fi

echo "[CODEC_CLI][RESETHASH]: Short hash..."
HASH="$2"
HASH=${HASH:0:64}

echo "[CODEC_CLI][RESETHASH]: Default password hash..."
docker rm -f codeccli-reset-hash-helper > /dev/null 2>&1
DEFAULT_PASS="$(
    docker run -it --rm \
        --name "codeccli-reset-hash-helper" \
        -v "$CODEC_USER_DATA/.codec:/app" \
        ubuntu:22.04 \
            bash -c \
            "cat /app/hash/$1.hash"
)"

echo "Reset password hash to: '$DEFAULT_PASS'"

$CURRENT_DIR/passhash.sh $1 "$DEFAULT_PASS"

echo "[CODEC_CLI][RESETHASH]: Default password hash set!"