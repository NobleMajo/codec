#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

USER=$1

if [ -z "$CODEC_USER_DATA" ]; then
    CODEC_USER_DATA="/var/lib/codec"
fi

echo "[CODEC_CLI][DISABLE]: Save startup arguments..."
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
