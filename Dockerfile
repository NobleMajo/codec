FROM majo418/ubuntudind:latest

LABEL version="0.3" maintainer="Majo Richter <majo@coreunit.net>"

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root
USER root

# unminimize
RUN apt-get update && \
    apt-get install -yq apt-utils && \
    yes | unminimize - && \
    sed -i "s/# deb-src/deb-src/g" /etc/apt/sources.list

# unluck full ubuntu and upgrade it
RUN apt-get update && \
    apt-get full-upgrade -y

# install ubuntu basics
RUN apt-get install -y \
    sudo bash adduser \
    nano vim git wget curl screen iptables supervisor \
    ca-certificates openssh-client apt-transport-https \
    gnupg software-properties-common

# install docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce

# install node and npm
RUN apt-get install -y nodejs npm

# install node@16 and npm@latest
RUN npm i -g n@latest && \
    n 16 && \ 
    PATH="/usr/local/bin/node:$PATH" \
    npm i -g npm@latest && \
    npm i -g nodemon@latest && \
    npm up -g
# export PATH="$PATH" && \

# setup "codec" user
RUN chmod -R 770 /root && \
    chown -hR root:sudo /root && \
    passwd -d root && \
    groupadd -g 10000 codec && \
    useradd -o \
        -mk /etc/skel \
        -d /home/codec \
        -s /bin/bash \
        -u 0 \
        -g 0 \
        -c "Default codec user" \
        codec \
    && \
    usermod -G root codec && \
    usermod -G sudo codec && \
    usermod -G codec codec && \
    chmod -R 770 /home/codec && \
    chown -hR codec:codec /home/codec && \
    passwd -d codec && \
    su codec && \
    mkdir -p /home/codec/ws/.codec/bin && \
    mkdir -p /home/codec/.bin

WORKDIR /home/codec
USER codec

# add bin folders, set bashinit.sh and set codec as sudo user
RUN echo -n "\nPATH=\"/home/codec/ws/.codec/bin:/home/codec/.bin:\$PATH\"" >> /home/codec/.bashrc && \
    echo -n "\nsource /home/codec/ws/.codec/bashinit.sh" >> /home/codec/.bashrc && \
    echo -n "\ncodec     ALL=(ALL:ALL) ALL\n" >> /etc/sudoers

# install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh && \
    code-server \
    --force \
    --install-extension \
    pkief.material-icon-theme

# prepare for startup
COPY ./scripts/docker-entrypoint.sh /docker-entrypoint.sh
COPY ./scripts/code-server.sh /code-server.sh
COPY ./skel /home/codec/.codec-skel
RUN chmod -R 700 /docker-entrypoint.sh && \
    chown -hR codec:codec /docker-entrypoint.sh && \
    chmod -R 700 /code-server.sh && \
    chown -hR codec:codec /code-server.sh && \
    chmod 770 /usr/lib/code-server/bin/code-server && \
    mkdir -p /home/code/ws/.codec/userdata && \
    mkdir -p /home/code/ws/.codec/extensions && \
    mkdir -p /home/code/ws/.codec/certs && \
    rm -rf /home/codec/.config/code-server/config.yaml && \
    touch /home/codec/ws/.codec/boot.sh && \
    chmod 700 /home/codec/ws/.codec/boot.sh

# set mount volume
VOLUME /home/codec/ws

# set export ports
EXPOSE 8080/tcp

CMD [ "/docker-entrypoint.sh" ]







