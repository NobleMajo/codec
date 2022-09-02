#!/bin/bash

echo "[CODEC][HEALTH]: Create folder..."
mkdir -p /codec/.codec/modules
mkdir -p /codec/mounts
mkdir -p /codec/archived
mkdir -p /codec/workspace
mkdir -p /etc/codec/logs

echo "[CODEC][HEALTH]: Copy codec skel..."
cp -nr /etc/codec/skel/* /codec/.codec/

echo "[CODEC][HEALTH]: Mounting..."
/etc/codec/mounts.js

echo "[CODEC][HEALTH]: Linking..."
mkdir -p /root/.config/code-server
rm -rf /root/.config/code-server/config.yaml
cp -n /etc/codec/vscode-server.yaml /codec/.codec/vscode-server.yaml
ln -s /codec/.codec/vscode-server.yaml /root/.config/code-server/config.yaml 
echo "Linked: '/root/.config/code-server/config.yaml'"

echo "[CODEC][HEALTH]: Linking..."
mkdir -p /root/.local/share/code-server/User
rm -rf /codec/mounts/vscode/User/keybindings.json
ln -s /codec/.codec/keybindings.json /root/.local/share/code-server/User/keybindings.json
echo "Linked: '/root/.local/share/code-server/User/keybindings.json'"

echo "[CODEC][HEALTH]: Linking..."
mkdir -p /root/.local/share/code-server/User
rm -rf /codec/mounts/vscode/User/settings.json
ln -s /codec/.codec/settings.json /root/.local/share/code-server/User/settings.json
echo "Linked: '/root/.local/share/code-server/User/settings.json'"

echo "[CODEC][HEALTH]: Linking..."
mkdir -p /usr/lib/code-server/lib/vscode
cp -n /usr/lib/code-server/lib/vscode/product.json /codec/.codec/product.json
rm -rf /usr/lib/code-server/lib/vscode/product.json
ln -s /codec/.codec/product.json /usr/lib/code-server/lib/vscode/product.json
echo "Linked: '/usr/lib/code-server/lib/vscode/product.json'"

echo "[CODEC][HEALTH]: Disable telemetry..."
/etc/codec/vscode_telemetry.js