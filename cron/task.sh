#!/usr/bin/env bash

CURRENT_DIR=$(dirname $(realpath $0))

UPDATE_START="$(date +'%Y_%m_%d_%H_%M')"

if [ -z "$CODEC_USER_DATA" ]; then
    CODEC_USER_DATA="/var/lib/codec"
fi

sudo rm -rf $CODEC_USER_DATA/.codec/$UPDATE_START.log
($CURRENT_DIR/update.sh $1 $UPDATE_START) >> $CODEC_USER_DATA/.codec/$UPDATE_START.log
