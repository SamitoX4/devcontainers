#!/bin/bash
set -e

echo 'export PATH=$PATH:$HOME/.local/bin' >> ~/.bashrc
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> ~/.bashrc
echo 'export ANDROID_SDK_ROOT=/usr/local/android-sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/bin:$ANDROID_SDK_ROOT/platform-tools' >> ~/.bashrc
echo 'export PATH=$PATH:/opt/kotlinc/bin' >> ~/.bashrc
