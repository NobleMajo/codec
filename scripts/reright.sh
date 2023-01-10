#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

$CURRENT_DIR/build.sh > /dev/null 2>&1 &
BUILD_PID=$!

if [ -z "$CODEC_USER_DATA" ]; then
    CODEC_USER_DATA="/var/lib/codec"
fi

echo "[CODEC_CLI][RERIGHT]: Reset user rights on .codec folder..."
docker run -it --rm \
    --name "codeccli-reright" \
    -v "$CODEC_USER_DATA/.codec:/app" \
    ubuntu:22.04 \
        bash -c \
            "chown -R root /app"

docker run -it --rm \
            --name "codeccli-start-port-reader" \
            -v "$CODEC_USER_DATA/.codec:/app" \
            ubuntu:22.04 \
                bash
