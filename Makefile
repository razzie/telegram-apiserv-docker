VERSION ?= latest
IMAGE_NAME := telegram-apiserv
IMAGE_REGISTRY ?= ghcr.io/razzie
FULL_IMAGE_NAME := $(IMAGE_REGISTRY)/$(IMAGE_NAME):$(VERSION)

.PHONY: build
build:
	docker build . -t $(FULL_IMAGE_NAME)

.PHONY: run
run: build
	docker run -p 8080:8080 $(FULL_IMAGE_NAME) --api-id=$(API_ID) --api-hash=$(API_HASH) --local --http-port=8080

.PHONY: push
push: build
	docker push $(FULL_IMAGE_NAME)

