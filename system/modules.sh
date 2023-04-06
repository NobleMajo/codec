#!/bin/bash

echo "[CODEC][MODULE]: Load modules..."

MODULES_PATH="/codec/.codec/modules"
OPTIONAL_PATH="/codec/.codec/optional"
LOGS_PATH="/etc/codec/logs"

mkdir -p $MODULES_PATH
mkdir -p $OPTIONAL_PATH
mkdir -p $LOGS_PATH

ENV_MODULE_PATHS=("$(find $MODULES_PATH -name "*.env.sh")")
BOOT_MODULE_PATHS=("$(find $MODULES_PATH -name "*.boot.sh")")
ASYNC_MODULE_PATHS=("$(find $MODULES_PATH -name "*.async.sh")")
BASH_MODULE_PATHS=("$(find $MODULES_PATH -name "*.bash.sh")")

MODULE_COUNTER=0

for MODULE_PATH in $ENV_MODULE_PATHS; do
    chmod +x $MODULE_PATH
    MODULE_COUNTER=$(($MODULE_COUNTER+1))
done
for MODULE_PATH in $BOOT_MODULE_PATHS; do
    chmod +x $MODULE_PATH
    MODULE_COUNTER=$(($MODULE_COUNTER+1))
done
for MODULE_PATH in $ASYNC_MODULE_PATHS; do
    chmod +x $MODULE_PATH
    MODULE_COUNTER=$(($MODULE_COUNTER+1))
done
for MODULE_PATH in $BASH_MODULE_PATHS; do
    chmod +x $MODULE_PATH
    MODULE_COUNTER=$(($MODULE_COUNTER+1))
done

echo "[CODEC][MODULE]: $MODULE_COUNTER modules found!"

export CODEC_ALL_APT_PACKAGES=""
export CODEC_ALL_NPM_PACKAGES=""
source /codec/.codec/env.sh > $LOGS_PATH/user.env.log

for ENV_MODULE_PATH in $ENV_MODULE_PATHS; do
    ENV_MODULE_NAME=$(basename "$ENV_MODULE_PATH")
    ENV_MODULE_LOGS_PATH=$LOGS_PATH/module.$ENV_MODULE_NAME.env.log
    echo "[CODEC][MODULE][ENV]: Load '$ENV_MODULE_NAME' env"
    touch $ENV_MODULE_LOGS_PATH
    source $ENV_MODULE_PATH > $ENV_MODULE_LOGS_PATH
    echo "[CODEC][MODULE][ENV]: '$ENV_MODULE_NAME' loaded!"
    if [ "$CODEC_APT_PACKAGES" != "" ]; then
        if [ "$CODEC_ALL_APT_PACKAGES" != "" ]; then
            export CODEC_ALL_APT_PACKAGES="$CODEC_ALL_APT_PACKAGES $CODEC_APT_PACKAGES"
        else
            export CODEC_ALL_APT_PACKAGES="$CODEC_APT_PACKAGES"
        fi
        
        export CODEC_APT_PACKAGES=""
    fi
    if [ "$CODEC_NPM_PACKAGES" != "" ]; then
        if [ "$CODEC_ALL_NPM_PACKAGES" != "" ]; then
            export CODEC_ALL_NPM_PACKAGES="$CODEC_ALL_NPM_PACKAGES $CODEC_NPM_PACKAGES"
        else
            export CODEC_ALL_NPM_PACKAGES="$CODEC_NPM_PACKAGES"
        fi
        
        export CODEC_NPM_PACKAGES=""
    fi
done

apt-get update
if [ "$CODEC_ALL_APT_PACKAGES" != "" ]; then
    echo "[CODEC][MODULE][APT]: Install following packages:"
    echo "'$CODEC_ALL_APT_PACKAGES'"
    apt-get install -y --no-install-recommends $CODEC_ALL_APT_PACKAGES
else 
    echo "[CODEC][MODULE][APT]: No apt packages defined!"
fi

if [ "$CODEC_ALL_NPM_PACKAGES" != "" ]; then
    echo "[CODEC][MODULE][NPM]: Install following packages:"
    echo "'$CODEC_ALL_NPM_PACKAGES'"
    npm i -g $CODEC_ALL_NPM_PACKAGES
else 
    echo "[CODEC][MODULE][NPM]: No npm packages defined!"
fi

for BOOT_MODULE_PATH in $BOOT_MODULE_PATHS; do
    BOOT_MODULE_NAME=$(basename "$BOOT_MODULE_PATH")
    BOOT_MODULE_LOGS_PATH=$LOGS_PATH/module.$BOOT_MODULE_NAME.boot.log
    echo "[CODEC][MODULE][BOOT]: Start '$BOOT_MODULE_NAME'..."
    touch $BOOT_MODULE_LOGS_PATH
    $BOOT_MODULE_PATH > $BOOT_MODULE_LOGS_PATH
    echo "[CODEC][MODULE][BOOT]: '$BOOT_MODULE_NAME' done!"
done
