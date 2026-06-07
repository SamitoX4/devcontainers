#!/bin/bash
set -e
REMOTE_USER="${REMOTE_USER:-developer}"
USER_HOME="/home/${REMOTE_USER}"

echo 'export PATH=$PATH:$HOME/.local/bin' >> "${USER_HOME}/.bashrc"
echo 'export CARGO_HOME=/usr/local/cargo' >> "${USER_HOME}/.bashrc"
echo 'export RUSTUP_HOME=/usr/local/rustup' >> "${USER_HOME}/.bashrc"
echo 'export PATH=$PATH:$CARGO_HOME/bin:$RUSTUP_HOME/bin' >> "${USER_HOME}/.bashrc"
