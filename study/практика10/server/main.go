package main

import (
	"database/sql"
	"fmt"
	_ "github.com/mattn/go-sqlite3"
	"log"
	"net"
	"os"
	"strings"
	"unicode/utf8"
)

var logger *log.Logger

func mylog(msg string) {
	fmt.Println(msg)
	logger.Println(msg)
}

func myerr(msg string) {
	fmt.Println(msg)
	logger.Fatalf(msg)
}

func localAddr() net.IP {
	conn, _ := net.Dial("udp", "8.8.8.8:80")
	defer conn.Close()

	localAddr := conn.LocalAddr().(*net.UDPAddr)
	return localAddr.IP
}

func encode(s string) string {
	r := ""
	for _, l := range s {
		if string(l) == "\n" {
			r += string(l)
		} else {
			c, _ := utf8.DecodeRuneInString(string(l + 3))
			r += string(c)
		}
	}
	return r
}

func decode(s string) string {
	r := ""
	for _, l := range s {
		c, _ := utf8.DecodeRuneInString(string(l - 3))
		r += string(c)
	}
	return r
}

func send(address, msg string) {
	conn, err := net.Dial("udp", address)
	if err != nil {
		myerr("Не удалось отправить сообщение! " + err.Error())
		return
	}
	fmt.Fprintf(conn, msg)
}

func allIP(address string) string {
	parts := strings.Split(address, ".")
	parts[3] = "255"
	return parts[0] + "." + parts[1] + "." + parts[2] + "." + parts[3]
}

func mPort(address string) string {
	return strings.Split(address, ":")[0]
}

func main() {
	defer func() {
		if r := recover(); r != nil {
			s := r.(error)
			mylog(s.Error() + " aga\n")
		}
	}()
	f, err := os.Open("log.txt")
	if err != nil {
		log.Fatalf("Не удалось открыть файл логов!", err)
	}
	defer f.Close()
	logger = log.New(f, "", log.LstdFlags)
	defer mylog("Сервер отключен.")
	mylog("Сервер запущен.")
	db, err := sql.Open("sqlite3", "db.db")
	if err != nil {
		myerr("Ошибка получения данных из базы " + err.Error())
	}
	for {
		pc, err := net.ListenPacket("udp", localAddr().String()+":12345")
		if err != nil {
			myerr(err.Error())
		}
		var r string
		buf := make([]byte, 1024)
		_, address, err := pc.ReadFrom(buf)
		if err != nil {
			myerr("Ошибка подключения " + address.String() + ", " + err.Error())
			continue
		}
		msg := strings.Split(decode(string(buf)), ";")[0] + ";"
		mylog("Подключился " + address.String())
		mylog("Запрос " + msg)
		querys, err := db.Query(msg)
		if err != nil {
			myerr(err.Error())
		}
		var res []*[]*sql.NullString
		i := 0
		for querys.Next() {
			var t []*sql.NullString
			res = append(res, &t)
			querys.ScanString(res[i])
			i++
		}
		for _, e := range res {
			var p string
			for _, ee := range *e {
				p += (*ee).String + "-|-"
			}
			r += p + "\\n"
		}
		send(mPort(address.String())+":12345", "бананы лопала бомба$|"+encode(r)+"|||")
		err = querys.Close()
		if err != nil {
			myerr(err.Error())
		}
		pc.Close()
	}
	db.Close()
}
