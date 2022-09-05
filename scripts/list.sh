#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

if [ -z "$CODEC_USER_DATA" ]; then
    CODEC_USER_DATA="/var/lib/codec"
fi

echo "Load codec container user list..."
USER_LIST=$(
    docker run -it --rm \
        -v "$CODEC_USER_DATA:/app" \
        -w /app \
        ubuntu:22.04 \
            ls -AQ
)

echo "User container:"
echo "$USER_LIST"
