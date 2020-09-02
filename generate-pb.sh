#!/bin/bash

## Generate Proto Buffer files with docker

## 1) Build docker image
podman build . -t bees-mail-cli -f container/cli

## 2) Run image
podman run --rm -v${PWD}:${PWD}:Z -w${PWD} bees-mail-cli \
    protoc -I grpc/proto grpc/proto/*.proto \
    --proto_path=./grpc/proto \
    --go_out=plugins=grpc:.
