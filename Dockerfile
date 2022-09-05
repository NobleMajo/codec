FROM docker:dind-rootless as dind

FROM ubuntu:22.04

LABEL version="1.0" maintainer="Majo Richter <majo418@coreunit.net>"

ARG NODE_VERSION=16
ARG NPM_VERSION=8
ARG VSCODE_VERSION=4.6.1
ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i "s/# deb-src/deb-src/g" /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -yq --no-install-recommends apt-utils \
    && apt-get full-upgrade -y \
    && apt-get autoremove -y \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf \
    /var/lib/apt/lists/* \
    /var/cache/apk/* \
    /tmp/*

RUN apt-get update \
    \
    && apt-get install -y --no-install-recommends \
    sudo bash adduser systemctl git curl nano locales \
    && locale-gen "en_IN.UTF-8" \
    \
    && apt-get install -y --no-install-recommends \
    systemd systemd-cron screen rsyslog \
    && cd /lib/systemd/system/sysinit.target.wants/ \
    && ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1 \
    && rm -f \
    /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/basic.target.wants/* \
    /lib/systemd/system/anaconda.target.wants/* \
    /lib/systemd/system/plymouth* \
    /lib/systemd/system/systemd-update-utmp* \
    /lib/systemd/system/systemd*udev* \
    /lib/systemd/system/getty.target \
    \
    && apt-get install -y nodejs npm \
    && npm i -g n@latest \
    && n $NODE_VERSION \ 
    && export PATH="/usr/local/bin/node:$PATH" \
    && npm i -g npm@$NPM_VERSION \
    && npm i -g nodemon@latest \
    && npm up -g \ 
    \
    && apt-get install -y --no-install-recommends \
    gnupg lxc apt-transport-https ca-certificates \
    openssh-client software-properties-common \
    && curl -fsSL https://get.docker.com | sh -s -- \
    \
    && curl -fsSL https://code-server.dev/install.sh | sh -s -- --version=$VSCODE_VERSION \
    \
    && apt-get autoremove -y \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache \
    && rm -rf /root/.npm \
    && rm -rf /tmp/*

RUN echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf \
    && sysctl -p \
    && echo -n "PATH=\"/codec/.codec/bin:/usr/local/bin/node:$PATH\"" > /etc/environment \
    && chmod +x /etc/environment \
    && echo "source /etc/codec/bash.sh" >> /root/.bashrc \
    && usermod --shell /bin/bash root \
    && systemctl disable lxc-net.service \
    && systemctl disable lxc-monitord.service \
    && systemctl disable lxc.service \
    && systemctl disable containerd.service \
    && systemctl disable docker.socket \
    && systemctl disable docker.service \
    && systemctl disable code-server@root

EXPOSE 8080/tcp

COPY --from=dind /usr/local/bin/ /usr/local/bin/
COPY system /etc/codec

RUN cp /etc/codec/bin/* /usr/local/bin/ \
    && mkdir -p /etc/docker \
    && cp /etc/codec/deamon.json /etc/docker/daemon.json \
    && mkdir -p /usr/lib/systemd/system/ \
    && cp /etc/codec/codec.service /usr/lib/systemd/system/ \
    && cp /etc/codec/vscode.service /usr/lib/systemd/system/ \
    && systemctl enable codec.service \
    && export VSCODE_GALLERY=ms2 \
    && /etc/codec/vscode_gallery.js \
    && codei vscode-icons-team.vscode-icons thiagolciobittencourt.ubuntuvscode

CMD ["/lib/systemd/systemd"]
