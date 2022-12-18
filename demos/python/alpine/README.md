# demo-python-alpine
App for demonstration of how to use python-alpine image.


## How to run
``` shell
ln -s demo/python/alpine/ .build-python-alpine
docker build \
    -f .build-python-alpine/Dockerfile \
    --build-arg IMAGE_NAME=demo-python-alpine \
    --build-arg IMAGE_VERSION=v1 \
    --build-arg IMAGE_ARCHITECTURE=x86_64 \
    --build-arg OS_NAME="Alpine Linux" \
    --build-arg OS_VERSION="3.17.0" \
    --build-arg KERNEL_VERSION="6.0.12-arch1-1" \
    --build-arg LICENSE="" \
    --build-arg BUILD_DATE=$(TZ="America/Sao_Paulo" date +'%Y-%m-%dT%H:%M:%SZ') \
    --build-arg VCS_REF=$(git rev-parse --short HEAD) \
    --build-arg VCS_URL="" \
    --build-arg IMAGE_MAINTAINER="acardoso.devops@gmail.com" \
    --build-arg IMAGE_VENDOR="Groking Labs" \
    --build-arg SCHEMA_VERSION="1.0" \
    --build-arg IMAGE_USAGE="" \
    --build-arg IMAGE_URL="" \
    --build-arg IMAGE_DESCRIPTION="App for demonstration of how to use python-alpine image." \
    --build-arg DOCKER_CMD="" \
    --build-arg DOCKER_CMD_DEBUG="" \
    --build-arg DOCKER_CMD_HELP="" \
    --build-arg DOCKER_CMD_DEVEL="" \
    --build-arg DOCKER_CMD_TEST="" \
    --build-arg DOCKER_PARAMS="" \
    -t aleroxac/demo-python-alpine:v1 .build-python-alpine
rm -rf .build-python-alpine
```
