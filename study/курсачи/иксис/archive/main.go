package main

import (
	"database/sql"
	"fmt"
	"github.com/gorilla/mux"
	_ "github.com/mattn/go-sqlite3"
	"io/fs"
	"io/ioutil"
	"math/rand"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"
)

type gameDir = []fs.FileInfo

type game struct {
	name        string
	description string
	number      string
	image1      string
	image2      string
	file        string
	genre       string
}

func newGame(d fs.FileInfo) (*game, error) {
	var r game
	r.number = d.Name()
	file, err := os.ReadFile("assets/games/" + r.number + "/text")
	if err != nil {
		return nil, err
	}
	text := strings.Split(string(file), "\n")
	r.name, r.description = text[0], sliceToStr(text[1:])
	r.image1 = "assets/games/" + r.number + "/image1.jpg"
	r.image2 = "assets/games/" + r.number + "/image2.jpg"
	r.file = "assets/games/" + r.number + "/game.nes"
	r.genre = findGenre(r.number)
	return &r, nil
}

type comment struct {
	name string
	date string
	text string
}

var (
	db []struct {
		id    int
		genre string
	}
	gameDirs gameDir
	slide    = []string{
		`<div class="nk-image-slider-item">
                <img src="assets/games/`, // № игры
		`/image2.jpg" alt="" class="nk-image-slider-img"
                     data-thumb="assets/games/`, // № игры
		`/image1.jpg">
                <div class="nk-image-slider-content">
                    <h3 class="h4">`, // название
		`</h3>
                    <p class="text-white">`, // описание
		`</p>
                    <a href="`, // № игры
		`" class="btn btn-slide btn-rounded btn-hover-color-main-1 ">Далее</a>
                </div>
            </div>`,
	}
	mainList = []string{
		`<div class="col-md-6">
                            <div class="blog-post">
                                <a href="`, // № игры
		`" class="post-img post-img-main">
                                    <img src="assets/games/`, // № игры
		`/image1.jpg" alt="">
                                </a>
                                <div class="gap"></div>
                                <h2 class="post-title h4"><a href="`, // № игры
		`">`, // название
		`</a></h2>
                                <div class="gap"></div>
                                <div class="post-text">
                                    <p>`, // описание
		`</p>
                                </div>
                                <div class="gap"></div>
                                <a href="`, // № игры
		`" class="btn btn-main btn-rounded btn-hover-color-main-1">Далее</a>
                            </div>
                        </div>`,
	}
	gameList = []string{
		`<div class="blog-post">
                        <div class="row vertical-gap">
                            <div class="col-md-5 col-lg-6">
                                <a href="`, // № игры
		`" class="post-img">
                                    <img src="assets/games/`, // № игры
		`/image1.jpg" alt="">
								</a>
                            </div>
                            <div class="col-md-7 col-lg-6">
                                <h2 class="post-title h4"><a href="`, // № игры
		`">`, // название
		`</a></h2>
                                <div class="post-text">
                                    <p>`, // описание
		`</p>
                                </div>
                            </div>
                        </div>
                    </div>`,
	}
	articleList = []string{
		`<div class="post-img blog-post-img">
                            <img src="assets/games/`, // № игры
		`/image2.jpg" alt=""></div>
                        <div class="gap-1"></div>
                        <h1 class="post-title h4">`, // название
		`</h1>
                        <div class="gap"></div>
                        <p>`, // описание
		`<div class="pagination pagination-center">
                        <a href="`, // файл
		`" class="pagination-prev">
                            Скачать
                        </a>
                    </div>`,
	}
)

func findGenre(number string) string {
	var r string
	for _, g := range db {
		id, err := strconv.Atoi(number)
		if err != nil {
			fmt.Println(err.Error())
			os.Exit(1)
		}
		if g.id == id {
			r = g.genre
			break
		}
	}
	return r
}

func getRandGame(g *gameDir) fs.FileInfo {
	rand.Seed(time.Now().UnixNano())
	n := rand.Intn(len(*g))
	r := (*g)[n]
	tmp := append((*g)[:n], (*g)[n+1:]...)
	*g = tmp
	return r
}

func sliceToStr(s []string) string {
	var r string
	for _, i := range s {
		r += i
	}
	return r
}

func splitSentences(d string) string {
	var (
		r     string
		count = 0
	)
	for n, i := range d {
		if i == '.' || i == '?' || i == '!' {
			count += 1
		}
		if count == 3 {
			r = d[:n] + ".."
			break
		}
	}
	return r
}

func getGames() (gameDir, error) {
	dirs, err := ioutil.ReadDir("./assets/games")
	if err != nil {
		return gameDir{}, err
	}
	return dirs, nil
}

func findGame(g string) fs.FileInfo {
	for _, i := range gameDirs {
		if i.Name() == g {
			return i
		}
	}
	return gameDirs[0]
}

