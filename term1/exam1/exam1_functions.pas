unit exam2_functions;

interface

uses
  exam2_types;

function integral(f: Ftype; a, b, eps2: real): real;
procedure root(f, g, f1, g1: Ftype; a, b, eps1: real; var x: real);

implementation

function integral(f: Ftype; a, b, eps2: real): real;
var
  s, h, r_current, r_last: real;
  {s = сумма, h = шаг}
  {r_current - текущий результат}
  {r_last - результат вычислений при прошлом количестве разбиений}
  i, m: integer;
  {i = итератор, m = множитель для четных/нечетных значений f(x)}
  n: integer;
  {n = количество разбиений}
begin
  n := 0;
  r_current := 0;
  repeat
    r_last := r_current;
    n := n + 10;
    h := (b - a) / (n - 1);
    s := f(a) + f(b);
    m := 4;
    for i := 1 to n - 2 do begin
      s := s + m * f(a + h * i);
      if i mod 2 = 1 then m := 2 else m := 4;
    end;
    r_current := s * h / 3;
  until
    abs(r_current - r_last) < eps2;

  integral := r_current;
end;

procedure root(f, g, f1, g1: Ftype; a, b, eps1: real; var x: real);
var
  x_current, x_last: real;
begin
  x_current := a;
  repeat
    x_last := x_current;
    x_current := x_last - (f(x_last) - g(x_last)) / (f1(x_last) - g1(x_last));
  until
    abs(x_current - x_last) < eps1;
  x := x_current;
end;

end.
