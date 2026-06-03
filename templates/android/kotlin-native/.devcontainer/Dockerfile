FROM ubuntu:24.04

# Build arguments for version customization
# Users can override these when building:
#   docker compose build --build-arg ANDROID_API_LEVEL=36
ARG KOTLIN_VERSION=2.0.21
ARG ANDROID_API_LEVEL=34
ARG BUILD_TOOLS_VERSION=34.0.0
ARG NDK_VERSION=26.1.10909125
ARG CMDLINE_TOOLS_VERSION=7302050_latest

# Expose as environment variables so scripts can read them
ENV KOTLIN_VERSION=${KOTLIN_VERSION}
ENV ANDROID_API_LEVEL=${ANDROID_API_LEVEL}
ENV BUILD_TOOLS_VERSION=${BUILD_TOOLS_VERSION}
ENV NDK_VERSION=${NDK_VERSION}
ENV CMDLINE_TOOLS_VERSION=${CMDLINE_TOOLS_VERSION}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y passwd

RUN echo "root:root" | chpasswd

COPY --chown=root:root ./scripts/install-system-packages.sh /tmp/install-system-packages.sh
RUN chmod +x /tmp/install-system-packages.sh && /tmp/install-system-packages.sh && rm /tmp/install-system-packages.sh

COPY --chown=root:root ./scripts/install-android.sh /tmp/install-android.sh
RUN chmod +x /tmp/install-android.sh && /tmp/install-android.sh && rm /tmp/install-android.sh

COPY --chown=root:root ./scripts/install-shared.sh /tmp/install-shared.sh
RUN chmod +x /tmp/install-shared.sh && /tmp/install-shared.sh && rm /tmp/install-shared.sh

COPY --chown=root:root ./scripts/setup-shell.sh /root/setup-shell.sh
RUN chmod +x /root/setup-shell.sh && /root/setup-shell.sh

WORKDIR /workspace
