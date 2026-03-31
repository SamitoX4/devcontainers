#!/bin/bash
set -e

echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
echo 'export GOPATH=/root/go' >> ~/.bashrc
echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> ~/.bashrc
