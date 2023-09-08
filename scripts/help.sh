#!/bin/bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

echo "CodeC - VS Code Container"
echo "- A VS Code Docker Container Image"
echo "- by Majo418 (See GitHub)"
echo "- based on coder/code-server (See GitHub)"
echo "- based on docker (See GitHub)"
echo ""

echo "Tipps:"
echo "1. You need to enter minimum 2 letters of a command to execute it."
echo "2. If you do something dangerous the cli tool will ask you if you really want to do it."
echo "3. The subcommands do not have an infotext."
echo "4. If you have no idea what you're doing, stop."
echo ""

echo "Available subcommands at:"
echo "'$CURRENT_DIR'"
ls -AQ $CURRENT_DIR
