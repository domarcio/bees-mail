.PHONY: all

SHELL = /bin/bash

build:
	docker build --network=host -t bees-mail-api -f ./container/api/Dockerfile.api ./api
	docker build --network=host -t bees-mail-grpc -f ./container/grcp/Dockerfile .
	docker build --network=host . -t bees-mail-cli -f container/cli/Dockerfile

run_api:
	docker run -d --rm --name bees-mail-api \
		-p 8080:80 \
		-v ${PWD}/container/api/php-ini-overrides.ini:/etc/php/7.4/fpm/conf.d/99-overrides.ini \
		-e PHP_INI_SCAN_DIR=/usr/local/etc/php/conf.d/:/etc/php/7.4/fpm/conf.d/ \
		bees-mail-api

run_grpc:
	docker run -it --rm --name bees-mail-grpc -p 50051:50051 -v${PWD}/grpc/:${PWD}:Z bees-mail-grpc /usr/bin/server

stop_run_api:
	docker stop bees-mail-api

create_pb_files:
	docker run --rm -v${PWD}:${PWD}:Z -w${PWD} bees-mail-cli protoc -I grpc/proto grpc/proto/*.proto \
		--proto_path=./grpc/proto \
		--go_out=plugins=grpc:.

test:
	docker build --network=host -t bees-mail-api-tests -f ./container/api/Dockerfile.tests ./api

	docker run -it --rm --name bees-mail-api-tests \
		-v ${PWD}/container/api/php-ini-overrides.ini:/etc/php/7.4/fpm/conf.d/99-overrides.ini \
		-e PHP_INI_SCAN_DIR=/usr/local/etc/php/conf.d/:/etc/php/7.4/fpm/conf.d/ \
		bees-mail-api-tests /bin/sh