func gamesHandler(genre *string, w http.ResponseWriter, r *http.Request) {
	var (
		gamesList []string
		genres    = false
	)
	if genre != nil {
		genres = true
	}
	file, err := os.ReadFile("assets/games.html")
	if err != nil {
		fmt.Fprintf(w, "Server error: "+err.Error())
		os.Exit(1)
	}
	gamesList = strings.Split(string(file), "Список игр")
	var tmp []string
	for i := 0; i < len(gameDirs); i++ {
		g, err := newGame(gameDirs[i])
		if err != nil {
			fmt.Fprintf(w, "cant make game struct: "+err.Error())
			os.Exit(1)
		}
		if genres {
			if g.genre == *genre {
				tmp = append(tmp, gameList[0]+g.number+gameList[1]+g.number+gameList[2]+g.number+gameList[3]+g.name+
					gameList[4]+splitSentences(g.description)+gameList[5]+"ㅤ")
			}
		} else {
			tmp = append(tmp, gameList[0]+g.number+gameList[1]+g.number+gameList[2]+g.number+gameList[3]+g.name+
				gameList[4]+splitSentences(g.description)+gameList[5]+"ㅤ")
		}
	}
	gamesList = append([]string{}, gamesList[0]+sliceToStr(tmp)+gamesList[1])
	fmt.Fprintf(w, sliceToStr(gamesList))
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
	var index []string
	file, err := os.ReadFile("assets/index.html")
	if err != nil {
		fmt.Fprintf(w, "Server error: "+err.Error())
		os.Exit(1)
	}
	index = strings.Split(string(file), "Слайдер")
	thisGames := append(gameDir{}, gameDirs...)
	var tmp []string
	for i := 0; i < 4; i++ {
		g, err := newGame(getRandGame(&thisGames))
		if err != nil {
			fmt.Fprintf(os.Stderr, "cant make game struct: "+err.Error())
			os.Exit(1)
		}
		tmp = append(tmp, slide[0]+g.number+slide[1]+g.number+slide[2]+g.name+slide[3]+g.description+slide[4]+g.number+slide[5])
	}
	index = append([]string{}, index[0]+sliceToStr(tmp)+index[1])
	index = strings.Split(index[0], "Главный список")
	tmp = []string{}
	for i := 0; i < 6; i++ {
		g, err := newGame(getRandGame(&thisGames))
		if err != nil {
			fmt.Fprintf(os.Stderr, "cant make game struct: "+err.Error())
			os.Exit(1)
		}
		tmp = append(tmp, mainList[0]+g.number+mainList[1]+g.number+mainList[2]+g.number+mainList[3]+
			g.name+mainList[4]+splitSentences(g.description)+mainList[5]+g.number+mainList[6])
	}
	index = append([]string{}, index[0]+sliceToStr(tmp)+index[1])
	fmt.Fprintf(w, sliceToStr(index))
}

func articleHandler(n string, w http.ResponseWriter, r *http.Request) {
	var article []string
	file, err := os.ReadFile("assets/article.html")
	if err != nil {
		fmt.Fprintf(w, "Server error: "+err.Error())
		os.Exit(1)
	}
	article = strings.Split(string(file), "Заголовок")
	g, err := newGame(findGame(n))
	if err != nil {
		fmt.Fprintf(w, "cant make game struct: "+err.Error())
		os.Exit(1)
	}
	article = strings.Split(sliceToStr([]string{article[0], g.number, article[1]}), "Содержимое")
	article = append([]string{},
		article[0]+articleList[0]+g.number+articleList[1]+g.name+articleList[2]+
			g.description+articleList[3]+g.file+articleList[4]+article[1])
	fmt.Fprintf(w, sliceToStr(article))
}

func articleComment(n string, w http.ResponseWriter, r *http.Request) {
	params := mux.Vars(r)
	fmt.Println(params)
}

func main() {
	fmt.Println("server start")
	dirs, err := getGames()
	if err != nil {
		fmt.Fprintf(os.Stderr, "cant read gameDirs directories: "+err.Error())
		os.Exit(1)
	}
	gameDirs = dirs
	data, err := sql.Open("sqlite3", "db.db")
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
	games, err := data.Query("select * from games")
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
	defer func(games *sql.Rows) {
		err := games.Close()
		if err != nil {
			fmt.Println(err.Error())
			os.Exit(1)
		}
	}(games)
	for games.Next() {
		g := struct {
			id    int
			genre string
		}{}
		err := games.Scan(&g.id, &g.genre)
		if err != nil {
			fmt.Println("dont read game from db: " + err.Error())
			continue
		}
		db = append(db, g)
	}
	r := mux.NewRouter()
	r.HandleFunc("/", indexHandler).Methods("GET")
	r.HandleFunc("/games", func(w http.ResponseWriter, r *http.Request) {
		gamesHandler(nil, w, r)
	}).Methods("GET")
	r.HandleFunc("/beat em up", func(w http.ResponseWriter, r *http.Request) {
		genre := "beat em up"
		gamesHandler(&genre, w, r)
	}).Methods("GET")
	r.HandleFunc("/arcade", func(w http.ResponseWriter, r *http.Request) {
		genre := "arcade"
		gamesHandler(&genre, w, r)
	}).Methods("GET")
	r.HandleFunc("/platform", func(w http.ResponseWriter, r *http.Request) {
		genre := "platform"
		gamesHandler(&genre, w, r)
	}).Methods("GET")
	r.HandleFunc("/run and gun", func(w http.ResponseWriter, r *http.Request) {
		genre := "run and gun"
		gamesHandler(&genre, w, r)
	}).Methods("GET")
	r.HandleFunc("/rpg", func(w http.ResponseWriter, r *http.Request) {
		genre := "rpg"
		gamesHandler(&genre, w, r)
	}).Methods("GET")
	for i := 1; i < len(gameDirs)+1; i++ {
		n := strconv.Itoa(i)
		r.HandleFunc("/"+n, func(w http.ResponseWriter, r *http.Request) {
			articleHandler(n, w, r)
		}).Methods("GET")
		r.HandleFunc("/"+n+"/get", func(w http.ResponseWriter, r *http.Request) {
			articleComment(n, w, r)
		}).Methods("get")
	}
	staticFileDir := http.Dir("./assets/")
	staticFileHandler := http.StripPrefix("/assets/", http.FileServer(staticFileDir))
	r.PathPrefix("/assets/").Handler(staticFileHandler).Methods("GET")
	http.ListenAndServe(":8080", r)
}
