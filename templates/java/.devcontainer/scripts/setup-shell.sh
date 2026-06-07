#!/bin/bash
set -e
REMOTE_USER="${REMOTE_USER:-developer}"
USER_HOME="/home/${REMOTE_USER}"

echo 'export PATH=$PATH:$HOME/.local/bin' >> "${USER_HOME}/.bashrc"
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> "${USER_HOME}/.bashrc"
echo 'export MAVEN_HOME=/opt/maven' >> "${USER_HOME}/.bashrc"
echo 'export PATH=$PATH:$MAVEN_HOME/bin:$JAVA_HOME/bin' >> "${USER_HOME}/.bashrc"
