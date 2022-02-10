
[![](https://img.shields.io/docker/image-size/majo418/codec)](https://hub.docker.com/r/majo418/codec)
![CI](https://github.com/majo418/codec/workflows/Image/badge.svg)
![can't load images](https://img.shields.io/badge/dynamic/json?style=plastic&color=orange&label=UnixTime&query=unixtime&suffix=sec&url=http%3A%2F%2Fworldtimeapi.org%2Fapi%2Ftimezone%2FEtc%2FUTC)
![MIT](https://img.shields.io/badge/license-MIT-blue.svg)

![](https://img.shields.io/badge/dynamic/json?color=darkred&label=open%20issues&query=open_issues&suffix=x&url=https%3A%2F%2Fapi.github.com%2Frepos%2Fmajo418%2Fcodec)
![](https://img.shields.io/badge/dynamic/json?color=navy&label=forks&query=forks&suffix=x&url=https%3A%2F%2Fapi.github.com%2Frepos%2Fmajo418%2Fcodec)
![](https://img.shields.io/badge/dynamic/json?color=green&label=subscribers&query=subscribers_count&suffix=x&url=https%3A%2F%2Fapi.github.com%2Frepos%2Fmajo418%2Fcodec)

# codec
|
[Docker Hub](https://hub.docker.com/r/majo418/codec)
|
[GitHub](https://github.com/majo418/codec)
|  
The main focus of this project is to provide a ubuntu visual studio code workspace in a docker container accessible from the browser.

# example commands
## pull image
```sh
docker push majo418/codec:latest
```
## start container
```sh
docker run -d --privileged \
    --restart unless-stopped \
    --name codec \
    --network host \
    codec:latest
```
## exec command
```sh
docker exec -it codec \
    docker ps
```
## remove container
```sh
docker rm -f codec
```
## run container persistently
```sh
docker run -d --privileged \
    --restart unless-stopped \
    --name codec \
    --network host \
    -v $(pwd)/.store:/var/lib/docker \
    codec:latest
```

# control scripts
This control scripts should help you to understand how to use the image and container.
 - build.sh - build docker image
 - start.sh USERNAME [START_PORT] [PORT_COUNT] - run docker container with network, volume and backup/cache mount to "./.store"
 - remove.sh USERNAME - remove docker container

# contribution
 - 1. fork the project
 - 2. implement your idea
 - 3. create a pull/merge request
```ts
// please create seperated forks for different kind of featues/ideas/structure changes/implementations
```

---
**cya ;3**  
*by majo418*


