#!/bin/bash

PARENT_NAME="$(basename $(dirname $(realpath $0)))"
if [ $PARENT_NAME != "modules" ]; then
    exit 0
fi

export VSCODE_GALLERY=ms2

/etc/codec/vscode_gallery.js