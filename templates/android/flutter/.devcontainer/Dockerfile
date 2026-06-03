FROM ubuntu:24.04

# Build arguments for version customization
ARG ANDROID_API_LEVEL=34
ARG BUILD_TOOLS_VERSION=34.0.0
ARG NDK_VERSION=26.1.10909125
ARG CMDLINE_TOOLS_VERSION=7302050_latest
ARG FLUTTER_BRANCH=stable

# Expose as environment variables so scripts can read them
ENV ANDROID_API_LEVEL=${ANDROID_API_LEVEL}
ENV BUILD_TOOLS_VERSION=${BUILD_TOOLS_VERSION}
ENV NDK_VERSION=${NDK_VERSION}
ENV CMDLINE_TOOLS_VERSION=${CMDLINE_TOOLS_VERSION}
ENV FLUTTER_BRANCH=${FLUTTER_BRANCH}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y passwd

RUN echo "root:root" | chpasswd

COPY --chown=root:root ./scripts/install-system-packages.sh /tmp/install-system-packages.sh
RUN chmod +x /tmp/install-system-packages.sh && /tmp/install-system-packages.sh && rm /tmp/install-system-packages.sh

COPY --chown=root:root ./scripts/install-android.sh /tmp/install-android.sh
RUN chmod +x /tmp/install-android.sh && /tmp/install-android.sh && rm /tmp/install-android.sh

COPY --chown=root:root ./scripts/install-flutter.sh /tmp/install-flutter.sh
RUN chmod +x /tmp/install-flutter.sh && /tmp/install-flutter.sh && rm /tmp/install-flutter.sh

COPY --chown=root:root ./scripts/install-shared.sh /tmp/install-shared.sh
RUN chmod +x /tmp/install-shared.sh && /tmp/install-shared.sh && rm /tmp/install-shared.sh

COPY --chown=root:root ./scripts/setup-shell.sh /root/setup-shell.sh
RUN chmod +x /root/setup-shell.sh && /root/setup-shell.sh

WORKDIR /workspace
