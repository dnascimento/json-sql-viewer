REGISTRY := dnascimento
NAME := jsondb
VERSION := $(shell cat VERSION)
DOCKER_IMAGE := ${REGISTRY}/${NAME}
PORT := 8000

.PHONY: clean build
all: build

build:
	docker build -t ${NAME} .
run:
	docker run -it -p 8000:5432 ${NAME}

publish: build
	docker tag ${NAME} ${DOCKER_IMAGE}
	docker tag ${NAME} ${DOCKER_IMAGE}:${VERSION}
	docker push ${DOCKER_IMAGE}
	docker push ${DOCKER_IMAGE}:${VERSION}
