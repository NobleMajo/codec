#!/usr/bin/env bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

$CURRENT_DIR/build.sh > /dev/null 2>&1 &
BUILD_PID=$!

if [ -z "$1" ]; then
    echo "[CODEC_CLI][START]: No codec user defined!"
    exit 1
fi

CODEC_USER="$1"

if [ -z "$MAX_ALLOED_CODEC_PORTs" ]; then
    MAX_ALLOED_CODEC_PORTS=99
fi

if [ -z "$DEFAULT_CODEC_PORT_COUNT" ]; then
    DEFAULT_CODEC_PORT_COUNT="10"
fi

START_PORT="$2" # 20
PORT_COUNT="$3" # 5

if (( START_PORT > 65535 )) || (( START_PORT < 1 )); then
    START_PORT=""
fi
if (( PORT_COUNT > $MAX_ALLOED_CODEC_PORTS )) || (( PORT_COUNT < 1 )); then
     PORT_COUNT=""
fi

if [ -z $START_PORT ]; then
    docker rm -f codeccli-start-port-reader > /dev/null 2>&1
    START_PORT="$(
        docker run -it --rm \
            --name "codeccli-start-port-reader" \
            -v "$CODEC_USER_DATA/.codec/ports:/app" \
            ubuntu:22.04 \
                bash -c \
                " \
                    touch /app/$CODEC_USER.start.port && \
                    cat /app/$CODEC_USER.start.port \
                "
    )"
    if [ -z $START_PORT ]; then
        echo "[CODEC_CLI][START]: Start port not defined!"
        exit 1
    fi
fi
echo "[CODEC_CLI][START]: Defined start port is:"
echo "'$START_PORT'"

if [ -z $PORT_COUNT ]; then
    docker rm -f codeccli-end-port-reader > /dev/null 2>&1

    PORT_COUNT="$(
        docker run -it --rm \
            --name "codeccli-end-port-reader" \
            -v "$CODEC_USER_DATA/.codec/ports:/app" \
            ubuntu:22.04 \
                bash -c \
                "touch /app/$CODEC_USER.count.port && cat /app/$CODEC_USER.count.port"
        )"
    if [ -z $PORT_COUNT ]; then
        PORT_COUNT="$DEFAULT_CODEC_PORT_COUNT"
    fi
fi

echo "[CODEC_CLI][START]: Defined port count is:"
echo "'$PORT_COUNT'"

if (( START_PORT > 65535 )); then
    echo "[CODEC_CLI][START]: The start port '$START_PORT' is not in the port range (1-65535)!"
    exit 1
fi
if (( START_PORT < 1 )); then
    echo "[CODEC_CLI][START]: The start port '$START_PORT' is not in the port range (1-65535)!"
    exit 1
fi
if (( PORT_COUNT > $MAX_ALLOED_CODEC_PORTS )); then
    echo "[CODEC_CLI][START]: The port count '$PORT_COUNT' is greater then the maximum allowed count of ports '$MAX_ALLOED_CODEC_PORTS'!"
    exit 1
fi
if (( PORT_COUNT < 1 )); then
    echo "[CODEC_CLI][START]: The port counts needs to be minimum '1'!"
    exit 1
fi

END_PORT=$(($START_PORT+$PORT_COUNT-1))

if (( END_PORT > 65535 )); then
    echo "[CODEC_CLI][START]: The end port '$END_PORT' is not in the port range (1-65535)!"
    exit 1
fi
if (( END_PORT < 1 )); then
    echo "[CODEC_CLI][START]: The end port '$END_PORT' is not in the port range (1-65535)!"
    exit 1
fi

ALREADY_EXIST=$($CURRENT_DIR/exist.sh "$CODEC_USER" "CODECDIR")

DOCKER_START_CMD=" \
    docker run -d \
        --privileged \
        --name 'codec_$CODEC_USER' \
        --net '$CODEC_NET' \
        --restart unless-stopped \
        -p '0.0.0.0:$START_PORT-$END_PORT:$START_PORT-$END_PORT/tcp' \
        -p '0.0.0.0:$START_PORT-$END_PORT:$START_PORT-$END_PORT/udp' \
        -e 'CODEC_PORTS=$START_PORT-$END_PORT' \
        -v '$CODEC_USER_DATA/.codec/shared_folder:/codec/mounts/shared' \
        -v '$CODEC_USER_DATA/$CODEC_USER:/codec' \
        codec2 \
"

