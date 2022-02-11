#!/bin/bash

if [ ! -d "/home/codec/ws/.codec" ]; then
    echo "CodecMain: Copying skeleton to \"/home/codec/ws/.codec\"..."
    cp -r /home/codec/.codec/skel /home/codec/ws/.codec
fi

echo "CodecMain: Save ports and link code-server settings..."
# if $PORT_RANGE is set
if [ ! -z "$PORT_RANGE" ]; then
   # split $PORT_RANGE into $START_PORT and $END_PORT
    START_PORT=$(echo $PORT_RANGE | cut -d'-' -f1)
    END_PORT=$(echo $PORT_RANGE | cut -d'-' -f2)
    # throw error is $START_PORT is not a number between 1 and 65535
    if ! [[ $START_PORT =~ ^[0-9]+$ ]] || [ $START_PORT -lt 1 ] || [ $START_PORT -gt 65535 ]; then
        echo "The \$START_PORT environment variable must be a number between 1 and 65535"
        exit 1
    fi
    # throw error is $END_PORT is not a number between $START_PORT and 65535
    if ! [[ $END_PORT =~ ^[0-9]+$ ]] || [ $END_PORT -lt $START_PORT ] || [ $END_PORT -gt 65535 ]; then
        echo "The \$END_PORT environment variable must be a number between \$START_PORT and 65535"
        exit 1
    fi

    echo -n "$START_PORT-$END_PORT" > /home/codec/ws/.codec/ports.txt
else
    echo -n "This container has no published ports." > /home/codec/ws/.codec/ports.txt
fi
echo "#!/bin/bash\n\ncd ..\n" >> "/home/codec/.codec/skel/cd.."
echo -n "$@" > /home/codec/ws/.codec/arguments.txt

echo "CodecMain: Run boot script..."
/home/codec/ws/.codec/boot.sh

echo "CodecMain: Run code-server..."
nodemon \
    -w /home/codec/ws/.codec/code-server.yaml \
    -x "sudo -u codec /home/codec/.codec/code-server.sh"
