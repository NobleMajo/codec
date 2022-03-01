#!/bin/bash

docker network disconnect ff_cunet codec_majo
docker network disconnect ff_cunet codec_sysdev
docker network disconnect ff_cunet codec_test
docker network disconnect ff_cunet codec_vodka

docker rm -f codec_majo
docker rm -f codec_sysdev
docker rm -f codec_test
docker rm -f codec_vodka
