#!/bin/bash

if [ -z "$1" ]; then
    echo "[CODEC_CLI][ATTACH]: No codec user defined!"
    exit 1
fi

echo "[CODEC_CLI][ATTACH]: Attach to '$1':"
docker exec -it "codec_$1" bash