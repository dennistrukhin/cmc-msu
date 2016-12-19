program hw4_1;

var
  n, m, p: integer;
  result: boolean;

begin
  write('Введите натуральное n: ');
  readln(n);
  m := 1;
  p := -1;
  result := false;
  repeat
    if n = m then
      result := true;
    inc(p);
    m := m * 5;
  until m > n;
  if result then
    writeln('Да, степень = ', p)
  else
    writeln('Нет');
end.
