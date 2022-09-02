#!/bin/bash

echo "[CODEC][EXTENSION]: Set vscode extension store..." 
export VSCODE_GALLERY=ms2
/etc/codec/vscode_gallery.js

echo "[CODEC][EXTENSION]: Install default extensions..." 
codei thiagolciobittencourt.ubuntuvscode
codei vscode-icons-team.vscode-icons