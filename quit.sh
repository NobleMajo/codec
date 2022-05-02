#!/bin/bash

# check if the first start argument is set
if [ -z "$1" ]; then
    echo "The first argument must be the username!"
    exit 1
fi
USERNAME=$1

docker rm -fv "codec_$USERNAME"
