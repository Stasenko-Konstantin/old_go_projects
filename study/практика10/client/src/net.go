package src

import (
	"fmt"
	"net"
	"strings"
	"time"
)

var myIP = localIp()

func send(address, msg string, log *myLogger) {
	conn, err := net.Dial("udp", address+":12345")
	if err != nil {
		log.Write([]byte("Не удалось отправить сообщение: " + err.Error()))
		return
	}
	fmt.Fprintf(conn, msg)
}

func localIp() net.IP {
	conn, _ := net.Dial("udp", "8.8.8.8:80")
	defer conn.Close()

	localAddr := conn.LocalAddr().(*net.UDPAddr)
	return localAddr.IP
}

func allIP(address string) string {
	parts := strings.Split(address, ".")
	parts[3] = "255"
	return parts[0] + "." + parts[1] + "." + parts[2] + "." + parts[3]
}

func takeDB() string {
	defer func() {
		if r := recover(); r != nil {
			s := r.(error)
			mylog.Write([]byte(s.Error() + " AGA\n"))
		}
	}()
	fmt.Println(myIP.String() + " takeDB")
	querys := []string{"select * from clients;", "select * from cassettes;", "select * from films;", "select * from librarians;", "select * from givings;"}
	var r string
	for _, q := range querys {
	again:
		myIP := localIp()
		pc, err := net.ListenPacket("udp", myIP.String()+":12345")
		if err != nil {
			mylog.Write([]byte(err.Error()))
		}
		time.Sleep(1)
		send(allIP(myIP.String()), encode(q), mylog)
		buf := make([]byte, 10000)
		_, _, err = pc.ReadFrom(buf)
		if err != nil {
			mylog.Write([]byte("AGAAA" + err.Error()))
			return ""
		}
		msg := strings.Split(string(buf), "$|")
		if msg[0] != "бананы лопала бомба" {
			pc.Close()
			goto again
		}
		r += "|||" + decode(msg[1])
		pc.Close()
	}
	return r
}
