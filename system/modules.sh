#!/bin/bash

MODULES_PATH="/codec/.codec/modules"
OPTIONAL_PATH="/codec/.codec/optional"
LOGS_PATH="/etc/codec/logs"

mkdir -p $MODULES_PATH
mkdir -p $OPTIONAL_PATH
mkdir -p $LOGS_PATH

BOOT_MODULE_PATHS=("$(find $MODULES_PATH -name "*.boot.sh")")
ASYNC_MODULE_PATHS=("$(find $MODULES_PATH -name "*.async.sh")")
BASH_MODULE_PATHS=("$(find $MODULES_PATH -name "*.bash.sh")")

for MODULE_PATH in $BOOT_MODULE_PATHS; do
    chmod +x $MODULE_PATH
done
for MODULE_PATH in $ASYNC_MODULE_PATHS; do
    chmod +x $MODULE_PATH
done
for MODULE_PATH in $BASH_MODULE_PATHS; do
    chmod +x $MODULE_PATH
done

for BOOT_MODULE_PATH in $BOOT_MODULE_PATHS; do
    BOOT_MODULE_NAME=$(basename "$BOOT_MODULE_PATH")
    BOOT_MODULE_LOGS_PATH=$LOGS_PATH/module.$BOOT_MODULE_NAME.boot.log
    echo "[CODEC][MODULE][BOOT]: Start '$BOOT_MODULE_NAME'..."
    touch $BOOT_MODULE_LOGS_PATH
    $BOOT_MODULE_PATH > $BOOT_MODULE_LOGS_PATH
    echo "[CODEC][MODULE][BOOT]: '$BOOT_MODULE_NAME' done!"
done

for ASYNC_MODULE_PATH in $ASYNC_MODULE_PATHS; do
    ASYNC_MODULE_NAME=$(basename "$ASYNC_MODULE_PATH")
    ASYNC_MODULE_LOGS_PATH=$LOGS_PATH/module.$ASYNC_MODULE_NAME.async.log
    echo "[CODEC][MODULE][ASYNC]: Start '$ASYNC_MODULE_NAME' async..."
    touch $ASYNC_MODULE_LOGS_PATH
    bash -c "$ASYNC_MODULE_PATH" > $ASYNC_MODULE_LOGS_PATH & echo
done


