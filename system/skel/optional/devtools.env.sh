#!/bin/bash

# dev
DEV_TOOLS="git make $DEV_TOOLS"
# com
DEV_TOOLS="curl wget telnet openssh-client $DEV_TOOLS"
# editors
DEV_TOOLS="vim nano  $DEV_TOOLS" 
# compression
DEV_TOOLS="tar zip unzip $DEV_TOOLS" 
# other
DEV_TOOLS="neofetch openssl $DEV_TOOLS" 
# essentials
DEV_TOOLS="build-essential $DEV_TOOLS" 

export CODEC_APT_MODULES="$DEV_TOOLS$CODEC_APT_MODULES"

