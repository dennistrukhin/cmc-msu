program hw5_1a.pas;

var
  i, z: integer;
  eps, x, s, y, q: real;
  
begin
  write('x = ');
  readln(x);
  write('eps (>0) = ');
  readln(eps);
  if eps <= 0 then
    writeln('eps должен быть больше нуля')
  else begin
  	i := 1;
    s := 1;
    z := 1;
    q := eps + 1;
    y := 1;
		while q > eps do begin
  		s := s * x;
  		z := z * i;
  		q := s / z;
  		y := y + q;
  		i := i + 1
		end;
  writeln('y = ', y:0:5);
	end;
end.
