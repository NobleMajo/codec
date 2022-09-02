#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

echo "Available subcommands at:"
echo "'$CURRENT_DIR'"
ls -AQ $CURRENT_DIR