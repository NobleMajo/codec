#!/usr/bin/env bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

$CURRENT_DIR/build.sh > /dev/null 2>&1 &
BUILD_PID=$!

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
