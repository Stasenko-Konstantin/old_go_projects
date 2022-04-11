use rayon::prelude::*;
use flot::range;

fn f(x: f64) -> f64 { // интегрируемая функция
    x
}

fn main() {
    let a: f64 = 0.; // левый конец интервала
    let b: f64 = 1.; // правый конец интервала
    let n = 100000000; // количество точек разбиения
    let ns: Vec<f64> = range(1.0, n as f64, 1.0).collect(); // точки разбиения
    let h: f64 = (b - a) / (n as f64); // шаг интегрированияn
    let res: f64 = 0.5 * (f(a) + f(b)) * h + ns
        .par_iter()
        .fold_with( 0.0, |r, i|
            r + f(a + (*i as f64) * h) * h)
        .sum::<f64>();
    println!("Интеграл от {} до {} = {}", a, b, res)
}