echo "[CODEC_CLI][START]: Docker run command preview: '"
echo "$DOCKER_START_CMD"
echo "'"

FLAG_NAME="--force"
FLAG_SHORTNAME="-f"
if [ "$CODEC_USER" != "$FLAG_NAME" ] && [ "$CODEC_USER" != "$FLAG_SHORTNAME" ] &&
    [ "$2" != "$FLAG_NAME" ] && [ "$2" != "$FLAG_SHORTNAME" ] &&
    [ "$3" != "$FLAG_NAME" ] && [ "$3" != "$FLAG_SHORTNAME" ] &&
    [ "$4" != "$FLAG_NAME" ] && [ "$5" != "$FLAG_NAME" ] &&
    [ "$6" != "$FLAG_NAME" ] && [ "$7" != "$FLAG_NAME" ] &&
    [ "$4" != "$FLAG_SHORTNAME" ] && [ "$5" != "$FLAG_SHORTNAME" ] &&
    [ "$6" != "$FLAG_SHORTNAME" ] && [ "$7" != "$FLAG_SHORTNAME" ]; then
    echo ""
    echo "[CODEC_CLI][START]: "
    echo "####### CONTAINER DATA #######"
    echo "#    Ports: '$START_PORT-$END_PORT'"
    echo "# Datapath: '$CODEC_USER_DATA/$CODEC_USER/'"
    echo "#    Exist: '$ALREADY_EXIST'"
    echo "# Enter 'y' to start the '$CODEC_USER' codec user container."
    echo "# [CTRL] + [C] to abort!"
    read INPUT_VALUE
    if [ "$INPUT_VALUE" != "y" ]; then
        echo "Abort because input was not 'y'!"
        exit 1
    fi
fi

echo "[CODEC_CLI][START]: Wait for image building..."
while kill -0 $BUILD_PID >/dev/null 2>&1; do
    sleep 1
done
echo "[CODEC_CLI][START]: Image ready!"

$CURRENT_DIR/close.sh $CODEC_USER

docker network create "$CODEC_NET" > /dev/null 2>&1

echo "[CODEC_CLI][START]: Run docker container..."
bash -c "$DOCKER_START_CMD"

#echo "[CODEC_CLI][START]: Run docker daemon..."
#$CURRENT_DIR/dockerd.sh $CODEC_USER

echo "[CODEC_CLI][START]: Set port user info..."
PORT_INFO_TEXT="Your codec ports: codec.coreunit.net:$START_PORT-$END_PORT"

docker rm -f codeccli-info-helper > /dev/null 2>&1
docker run -it --rm \
    --name "codeccli-info-helper" \
    -v "$CODEC_USER_DATA/$CODEC_USER:/codec" \
    ubuntu:22.04 \
        bash -c \
        " \
        mkdir -p /codec/.codec && \
        chmod 777 /codec/.codec && \
        echo '$PORT_INFO_TEXT' > /codec/.codec/ports.info.txt \
        && chmod 744 /codec/.codec \
        "

echo "[CODEC_CLI][START]: Save startup arguments..."
docker rm -f codeccli-port-helper > /dev/null 2>&1
docker run -it --rm \
    --name "codeccli-port-helper" \
    -v "$CODEC_USER_DATA/.codec:/app" \
    ubuntu:22.04 \
        bash -c \
        " \
        mkdir -p /app/ports \
        && touch /app/ports/$CODEC_USER.start.port \
        && echo -n '$START_PORT' > /app/ports/$CODEC_USER.start.port \
        && touch /app/ports/$CODEC_USER.count.port \
        && echo -n '$PORT_COUNT' > /app/ports/$CODEC_USER.count.port \
        "

if [ "$ALREADY_EXIST" == "false" ]; then
    echo "[CODEC_CLI][START]: Set new random generated password..."
    NEW_DEFAULT_PASS="$($CURRENT_DIR/randompass.sh $CODEC_USER)"
    $CURRENT_DIR/defaultpass.sh $CODEC_USER "$NEW_DEFAULT_PASS"
    $CURRENT_DIR/setpass.sh $CODEC_USER "$NEW_DEFAULT_PASS"

    echo "Default password is: '$NEW_DEFAULT_PASS'"
fi

echo "[CODEC_CLI][START]: Finished!"
