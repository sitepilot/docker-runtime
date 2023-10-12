FROM ubuntu:22.04

LABEL maintainer="@sitepilot"

ENV DEBIAN_FRONTEND="noninteractive" \
    APP_DIR=/app \
    APP_LOGS_DIR=/app/logs \
    APP_FILES_DIR=/app/files \
    APP_CONFIG_DIR=/app/config \
    RUNTIME_UID=1000 \
    RUNTIME_GID=1000 \
    RUNTIME_USER=app \
    RUNTIME_GROUP=app \
    RUNTIME_DIR=/runtime \
    RUNTIME_BIN_DIR=/runtime/bin \
    RUNTIME_INC_DIR=/runtime/inc \
    RUNTIME_RUN_DIR=/runtime/run \
    RUNTIME_LOGS_DIR=/runtime/logs \
    RUNTIME_TEMPLATES_DIR=/runtime/templates \
    RUNTIME_COMMAND_DIR=/runtime/command.d \
    RUNTIME_ENTRYPOINT_DIR=/runtime/entrypoint.d

ADD ./rootfs/runtime/bin/install $RUNTIME_BIN_DIR/install

RUN $RUNTIME_BIN_DIR/install j2cli; \
    groupadd -r -g ${RUNTIME_GID} ${RUNTIME_GROUP}; \
    useradd --no-log-init -r -s /usr/bin/bash -m -d ${APP_DIR} -u ${RUNTIME_UID} -g ${RUNTIME_GID} ${RUNTIME_USER}

COPY rootfs /

RUN $RUNTIME_BIN_DIR/finalize

USER $RUNTIME_UID

WORKDIR $APP_DIR

ENTRYPOINT ["/runtime/bin/entrypoint"]

CMD ["/runtime/bin/command"]
