#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

if [ -z "$1" ]; then
    echo "No codec user defined!"
    exit 1
fi

echo "Logs of '$1':"
docker logs "codec_$1"
docker exec -it "codec_$1" codec -l