package util

import "strings"

func Split(s string) []*string {
	var (
		w string
		r []*string
	)
	for _, l := range s {
		switch string(l) {
		case " ", "\n", "\t", "\v", "\r":
			p := w
			r = append(r, &p)
			w = ""
		default:
			w += strings.ToLower(string(l))
		}
	}
	r = append(r, &w)
	return r
}

func Contain(es []string, s string) bool {
	for _, e := range es {
		if e == s {
			return true
		}
	}
	return false
}