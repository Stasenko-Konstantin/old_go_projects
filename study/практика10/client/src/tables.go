package src

import (
	_ "github.com/mattn/go-sqlite3"
	"strings"
)

type (
	table [][]string
	row   []string
)

func connect() {
	db := takeDB()
	i := 0
	m := strings.Split(db, "|||")
	for _, d := range m[1:] {
		var r table
		d := strings.Split(d, "$|")[0]
		m := strings.Split(d, "\\n")
		for n, e := range m {
			if n == len(m)-1 {
				break
			}
			ee := strings.Split(e, "-|-")
			switch i {
			case 0: // клиенты
				id := ee[0]
				sfm := ee[1]
				residence := ee[2]
				r = append(r, []string{id, sfm, residence, ""})
			case 1: // кассеты
				id := ee[0]
				price := ee[1]
				film := ee[2] + " " + ee[3]
				r = append(r, []string{id, price, film, ""})
			case 2: // фильмы
				name := ee[0]
				year := ee[1]
				director := ee[2]
				genre := ee[3]
				timeline := ee[4]
				studio := ee[5]
				r = append(r, []string{name, year, director, genre, timeline, studio, ""})
			case 3: // библиотекари
				id := ee[0]
				sfm := ee[1]
				r = append(r, []string{id, sfm, ""})
			case 4: // выдачи
				id := ee[0]
				client := ee[1]
				cassette := ee[2]
				issued := ee[3]
				r = append(r, []string{id, client, cassette, issued, ""})
			}
		}
		switch i {
		case 0:
			clients = append(clients, r...)
		case 1:
			cassettes = append(cassettes, r...)
		case 2:
			films = append(films, r...)
		case 3:
			librarians = append(librarians, r...)
		case 4:
			givings = append(givings, r...)
		}
		i++
	}
}
