# dockerfiles
Dockerfiles to be used as base for any project



## Brief
These dockerfiles has been builded based on:
- Open Container Initiative specifications
- Docker Official Documentation
- Label Schema Convention
- Best practices, tips and tricks earned from professional experiences working with as SRE/DevOps/Platform Enginner



## Resources
- Container Initiative specifications
- Label Schema Convention
- Docker Content Trust

- armosec/kubescape
- aquasec/trivy
- redhat quay/clair
- snyk



## Scanners
- filesystem
    - malware
    - content finding(indicators of compromise)
    - layers(diff)

- network
    - network egress
    - network ingress
    - waas(web application and api security)

- runtime
    - dta(dynamic threat analysis): malware, crypto miners, code injection backdoors, network anomalies
    - se-linux
    - sandbox

- conformity
    - scan hadolint
    - scan kics

- vulnerabilities
    - scan trivy
    - scan clair
    - scan snyk



## Languages Supported
- python
- go
- javascript
- java
- php


## Architectures Supported
- amd64
- arm64



## Image Types Supported
- alpine
- slim



## Usage
- Choose a language end see one of the [demos here](demo)



## References
- https://github.com/opencontainers
- http://label-schema.org/rc1/
- https://docs.docker.com/docker-hub/official_images/
- https://github.com/docker-library/official-images
- https://docs.docker.com/develop/dev-best-practices/
- https://docs.docker.com/develop/develop-images/dockerfile_best-practices
- https://docs.docker.com/config/labels-custom-metadata/
- https://docs.docker.com/engine/reference/builder/
