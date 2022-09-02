#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

if [ -z "$1" ]; then
    echo "No codec user defined!"
    exit 1
fi

if [ -z "$CODEC_USER_DATA" ]; then
    CODEC_USER_DATA="/var/lib/codec"
fi

CODEC_USERS="$(
docker run -it --rm \
    -v "$CODEC_USER_DATA:/app" \
    -w /app \
    ubuntu:22.04 \
        ls -AQ
)"

if [[ $CODEC_USERS != *"\"$1\""* ]]; then
    echo "false"
    exit 1
fi

echo "true"
exit 0