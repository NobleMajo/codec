#!/usr/bin/env bash

source /etc/environment

# clear cache files
/etc/codec/cache.sh

# health check
/etc/codec/health.sh

apt-get update

# default vscode extensions
/etc/codec/extensions.sh

# init mod system
source /etc/codec/mods.sh

# reload sysctl
sysctl -p

# run vscode server service
echo "[CODEC][VSCODE]: Start vscode service..."
systemctl start vscode

# init async mods
/etc/codec/mods_async.sh

echo "[CODEC][VSCODE]: Done!"
