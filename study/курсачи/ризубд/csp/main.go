package main

import (
	"fmt"
	"os"
	"strconv"
)

// процедура вычисления интеграда
func integrate(a, b float64, n int, c chan float64) {
	var (
		h   = (b - a) / float64(n) // шаг интегрования
		res = 0.5 * (f(a) + f(b)) * h
	)
	for i := 1; i < n; i++ {
		res += f(a+float64(i)*h) * h
	}
	c <- res // отправка результата по каналу
}

func f(x float64) float64 { // интегрируемая функция
	return x
}

const (
	a = 0.        // левый конец интервала
	b = 1.        // правый конец интервала
	n = 100000000 // число точек разбиения
)

func main() {
	var (
		result = 0.
		chans  []chan float64
		p      int // общее кол-во запускаемых горутин
	)

	args := os.Args
	if len(args) != 2 {
		_, _ = fmt.Fprintf(os.Stderr, "Использование: ./csp <экземпляры> или csp.exe <экземпляры>\n")
		os.Exit(1)
	}
	p, err := strconv.Atoi(args[1])
	if err != nil {
		_, _ = fmt.Fprintf(os.Stderr, "Аргумент должен быть числом!\n")
		os.Exit(1)
	}
	if p < 1 || p > 25 {
		_, _ = fmt.Fprintf(os.Stderr, "Число экземпляров должно быть в диапазоне от 1 до 25!\n")
	}

	for i := 0; i < p; i++ { // создание и запуска горутин
		var (
			length = (b - a) / float64(p)  // длина отрезка интегрирования для текущей горутины
			localN = n / p                 // число точек разбиения для текущей горутины
			localA = a + float64(i)*length // левый конец интервала для текущей горутины
			localB = localA + length       // правый конец интервала
			c      = make(chan float64)    // канал для общения между горутинами
		)
		go integrate(localA, localB, localN, c) // запуск горутины
		chans = append(chans, c)
	}

	for _, c := range chans { // получение результатов
		res := <-c // чтение из канала
		result += res
	}
	fmt.Printf("Интеграл от %f до %f = %f\n", a, b, result)
}
