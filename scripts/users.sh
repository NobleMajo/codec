#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

if [ -z "$CODEC_USER_DATA" ]; then
    CODEC_USER_DATA="/var/lib/codec"
fi

echo "[CODEC_CLI][USERS]: Load codec container user list..."
USER_LIST=$(
    docker run -it --rm \
        -v "$CODEC_USER_DATA:/app" \
        -w /app \
        ubuntu:22.04 \
            ls -AQ
)

USER_LIST=${USER_LIST::-1}
USER_ARR=()
for USER_FOLDER in ${USER_LIST[@]}; do
    if [ $USER_FOLDER == '".codec"' ]; then
        continue
    fi
    USER_ARR+=($(echo -n "${USER_FOLDER:1:-1}"))
done

echo "[CODEC_CLI][USERS]: Existing user folder:"
for USER_NAME in ${USER_ARR[@]}; do
    echo " - '$USER_NAME'"
done