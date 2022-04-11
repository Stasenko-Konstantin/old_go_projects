package main

import (
	"Stasenko-Konstantin/UMGo/src"
)

func main() {
	defer src.Offline()
	src.Start()
}
