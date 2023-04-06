#!/bin/bash

if ! pgrep "ssh-agent" > /dev/null; then
  rm -rf "$HOME/.ssh-agent-env"
fi

if [ ! -f "$HOME/.ssh-agent-env" ]; then
  ssh-agent -s > "$HOME/.ssh-agent-env"
  sed -i '/^echo/d' "$HOME/.ssh-agent-env"
fi

source "$HOME/.ssh-agent-env"