#!/usr/bin/env bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

$CURRENT_DIR/close.sh $1

echo "[CODEC_CLI][DISABLE]: Disable user '$1'..."
docker rm -f codeccli-disable > /dev/null 2>&1
docker run -it --rm \
    --name "codeccli-disable" \
    -v "$CODEC_USER_DATA/:/app" \
    ubuntu:22.04 \
        bash -c \
        "mkdir -p /app/.codec/archive/$1 \
        && mkdir -p /app/$1 \
        && cp -r /app/$1/* /app/.codec/archive/$1/ \
        && rm -rf /app/$1"
