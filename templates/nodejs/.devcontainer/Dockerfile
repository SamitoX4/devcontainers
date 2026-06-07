ARG VARIANT=22-bullseye
ARG NODE_MAJOR_VERSION=22
FROM node:${VARIANT}
__SECURITY_ARGS__
ENV REMOTE_USER=${REMOTE_USER}
ENV REMOTE_PASSWORD=${REMOTE_PASSWORD}
ENV CONTAINER_PASSWORD=${CONTAINER_PASSWORD}
ENV SUDO_MODE=${SUDO_MODE}

ENV NODE_MAJOR_VERSION=${NODE_MAJOR_VERSION}

# The user `node` already exists, just configure password and sudo
RUN echo "root:${CONTAINER_PASSWORD}" | chpasswd && \
    echo "node:${REMOTE_PASSWORD}" | chpasswd

RUN if [ "${SUDO_MODE}" != "none" ]; then \
        if [ "${SUDO_MODE}" = "nopasswd" ]; then \
            echo "node ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/node; \
        else \
            echo "node ALL=(ALL) ALL" > /etc/sudoers.d/node; \
        fi && \
        chmod 0440 /etc/sudoers.d/node; \
    fi

COPY --chown=root:root ./scripts/install-system-packages.sh /tmp/install-system-packages.sh
RUN chmod +x /tmp/install-system-packages.sh && /tmp/install-system-packages.sh && rm /tmp/install-system-packages.sh

COPY --chown=root:root ./scripts/install-shared.sh /tmp/install-shared.sh
RUN chmod +x /tmp/install-shared.sh && /tmp/install-shared.sh && rm /tmp/install-shared.sh

COPY --chown=node:node ./scripts/install-nvm.sh /home/node/install-nvm.sh
RUN chmod +x /home/node/install-nvm.sh

USER node
RUN /home/node/install-nvm.sh

COPY --chown=node:node ./scripts/install-global-packages.sh /home/node/install-global-packages.sh
RUN chmod +x /home/node/install-global-packages.sh && /home/node/install-global-packages.sh

USER root

COPY --chown=node:node ./scripts/setup-shell.sh /home/node/setup-shell.sh
RUN chmod +x /home/node/setup-shell.sh
USER node
RUN /home/node/setup-shell.sh

USER root

WORKDIR /workspace
