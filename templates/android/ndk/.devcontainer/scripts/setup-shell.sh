#!/bin/bash
set -e

echo 'export PATH=$PATH:$HOME/.local/bin' >> ~/.bashrc
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> ~/.bashrc
echo 'export ANDROID_SDK_ROOT=/usr/local/android-sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/bin:$ANDROID_SDK_ROOT/platform-tools' >> ~/.bashrc
echo 'export NDK_HOME=$ANDROID_SDK_ROOT/ndk/26.1.10909125' >> ~/.bashrc
echo 'export PATH=$PATH:$NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin' >> ~/.bashrc
