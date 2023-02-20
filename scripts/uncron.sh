#!/bin/bash

echo "Need root access..."
sudo echo "Root access granted!"

sudo crontab -l > /tmp/codec-cron
sed '/.codec/d' /tmp/codec-cron > /tmp/codec-cron
sudo crontab /tmp/codec-cron
sudo rm -rf /tmp/codec-cron
