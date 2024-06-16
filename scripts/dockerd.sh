#!/usr/bin/env bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

if [ -z "$1" ]; then
    echo "[CODEC_CLI][DOCKERD]: No codec user defined!"
    exit 1
fi

echo "[CODEC_CLI][DOCKERD]: Prepare $CODEC_USER docker daemon process..."

CODEC_USER=$1
CODEC_DOCKERD_DIR="$CODEC_USER_DATA/.codec/dockerd/"
CODEC_DOCKERD_CONFIG_PATH="$CODEC_DOCKERD_DIR/$CODEC_USER_dockerd_config.json"
CODEC_DOCKERD_PID_PATH="$CODEC_DOCKERD_DIR/$CODEC_USER_dockerd.pid"

mkdir -p $CODEC_DOCKERD_DIR
mkdir -p $CODEC_USER_DATA/$CODEC_USER/dockerd/

$CURRENT_DIR/dockerd-stop.sh $CODEC_USER

cat <<EOF > $CODEC_DOCKERD_CONFIG_PATH
{
  "hosts": ["unix://$CODEC_USER_DATA/$CODEC_USER/dockerd/dockerd.sock"],
  "pidfile": "$CODEC_DOCKERD_DIR/$CODEC_USER_dockerd.pid",
  "data-root": "$CODEC_USER_DATA/$CODEC_USER/dockerd/data",
  "registry-mirrors": [
    "https://docker-reg.coreunit.net"
  ],
  "storage-driver": "vfs",
  "debug": true,
  "log-driver": "json-file",
  "log-opts": {
  "max-size": "12m",
  "max-file": "3"
}
EOF

echo "[CODEC_CLI][DOCKERD]: Run $CODEC_USER docker daemon process..."
$CURRENT_DIR/dockerd-process.sh $CODEC_USER > "$CODEC_DOCKERD_DIR/$CODEC_USER_docker_sidecar.logs" &