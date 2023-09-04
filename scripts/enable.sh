#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

USER=$1

source $CURRENT_DIR/vars.sh

echo "[CODEC_CLI][ENABLE]: Enable user '$1'..."
docker rm -f codeccli-disable > /dev/null 2>&1
docker run -it --rm \
    --name "codeccli-disable" \
    -v "$CODEC_USER_DATA/:/app" \
    ubuntu:22.04 \
        bash -c \
        "mkdir -p /app/.codec/archive/$1 \
        && mkdir -p /app/$1 \
        && cp -r /app/.codec/archive/$1/* /app/$1/ \
        && rm -rf /app/.codec/archive/$1"

