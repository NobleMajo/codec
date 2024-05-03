#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "[CODEC_CLI][RANDOMPASSWORD]: No codec user defined!"
    exit 1
fi

HASH_VALUE="$(date +'%N%S')$1$(date)$1$(date +'%S%N')"

HASH="$(echo -n "$HASH_VALUE" | sha256sum | cut -d' ' -f1)"

HASH="${HASH:16:1}${HASH:8:4}${HASH:32:2}${HASH:2:1}${HASH:24:2}"
HASH+="${HASH:9:2}${HASH:22:2}${HASH:23:1}${HASH:15:1}${HASH:3:1}"

HASH="$(echo -n "$(date +'%N%S')$HASH$(date +'%S%N')" | sha256sum | cut -d' ' -f1)"

echo -n "${HASH:16:5}_$1_${HASH:4:5}_CODEC_${HASH:24:5}"
