package src

import (
	"errors"
	"os"
	"sort"
	"strings"
	"unicode/utf8"
)

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

func newLogger() *myLogger {
	if _, err := os.Stat("log.txt"); os.IsNotExist(err) {
		f, err := os.Create("log.txt")
		if err != nil {
			panic("Не удалось создать логер!")
		}
		return &myLogger{f, os.Stdout}
	}
	f, err := os.Open("log.txt")
	if err != nil {
		panic("Не удалось открыть логер!")
	}
	return &myLogger{f, os.Stdout}
}

func boolToStr(b bool) string {
	if b {
		return "true"
	}
	return "false"
}

func stringConcat(vals []string, del string) string {
	var r string
	for _, e := range vals {
		r += e + " " + del
	}
	return r
}

func contain(mas []string, e string) bool {
	for _, s := range mas {
		if s == e {
			return true
		}
	}
	return false
}

func encode(s string) string {
	r := ""
	for _, l := range s {
		c, _ := utf8.DecodeRuneInString(string(l + 3))
		r += string(c)
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

func read(msg string) string {
	var r string
	m := strings.Split(msg, "\\n")
	for n, e := range m {
		if n == len(m)-1 {
			break
		}
		m := strings.Split(e, "-|-")
		for _, ee := range m {
			r += ee + " "
		}
		r += "\n"
	}
	return r
}

func makePrices() []string {
	var r []string
	i := 0
	for _, p := range cassettes {
		if i == 0 {
			i += 1
		} else {
			if !contain(r, p[1]) {
				r = append(r, p[1])
			}
		}
	}
	sort.Strings(r)
	return r
}

func makeTimes() []string {
	var r []string
	i := 0
	for _, p := range films {
		if i == 0 {
			i += 1
		} else {
			if !contain(r, p[4]) {
				r = append(r, p[4])
			}
		}
	}
	sort.Strings(r)
	return r
}

func makeGenres() []string {
	var r []string
	i := 0
	for _, p := range films {
		if i == 0 {
			i += 1
		} else {
			if !contain(r, p[3]) {
				r = append(r, p[3])
			}
		}
	}
	sort.Strings(r)
	return r
}

func makeDirs() []string {
	var r []string
	i := 0
	for _, p := range films {
		if i == 0 {
			i += 1
		} else {
			if !contain(r, p[2]) {
				r = append(r, p[2])
			}
		}
	}
	sort.Strings(r)
	return r
}

func makeYears() []string {
	var r []string
	i := 0
	for _, p := range films {
		if i == 0 {
			i += 1
		} else {
			if !contain(r, p[1]) {
				r = append(r, p[1])
			}
		}
	}
	sort.Strings(r)
	return r
}

func makeLibs() []string {
	var r []string
	i := 0
	for _, p := range librarians {
		if i == 0 {
			i += 1
		} else {
			if !contain(r, p[1]) {
				r = append(r, p[1])
			}
		}
	}
	sort.Strings(r)
	return r
}

func findLib(sfm string) string {
	for _, l := range librarians {
		if l[1] == sfm {
			return l[0]
		}
	}
	return ""
}

//func (rs *Rows) ScanString(dest *[]*NullString) error {
//	rs.closemu.RLock()
//
//	if rs.lasterr != nil && rs.lasterr != io.EOF {
//		rs.closemu.RUnlock()
//		return rs.lasterr
//	}
//	if rs.closed {
//		err := rs.lasterrOrErrLocked(errRowsClosed)
//		rs.closemu.RUnlock()
//		return err
//	}
//	rs.closemu.RUnlock()
//
//	if rs.lastcols == nil {
//		return errors.New("sql: Scan called without calling Next")
//	}
//	if len(*dest) != len(rs.lastcols) {
//		for i := 0; i < len(rs.lastcols); i++ {
//			var s NullString
//			*dest = append(*dest, &s)
//		}
//	}
//	for i, sv := range rs.lastcols {
//		e := *dest
//		err := convertAssignRows(e[i], sv, rs)
//		if err != nil {
//			return fmt.Errorf(`sql: Scan error on column index %d, name %q: %w`, i, rs.rowsi.Columns()[i], err)
//		}
//	}
//	return nil
//}
