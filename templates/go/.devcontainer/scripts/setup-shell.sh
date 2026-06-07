#!/bin/bash
set -e
REMOTE_USER="${REMOTE_USER:-developer}"
USER_HOME="/home/${REMOTE_USER}"

echo 'export PATH=$PATH:$HOME/.local/bin' >> "${USER_HOME}/.bashrc"
echo 'export GOROOT=/usr/local/go' >> "${USER_HOME}/.bashrc"
echo 'export GOPATH=/root/go' >> "${USER_HOME}/.bashrc"
echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> "${USER_HOME}/.bashrc"
