#!/bin/bash

echo "[CODEC][HEALTH]: Create folder..."
mkdir -p /codec/.codec/modules
mkdir -p /codec/mounts

mkdir -p /codec/archived
mkdir -p /codec/workspace
mkdir -p /codec/todo
mkdir -p /codec/tests

echo "[CODEC][HEALTH]: Copy codec skel..."
cp -nr /etc/codec/skel/* /codec/.codec/

echo "[CODEC][HEALTH]: Mounting..."
/etc/codec/mounts.js

echo "[CODEC][HEALTH]: Linking 'config.yaml'..."
mkdir -p /root/.config/code-server
rm -rf /root/.config/code-server/config.yaml
cp -n /etc/codec/vscode-server.yaml /codec/.codec/vscode-server.yaml
ln -s /codec/.codec/vscode-server.yaml /root/.config/code-server/config.yaml 
echo "Linked: '/root/.config/code-server/config.yaml'"

echo "[CODEC][HEALTH]: Linking 'keybindings.json'..."
mkdir -p /root/.local/share/code-server/User
rm -rf /codec/mounts/vscode/User/keybindings.json
ln -s /codec/.codec/keybindings.json /root/.local/share/code-server/User/keybindings.json
echo "Linked: '/root/.local/share/code-server/User/keybindings.json'"

echo "[CODEC][HEALTH]: Linking 'vscode/User/settings.json'..."
mkdir -p /root/.local/share/code-server/User
rm -rf /codec/mounts/vscode/User/settings.json
ln -s /codec/.codec/settings.json /root/.local/share/code-server/User/settings.json
echo "Linked: '/root/.local/share/code-server/User/settings.json'"

# echo "[CODEC][HEALTH]: Linking 'product.json'..."
# mkdir -p /usr/lib/code-server/lib/vscode
# cp -n /usr/lib/code-server/lib/vscode/product.json /codec/.codec/product.json
# rm -rf /usr/lib/code-server/lib/vscode/product.json
# ln -s /codec/.codec/product.json /usr/lib/code-server/lib/vscode/product.json
# echo "Linked: '/usr/lib/code-server/lib/vscode/product.json'"

echo "[CODEC][HEALTH]: Linking..."
rm -rf /usr/lib/code-server/src/browser/pages
ln -s /etc/codec/login /usr/lib/code-server/src/browser/pages
echo "Linked: '/usr/lib/code-server/src/browser'"

/etc/codec/readme.sh
/etc/codec/changelogs.sh

echo "[CODEC][HEALTH]: Linking..."
rm -rf /root/ws
ln -s /codec /root/ws
echo "Link in `/root/ws` to '/codec' created!"

echo "[CODEC][HEALTH]: Disable vscode telemetry..."
/etc/codec/vscode_telemetry.js
echo "[CODEC][HEALTH]: Telemetry disabled!"
