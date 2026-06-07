ARG POSTGRES_CLIENT_VERSION=16
FROM python:3.12
__SECURITY_ARGS__
ENV REMOTE_USER=${REMOTE_USER}
ENV REMOTE_PASSWORD=${REMOTE_PASSWORD}
ENV CONTAINER_PASSWORD=${CONTAINER_PASSWORD}
ENV SUDO_MODE=${SUDO_MODE}

ENV POSTGRES_CLIENT_VERSION=${POSTGRES_CLIENT_VERSION}

RUN apt-get update && apt-get install -y passwd sudo postgresql-client

RUN echo "root:${CONTAINER_PASSWORD}" | chpasswd

RUN if [ "${REMOTE_USER}" != "root" ] && ! id "${REMOTE_USER}" &>/dev/null; then \
        useradd -m -s /bin/bash "${REMOTE_USER}"; \
    fi && \
    if [ "${REMOTE_USER}" != "root" ]; then \
        echo "${REMOTE_USER}:${REMOTE_PASSWORD}" | chpasswd; \
    fi

RUN if [ "${SUDO_MODE}" != "none" ] && [ "${REMOTE_USER}" != "root" ]; then \
        if [ "${SUDO_MODE}" = "nopasswd" ]; then \
            echo "${REMOTE_USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${REMOTE_USER}; \
        else \
            echo "${REMOTE_USER} ALL=(ALL) ALL" > /etc/sudoers.d/${REMOTE_USER}; \
        fi && \
        chmod 0440 /etc/sudoers.d/${REMOTE_USER}; \
    fi

COPY --chown=root:root ./scripts/install-system-packages.sh /tmp/install-system-packages.sh
RUN chmod +x /tmp/install-system-packages.sh && /tmp/install-system-packages.sh && rm /tmp/install-system-packages.sh

COPY --chown=root:root ./scripts/install-shared.sh /tmp/install-shared.sh
RUN chmod +x /tmp/install-shared.sh && /tmp/install-shared.sh && rm /tmp/install-shared.sh

COPY --chown=root:root ./scripts/setup-shell.sh /root/setup-shell.sh
RUN chmod +x /root/setup-shell.sh && /root/setup-shell.sh

WORKDIR /workspace
