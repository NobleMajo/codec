#!/bin/bash

# dev
DEV_TOOLS="make automake"
# cli 
DEV_TOOLS="tmux $DEV_TOOLS"
# network
DEV_TOOLS="nmap net-tools $DEV_TOOLS"
# ssh
DEV_TOOLS="openssh-client openssl $DEV_TOOLS" 
# essentials
DEV_TOOLS="build-essential $DEV_TOOLS"

export CODEC_APT_PACKAGES="$DEV_TOOLS"

