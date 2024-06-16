#!/usr/bin/env bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

if [ -z "$1" ]; then
    echo "[CODEC_CLI][DOCKERD_STOP]: No codec user defined!"
    exit 1
fi

CODEC_USER=$1
CODEC_DOCKERD_DIR="$CODEC_USER_DATA/.codec/dockerd/"
CODEC_DOCKERD_CONFIG_PATH="$CODEC_DOCKERD_DIR/$CODEC_USER_dockerd_config.json"
CODEC_DOCKERD_PID_PATH="$CODEC_DOCKERD_DIR/$CODEC_USER_dockerd.pid"

if [ ! -f "$CODEC_DOCKERD_PID_PATH" ]; then
    echo "[CODEC_CLI][DOCKERD_STOP]: No $CODEC_USER dockerd started for $CODEC_USER!"
    exit 0
fi

CODEC_DOCKERD_PID=$(<"$CODEC_DOCKERD_PID_PATH")

echo "[CODEC_CLI][DOCKERD_STOP]: Exit $CODEC_USER dockerd graceful..."
kill -s SIGTERM $CODEC_DOCKERD_PID

GRACEFUL_COUNTER=0

while ps -p $CODEC_DOCKERD_PID > /dev/null; do
    if [ $GRACEFUL_COUNTER -ge 10 ]; then
        echo "[CODEC_CLI][DOCKERD_STOP]: No graceful exit!"
        kill -s SIGKILL $CODEC_DOCKERD_PID
        break
    fi
    sleep 2
    GRACEFUL_COUNTER=$((GRACEFUL_COUNTER + 1))
done

echo "[CODEC_CLI][DOCKERD_STOP]: $CODEC_USER dockerd exit!"