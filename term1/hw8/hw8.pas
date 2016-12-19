program hw8;

type
  complex = record
    re: real;
    im: real;
  end;

var c1, c2, c3, c4, c5, c6, c: complex;


function add(c1: complex; c2: complex): complex;
begin
  add.re := c1.re + c2.re;
  add.im := c1.im + c2.im;
end;


function subtract(c1: complex; c2: complex): complex;
begin
  subtract.re := c1.re - c2.re;
  subtract.im := c1.im - c2.im;
end;


function multiply(c1: complex; c2: complex): complex;
begin
  multiply.re := c1.re * c2.re - c1.im * c2.im;
  multiply.im := c1.re * c2.im + c1.im * c2.re;
end;


function divide(c1: complex; c2: complex): complex;
begin
  divide.re := (c1.re * c2.re + c1.im * c2.im) / (c2.re * c2.re + c2.im * c2.im);
  divide.im := (c2.re * c1.im - c1.re * c2.im) / (c2.re * c2.re + c2.im * c2.im);
end;


procedure display(c: complex);
var
  result, tmp: string;
begin
  if (c.re <> 0) and (c.im = 0) then
    writeln(c.re:0:2)
  else if (c.re = 0) and (c.im <> 0) then
    writeln(c.im:0:2, 'i')
  else
    writeln(c.re:0:2, 'Re+', c.im:0:2, 'Im');
end;


begin
  c1.re := 0.25;
  c1.im := 0;

  c2.re := 17;
  c2.im := 31;

  c3.re := 7;
  c3.im := 1;

  c4.re := 12;
  c4.im := 0;

  c5.re := 1;
  c5.im := 1;

  c6.re := 0;
  c6.im := 1;

  c := add(multiply(c1, add(divide(c2, c3), divide(c4, c5))), c6);

  display(c);

end.
