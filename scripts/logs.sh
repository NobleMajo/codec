#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

if [ -z "$1" ]; then
    echo "[CODEC_CLI][LOGS]: No codec user defined!"
    exit 1
fi

echo "[CODEC_CLI][LOGS]: Sysdemd logs of '$1':"
docker logs "codec_$1"
echo "[CODEC_CLI][LOGS]: Codec boot logs of '$1':"
docker exec -it "codec_$1" codec -l