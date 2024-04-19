#!/bin/bash

echo "[CODEC][EXTENSION]: Set vscode extension store..." 
export VSCODE_GALLERY=ms2
/etc/codec/vscode_gallery.js

echo "[CODEC][EXTENSION]: Install default extensions..." 

codei emmanuelbeziat.vscode-great-icons
codei coltwillcox.synthwave-x-fluoromachine-contrast
