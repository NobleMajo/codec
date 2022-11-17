
# codec
![Docker](https://img.shields.io/docker/image-size/majo418/codec)
![CI/CD](https://github.com/majo418/codec/workflows/Image/badge.svg)
![MIT](https://img.shields.io/badge/license-MIT-blue.svg)

![](https://img.shields.io/badge/dynamic/json?color=green&label=watchers&query=watchers&suffix=x&url=https%3A%2F%2Fapi.github.com%2Frepos%2Fmajo418%2Fcodec)
![](https://img.shields.io/badge/dynamic/json?color=yellow&label=stars&query=stargazers_count&suffix=x&url=https%3A%2F%2Fapi.github.com%2Frepos%2Fmajo418%2Fcodec)
![](https://img.shields.io/badge/dynamic/json?color=orange&label=subscribers&query=subscribers_count&suffix=x&url=https%3A%2F%2Fapi.github.com%2Frepos%2Fmajo418%2Fcodec)
![](https://img.shields.io/badge/dynamic/json?color=navy&label=forks&query=forks&suffix=x&url=https%3A%2F%2Fapi.github.com%2Frepos%2Fmajo418%2Fcodec)
![](https://img.shields.io/badge/dynamic/json?color=darkred&label=open%20issues&query=open_issues&suffix=x&url=https%3A%2F%2Fapi.github.com%2Frepos%2Fmajo418%2Fcodec)

# table of contents
- [codec](#codec)
- [table of contents](#table-of-contents)
- [about](#about)
- [cli tool](#cli-tool)
  - [install](#install)
  - [use](#use)
  - [debug](#debug)
  - [stop](#stop)
- [contribution](#contribution)

# about
|
[Docker Hub](https://hub.docker.com/r/majo418/codec)
|
[GitHub](https://github.com/majo418/codec)
|  
The main focus of this project is to provide a ubuntu visual studio code workspace in a docker container accessible from the browser.

# cli tool
## install
```sh
./codeccli in
```
all-in-one:
```sh
git clone https://github.com/majo418/codec codec; cd codec; ./codeccli in
```
## use
```sh
codeccli start <NAME> <START_PORT> <PORT_COUNT> # starts a new container
codeccli pass <NAME> # change the password of a container
```
## debug
```sh
codeccli list # show list of container volumes
codeccli logs <NAME> # show systemd and codec service logs of a container
```
## stop
```sh
codeccli close <NAME> # stop and remove the container
codeccli reset <NAME> # reset all files in /codec/mounts and /codec/.codec
codeccli delete <NAME> # delete all persistent container files
```

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


