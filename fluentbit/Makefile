.PHONY:	build 

IMAGE = fluentd-elasticsearch
TAG = v0.12

build:
	docker pull ubuntu:16.04
	docker build --rm=true -t quay.io/fsinvestments/$(IMAGE):$(TAG) .
	docker push quay.io/fsinvestments/$(IMAGE):$(TAG)
