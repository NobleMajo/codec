#!/usr/bin/env bash

echo "[CODEC][HEALTH]: Create folder..."

mkdir -p /codec/.codec/mods
mkdir -p /codec/.codec/enabled-mods
mkdir -p /etc/codec/logs
mkdir -p /codec/mounts/logs
mkdir -p /codec/archive
mkdir -p /codec/ws

echo "[CODEC][HEALTH]: Copy codec skel..."
cp -nr /etc/codec/skel/* /codec/.codec/

echo "[CODEC][HEALTH]: Disable vscode telemetry..."
/etc/codec/vscode_telemetry.js &> /codec/mounts/logs/vscode_telemetry.js.log
echo "[CODEC][HEALTH]: Telemetry disabled!"

echo "[CODEC][HEALTH]: Mounting..."
/etc/codec/mounts.js &> /codec/mounts/logs/mount.js.log

echo "[CODEC][HEALTH]: Linking 'config.yaml'..."
mkdir -p /root/.config/code-server
rm -rf /root/.config/code-server/config.yaml
cp -n /etc/codec/vscode-server.yaml /codec/.codec/vscode-server.yaml
ln -sf /codec/.codec/vscode-server.yaml /root/.config/code-server/config.yaml 
echo "Linked: '/root/.config/code-server/config.yaml'"

echo "[CODEC][HEALTH]: Linking 'keybindings.json'..."
mkdir -p /root/.local/share/code-server/User
rm -rf /codec/mounts/vscode/User/keybindings.json
ln -sf /codec/.codec/keybindings.json /root/.local/share/code-server/User/keybindings.json
echo "Linked: '/root/.local/share/code-server/User/keybindings.json'"

echo "[CODEC][HEALTH]: Linking 'vscode/User/settings.json'..."
mkdir -p /root/.local/share/code-server/User
rm -rf /codec/mounts/vscode/User/settings.json
ln -sf /codec/.codec/settings.json /root/.local/share/code-server/User/settings.json
echo "Linked: '/root/.local/share/code-server/User/settings.json'"

echo "[CODEC][HEALTH]: Linking..."
rm -rf /usr/lib/code-server/src/browser/pages
ln -sf /etc/codec/login /usr/lib/code-server/src/browser/pages
echo "Linked: '/usr/lib/code-server/src/browser'"

echo "[CODEC][HEALTH]: Linking home 'ws' dir..."
rm -rf /root/ws
ln -sf /codec/ws /root/ws
echo "Link in '/codec/ws' to '/root/ws' created!"

echo "[CODEC][HEALTH]: Linking home 'workspace' dir..."
rm -rf /root/workspace
ln -sf /codec/ws /root/workspace
echo "Link in '/root/workspace' to '/codec/ws' created!"

echo "[CODEC][HEALTH]: Linking home 'codec' dir..."
rm -rf /root/codec
ln -sf /codec /root/codec
echo "Link in '/root/codec' to '/codec' created!"
