COMMIT=$(shell git rev-parse --short HEAD)
IMAGE=lazypower/restic

.PHONY: all
all: docker publish

.PHONY: docker
docker:
	docker build -t $(IMAGE):$(COMMIT) .

.PHONY: publish
publish:
	docker push $(IMAGE):$(COMMIT)

