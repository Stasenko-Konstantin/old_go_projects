use std::env;
use std::process::exit;

use actix::prelude::*;

// структура сообщения отправляемого актору
#[derive(Message)]
#[rtype(result = "f64")]
struct Msg(f64, f64, i32);

// актор вычисляющий интеграл
struct Integrator;

// реализация trait`a Actor для нашей структуры
impl Actor for Integrator {
    type Context = Context<Self>;
}

// реализация обработки сообщений
impl Handler<Msg> for Integrator {
    type Result = f64;

    // обработчик сообщений
    fn handle(&mut self, Msg(a, b, n): Msg, _ctx: &mut Self::Context) -> Self::Result {
        let h = (b - a) / (n as f64); // шаг интегрирования
        let mut res = 0.5 * (f(a) + f(b)) * h;
        for i in 1..n {
            res += f(a + (i as f64) * h) * h;
        }
        res
    }
}

fn f(x: f64) -> f64 { // интегрируемая функция
    x
}

#[actix::main]
async fn main() {
    let a: f64 = 0.;   // левый конец интервала
    let b: f64 = 1.;   // правый конец интервала
    let n = 100000000; // число точек разбиения

    let mut result: f64 = 0.;
    let mut actors: Vec<Addr<Integrator>> = Vec::new();
    let p: usize; // общее кол-во запускаемых акторов

    let args: Vec<String> = env::args().collect();
    if args.len() != 2 {
        eprintln!("Использование: ./actors <экземпляры> или actors.exe <экземпляры>");
        exit(1);
    }
    match args[1].parse() {
        Ok(res) => p = res,
        Err(_) => {
            eprintln!("Аргумент должен быть числом!");
            exit(1);
        }
    };
    if p < 1 || p > 25 {
        eprintln!("Число экземпляров должно быть в диапазоне от 1 до 25!");
        exit(1);
    }

    for _ in 1..p + 1 { // создание экземпляров акторов
        let actor = Integrator.start();
        actors.push(actor);
    }

    for i in 0..actors.len() { // получение результатов
        let len = (b - a) / (p as f64);    // длина отрезка интегрирования для текущего актора
        let n = n / p;                     // число точек разбиения для текущего актора
        let a = a + (i as f64) * len;      // левый конец интервала для текущего актора
        let b = a + len;                   // правый конец интервала
        let msg = Msg(a, b, n as i32);     // отправка сообщения актору
        result += actors[i]                // получение результата
            .send(msg)
            .await
            .unwrap();
    }
    println!("Интеграл от {} до {} = {}", a, b, result);
}
