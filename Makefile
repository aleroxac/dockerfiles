.PHONY: help
help: ## Show this menu
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: build-python-alpine
build-python-alpine: ## Build the container image
	@ln -s src/python/alpine/ .build-python-alpine
	@docker build \
		-f .build-python-alpine/Dockerfile \
		--build-arg IMAGE_NAME=python-alpine \
		--build-arg IMAGE_VERSION=test \
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
		--build-arg IMAGE_DESCRIPTION="Badass base image for python projects" \
		--build-arg DOCKER_CMD="" \
		--build-arg DOCKER_CMD_DEBUG="" \
		--build-arg DOCKER_CMD_HELP="" \
		--build-arg DOCKER_CMD_DEVEL="" \
		--build-arg DOCKER_CMD_TEST="" \
		--build-arg DOCKER_PARAMS="" \
		-t aleroxac/python-alpine:test .build-python-alpine
	@rm -rf .build-python-alpine

.PHONY: scan-vul
scan-vul: ## Scan container image, looking for
	@docker run \
		-v ${PWD}:/target \
		-v /run/containerd/containerd.sock:/run/containerd/containerd.sock \
		-v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:0.35.0 \
		image aleroxac/python-alpine:test
