#!/bin/bash
set -e

echo 'export PATH=$PATH:$HOME/.local/bin' >> ~/.bashrc
echo 'export CARGO_HOME=/usr/local/cargo' >> ~/.bashrc
echo 'export RUSTUP_HOME=/usr/local/rustup' >> ~/.bashrc
echo 'export PATH=$PATH:$CARGO_HOME/bin:$RUSTUP_HOME/bin' >> ~/.bashrc
