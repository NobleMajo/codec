#!/bin/bash

docker exec "codec_$1" su codec -c "${*:2}"
