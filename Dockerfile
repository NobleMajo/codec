FROM ubuntu:24.04

LABEL version="2.5" maintainer="NobleMajo (Majo Richter) <majo@coreunit.net>"

EXPOSE 8080/tcp

ENV NVM_VERSION "0.40.0"
ENV NVM_URL "https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh"
ENV NODE_VERSION "20"
ENV NPM_VERSION "10"
ENV NODEMON_VERSION "3"
ENV VSCODE_VERSION "4.91.1"
ENV VSCODE_URL "https://code-server.dev/install.sh"

ENV VSCODE_GALLERY "ms2"
ENV NVM_DIR "/root/.nvm"
ENV DEBIAN_FRONTEND noninteractive
ENV LANG "en_US.UTF-8"
ENV LANGUAGE "en"
ENV LC_CTYPE "en_US.UTF-8"
ENV LC_NUMERIC "en_US.UTF-8"
ENV LC_TIME "en_US.UTF-8"
ENV LC_COLLATE "en_US.UTF-8"
ENV LC_MONETARY "en_US.UTF-8"
ENV LC_MESSAGES "en_US.UTF-8"
ENV LC_PAPER "en_US.UTF-8"
ENV LC_NAME "en_US.UTF-8"
ENV LC_ADDRESS "en_US.UTF-8"
ENV LC_TELEPHONE "en_US.UTF-8"
ENV LC_MEASUREMENT "en_US.UTF-8"
ENV LC_IDENTIFICATION "en_US.UTF-8"
ENV LC_ALL "en_US.UTF-8"
ENV L "us"

RUN sed -i "s/# deb-src/deb-src/g" /etc/apt/sources.list \
    && apt-get update \
    && echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections \
    && echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections \
    && apt-get install -yq --no-install-recommends \
    apt-utils locales tzdata libtimedate-perl ca-certificates \
    && sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen \
    && locale-gen \
    && apt-get full-upgrade -y \
    \
    && apt-get install -y --no-install-recommends \
    sudo bash adduser systemctl lbzip2 locales lsof \
    && apt-get install -y --no-install-recommends \
    curl wget tar git nano vim git-lfs \
    && apt-get install -y --no-install-recommends \
    systemd systemd-cron rsyslog dnsutils \
    && git lfs install \
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
    && apt-get autoremove -y \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /var/cache/apk/* \
        /tmp/*

COPY system /etc/codec

RUN curl -o- $NVM_URL |bash \
    && [ -s "$NVM_DIR/nvm.sh" ] \
    && . "$NVM_DIR/nvm.sh" \
    && . "$NVM_DIR/bash_completion" \
    && npm i -g npm@$NPM_VERSION \
    && npm i -g nodemon@$NODEMON_VERSION \
    && chmod 775 /etc/environment \
    && echo -n "PATH=\"/codec/.codec/bin:$PATH\"" > /etc/environment \
    \
    && curl -fsSL $VSCODE_URL | sh -s -- --version=$VSCODE_VERSION \
    && systemctl disable code-server@root \
    \
    && cp /etc/codec/bin/* /usr/local/bin/ \
    && mkdir -p /etc/docker \
    && cp /etc/codec/deamon.json /etc/docker/daemon.json \
    && mkdir -p /usr/lib/systemd/system/ \
    && cp /etc/codec/codec.service /usr/lib/systemd/system/ \
    && cp /etc/codec/vscode.service /usr/lib/systemd/system/ \
    && systemctl enable codec.service \
    && . /etc/environment \
    && VSCODE_GALLERY="$VSCODE_GALLERY" /etc/codec/vscode_gallery.js \
    && codei emmanuelbeziat.vscode-great-icons \
    \
    && /etc/codec/health.sh \
    \
    && echo "source /etc/codec/bash.sh" >> /root/.bashrc \
    && usermod --shell /bin/bash root \
    && echo fs.inotify.max_user_watches=262144 | tee -a /etc/sysctl.conf \
    && sysctl -p \
    \
    && npm cache clean --force \
    && apt-get autoremove -y \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /var/cache/apk/* \
        /tmp/*

CMD ["/lib/systemd/systemd"]
