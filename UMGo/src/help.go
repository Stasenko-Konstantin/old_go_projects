package src

import (
	"errors"
	"log"
	"os"
	"strconv"
	"strings"
)

type Interlocutor struct {
	name    string
	address string
	status  bool
}

type myLogger struct {
	file   *os.File
	stdout *os.File
}

func (ml myLogger) Write(b []byte) (n int, err error) {
	var myerr string
	n, err = ml.file.Write(b)
	if err != nil {
		myerr += err.Error() + "\n"
	}
	_, err = ml.stdout.Write(b)
	if err != nil {
		myerr += err.Error()
	}
	if myerr != "" {
		err = errors.New(myerr)
	}
	return n, err
}

func (ml *myLogger) Close() {
	ml.file.Close()
	ml.stdout.Close()
}

func newLogger() (*log.Logger, *myLogger) {
	if _, err := os.Stat("log.txt"); os.IsNotExist(err) {
		f, err := os.Create("log.txt")
		if err != nil {
			panic("Не удалось создать логер!")
		}
		mlog := myLogger{f, os.Stdout}
		return log.New(mlog, "INFO\t", log.Ltime), &mlog
	}
	f, err := os.Open("log.txt")
	if err != nil {
		panic("Не удалось открыть логер!")
	}
	mlog := myLogger{f, os.Stdout}
	return log.New(mlog, "INFO\t", log.Ltime), &mlog
}

func split(str, del string) []string {
	return strings.Split(str, del)
}

func takeName(intrls []Interlocutor, addr string) (string, error) {
	for _, e := range intrls {
		if e.address == addr {
			return e.name + ", " + split(addr, ":")[0], nil
		}
	}
	return "", errors.New("Не удалось взять имя " + addr)
}

func statusIntrls(intrls []Interlocutor, addr string) (bool, error) {
	for _, e := range intrls {
		if e.address == addr {
			return e.status, nil
		}
	}
	return false, errors.New("Не удалось получить статус " + addr)
}

func isOnline(status bool) string {
	if status {
		return "online"
	} else {
		return "offline"
	}
}

func boolToString(b bool) string {
	if b {
		return "true"
	} else {
		return "false"
	}
}

func remove(s []string, str string) []string {
	if contains(s, str) {
		var i int
		for j, e := range s {
			if e == str {
				i = j
				break
			}
		}
		s[i] = s[len(s)-1]
		return s[:len(s)-1]
	} else {
		return nil
	}
}

func contains(s []string, e string) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}

func validate(address string) bool {
	slice := strings.Split(address, ".")
	if len(slice) < 4 || len(slice) > 4 {
		return false
	}

	for _, r := range slice {
		t, err := strconv.ParseUint(r, 10, 64)
		if t > 255 {
			return false
		}
		if err != nil {
			log.Printf(err.Error())
			return false
		}
	}

	return true
}
