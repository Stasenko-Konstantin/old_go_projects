package src

import (
	"strconv"
	"strings"
)

type Interlocutor struct {
	name    string
	address string
	status  bool
}

func split(str, del string) []string {
	return strings.Split(str, del)
}

func validate(address string) bool {
	slice := strings.Split(address, ".")
	if len(slice) < 4 || len(slice) > 4 {
		return false
	}

	for _, r := range slice {
		t, err := strconv.ParseUint(r, 10, 64)
		if t > 255 || err != nil {
			return false
		}
	}

	return true
}
