program hw6_3;

const
  e = 0.0001;
  N = 3;

var
  a, a1: array[1..N, 1..N] of real;
  b, b1: array[1..N] of real;
  x: array[1..N] of real;
  i, j, k: integer;z, r, g: real;

begin
  writeln('Введите коэффициенты системы и свободные члены');
  for i := 1 to N do begin
    for j := 1 to N do begin
      write('a[', i, ',', j, ']= ');
      readln(a[i][j]);
      a1[i][j]:=a[i][j];
    end;
    writeln('b[', i, ']= ');
    readln(b[i]);
  end;
  for k := 1 to N do begin
    for j := k + 1 to N do begin
      r := a[j][k] / a[k][k];
      for i := k to n do begin
        a[j][i] := a[j][i] - r * a[k][i];
      end;
      b[j] := b[j] - r * b[k];
    end;
  end;
  for k := n downto 1 do begin
    r := 0;
    for j := k + 1 to n do begin
      g := a[k][j] * x[j];
      r := r + g;
    end;
    x[k] := (b[k] - r) / a[k, k];
  end;
  writeln('=== Решение === ');
  for i := 1 to n do
    write('x[', i, ']=', x[i]:0:2, '   ');
  writeln;
end.
