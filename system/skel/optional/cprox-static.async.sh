#!/bin/bash

if ["$CPROX_PORT" == ""]; then
    echo "Don't start cprox because no port is defined."
    echo "Define the port in '/codec/.codec/env.sh'"
    echo "via the 'export CPROX_PORT=?????'."
    exit 0
fi

/usr/local/bin/cprox \
    -p "$CPROX_PORT" \
    -b 0.0.0.0 \
    --trust-all-certs \
        *=STATIC:/codec/html

