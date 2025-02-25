#!/usr/bin/env bash

echo "[CODEC][EXTENSION]: Set vscode extension store..." 
export VSCODE_GALLERY=ms2
/etc/codec/vscode_gallery.js &> /codec/mounts/logs/vscode_gallery.js.log

echo "[CODEC][EXTENSION]: Install default extensions..." 

codei emmanuelbeziat.vscode-great-icons
