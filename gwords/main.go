// вдохновленно книгой "Практика программирования" Пайка и Кернигана
package main

import (
	"fmt"
	"gwords/util"
	"io/ioutil"
	"math/rand"
	"os"
	"time"
)

var (
	gen   = 100
	count = 3
	text  []*string
	words = make(map[string][]string)
)

func main() {
	args := os.Args
	if len(args) < 2 {
		fmt.Println("usage: gwords file1 file2 .. filen")
		os.Exit(0)
	}
	for _, name := range args[1:] {
		part, err := ioutil.ReadFile(name)
		if err != nil {
			panic(err)
		}
		text = append(text, util.Split(string(part))...)
	}

	for i := 0; i < len(text) - 2; i ++ {
		fword := *text[i]
		for j := 0; j < count - 1; j++ {
			word := *text[i+j]
			if !util.Contain(words[fword], word) {
				words[fword] = append(words[fword], word)
			}
		}
	}

	rand.Seed(time.Now().UnixNano())
	again: rind := rand.Intn(len(text))
	rword := *text[rind]
	if words[rword] == nil {
		goto again
	}
	for i := 0; i < gen; i++ {
		fmt.Print(rword, " ")
		word := words[rword][1:]
		rind = rand.Intn(len(word))
		rword = word[rind]
	}
}
