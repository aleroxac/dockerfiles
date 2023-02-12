## ---------- UTILS
.PHONY: help
help: ## Show this menu
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: clean
clean: ## Clean all temp files
	@rm -rf .temp



## ---------- HELPERS
.PHONY: create-envfile
create-envfile: ## Create envfile to be used by scanners
	@[ -d .temp ] && rm -rf .temp || true
	@$(eval project_path=$(shell realpath $(PWD)))
	@mkdir -p $(project_path)/.temp
	@cd src/$(base)/$(lang) && python3 $(project_path)/scripts/compose-envfile.py $(project_path)/src/$(base)/$(lang)/.env > $(project_path)/.temp/.env

.PHONY: import-envfile
import-envfile: ## Import envfile to be used during build container image and scans
	$(eval include .temp/.env)
	$(eval export)



## ---------- LINT & FORMAT
## --- Scan specified dockerfile using hadolint
define dockerfile-lint
	$(call format-dockerfile, $(lang), $(base))
	cp scans/local/hadolint.yaml .temp/hadolint.yaml
	docker run --rm \
		-v ${PWD}/.temp:/scan -w /scan \
		-w /scan \
		hadolint/hadolint:2.12.0-alpine \
			hadolint -c hadolint.yaml Dockerfile
endef

.PHONY: lint
lint: create-envfile import-envfile ## Lint yaml files
	@$(call dockerfile-lint, $(lang), $(base))
	@yamllint -c scans/yamllint.yaml .

.PHONY: format
fmt: create-envfile import-envfile ## Format dockerfile
	@$(call format-dockerfile, $(lang), $(base))



## ---------- BUILD
## --- Build specified container image
define build
	cp -n src/$(base)/$(lang)/* .temp
	docker build \
		-f .temp/Dockerfile \
		--build-arg IMAGE_MAINTAINER=$(IMAGE_MAINTAINER) \
		--build-arg IMAGE_VENDOR=$(IMAGE_VENDOR) \
		--build-arg AUTHOR_NAME=${AUTHOR_NAME} \
		--build-arg AUTHOR_USERNAME=${AUTHOR_USERNAME} \
		--build-arg AUTHOR_TITLE=${AUTHOR_TITLE} \
		--build-arg AUTHOR_EMAIL=${AUTHOR_EMAIL} \
		--build-arg LICENSE=$(LICENSE) \
		--build-arg SCHEMA_VERSION=$(SCHEMA_VERSION) \
		--build-arg VCS_REF=$(VCS_REF) \
		--build-arg VCS_URL=$(VCS_URL) \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg IMAGE_NAME=$(IMAGE_NAME) \
		--build-arg IMAGE_BASE=$(IMAGE_BASE) \
		--build-arg IMAGE_VERSION=$(IMAGE_VERSION) \
		--build-arg IMAGE_DESCRIPTION=$(IMAGE_DESCRIPTION) \
		--build-arg IMAGE_USAGE=$(IMAGE_USAGE) \
		--build-arg IMAGE_URL=$(IMAGE_URL) \
		--build-arg OS_NAME=$(OS_NAME) \
		--build-arg OS_VERSION=$(OS_VERSION) \
		--build-arg DOCKER_CMD=$(DOCKER_CMD) \
		--build-arg DOCKER_CMD_DEVEL=$(DOCKER_CMD_DEVEL) \
		--build-arg DOCKER_CMD_TEST=$(DOCKER_CMD_TEST) \
		--build-arg DOCKER_CMD_DEBUG=$(DOCKER_CMD_DEBUG) \
		--build-arg DOCKER_CMD_HELP=$(DOCKER_CMD_HELP) \
		--build-arg DOCKER_PARAMS=$(DOCKER_PARAMS) \
		-t aleroxac/$(lang):local-$(base) .temp
endef

.PHONY: build
build: create-envfile import-envfile ## Build container image
	@$(call format-dockerfile, $(lang), $(base))
	@$(call build, $(lang), $(base))



## ---------- SCANS
## --- Scan specified dockerfile using hadolint
define format-dockerfile
	cat src/$(base)/$(lang)/Dockerfile | envsubst > .temp/Dockerfile
endef

## --- Scan files with kics
define scan-kics
	[ ! -d .temp/reports ] && mkdir .temp/reports
	[ ! -f .temp/reports/ ] && touch .temp/reports/kics.html
	docker run --rm \
		-v ${PWD}:/scan \
		-w /scan \
		-it checkmarx/kics scan \
			--config /scan/scans/local/kics.yaml
endef

## --- Scan files using trivy
define scan-trivy-files
	[ ! -d /tmp/trivy ] && mkdir /tmp/trivy || true
	docker run \
		-v ${PWD}:/scan \
		-v /tmp/trivy:/tmp/trivy \
		aquasec/trivy fs \
			--cache-dir=/tmp/trivy \
			--vuln-type='os,library' \
			--format=table  \
			--security-checks='vuln,config,secret,license' \
			--severity='UNKNOWN,LOW,MEDIUM,HIGH,CRITICAL' \
			--ignore-unfixed=true \
			--exit-code=1 /scan
endef

## --- Scan specified container image using trivy
define scan-trivy-image
	[ ! -d /tmp/trivy ] && mkdir /tmp/trivy || true
	docker run \
		-v /run/containerd/containerd.sock:/run/containerd/containerd.sock \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v /tmp/trivy:/tmp/trivy \
		aquasec/trivy image \
			--cache-dir=/tmp/trivy \
			--format='table' \
			--severity='UNKNOWN,LOW,MEDIUM,HIGH,CRITICAL' \
			--ignore-unfixed=true \
			--exit-code=1 \
			aleroxac/$(lang):local-$(base)
endef

## --- Run trivy files and image scans
define scan-trivy
	$(call scan-trivy-files)
	$(call scan-trivy-image, $(lang), $(base))
endef

## --- Run specified scanner
define scan
	$(call scan-$(type), $(lang), $(base))
endef

.PHONY: scan
scan: create-envfile import-envfile ## Run scan: [trivy-files, trivy-image, trivy, kics]
	@[ -z $(type) ] && echo "Please, inform the type: [trivy-files, trivy-image, trivy,kics]" || true
	@[ -z $(lang) ] && echo "Please, inform the lang: [python]" || true
	@[ -z $(base) ] && echo "Please, inform the base: [alpine]" || true
	@$(call scan, $(type), $(lang), $(base))
