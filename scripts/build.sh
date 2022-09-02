#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

cd $CURRENT_DIR/..
docker build -t codec2 .
