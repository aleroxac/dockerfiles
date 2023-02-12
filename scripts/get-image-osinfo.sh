#!/usr/bin/env bash

# find dockerfiles
AVAILABLE_DOCKERFILES=$(find "${PWD}" -type f -name "Dockerfile")

for dockerfile in $(echo "${AVAILABLE_DOCKERFILES}"); do
  # get base image from dockerfile
  DOCKERFILE_BASE_IMAGE=$(sed -n 2p "${dockerfile}" | cut -d" " -f2)

  # pull images
  # docker pull -q "${DOCKERFILE_BASE_IMAGE}"

  # get os-info from dockerfile
  DOCKERFILE_OS_NAME=$(docker run --rm -it --entrypoint='' "${DOCKERFILE_BASE_IMAGE}" grep -E '^NAME' /etc/os-release | cut -d"=" -f2 | tr '"' "'")
  DOCKERFILE_OS_VERSION=$(docker run --rm -it --entrypoint='' "${DOCKERFILE_BASE_IMAGE}" grep -E '^VERSION' /etc/os-release | cut -d"=" -f2 | sed -r "s/(.+)(.)/'\1'/g")
  DOCKERFILE_KERNEL_VERSION=$(docker run --rm -it --entrypoint='' "${DOCKERFILE_BASE_IMAGE}" uname -r | sed -r "s/(.+-.)/'\1'/g")

  # get .env path
  DOTENV_FILE="$(dirname ${dockerfile})/.env"

  # replace values on .env file
  sed -i "s/OS_NAME=.*/OS_NAME=${DOCKERFILE_OS_NAME}/g" "${DOTENV_FILE}"
  sed -i "s/OS_VERSION=.*/OS_VERSION=${DOCKERFILE_OS_VERSION}/g" "${DOTENV_FILE}"
  sed -i "s/KERNEL_VERSION=.*/KERNEL_VERSION=${DOCKERFILE_KERNEL_VERSION}/g" "${DOTENV_FILE}"
done
