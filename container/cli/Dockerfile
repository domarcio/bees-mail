FROM alpine:latest AS binary

RUN apk add --no-cache --update unzip curl

# Install protobuf binary
RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/protoc-3.13.0-linux-x86_64.zip
RUN unzip protoc-3.13.0-linux-x86_64.zip -d protoc3
RUN mv protoc3/bin/* /usr/local/bin/
RUN mv protoc3/include/* /usr/local/include/

FROM bees-mail-grpc

RUN cd /tmp
WORKDIR /tmp

COPY --from=binary /usr/local/bin/* /usr/local/bin/
COPY --from=binary /usr/local/include/* /usr/local/bin/

RUN go get -u github.com/golang/protobuf/protoc-gen-go
RUN ln -s ~/go/bin/protoc-gen-go /usr/local/bin/
