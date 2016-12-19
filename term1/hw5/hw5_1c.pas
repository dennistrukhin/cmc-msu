program hw5_1c;
var
	i, n: integer;
	eps, x, s, y, q: real;
	z: int64;
begin
	write('x = ');
  readln(x);
  write('eps (>0) = ');
  readln(eps);
  if eps <= 0 then
    writeln('eps должен быть больше нуля')
  else begin
		i := 1;
		n := 1;
		q := eps + 1;
		y := 1;
		while q>eps do begin
			s := 1; z := 1;
			for i := 1 to 2 * n do begin
				s := s * x;
				z := z * i;
			end;
			q:=s/z;
			if n mod 2 = 0 then
				y:=y+q
			else
				y:=y-q;
			n:=n+1
		end;
		writeln('cos (', x:0:5, ') = ', y:0:5);
	end;
end.
