#!/bin/bash

docker run -d --rm \
    --name "codec" \
    -e "PORT_RANGE=$START_PORT-$END_PORT" \
    codec
