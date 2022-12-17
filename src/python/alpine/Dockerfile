# syntax=docker/dockerfile:1
FROM python:3.11.1-alpine3.17 as base



# ---------- BUILD-ARGUMENTS
ARG IMAGE_MAINTAINER
ARG IMAGE_VENDOR
ARG LICENSE

ARG SCHEMA_VERSION
ARG VCS_REF
ARG VCS_URL
ARG BUILD_DATE

ARG IMAGE_NAME
ARG IMAGE_VERSION
ARG IMAGE_ARCHITECTURE
ARG IMAGE_DESCRIPTION
ARG IMAGE_USAGE
ARG IMAGE_URL
ARG OS_NAME
ARG OS_VERSION
ARG KERNEL_VERSION

ARG DOCKER_CMD
ARG DOCKER_CMD_DEVEL
ARG DOCKER_CMD_TEST
ARG DOCKER_CMD_DEBUG
ARG DOCKER_CMD_HELP
ARG DOCKER_PARAMS



# ---------- LABELS
LABEL maintainer=${IMAGE_MAINTAINER}
LABEL vendor=${IMAGE_VENDOR}
LABEL org.label-schema.license=${LICENSE}

LABEL org.label-schema.schema-version=${SCHEMA_VERSION}
LABEL org.label-schema.vcs-ref=${VCS_REF}
LABEL org.label-schema.vcs-url=${VCS_URL}
LABEL org.label-schema.build-date=${BUILD_DATE}

LABEL org.label-schema.name=${IMAGE_NAME}
LABEL org.label-schema.version=${IMAGE_VERSION}
LABEL org.label-schema.architecture=${IMAGE_ARCHITECTURE}
LABEL org.label-schema.description=${IMAGE_DESCRIPTION}
LABEL org.label-schema.usage=${IMAGE_USAGE}
LABEL org.label-schema.url=${IMAGE_URL}
LABEL org.label-schema.os-name=${OS_NAME}
LABEL org.label-schema.os-version=${OS_VERSION}
LABEL org.label-schema.kernel-version=${KERNEL_VERSION}

LABEL org.label-schema.docker.cmd=${DOCKER_CMD}
LABEL org.label-schema.docker.cmd.devel=${DOCKER_CMD_DEVEL}
LABEL org.label-schema.docker.cmd.test=${DOCKER_CMD_TEST}
LABEL org.label-schema.docker.cmd.debug=${DOCKER_CMD_DEBUG}
LABEL org.label-schema.docker.cmd.help=${DOCKER_CMD_HELP}
LABEL org.label-schema.docker.params=${DOCKER_PARAMS}


# ---------- GROUNDWORK
WORKDIR /code
RUN addgroup python && \
    adduser -h /code -G python -s /bin/bash -S python && \
    chown -R python .



# ---------- MAIN
USER python
CMD python
HEALTHCHECK CMD [ "python --version" ]
