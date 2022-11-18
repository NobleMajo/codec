#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

$CURRENT_DIR/uncron.sh

sudo crontab -l > /tmp/codec-cron
sudo echo "50 4 * * * codeccli updateall -s -f" >> /tmp/codec-cron
sudo crontab /tmp/codec-cron
sudo rm -rf /tmp/codec-cron
