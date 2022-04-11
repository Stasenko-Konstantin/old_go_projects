package src

import (
	"errors"
	"os"
	"sort"
	"strings"
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

func makePers() []string {
	var r []string
	i := 0
	for _, p := range talons {
		if i == 0 {
			i += 1
		} else {
			cp := strings.Split(p[1], " ")[0]
			if !contain(r, cp) && cp != "0001-01-01" {
				r = append(r, cp)
			}
		}
	}
	sort.Strings(r)
	return r
}

func makeDocs() []string {
	var r []string
	i := 0
	for _, p := range talons {
		if i == 0 {
			i += 1
		} else {
			if !contain(r, p[2]) {
				r = append(r, p[2])
			}
		}
	}
	return r
}

func makeDeps() []string {
	var r []string
	i := 0
	for _, p := range patients {
		if i == 0 {
			i += 1
		} else {
			if !contain(r, p[6]) {
				r = append(r, p[6])
			}
		}
	}
	return r
}

func makeCmps() []string {
	var r []string
	i := 0
	for _, p := range patients {
		if i == 0 {
			i += 1
		} else {
			if !contain(r, p[1]) {
				r = append(r, p[1])
			}
		}
	}
	return r
}

func makeBrts() []string {
	var r []string
	i := 0
	for _, p := range patients {
		if i == 0 {
			i += 1
		} else {
			cp := strings.Split(p[4], " ")[0]
			if !contain(r, cp) && cp != "0001-01-01" {
				r = append(r, cp)
			}
		}
	}
	sort.Strings(r)
	return r
}

func makeSpcs() []string {
	var r []string
	i := 0
	for _, d := range doctors {
		if i == 0 {
			i += 1
		} else {
			if !contain(r, d[2]) {
				r = append(r, d[2])
			}
		}
	}
	return r
}

func makeOtds() []string {
	var r []string
	i := 0
	for _, d := range doctors {
		if i == 0 {
			i += 1
		} else {
			if !contain(r, d[1]) {
				r = append(r, d[1])
			}
		}
	}
	return r
}

func makeAdrs() []string {
	var r []string
	i := 0
	for _, p := range patients {
		if i == 0 {
			i += 1
		} else {
			if !contain(r, p[3]) {
				r = append(r, p[3])
			}
		}
	}
	return r
}

func makePats() []string {
	var r []string
	i := 0
	for _, p := range patients {
		if i == 0 {
			i += 1
		} else {
			if !contain(r, p[2]) {
				r = append(r, p[2])
			}
		}
	}
	return r
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
