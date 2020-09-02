FROM golang:latest

LABEL maintainer="Marcio Vinicius <marciovinicius55@gmail.com>"

# Create environment variables
ENV BASE_PATH /go/src/github.com/domarcio/bees-mail/grpc/server
ENV GRPC_PORT 50051

# Create base path to container
RUN mkdir -p ${BASE_PATH}

# Copy all files in root path (from project) and setting the base path as workspace
COPY ./grpc/server ${BASE_PATH}
WORKDIR ${BASE_PATH}

RUN go mod init

RUN go get -u google.golang.org/grpc

## NA: Special thanks to the https://ops.tips/blog/dockerfile-golang/
# 0.  Set some shell flags like `-e` to abort the
#       execution in case of any failure (useful if we
#       have many ';' commands) and also `-x` to print to
#       stderr each command already expanded.
# 1.  Get into the directory with the golang source code
# 2.  Perform the go build with some flags to make our
#       build produce a static binary (CGO_ENABLED=0 and
#       the `netgo` tag).
# 3.  Copy the final binary to a suitable location that
#       is easy to reference in the next stage
RUN set -ex && \
  cd ${BASE_PATH} && \
  CGO_ENABLED=0 go build \
        -tags netgo \
        -v -a \
        -ldflags '-extldflags "-static"' && \
  mv ./server /usr/bin/server

# Set the binary as the entrypoint of the container
ENTRYPOINT [ "server" ]

EXPOSE ${GRPC_PORT}
