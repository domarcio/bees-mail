FROM fedora:latest

LABEL maintainer="Marcio Vinicius <marciovinicius55@gmail.com>"

RUN cd /tmp
WORKDIR /tmp

# Keep updated
RUN dnf update -y

# Install Golang
RUN dnf install go -y
RUN go get -u google.golang.org/grpc
RUN go get -u github.com/golang/protobuf/protoc-gen-go
RUN ln -s ~/go/bin/protoc-gen-go /usr/local/bin/

# Install protobuf binary
RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/protoc-3.13.0-linux-x86_64.zip
RUN unzip protoc-3.13.0-linux-x86_64.zip -d protoc3
RUN mv protoc3/bin/* /usr/local/bin/
RUN mv protoc3/include/* /usr/local/include/
