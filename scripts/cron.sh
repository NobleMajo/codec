#!/usr/bin/env bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

$CURRENT_DIR/uncron.sh

sudo mkdir -p $CURRENT_DIR/.codec/cron
sudo rm -rf $CODEC_USER_DATA/.codec/cron/*
sudo cp $CURRENT_DIR/../cron/* $CODEC_USER_DATA/.codec/cron/

sudo crontab -l > /tmp/codec-cron
sudo echo "50 4 * * * $CODEC_USER_DATA/.codec/cron/task.sh $USER" >> /tmp/codec-cron
sudo crontab /tmp/codec-cron
sudo rm -rf /tmp/codec-cron
