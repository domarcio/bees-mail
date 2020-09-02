package main

import (
	"fmt"
	"log"
	"net"
	"os"
	"os/signal"

	"github.com/domarcio/bees-mail/grpc/server/proto"

	"google.golang.org/grpc"
)

type server struct{}

func main() {
	log.SetFlags(log.LstdFlags | log.Lshortfile | log.Lmicroseconds)

	var (
		network string = "tcp"
		address string = fmt.Sprintf("0.0.0.0:%s", os.Getenv("GRPC_PORT"))
	)

	log.Printf("Starts server with network=(%s) and address=(%s)", network, address)

	lis, err := net.Listen(network, address)
	if err != nil {
		log.Fatalf("Failed to list: %v", err)
	}

	s := grpc.NewServer()
	proto.RegisterServicesServer(s, &server{})

	go func() {
		if err := s.Serve(lis); err != nil {
			log.Fatalf("Failed to setup server: %v", err)
		}
	}()

	// Waiting for CTRL+C to exit
	ch := make(chan os.Signal, 1)
	signal.Notify(ch, os.Interrupt)

	// Block until a signal received
	<-ch
	log.Println("Stopping the server")
	s.Stop()
	log.Println("Closing the listener")
	lis.Close()
	log.Println("End of server")
}
