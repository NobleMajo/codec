#!/bin/bash
###
### CODEC
###
### This file gets executed the first the codec container starts.
### Its before a inteactive bash session or the code-server is started.
###

### create workspace folder
mkdir -p /home/codec/ws/test
mkdir -p /home/codec/ws/old
mkdir -p /home/codec/ws/main

### setup credentails
#GIT_USERNAME="majo418"
#GIT_EMAIL="majo@coreunit.net"
#git config --global user.name "$GIT_USERNAME"
#git config --global user.email "$GIT_EMAIL"

### setup rsa key
#rm -rf /home/codec/.ssh
#ln -s /home/codec/ws/.codec/id /home/codec/.ssh
#if [ ! -f ~/.ssh/id_rsa ]; then
#    rm -rf ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
#    ssh-keygen -t rsa -b 4096 -C "$GIT_EMAIL" -f "/home/codec/.ssh/id_rsa" -N ""
#fi

### Starts the docker daemon in the background
#screen -dm \
#    -S dockerd \
#    -L -Logfile "/home/codec/ws/.codec/logs/dockerd_$(date +"%m_%H_%d_%m_%Y").log" \
#    -s bash \
#    bash -c dockerd

### VS Code Extensions (recommended)

### ### THEMES
codei thiagolciobittencourt.ubuntuvscode
#codei github.github-vscode-theme
#codei futureglobe.redneon
#codei akamud.vscode-theme-onedark
#codei zhuangtongfa.material-theme
#codei johnpapa.winteriscoming
#codei monokai.theme-monokai-pro-vscode

### ### ICONS
codei vscode-icons-team.vscode-icons
#codei pkief.material-icon-theme
#codei be5invis.vscode-icontheme-nomo-dark
#codei jamesmaj.easy-icons

### ### REMOTE
#codei ms-vscode-remote.remote-ssh
#codei ms-vscode-remote.remote-containers
#codei ms-vscode-remote.remote-wsl
#codei ms-vscode-remote.remote-ssh-edit
#codei ms-vscode-remote.vscode-remote-extensionpack

### ### GIT
#codei eamodio.gitlens
#codei donjayamanne.githistory
#codei mhutchie.git-graph

### ### GITHUB
#codei github.vscode-pull-request-github
#codei knisterpeter.vscode-github
#codei github.copilot

### ### GITLAB
#codei gitlab.gitlab-workflow
#codei jasonn-porch.gitlab-mr
#codei logerfo.gitlab-notifications
#codei cstuder.gitlab-ci-validator
#codei jyee721.gitlab-snippets
#codei balazs4.gitlab-pipeline-monitor

### ### DOCKER
#codei ms-azuretools.vscode-docker
#codei formulahendry.docker-explorer

### ### TODO
#codei gruntfuggly.todo-tree
#codei wayou.vscode-todo-highlight

### ### DRAWING AND DIAGRAMS
#codei hediet.vscode-drawio
#codei theumletteam.umlet
#codei tyriar.luna-paint

### ### JavaScript
#codei mgmcdermott.vscode-language-babel
#codei xabikos.javascriptsnippets

### ### TypeScript
#codei rbbit.typescript-hero
#codei ms-vscode.vscode-typescript-next
#codei pmneo.tsimporter
#codei myxvisual.vscode-ts-uml

### ### Java
#codei vscjava.vscode-java-pack
#codei vscjava.vscode-java-debug
#codei vscjava.vscode-maven
#codei vscjava.vscode-java-test
#codei vscjava.vscode-java-dependency
#codei redhat.java

### ### MARKDOWN
#codei yzhang.markdown-all-in-one
#codei yzane.markdown-pdf
#codei bierner.markdown-preview-github-styles

### ### HTML
#codei formulahendry.auto-rename-tag
#codei formulahendry.auto-close-tag
#codei abusaidm.html-snippets
#codei tht13.html-preview-vscode

### ### CSS
#codei zignd.html-css-class-completion
#codei ecmel.vscode-html-css

### ### SCSS
#codei sibiraj-s.vscode-scss-formatter
#codei gencer.html-slim-scss-css-class-completion

### ### SASS
#codei syler.sass-indented
#codei ritwickdey.live-sass

### ### LATEX
#codei james-yu.latex-workshop

### ### PHP
#codei xdebug.php-debug
#codei bmewburn.vscode-intelephense-client
#codei xdebug.php-pack

### ### C_SHARP
#codei ms-dotnettools.csharp

