package main

import (
	"fmt"
	"log"
	"net"
)

func main() {
	conn, err := net.Dial("udp", "127.0.0.1:3000")
	if err != nil {
		log.Fatal(err)
	}

	go func(c net.Conn) {
		conn.Write([]byte("ping"))
	}(conn)

	go func(c net.Conn) {
		data := make([]byte, 4096)
		for {
			n, err := c.Read(data)
			if err != nil {
				log.Fatal(err)
				break
			}
			fmt.Println(string(data[:n]))
		}
	}(conn)

	fmt.Scanln()

	defer func() {
		conn.Write([]byte("disconnect"))
		conn.Close()
	}()
}
