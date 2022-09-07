#!/bin/bash

echo "[CODEC][MODULE]: Load modules..."

MODULES_PATH="/codec/.codec/modules"
OPTIONAL_PATH="/codec/.codec/optional"
LOGS_PATH="/etc/codec/logs"

ASYNC_MODULE_PATHS=("$(find $MODULES_PATH -name "*.async.sh")")

for ASYNC_MODULE_PATH in $ASYNC_MODULE_PATHS; do
    ASYNC_MODULE_NAME=$(basename "$ASYNC_MODULE_PATH")
    ASYNC_MODULE_LOGS_PATH=$LOGS_PATH/module.$ASYNC_MODULE_NAME.async.log
    echo "[CODEC][MODULE][ASYNC]: Start '$ASYNC_MODULE_NAME' async..."
    touch $ASYNC_MODULE_LOGS_PATH
    $ASYNC_MODULE_PATH &> $ASYNC_MODULE_LOGS_PATH
    echo "Started $ASYNC_MODULE_NAME async in background!"
done
