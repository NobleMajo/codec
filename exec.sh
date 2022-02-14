#!/bin/bash

docker exec -it "codec_$1" su codec -c "${*:2}"
