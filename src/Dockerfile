FROM ubuntu:22.04

ARG TARGETARCH
ARG DOCKERIZE_VERSION=v0.7.0

LABEL maintainer="@sitepilot"

ENV DEBIAN_FRONTEND="noninteractive" \
    RUNTIME_UID=1000 \
    RUNTIME_GID=1000 \
    RUNTIME_USER=app \
    RUNTIME_GROUP=app \
    RUNTIME_PASSWORD="" \
    RUNTIME_LOG_LEVEL=1 \
    RUNTIME_DIR=/runtime \
    RUNTIME_WORKDIR=/app \
    RUNTIME_BIN_DIR=/runtime/bin \
    RUNTIME_INC_DIR=/runtime/inc \
    RUNTIME_RUN_DIR=/runtime/run \
    RUNTIME_LOGS_DIR=/runtime/logs \
    RUNTIME_TEMPLATES_DIR=/runtime/templates \
    RUNTIME_ENTRYPOINT_DIR=/runtime/entrypoint.d \
    RUNTIME_BOOTED_FILE=/runtime/booted

ENV PATH="$PATH:$RUNTIME_BIN_DIR"

ADD rootfs/runtime/bin/rt-install $RUNTIME_BIN_DIR/rt-install

RUN rt-install curl wget nano ca-certificates \
    && groupadd -r -g ${RUNTIME_GID} ${RUNTIME_GROUP} \
    && useradd --no-log-init -r -s /usr/bin/bash -m -d ${RUNTIME_WORKDIR} -u ${RUNTIME_UID} -g ${RUNTIME_GID} ${RUNTIME_USER} \
    && wget -O - https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-$TARGETARCH-$DOCKERIZE_VERSION.tar.gz | tar xzf - -C /usr/local/bin

COPY --chown=$RUNTIME_UID:$RUNTIME_GID rootfs /

USER $RUNTIME_UID

WORKDIR $RUNTIME_WORKDIR

ENTRYPOINT ["runtime"]
