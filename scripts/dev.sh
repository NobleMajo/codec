#!/bin/bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

if [ "$1" == "reset" ] || [ "$1" == "-r" ]; then
    echo "Reset user '$1_dev'..."
    $CURRENT_DIR/delete.sh "$1_dev" -f
fi

$CURRENT_DIR/build.sh
$CURRENT_DIR/start.sh "$1_dev" 33330 10 -f

if [ "$1" == "reset" ] || [ "$1" == "-r" ]; then
    sleep 3
    $CURRENT_DIR/pass.sh "$1_dev"
fi
