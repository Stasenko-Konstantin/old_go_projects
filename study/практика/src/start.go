package src

import (
	"database/sql"
	"errors"
	"fmt"
	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/container"
	"fyne.io/fyne/v2/dialog"
	"fyne.io/fyne/v2/widget"
	_ "github.com/mattn/go-sqlite3"
	"os"
	"reflect"
	"strconv"
	"strings"
	_ "strings"
)

var (
	patients = [][]string{[]string{"ID", "Страховая компания", "ФИО", "Место жительства",
		"Дата рождения", "Пол", "Участок", ""}}
	doctors    = [][]string{[]string{"ФИО", "Отделение", "Специализация", "Участок", ""}}
	talons = [][]string{[]string{"ID", "Дата и время приема", "Доктор", "Пациент", ""}}
)

//
// Последний запрос - Манежная !!!!!!!!!!!!!!
//

func Start() {
	mylog := newLogger()

	defer func() {
		if r := recover(); r != nil {
			s := r.(error)
			mylog.Write([]byte(s.Error() + " aga"))
		}
	}()

	a := app.New()
	w := a.NewWindow("практика")
	w.Resize(fyne.NewSize(1800, 900))

	connect()
	mylog.Write([]byte("DB connection complete"))

	for _, e := range dbs {
		switch e.(type) {
		case []patient:
			for _, p := range e.([]patient) {
				var sex string
				if p.sex {
					sex = "Ж."
				} else {
					sex = "М."
				}
				birth := strings.Split(p.birth, "T")[0]
				patients = append(patients, []string{strconv.Itoa(p.id), p.insuranceCompany, p.sfm, p.residence,
					birth, sex, strconv.Itoa(p.district), ""})
			}
		case []doctor:
			for _, d := range e.([]doctor) {
				doctors = append(doctors, []string{d.sfm, d.department, d.specialization, strconv.Itoa(int(d.district.Int32)), ""})
			}
		case []talon:
			for _, t := range e.([]talon) {
				r := strings.Split(t.reception, "T")
				r[1] = r[1][0:5]
				reception := stringConcat(r, " ")
				talons = append(talons, []string{strconv.Itoa(t.id), reception, t.doctor, t.patient, ""})
			}
		}
	}

	mylog.Write([]byte("Data is full"))

	patientsT := widget.NewTable(
		func() (int, int) {
			return len(patients), len(patients[0])
		},
		func() fyne.CanvasObject {
			return container.NewVBox(widget.NewEntry())
		},
		func(i widget.TableCellID, o fyne.CanvasObject) {
			if i.Row == 0 {
				o.(*fyne.Container).Objects[0] = widget.NewLabel(patients[i.Row][i.Col])
			} else if i.Col == 7 {
				o.(*fyne.Container).Objects[0] = widget.NewButton("", func() {
					fmt.Println(i.Col, i.Row)
				})
			} else {
				o.(*fyne.Container).Objects[0].(*widget.Entry).SetText(patients[i.Row][i.Col])
			}
		})
	patientsT.SetColumnWidth(0, 50.0)
	patientsT.SetColumnWidth(1, 170.0)
	patientsT.SetColumnWidth(2, 300.0)
	patientsT.SetColumnWidth(3, 430.0)
	patientsT.SetColumnWidth(4, 130.0)
	patientsT.SetColumnWidth(5, 50.0)
	patientsT.SetColumnWidth(6, 70.0)

	doctorsT := widget.NewTable(
		func() (int, int) {
			return len(doctors), len(doctors[0])
		},
		func() fyne.CanvasObject {
			return container.NewVBox(widget.NewEntry())
		},
		func(i widget.TableCellID, o fyne.CanvasObject) {
			if i.Row == 0 {
				o.(*fyne.Container).Objects[0] = widget.NewLabel(doctors[i.Row][i.Col])
			} else if i.Col == 4 {
				o.(*fyne.Container).Objects[0] = widget.NewButton("", func() {})
			} else {
				o.(*fyne.Container).Objects[0].(*widget.Entry).SetText(doctors[i.Row][i.Col])
			}
		})
	doctorsT.SetColumnWidth(0, 300.0)
	doctorsT.SetColumnWidth(1, 270.0)
	doctorsT.SetColumnWidth(2, 200.0)
	doctorsT.SetColumnWidth(3, 70.0)

	talonsT := widget.NewTable(
		func() (int, int) {
			return len(talons), len(talons[0])
		},
		func() fyne.CanvasObject {
			return widget.NewLabel("")
		},
		func(i widget.TableCellID, o fyne.CanvasObject) {
			o.(*widget.Label).SetText(talons[i.Row][i.Col])
		})
	talonsT.SetColumnWidth(0, 50.0)
	talonsT.SetColumnWidth(1, 170.0)
	talonsT.SetColumnWidth(2, 300.0)
	talonsT.SetColumnWidth(3, 300.0)

	mylog.Write([]byte("Table template ready"))

	checkErr := func(err error) {
		if err != nil {
			fmt.Println(err.Error())
		}
	}

	result := widget.NewMultiLineEntry()
	result.Disable()
	result.Move(fyne.NewPos(0.0, 40.0))
	result.Resize(fyne.NewSize(1800, 250))
	requestE := widget.NewEntry()

	//1 выбрать пациентов за конкретный период
	var perS *widget.Select
	ops := []string{">", ">=", "<", "<=", "=="}
	op := ops[0]
	opS := widget.NewSelect(ops, func(opfS string) {
		op = opfS
		perS.SetSelectedIndex(perS.SelectedIndex())
	})
	pers := makePers()
	perS = widget.NewSelect(pers, func(per string) {
		requestE.SetText("P.sfm, P.birth, D.sfm from patients as P join doctors as D join talons as T on P.sfm = T.patient and D.sfm = T.doctor where T.reception " + op + " " +
			per)
	})
	r1 := container.NewVBox(container.NewHBox(opS), perS)
	perS.Move(fyne.NewPos(0, 10))
	perS.Refresh()
	opS.SetSelectedIndex(0)

	//2 выбрать врачей, лечивших конкретного пациента
	pats := makePats()
	patS := widget.NewSelect(pats, func(pat string) {
		requestE.SetText("T.doctor, T.reception from patients as P join talons as T on P.sfm = T.patient where P.sfm == \"" +
			pat + "\"")
	})
	r2 := container.NewVBox(patS)
	patS.Move(fyne.NewPos(0, 10))
	patS.Refresh()

	//3 выбрать пациентов, лечившихся у конкретного врача
	docs := makeDocs()
	docS := widget.NewSelect(docs, func(doc string) {
		requestE.SetText("T.patient, T.reception from patients as P join talons as T join doctors as D on P.sfm = T.patient where D.sfm == \"" +
			doc + "\"")
	})
	r3 := container.NewVBox(docS)
	docS.Move(fyne.NewPos(0, 10))
	docS.Refresh()

	//4 вывести пациентов с одного участка
	deps := makeDeps()
	depS := widget.NewSelect(deps, func(dep string) {
		requestE.SetText("P.sfm, P.birth, P.residence from patients as P where P.district == " +
			dep)
	})
	r4 := container.NewHBox(depS)
	depS.Move(fyne.NewPos(0, 10))
	depS.Refresh()

	//5 вывести пациентов, пользующихся одной страховой компанией
	cmps := makeCmps()
	cmpS := widget.NewSelect(cmps, func(cmp string) {
		requestE.SetText("P.sfm, P.residence from patients as P where P.insurance_company == \"" +
			cmp + "\"")
	})
	r5 := container.NewHBox(cmpS)
	cmpS.Move(fyne.NewPos(0, 10))
	cmpS.Refresh()

	//6 вывести пациентов за определенный период по дате их рождения
	var brtS *widget.Select
	ops6 := []string{">", ">=", "<", "<=", "=="}
	op6 := ops6[0]
	opS6 := widget.NewSelect(ops6, func(opfS string) {
		op6 = opfS
		brtS.SetSelectedIndex(brtS.SelectedIndex())
	})
	brts := makeBrts()
	brtS = widget.NewSelect(brts, func(brt string) {
		requestE.SetText("P.sfm, P.residence from patients as P where P.birth " + op6 + " \"" +
			brt + "\"")
	})
	r6 := container.NewVBox(container.NewHBox(opS6), brtS)
	brtS.Move(fyne.NewPos(0, 10))
	brtS.Refresh()
	opS6.SetSelectedIndex(0)

	//7 вывести пациентов, лечившихся у докторов определенной специализации
	spcs := makeSpcs()
	spcS := widget.NewSelect(spcs, func(spc string) {
		requestE.SetText("P.sfm, P.residence, D.sfm from patients as P join doctors as D join talons as T on P.sfm = T.patient and D.sfm = T.doctor where D.specialization == \"" +
			spc + "\"")
	})
	r7 := container.NewVBox(spcS)
	spcS.Move(fyne.NewPos(0, 10))
	spcS.Refresh()

	//8 вывести пациентов, лечившихся у докторов из одного отделения
	otds := makeOtds()
	otdS := widget.NewSelect(otds, func(otd string) {
		requestE.SetText("P.sfm, P.birth, D.sfm from patients as P join doctors as D join talons as T on P.sfm = T.patient and D.sfm = T.doctor where D.department == \"" +
			otd + "\"")
	})
	r8 := container.NewVBox(otdS)
	otdS.Move(fyne.NewPos(0, 10))
	otdS.Refresh()

	//9 вывести пациентов одного пола
	sexs := []string{"М.", "Ж."}
	sexS := widget.NewSelect(sexs, func(sex string) {
		rSex := "0"
		if sex == "М." {
			rSex = "1"
		}
		requestE.SetText("P.sfm, P.birth, P.residence from patients as P where P.sex == " +
			rSex)
	})
	r9 := container.NewHBox(sexS)
	sexS.Move(fyne.NewPos(0, 10))
	sexS.Refresh()

	//10 вывести пациентов, живущих по одному и тому же месту жительства
	adrs := makeAdrs()
	adrS := widget.NewSelect(adrs, func(adr string) {
		requestE.SetText("P.sfm, P.birth, P.sex from patients as P where P.residence == \"" +
			adr + "\"")
	})
	r10 := container.NewVBox(adrS)
	adrS.Move(fyne.NewPos(0, 10))
	adrS.Refresh()

	perS.SetSelectedIndex(0) // из первого запроса

	hideAll := func() {
		r1.Hide()
		r2.Hide()
		r3.Hide()
		r4.Hide()
		r5.Hide()
		r6.Hide()
		r7.Hide()
		r8.Hide()
		r9.Hide()
		r10.Hide()
	}
	hideAll()
	r1.Show()

	rs := []string{
		"Пациенты за конкретный период",
		"Врачи лечившие конкретного пациента",
		"Пациенты лечившиеся у конкретного врача",
		"Пациенты с одного участка",
		"Пациенты, пользующиеся одной страховой компанией",
		"Пациенты за определенный период по дате их рождения",
		"Пациенты, лечившиеся у докторов определенной специализации",
		"Пациенты, лечившиеся у докторов из одного отделения",
		"Пациенты одного пола",
		"Пациенты, живущие по одному и тому же месту жительствая",
	}
	requests := widget.NewSelect(rs, func(r string) {
		hideAll()
		switch r {
		case rs[0]:
			r1.Show()
			perS.SetSelectedIndex(0)
		case rs[1]:
			r2.Show()
			patS.SetSelectedIndex(0)
		case rs[2]:
			r3.Show()
			docS.SetSelectedIndex(0)
		case rs[3]:
			r4.Show()
			depS.SetSelectedIndex(0)
		case rs[4]:
			r5.Show()
			cmpS.SetSelectedIndex(0)
		case rs[5]:
			r6.Show()
			brtS.SetSelectedIndex(0)
		case rs[6]:
			r7.Show()
			spcS.SetSelectedIndex(0)
		case rs[7]:
			r8.Show()
			otdS.SetSelectedIndex(0)
		case rs[8]:
			r9.Show()
			sexS.SetSelectedIndex(0)
		case rs[9]:
			r10.Show()
			adrS.SetSelectedIndex(0)
		}
	})
	requests.SetSelectedIndex(0)

	requestsC := container.NewVBox(
		requests,
		r1,
		r2,
		r3,
		r4,
		r5,
		r6,
		r7,
		r8,
		r9,
		r10,
		requestE,
	)
	requestsC.Move(fyne.NewPos(0.0, 300.0))
	requestsC.Resize(fyne.NewSize(1600, 200))
	requestsC.Refresh()

	mylog.Write([]byte("Request fields ready\n"))

	tabs := container.NewAppTabs(
		container.NewTabItem("Пациенты", patientsT),
		container.NewTabItem("Врачи", doctorsT),
		container.NewTabItem("Талоны", talonsT),
		container.NewTabItem("Запросы", container.NewWithoutLayout(
			container.NewHBox(
				widget.NewButton("Запрос", func() {
					go func() {
						defer func() {
							if r := recover(); r != nil {
								s := reflect.ValueOf(r)
								mylog.Write([]byte(s.String() + "\n"))
								dialog.ShowError(errors.New(s.String()+"\nскорее всего неверный синтаксис ¯\\_:-/_/¯"), w)
							}
						}()
						db, err := sql.Open("sqlite3", "db.db")
						checkErr(err)
						rows, err := db.Query("select " + requestE.Text)
						checkErr(err)
						var r []*[]*sql.NullString
						i := 0
						for rows.Next() {
							var t []*sql.NullString
							r = append(r, &t)
							err := rows.ScanString(r[i])
							checkErr(err)
							i += 1
						}
						res := ""
						for _, e := range r {
							for _, ee := range *e {
								res += (*ee).String + " "
							}
							res += "\n"
						}
						result.SetText(res)
					}()
				}),
				widget.NewButton("Печать", func() {
					dialog.ShowFileSave(func(closer fyne.URIWriteCloser, err error) {
						if closer == nil {
							return
						}
						if err != nil {
							panic(err)
						}
						path := closer.URI().Path()
						closer.Close()
						text := []byte(result.Text)
						err = os.WriteFile(path, text, 0644)
						checkErr(err)
					}, w)
				}),
			),
			result,
			requestsC,
		)))

	prog := "Программа по производственной практике №2 \"Разработка программы для работы с базой данных\""
	author := "Курсант 432 гр. ТАТК ГА Стасенко Константин"

	mainMenu := fyne.NewMainMenu(fyne.NewMenu("Меню",
		fyne.NewMenuItem("О программе", func() { dialog.ShowInformation("О программе", prog, w) }),
		fyne.NewMenuItem("Об авторе", func() { dialog.ShowInformation("Об авторе", author, w) }),
	))

	w.SetMainMenu(mainMenu)

	mylog.Write([]byte("Start render\n"))

	w.SetContent(tabs)
	w.ShowAndRun()
}
