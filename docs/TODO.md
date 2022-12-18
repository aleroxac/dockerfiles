# TO-DOs


quando for feito push de codigo em qualquer, deverá ser feito o processo de ci padrão
push:code > workflow:ci      > build,scan,test

quando for feito push de tag, deverá ser feito processo de ci e release
push:tag  > workflow:release > build,scan,test,release



- [x] implement demo for python-alpine
- [ ] create a workflow for release

- [ ] implement scan-dockerfile: hadolint, kics
- [ ] implement scan-image: trivy
- [ ] implement test-image: ansible, docker-run/docker-compose, testinfra

- [ ] add badges on readme:
    - [ ] last-release
    - [ ] scan-conf
    - [ ] scan-vul

- [ ] implement content-trust on images

- [ ] solve the problem to handle build-args manually, for all dockerfiles, on: dockerfile, workflow, makefile, build-args.env
- [ ] solve the problem to change some build-args, for all dockerfiles
