# syntax=docker/dockerfile:1
FROM aleroxac/python:alpine as base



# ---------- ARGS
ARG \
  IMAGE_MAINTAINER \
  IMAGE_VENDOR \
  AUTHOR_NAME \
  AUTHOR_USERNAME \
  AUTHOR_TITLE \
  AUTHOR_EMAIL \
  LICENSE \
  SCHEMA_VERSION \
  VCS_REF \
  VCS_URL \
  BUILD_DATE \
  IMAGE_NAME \
  IMAGE_VERSION \
  IMAGE_ARCHITECTURE \
  IMAGE_DESCRIPTION \
  IMAGE_USAGE \
  IMAGE_URL \
  OS_NAME \
  OS_VERSION \
  KERNEL_VERSION \
  DOCKER_CMD \
  DOCKER_CMD_DEVEL \
  DOCKER_CMD_TEST \
  DOCKER_CMD_DEBUG \
  DOCKER_CMD_HELP \
  DOCKER_PARAMS



# ---------- LABELS
LABEL \
  maintainer=${IMAGE_MAINTAINER} \
  vendor=${IMAGE_VENDOR} \
  org.label-schema.author-name=${AUTHOR_NAME}\
  org.label-schema.author-username=${AUTHOR_USERNAME}\
  org.label-schema.author-title=${AUTHOR_TITLE}\
  org.label-schema.author-email=${AUTHOR_EMAIL}\
  org.label-schema.license=${LICENSE} \
  org.label-schema.schema-version=${SCHEMA_VERSION} \
  org.label-schema.vcs-ref=${VCS_REF} \
  org.label-schema.vcs-url=${VCS_URL} \
  org.label-schema.build-date=${BUILD_DATE} \
  org.label-schema.name=${IMAGE_NAME} \
  org.label-schema.version=${IMAGE_VERSION} \
  org.label-schema.architecture=${IMAGE_ARCHITECTURE} \
  org.label-schema.description=${IMAGE_DESCRIPTION} \
  org.label-schema.usage=${IMAGE_USAGE} \
  org.label-schema.url=${IMAGE_URL} \
  org.label-schema.os-name=${OS_NAME} \
  org.label-schema.os-version=${OS_VERSION} \
  org.label-schema.kernel-version=${KERNEL_VERSION} \
  org.label-schema.docker.cmd=${DOCKER_CMD} \
  org.label-schema.docker.cmd.devel=${DOCKER_CMD_DEVEL} \
  org.label-schema.docker.cmd.test=${DOCKER_CMD_TEST} \
  org.label-schema.docker.cmd.debug=${DOCKER_CMD_DEBUG} \
  org.label-schema.docker.cmd.help=${DOCKER_CMD_HELP} \
  org.label-schema.docker.params=${DOCKER_PARAMS}




# ---------- BUILD
FROM base AS build
USER root
WORKDIR /build
COPY src/requirements.txt /build/requirements.txt
RUN pip install --no-cache-dir --prefix=/build -r /build/requirements.txt
USER python



# ---------- MAIN
FROM base AS main
USER root
WORKDIR /app
COPY --from=build /build /usr/local
COPY src/app.py /app
USER python
CMD [ "python" , "app.py" ]
EXPOSE 8000
HEALTHCHECK CMD ["wget", "-q", "localhost:8000/healthz"]