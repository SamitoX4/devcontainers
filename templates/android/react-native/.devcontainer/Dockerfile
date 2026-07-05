ARG VARIANT=22-bookworm
FROM node:${VARIANT}
__SECURITY_ARGS__
ENV REMOTE_USER=${REMOTE_USER}
ENV REMOTE_PASSWORD=${REMOTE_PASSWORD}
ENV CONTAINER_PASSWORD=${CONTAINER_PASSWORD}
ENV SUDO_MODE=${SUDO_MODE}

# Build arguments for version customization
ARG NODE_MAJOR_VERSION=22
ARG ANDROID_API_LEVEL=34
ARG BUILD_TOOLS_VERSION=34.0.0
ARG NDK_VERSION=26.1.10909125
ARG CMDLINE_TOOLS_VERSION=7302050_latest

# Expose as environment variables so scripts can read them
ENV NODE_MAJOR_VERSION=${NODE_MAJOR_VERSION}
ENV ANDROID_API_LEVEL=${ANDROID_API_LEVEL}
ENV BUILD_TOOLS_VERSION=${BUILD_TOOLS_VERSION}
ENV NDK_VERSION=${NDK_VERSION}
ENV CMDLINE_TOOLS_VERSION=${CMDLINE_TOOLS_VERSION}
ENV DEBIAN_FRONTEND=noninteractive

# The user `node` already exists, just configure password and sudo
RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*

RUN awk 'BEGIN{print "root:" ENVIRON["CONTAINER_PASSWORD"]}' | chpasswd && \
    awk 'BEGIN{print "node:" ENVIRON["REMOTE_PASSWORD"]}' | chpasswd

RUN if [ "${SUDO_MODE}" != "none" ]; then \
        mkdir -p /etc/sudoers.d; \
        if [ "${SUDO_MODE}" = "nopasswd" ]; then \
            echo "node ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/node; \
        else \
            echo "node ALL=(ALL) ALL" > /etc/sudoers.d/node; \
        fi && \
        chmod 0440 /etc/sudoers.d/node; \
    fi

COPY --chown=root:root ./scripts/install-system-packages.sh /tmp/install-system-packages.sh
RUN chmod +x /tmp/install-system-packages.sh && /tmp/install-system-packages.sh && rm /tmp/install-system-packages.sh

COPY --chown=root:root ./scripts/install-android.sh /tmp/install-android.sh
RUN chmod +x /tmp/install-android.sh && /tmp/install-android.sh && rm /tmp/install-android.sh

COPY --chown=root:root ./scripts/install-shared.sh /tmp/install-shared.sh
RUN chmod +x /tmp/install-shared.sh && /tmp/install-shared.sh && rm /tmp/install-shared.sh

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV ANDROID_SDK_ROOT=/usr/local/android-sdk
ENV PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/bin:$ANDROID_SDK_ROOT/platform-tools"

COPY --chown=node:node ./scripts/install-nvm.sh /home/node/install-nvm.sh
RUN chmod +x /home/node/install-nvm.sh

USER node
RUN /home/node/install-nvm.sh

COPY --chown=node:node ./scripts/install-global-packages.sh /home/node/install-global-packages.sh
RUN chmod +x /home/node/install-global-packages.sh && /home/node/install-global-packages.sh

USER root

COPY --chown=root:root ./scripts/configure-react-native.sh /tmp/configure-react-native.sh
RUN chmod +x /tmp/configure-react-native.sh && /tmp/configure-react-native.sh && rm /tmp/configure-react-native.sh

COPY --chown=node:node ./scripts/setup-shell.sh /home/node/setup-shell.sh
RUN chmod +x /home/node/setup-shell.sh
USER node
RUN /home/node/setup-shell.sh

USER root

WORKDIR /workspace
