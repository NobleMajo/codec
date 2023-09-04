#!/bin/bash

if [ -z "$CODEC_USER_DATA" ]; then
    export CODEC_USER_DATA="/mnt/sdb/codec-data"
fi

if [ -z "$CODEC_NET" ]; then
    export CODEC_NET="ff_codec_net"
fi

if [ -z "$CODEC_INSTALL_PATH" ]; then 
    export CODEC_INSTALL_PATH="/usr/bin"
fi
