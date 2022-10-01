#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

cd $CURRENT_DIR/..

FLAG_NAME="--scratch"
FLAG_SHORTNAME="-s"
if [ "$1" == "$FLAG_NAME" ] ||  [ "$1" == "$FLAG_SHORTNAME" ]  || 
    [ "$2" == "$FLAG_NAME" ] ||  [ "$2" == "$FLAG_SHORTNAME" ]  || 
    [ "$3" == "$FLAG_NAME" ] ||  [ "$3" == "$FLAG_SHORTNAME" ]  || 
    [ "$4" == "$FLAG_NAME" ] || [ "$5" == "$FLAG_NAME" ] || 
    [ "$6" == "$FLAG_NAME" ] || [ "$7" == "$FLAG_NAME" ] ||
    [ "$4" == "$FLAG_SHORTNAME" ] || [ "$5" == "$FLAG_SHORTNAME" ] || 
    [ "$6" == "$FLAG_SHORTNAME" ] || [ "$7" == "$FLAG_SHORTNAME" ]; then
    echo "[CODEC_CLI][BUILD]: Build codec image form scratch..."
    docker build --pull --no-cache -t codec2 .
    echo "[CODEC_CLI][BUILD]: Scratch image ready!"
    echo 0
fi

echo "[CODEC_CLI][BUILD]: Build codec image..."
docker build -t codec2 .
echo "[CODEC_CLI][BUILD]: Image ready!"