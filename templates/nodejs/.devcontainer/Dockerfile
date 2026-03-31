ARG VARIANT=22-bullseye
FROM node:${VARIANT}

RUN apt-get update && apt-get install -y passwd

RUN echo "root:node" | chpasswd

COPY --chown=root:root ./scripts/install-system-packages.sh /tmp/install-system-packages.sh
RUN chmod +x /tmp/install-system-packages.sh && /tmp/install-system-packages.sh && rm /tmp/install-system-packages.sh

COPY --chown=root:root ./scripts/install-shared.sh /tmp/install-shared.sh
RUN chmod +x /tmp/install-shared.sh && /tmp/install-shared.sh && rm /tmp/install-shared.sh

COPY --chown=node:node ./scripts/install-nvm.sh /home/node/install-nvm.sh
RUN chmod +x /home/node/install-nvm.sh

USER node
RUN NODE_MAJOR_VERSION=22 /home/node/install-nvm.sh

COPY --chown=node:node ./scripts/install-global-packages.sh /home/node/install-global-packages.sh
RUN chmod +x /home/node/install-global-packages.sh && /home/node/install-global-packages.sh

USER root

COPY --chown=node:node ./scripts/setup-shell.sh /home/node/setup-shell.sh
RUN chmod +x /home/node/setup-shell.sh
USER node
RUN /home/node/setup-shell.sh

USER root

WORKDIR /workspace
