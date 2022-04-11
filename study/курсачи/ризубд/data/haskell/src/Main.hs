module Main where

f x = x                   -- интегрируемая функция
a = 0.0                   -- левый конец интервала
b = 1.0                   -- правый конец интервала
n = 100000000             -- число точек разбиения
ns = [1 .. n] :: [Double] -- точки разбиения
h = (b - a) / n           -- шаг интегрирования

main :: IO ()
main = do
  print $
    show $
      0.5 * (f a + f b) * h
        + foldl -- тут должна была быть параллельная свертка, но у меня не получилось
          (\r i -> r + f (a + i * h) * h)
          0.0
          ns
