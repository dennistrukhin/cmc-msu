program hw6_2;

const
  M = 5;
  K = 4;
  N = 6;

var
  i, j, p: integer;
  A: array[1..M, 1..K] of real;
  B: array[1..M, 1..M] of real;
  C1: array[1..M, 1..N] of real;
  C2: array[1..N, 1..K] of real;
  C: array[1..M, 1..K] of real;
  sum, norm, tmp: real;

begin
  randomize;
  for i := 1 to M do begin
    for j := 1 to K do begin
      A[i][j] := random;
      write(A[i][j]:0:2, ' ');
    end;
    writeln;
  end;

  sum := 0;
  norm := 0;
  {Будем считать Эвклидову норму}
  for i := 1 to M do
    for j := 1 to K do begin
      sum := sum + A[i][j];
      norm := norm + A[i][j] * A[i][j];
    end;
  norm := sqrt(norm);
  writeln('Сумма = ', sum:0:3);
  writeln('Норма = ', norm:0:3);

  {Транспонируем квадратную матрицу}
  for i := 1 to M do begin
    for j := 1 to M do begin
      B[i][j] := random;
      write(B[i][j]:0:2, ' ');
    end;
    writeln;
  end;
  writeln('==========');
  for i := 1 to M - 1 do
    for j := 1 + i to M do begin
      tmp := B[i][j];
      B[i][j] := B[j][i];
      B[j][i] := tmp;
    end;

  for i := 1 to M do begin
    for j := 1 to M do
      write(B[i][j]:0:2, ' ');
    writeln;
  end;

  {Умножим две матрицы}
  for i := 1 to M do
    for j := 1 to N do
      C1[i][j] := random;
  for i := 1 to N do
    for j := 1 to K do
      C2[i][j] := random;

  for i:= 1 to M do
    for j := 1 to K do
      begin
        sum := 0;
        for p := 1 to N do
          sum := sum + C1[i][p] * C2[p][j];
        C[i][j] := sum;
      end;

end.
