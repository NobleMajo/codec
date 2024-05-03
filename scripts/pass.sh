#!/usr/bin/env bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

if [ -z "$1" ]; then
    echo "[CODEC_CLI][PASS]: No codec user defined!"
    exit 1
fi

PASSWORD=""
while [ ${#PASSWORD} -lt 8 ]; do 
    echo "[CODEC_CLI][PASS]: Enter a password with min 8 letters:"
    echo "[CTRL] + [C] to abort"
    read -s PASSWORD

    echo -n "[CODEC_CLI][PASS]: Enter password again:"
    echo "[CTRL] + [C] to abort"
    read -s RE_PASSWORD
    echo
    if [ "$PASSWORD" != "$RE_PASSWORD" ]; then
        echo "[CODEC_CLI][PASS]: Passwords does not match!"
        echo "Please try again!"
        echo "[CTRL] + [C] to abort"
        continue
    fi
done

echo "[CODEC_CLI][PASS]: Hash password..."
HASH="$(echo -n "$PASSWORD" | sha256sum | cut -d' ' -f1)"

echo "[CODEC_CLI][PASS]: Set password hash..."
$CURRENT_DIR/passhash.sh $1 "$HASH"

echo "[CODEC_CLI][PASS]: Password set!"
