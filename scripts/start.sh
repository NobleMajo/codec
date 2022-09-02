#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

$CURRENT_DIR/build.sh &
BUILD_PID=$!

if [ -z "$1" ]; then
    echo "No codec user defined!"
    exit 1
fi

if [ -z "$CODEC_USER_DATA" ]; then
    CODEC_USER_DATA="/var/lib/codec"
fi

if [ -z "$CODEC_NET" ]; then
    CODEC_NET="ff_cunet"
fi

if [ -z "$MAX_ALLOED_CODEC_PORTS" ]; then
    MAX_ALLOED_CODEC_PORTS=15
fi

START_PORT="$2" # 20
PORT_COUNT="$3" # 5
END_PORT=$START_PORT + PORT_COUNT - 1 # 24 

if (( START_PORT > 65535 )); then
    echo "The start port '$START_PORT' is not in the port range (1-65535)!"
    exit 1
fi
if (( START_PORT < 1 )); then
    echo "The start port '$START_PORT' is not in the port range (1-65535)!"
    exit 1
fi
if (( END_PORT > 65535 )); then
    echo "The end port '$END_PORT' is not in the port range (1-65535)!"
    exit 1
fi
if (( END_PORT < 1 )); then
    echo "The end port '$END_PORT' is not in the port range (1-65535)!"
    exit 1
fi

if (( PORT_COUNT > $MAX_ALLOED_CODEC_PORTS )); then
    echo "The port count '$PORT_COUNT' is greater then the maximum allowed count of ports '$MAX_ALLOED_CODEC_PORTS'!"
    exit 1
fi
if (( PORT_COUNT < 1 )); then
    echo "The port counts needs to be minimum '1'!"
    exit 1
fi


if [ "$4" != "-f" ] && [ "$4" != "--force" ]; then
    echo "Type `y` to create the codec user `$1`"
    echo "Userdata at:'$CODEC_USER_DATA/$1/.codec'"
    read INPUT_VALUE
    if [ "$INPUT_VALUE" != "y" ]; then
        echo "Abort because input was not 'y'!"
        exit 1
    fi
fi



echo "Wait for image building..."
while kill -0 $BUILD_PID >/dev/null 2>&1; do
    sleep 1
done
echo "Image ready!"

$CURRENT_DIR/close.sh $1

echo "Start '$1'..."
docker run -d --privileged \
    --name "codec_$1" \
    --net "$CODEC_NET" \
    -restart unless-stopped \
    -p "0.0.0.0:$START_PORT-$ENDPORT:$START_PORT-$ENDPORT/tcp" \
    -p "0.0.0.0:$START_PORT-$ENDPORT:$START_PORT-$ENDPORT/udp" \
    -e "CODEC_PORTS=$START_PORT-$ENDPORT" \
    -v "$CODEC_USER_DATA/$1:/codec" \
    codec2
