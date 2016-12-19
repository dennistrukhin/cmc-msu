program hw5_1b.pas;

var
	i, n: integer;
	z: int64;
	eps, x, s, y, q: real;
	
begin
	write('x = ');
  readln(x);
  write('eps (>0) = ');
  readln(eps);
  if eps <= 0 then
    writeln('eps должен быть больше нуля')
  else begin
	  n := 1;
		q := eps + 1;
		y := x;
		while q > eps do begin
			s := 1;
			z := 1;
			for i := 1 to 2 * n + 1 do begin
				s := s * x;
				z := z * i;
			end;
			q := s / z;
			y := y + q;
			n := n + 1
		end;
		writeln('sinh (', x:0:5, ') = ', y:0:5);
	end;
end.
