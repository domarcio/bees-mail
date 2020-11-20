.PHONY: all

SHELL = /bin/bash

build:
	docker build --network=host -t bees-mail-grpc-server -f ./container/grcp/Dockerfile.server .
	docker build --network=host . -t bees-mail-cli -f container/cli/Dockerfile

run_grpc:
	docker run -it --rm --name bees-mail-grpc-server -p 50051:50051 -v${PWD}/grpc/:${PWD}:Z bees-mail-grpc-server /usr/bin/server

create_pb_files:
	docker run --rm -v${PWD}:${PWD}:Z -w${PWD} bees-mail-cli protoc -I grpc/proto grpc/proto/*.proto \
		--proto_path=./grpc/proto \
		--go_out=plugins=grpc:.