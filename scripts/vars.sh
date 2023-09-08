#!/bin/bash

if [ -z "$CODEC_USER_DATA" ]; then
    export CODEC_USER_DATA=""
fi

if [ -z "$CODEC_NET" ]; then
    export CODEC_NET="ff_codec_net"
fi

if [ -z "$CODEC_BIN_INSTALL_PATH" ]; then
    export CODEC_BIN_INSTALL_PATH="/usr/bin"
fi

export CURRENT_DIR=$(dirname $(realpath $0))

