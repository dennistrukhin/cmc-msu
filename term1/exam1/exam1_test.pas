program exam1_test;
uses
  exam1_types,
  exam1_functions;

var
  x: real;

function f1(x: real): real;
begin
  f1 := x;
end;

function f2(x: real): real;
begin
  f2 := 3;
end;

function f3(x: real): real;
begin
  f3 := -x;
end;

function g1(x: real): real;
begin
  g1 := -x + 1;
end;

function g2(x: real): real;
begin
  g2 := x * x - 1;
end;

function g1_d1(x: real): real;
begin
  g1_d1 := -1;
end;

function g2_d1(x: real): real;
begin
  g2_d1 := 2 * x;
end;

begin
  writeln('(Integral) Expected: 8, actual: ', integral(@f1, 0, 4, 0.001));
  writeln('(Integral) Expected: 12, actual: ', integral(@f2, 0, 4, 0.001));
  writeln('(Integral) Expected: -8, actual: ', integral(@f3, 0, 4, 0.001));

  root(@g1, @g2, @g1_d1, @g2_d1, 0, 2, 0.001, x);
  writeln('(Root) Expected: 1, actual: ', x);
end.
