#!/bin/bash

if [ -z "$1" ]; then
    echo "No codec user defined!"
    exit 1
fi

echo "Attach to '$1':"

$CURRENT_DIR/attach.sh $1
docker exec -it "codec_$1" bash