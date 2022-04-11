package src

import (
	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/widget"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"os"
	"strconv"
)

type depart struct {
	gorm.Model
	depno int
	name  string
}

func (d depart) String() string {
	return strconv.Itoa(d.depno) + ", " + d.name
}

func readDsn() string {
	dsn, err := os.ReadFile("dsn.txt")
	if err != nil {
		panic("не удалось прочитать dsn: " + err.Error())
	}
	return string(dsn)
}

func Start() {
	a := app.New()
	w := a.NewWindow("ризубд")
	w.Resize(fyne.NewSize(1000, 600))

	dsn := readDsn()
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		panic("не удалось подключиться к базе: " + err.Error())
	}
	db.AutoMigrate(&depart{})
	var d depart
	db.First(&d)

	table := widget.NewLabel(d.String())

	w.SetContent(table)
	w.ShowAndRun()
}
