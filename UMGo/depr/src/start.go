package src

import (
	"fmt"
	"net"
	"strconv"
	"time"

	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/container"
	"fyne.io/fyne/v2/widget"
)

var myIp string = localIp().String()

func serve(pc net.PacketConn, address net.Addr, buf []byte) {
	buf[2] |= 0x80
	pc.WriteTo(buf, address)
}

func Offline() {
	send(allIp(myIp), "#offline")
}

func Start() {
	fmt.Println("?")
	a := app.New()
	w := a.NewWindow("UMGo")
	w.Resize(fyne.NewSize(420, 300))

	//intrlCount := 0
	//interlocutors := make([]Interlocutor, 1024)

	msgCount := 0
	currMsg := 0
	messages := make([]string, 1024)

	label := widget.NewLabel("-")
	wrong := widget.NewLabel("-")
	state := widget.NewLabel(" ")
	current := widget.NewLabel(" ")
	text1 := widget.NewMultiLineEntry()
	text1.Disable()
	text2 := widget.NewMultiLineEntry()
	entry := widget.NewEntry()
	entry.SetText(myIp)

	w.SetContent(container.NewVBox(
		widget.NewLabel("Ваш адрес: "+myIp),
		widget.NewLabel("Отправитель:"),
		label,
		widget.NewSeparator(),
		widget.NewLabel("Текст сообщения:"),
		text1,

		container.NewHBox(
			widget.NewLabel("Текущее сообщ.: "),
			current,

			widget.NewButton("<", func() {
				if currMsg > 0 {
					currMsg -= 1
					text1.SetText(messages[currMsg])
					current.SetText(strconv.Itoa(currMsg + 1))
				}
			}),

			widget.NewButton(">", func() {
				if currMsg < msgCount-1 {
					currMsg += 1
					text1.SetText(messages[currMsg])
					current.SetText(strconv.Itoa(currMsg + 1))
				}
			}),

			widget.NewLabel("Всего сообщ.:"),
			state),

		widget.NewSeparator(),
		widget.NewLabel("Текст:"),
		text2,
		widget.NewSeparator(),
		widget.NewLabel("Получатель:"),
		entry,
		wrong,

		widget.NewButton("Отправить", func() {
			if validate(entry.Text) {
				wrong.SetText(" ")
				go send(entry.Text, text2.Text) //Отправка сообщения
			} else {
				wrong.SetText("неверный адрес")
			}
		}),
	))

	var listen func()
	listen = func() { //UDP server
		go send(allIp(myIp), "#new")
		go send(allIp(myIp), "#online")
		pc, err := net.ListenUDP("udp", &net.UDPAddr{
			Port: 12345,
			IP:   net.ParseIP(allIp(myIp)),
		})
		if err != nil {
			wrong.SetText("не удалось установить соединение: " + err.Error())
			time.Sleep(25 * time.Second)
			go listen()
			return
		}
		defer pc.Close()

		for {
			buf := make([]byte, 1024)
			_, address, err := pc.ReadFromUDP(buf)
			if err != nil {
				wrong.SetText(err.Error())
				continue
			}

			msg := string(buf)
			addr := address.String()
			if split(addr, ":")[0] == myIp {
				wrong.SetText(msg)
				continue
			}

			if msgCount == 0 {
				text1.SetText(msg)
				label.SetText(addr)
				current.SetText("1")
			}
			state.SetText(strconv.Itoa(msgCount + 1))
			messages[msgCount] = msg
			msgCount += 1
		}
		return
	}

	go listen()

	w.ShowAndRun()
}
