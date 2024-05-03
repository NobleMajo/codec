#!/usr/bin/env bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

echo "Need root access..."
sudo echo "Root access granted!"

sudo crontab -l > /tmp/codec-cron
sed '/.codec/d' /tmp/codec-cron > /tmp/codec-cron
sudo crontab /tmp/codec-cron
sudo rm -rf /tmp/codec-cron
