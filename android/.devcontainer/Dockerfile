ARG VARIANT=22-bullseye
FROM node:${VARIANT}

ARG NODE_MAJOR_VERSION=${VARIANT%%-*}

RUN apt-get update && apt-get install -y passwd

# Establecer contraseña para root
# RUN echo 'root:mi_password_segura' | chpasswd

# Instalación de paquetes base
COPY --chown=root:root ./scripts/install-system-packages.sh /tmp/install-system-packages.sh
RUN chmod +x /tmp/install-system-packages.sh && /tmp/install-system-packages.sh && rm /tmp/install-system-packages.sh

# NVM
COPY --chown=node:node ./scripts/install-nvm.sh /home/node/install-nvm.sh
RUN chmod +x /home/node/install-nvm.sh

USER node
RUN NODE_MAJOR_VERSION=$NODE_MAJOR_VERSION /home/node/install-nvm.sh

# Paquetes globales de Node
COPY --chown=node:node ./scripts/install-global-packages.sh /home/node/install-global-packages.sh
RUN chmod +x /home/node/install-global-packages.sh && /home/node/install-global-packages.sh

USER root

# Android SDK
COPY --chown=root:root ./scripts/install-android.sh /tmp/install-android.sh
RUN chmod +x /tmp/install-android.sh && /tmp/install-android.sh && rm /tmp/install-android.sh
ENV ANDROID_SDK_ROOT=/usr/local/android-sdk
ENV PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/bin:$ANDROID_SDK_ROOT/platform-tools"

# Herramientas adicionales (gcloud, git-filter-repo, doppler)
COPY --chown=root:root ./scripts/install-gcloud.sh /tmp/
COPY --chown=root:root ./scripts/install-git-filter-repo.sh /tmp/
COPY --chown=root:root ./scripts/install-doppler.sh /tmp/
RUN chmod +x /tmp/install-*.sh && \
    /tmp/install-gcloud.sh && \
    /tmp/install-git-filter-repo.sh && \
    /tmp/install-doppler.sh && \
    rm /tmp/install-*.sh

USER node

# Herramientas adicionales (gcloud, git-filter-repo, doppler)
COPY --chown=node:node ./scripts/install-opencode.sh /tmp/
COPY --chown=node:node ./scripts/install-claude-ai.sh /tmp/
RUN chmod +x /tmp/install-*.sh && \
    /tmp/install-opencode.sh && \
    /tmp/install-claude-ai.sh && \
    rm /tmp/install-*.sh

USER root

# Limpieza final (si no se hizo en los scripts)
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Configuración de shell
COPY --chown=node:node ./scripts/setup-shell.sh /home/node/setup-shell.sh
RUN chmod +x /home/node/setup-shell.sh
USER node
RUN /home/node/setup-shell.sh

USER root

WORKDIR /workspace