#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

CODEC_USERS="$(
docker run -it --rm \
    -v "$CODEC_USER_DATA:/app" \
    -w /app \
    ubuntu:22.04 \
        ls -AQ
)"

echo "$CODEC_USERS"

#if echo "adla skdöal dk södl kadsö lkc" | grep -q "test" ; then echo "ok"; fi