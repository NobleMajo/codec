#!/usr/bin/env bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

if [ -z "$1" ]; then
    echo "[CODEC_CLI][DOCKERD_PROCESS]: No codec user defined!"
    exit 1
fi

echo "[CODEC_CLI][DOCKERD_PROCESS]: Start docker daemon..."

CODEC_USER=$1
CODEC_DOCKERD_DIR="$CODEC_USER_DATA/.codec/dockerd/"
CODEC_DOCKERD_CONFIG_PATH="$CODEC_DOCKERD_DIR/$CODEC_USER_dockerd_config.json"

dockerd \
    --config-file "$CODEC_DOCKERD_CONFIG_PATH" > \
    "$CODEC_DOCKERD_DIR/$CODEC_USER_dockerd.logs" \
    2>&1 &
    
CODEC_DOCKERD_PID=$!

while docker ps -q --filter name=codec_$CODEC_USER &> /dev/null; do
    sleep 30
done

$CURRENT_DIR/dockerd-stop.sh $CODEC_USER
kill -s SIGKILL $CODEC_DOCKERD_PID

echo "[CODEC_CLI][DOCKERD_PROCESS]: dockerd exit!"
