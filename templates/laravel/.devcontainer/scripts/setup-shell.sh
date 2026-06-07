#!/bin/bash
set -e
REMOTE_USER="${REMOTE_USER:-developer}"
USER_HOME="/home/${REMOTE_USER}"

echo 'export PATH=$PATH:$HOME/.local/bin' >> "${USER_HOME}/.bashrc"
