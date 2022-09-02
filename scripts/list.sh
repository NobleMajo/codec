#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

if [ -z "$CODEC_USER_DATA" ]; then
    CODEC_USER_DATA="/var/lib/codec"
fi

echo "User container:"

docker run -it --rm \
    -v "$CODEC_USER_DATA:/app" \
    -w /app \
    ubuntu:22.04 \
        ls -AQ