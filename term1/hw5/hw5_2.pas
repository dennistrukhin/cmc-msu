program hw5_2;

var
	i, a, b: integer;
	s: int64;
	x, y, z: real;

begin
	write('x (>1) = ');
	readln(x);
	if x <= 1 then
		writeln('X должен быть > 1')
	else begin
		s := 0;
		y := ln(x);
		z := exp(x);
		a := trunc(y) + 1;
		b := trunc(z);
		for i := a to b do
			s := s + i * i;
		writeln('ln (', x:0:5, ') = ', y:0:5);
		writeln('exp (', x:0:5, ') = ', z:0:5);
		writeln('Сумма = ', s)
	end;
end.
