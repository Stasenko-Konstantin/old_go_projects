package src

import (
	"fmt"
	"log"
	"net"
	"strings"
)

func send(address, msg string) { //UDP client
	conn, err := net.Dial("udp", address+":12345")
	if err != nil {
		log.Fatal("не удалось отправить сообщение:", err)
		return
	}
	fmt.Fprintf(conn, msg)
}

func localIp() net.IP {
	conn, err := net.Dial("udp", "8.8.8.8:80")
	if err != nil {
		log.Fatal(err)
	}
	defer conn.Close()

	localAddr := conn.LocalAddr().(*net.UDPAddr)
	return localAddr.IP
}

func allIp(address string) string {
	parts := strings.Split(address, ".")
	parts[3] = "255"
	return parts[0] + "." + parts[1] + "." + parts[2] + "." + parts[3]
}
