import java.util.ArrayList;

class Integrator extends Thread { // поток вычисляющий интеграл
    private final double a;
    private final double b;
    private final int n;
    private final double[] result;

    Integrator(double a, double b, int n, double[] result) {
        this.a = a;
        this.b = b;
        this.n = n;
        this.result = result;
    }

    private static double f(double x) { // интегрируемая функция
        return x;
    }

    @Override
    public void run() { // процедура вычисления интеграла
        double h = (b - a) / n; // шиг интегрирования
        double res = 0.5 * (f(a) + f(b)) * h;
        for (int i1 = 1; i1 < n; i1++) {
            res += f(a + i1 * h) * h;
        }
        synchronized (result) { // внутренняя блокировка объекта
            result[0] += res; // сложение промежуточного результата в общую память
        }
    }
}

class Main {
    public static void main(String[] args) {
        double a = 0; // левый конец интервала
        double b = 1; // правый конец интервала
        var n = 100000000; // число точек разбиения

        var threads = new ArrayList<Thread>();
        final double[] result = {0};
        int p = 0; // общее кол-во запускаемых потоков

        try {
            p = Integer.parseInt(args[0]);
        } catch (NumberFormatException e) {
            System.err.println("Аргумент должен быть числом!");
            System.exit(1);
        }
        if (p < 1 || p > 25) {
            System.err.println("Число экземпляров должно быть в диапазоне от 1 до 25!");
            System.exit(1);
        }

        for (int i = 0; i < p; i++) { // создание экземпляров потоков
            var len = (b - a) / ((double) p); // длина отрезка интегрирования для текущего потока
            var local_n = n / p; // число точек разбиения для текущего потока
            var local_a = a + ((double) i) * len; // левый конец интервала для текущего потока
            var local_b = local_a + len; // правый конец интервала
            var thread = new Integrator(local_a, local_b, local_n, result);
            threads.add(thread);
        }

        threads.forEach((t) -> { // запуск потоков
            t.start();
            try {
                t.join(); // закрытие потоков
            } catch (InterruptedException e) {
                System.err.println("Ошибка вычислений!");
                System.exit(1);
            }
        });
        System.out.println("Интеграл от " + a + " до " + b + " = " + result[0]);
    }
}