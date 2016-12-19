program hw7_3;

var
  m, n, product, lcm: integer;

begin
  write('Введите два числа: ');
  readln(m, n);
  product := m * n;
  while m <> n do
    if m > n then
      m := m - n
    else
      n := n - m;
  lcm := product div m;
  writeln('НОК = ', lcm);
end.
