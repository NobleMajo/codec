#!/bin/bash

./uncron.sh

sudo crontab -l > /tmp/codec-cron
sudo echo "50 4 * * * codeccli updateall -s -f" >> /tmp/codec-cron
sudo crontab /tmp/codec-cron
sudo rm -rf /tmp/codec-cron