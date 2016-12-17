program exam2;
uses
  exam2_types,
  exam2_functions;

var
  x1, x2, x3: real;
  {точки пересечения графиков функций}
  s1, s2, s3: real;
  {интегралы соответствующих функций}
  s: real;
  {Площадь искомой фигуры}

function f1(x: real): real;
begin
  f1 := exp(x) + 2;
end;

function f1_d1(x: real): real;
begin
  f1_d1 := exp(x);
end;

function f2(x: real): real;
begin
  f2 := -1 / x;
end;

function f2_d1(x: real): real;
begin
  f2_d1 := 1 / (x * x);
end;

function f3(x: real): real;
begin
  f3 := -2/3 * (x + 1);
end;

function f3_d1(x: real): real;
begin
  f3_d1 := -2/3;
end;

begin
  root(@f1, @f3, @f1_d1, @f3_d1, -1, 0, 0.001, x1);
  root(@f2, @f3, @f2_d1, @f3_d1, -1, 0, 0.001, x2);
  root(@f1, @f2, @f1_d1, @f2_d1, -1, 0, 0.001, x3);
  writeln('x1 = ', x1:5:2, ', x2 = ', x2:5:2, ', x3 = ', x3:5:2);

  s1 := integral(@f1, x1, x3, 0.001);
  s2 := integral(@f2, x2, x3, 0.001);
  s3 := integral(@f3, x1, x2, 0.001);
  writeln('s1 = ', s1:5:2, ', s2 = ', s2:5:2, ', s3 = ', s3:5:2);

  s := s1 - s2 - s3;
  writeln('s = ', s:5:2);
end.
