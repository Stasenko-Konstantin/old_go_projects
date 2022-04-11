package src

import (
	"net"
	"strconv"
	"strings"
	"time"

	pinger "github.com/go-ping/ping"

	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/container"
	"fyne.io/fyne/v2/dialog"
	"fyne.io/fyne/v2/widget"
)

var myIp = localIp().String()

func serve(pc net.PacketConn, address net.Addr, buf []byte) {
	buf[2] |= 0x80
	pc.WriteTo(buf, address)
}

func Start() {
	_, mlog := newLogger()
	defer mlog.Close()
	defer mlog.Write([]byte("End\n"))
	mlog.Write([]byte("Start\n"))

	a := app.New()
	w := a.NewWindow("UMGo")
	w.Resize(fyne.NewSize(1000, 600))

	intrlCount := 0
	interlocutors := make([]Interlocutor, 1024)

	pingCount := 1
	msgCount := 0
	currMsg := 0
	messages := make([]string, 1024)
	senders := make([]string, 1024)
	counts := []string{"1", "5", "10", "15", "20", "30", "40", "50", "75", "100"}

	currName := 0
	names := make([]string, 30)

	license := "\n\tUMGo - a \"messenger\" that sends and receives messages via udp in local net\n" +
		"\tCopyright (C) 2021  Stasenko Konstantin\n" + "\n\n" +
		"\tThis program is free software: you can redistribute it and/or modify\n" +
		"\tit under the terms of the GNU General Public License as published by\n" +
		"\tthe Free Software Foundation, either version 3 of the License, or\n" +
		"\t(at your option) any later version.\n" + "\n\n" +
		"\tThis program is distributed in the hope that it will be useful,\n" +
		"\tbut WITHOUT ANY WARRANTY; without even the implied warranty of\n" +
		"\tMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n" +
		"\tGNU General Public License for more details.\n" + "\n\n" +
		"\tYou should have received a copy of the GNU General Public License\n" +
		"\talong with this program.  If not, see <http://www.gnu.org/licenses/>.\n" + "\n\n" +
		"\tcontacts:\n" +
		"\t    mail - stasenko.ky@gmail.com\n" +
		"\t    github - Stasenko-Konstantin\n\n"

	label := widget.NewLabel(" ")
	wrong := widget.NewLabel(" ")
	state := widget.NewLabel(" ")
	current := widget.NewLabel(" ")
	ping := widget.NewLabel(" ")
	text1 := widget.NewMultiLineEntry()
	text1.Disable()
	text2 := widget.NewMultiLineEntry()
	entry := widget.NewEntry()
	changeName := widget.NewEntry()
	changeName.SetText("Anon")

	selectIntrl := func(name string) {
		for _, e := range interlocutors {
			if e.name == name {
				entry.SetText(split(e.address, ":")[0])
				wrong.SetText("-")
			}
		}
	}

	selectPingCount := func(count string) {
		pingCount, _ = strconv.Atoi(count)
	}

	listIntrls := widget.NewSelect(names, selectIntrl)
	pingCounts := widget.NewSelect(counts, selectPingCount)

	offline := func() { send(allIp(myIp), "#offline") }
	changeDialog := func(p func(int) bool, cMsg func(int) int) {
		if p(currMsg) {
			currMsg = cMsg(currMsg)
			text1.SetText(messages[currMsg])
			current.SetText(strconv.Itoa(currMsg + 1))
			sender := senders[currMsg]
			mlog.Write([]byte("получения адреса -- старт\n"))
			mlog.Write([]byte(sender + "\n"))
			addr := split(sender, ",")[1]
			mlog.Write([]byte("получения адреса -- конец\n"))
			mlog.Write([]byte("получение статуса 1 -- старт\n"))
			status, err := statusIntrls(interlocutors, addr)
			if err != nil {
				mlog.Write([]byte(err.Error()))
			}
			mlog.Write([]byte("получение статуса 1 -- конец\n"))
			mlog.Write([]byte("получение статуса 2 -- старт\n"))
			status2 := isOnline(status)
			mlog.Write([]byte("получение статуса 2 -- конец\n"))
			label.SetText(sender + ", " + status2)
		}
	}

	pingC := func () {
		truler := widget.NewLabel("")
		recivier := widget.NewEntry()
		recivier.Resize(fyne.NewSize(100, entry.Size().Height))
		recivier.Refresh()
		recivier.OnChanged = func(addr string) {
			if validate(addr) {
				truler.SetText("Ok")
			} else {
				truler.SetText("×")
			}
		}
		d := dialog.NewCustom("Пинг", "Ok", container.NewVBox(
			container.NewHBox(
				truler,
				container.NewWithoutLayout(recivier),
			),
			container.NewHBox(
				widget.NewLabel("Кол-во пакетов: "),
				pingCounts,
				widget.NewButton("Отправить", func() {
					go func() {
						if validate(recivier.Text) {
							connPing, err := pinger.NewPinger(recivier.Text)
							connPing.SetPrivileged(true)
							if err != nil {
								mlog.Write([]byte(err.Error()))
								wrong.SetText(err.Error())
							}
							connPing.Count = pingCount
							err = connPing.Run()
							mlog.Write([]byte("запуск пинга -- старт\n"))
							if err != nil {
								mlog.Write([]byte(err.Error()))
							}
							mlog.Write([]byte("запуск пинга -- конец\n"))
							ping.SetText(connPing.Addr())
						}
					}()
				}),
				ping,
			),
		), w)
		d.Resize(fyne.NewSize(250, 100))
		d.Show()
	}

	mainMenu := fyne.NewMainMenu(fyne.NewMenu("Меню",
		fyne.NewMenuItem("Лицензия", func() { dialog.ShowInformation("Лицензия", license, w) }),
		fyne.NewMenuItem("Пинг", pingC ),
	))

	w.SetMainMenu(mainMenu)

	w.SetContent(container.NewVScroll(
		container.NewVBox(
		widget.NewLabel("Ваше имя:"),
		changeName,
		widget.NewLabel("Ваш адрес: "+myIp),
		widget.NewSeparator(),
		container.NewHBox(
			widget.NewLabel("Отправитель:"),
			label,
		),
		widget.NewLabel("Текст сообщения:"),
		text1,

		container.NewHBox(
			widget.NewLabel("Текущее сообщ.: "),
			current,

			widget.NewButton("<", func() {
				changeDialog(func(cMsg int) bool { return cMsg > 0 },
					func(cMsg int) int { return cMsg - 1 })
			}),

			widget.NewButton(">", func() {
				changeDialog(func(cMsg int) bool { return cMsg < msgCount-1 },
					func(cMsg int) int { return cMsg + 1 })
			}),

			widget.NewLabel("Всего сообщ.:"),
			state),

		widget.NewSeparator(),
		widget.NewLabel("Текст:"),
		text2,
		widget.NewSeparator(),
		widget.NewLabel("Получатель:"),
		entry,
		widget.NewCheck("всем?", func(isAll bool) {
			if isAll {
				entry.Disable()
				entry.SetText(allIp(myIp))
			} else {
				entry.Enable()
				entry.SetText(" ")
			}
		}),

		listIntrls,
		wrong,

		widget.NewButton("Отправить", func() {
			if validate(entry.Text) {
				wrong.SetText(" ")
				go send(entry.Text, text2.Text)
			} else {
				wrong.SetText("неверный адрес")
			}
		}),
	)))

	go send(allIp(myIp), "#online|"+changeName.Text)
	var listen func(a string)
	listen = func(a string) { //UDP server
		checkError := func(err error) bool {
			if err != nil {
				wrong.SetText("не удалось установить соединение: " + err.Error())
				mlog.Write([]byte("не удалось установить соединение: " + err.Error() + "\n"))
				time.Sleep(25 * time.Second)
				go listen(a)
				return true
			}
			return false
		}

		pc, err := net.ListenPacket("udp", a+":12345")
		check := checkError(err)
		if check {
			return
		}

		defer pc.Close()

		for {
			buf := make([]byte, 1024)
			_, address, err := pc.ReadFrom(buf)
			if err != nil {
				mlog.Write([]byte(err.Error() + "\n"))
				continue
			}

			msg := string(buf)
			addr := address.String()
			if split(addr, ":")[0] == myIp {
				continue
			}

			if strings.Contains(msg, "#offline") {
				for _, e := range interlocutors {
					if e.address == addr {
						e.status = false
					}
				}
				continue
			}

			if strings.Contains(msg, "|") {
				parts := split(msg, "|")
				keyword, name := parts[0], parts[1]
				if keyword == "#online" {
					if !contains(names, name) {
						go send(allIp(myIp), "#online|"+changeName.Text)
						names[currName] = name
						currName += 1
						interlocutors[intrlCount] = Interlocutor{name, addr, true}
						intrlCount += 1
					} else {
						for _, e := range interlocutors {
							if addr == e.address {
								e.status = true
							}
						}
					}
				}
				continue
			}

			if msgCount == 0 {
				text1.SetText(msg)
				name, err := takeName(interlocutors, addr)
				if err != nil {
					mlog.Write([]byte(err.Error()))
				}
				label.SetText(name + ", online")
			}
			state.SetText(strconv.Itoa(msgCount + 1))
			messages[msgCount] = msg
			senders[msgCount], err = takeName(interlocutors, addr)
			if err != nil {
				mlog.Write([]byte(err.Error()))
			}
			msgCount += 1
		}
	}

	go listen(myIp)

	w.ShowAndRun()
	defer offline()
}
