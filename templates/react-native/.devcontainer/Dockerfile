ARG VARIANT=22-bullseye
FROM node:${VARIANT}

RUN apt-get update && apt-get install -y passwd

RUN echo "root:node" | chpasswd

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
RUN NODE_MAJOR_VERSION=22 /home/node/install-nvm.sh

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
