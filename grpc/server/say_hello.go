package main

import (
	"context"
	"fmt"
	"log"

	"github.com/domarcio/bees-mail/grpc/server/proto"
)

func (*server) SayHello(ctx context.Context, req *proto.SayHelloRequest) (*proto.SayHelloResponse, error) {
	log.Printf("SayHello function was invoked with %v", req)

	var (
		name = req.GetName()
		res  = new(proto.SayHelloResponse)
	)

	res.Regards = fmt.Sprintf("Hello, %s! Welcome to Bees Mail application.", name)
	return res, nil
}
