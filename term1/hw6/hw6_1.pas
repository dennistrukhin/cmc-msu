program hw6_1;

const
  N_SIZE = 10;

var
  n: array[1..N_SIZE] of integer;
  sum: integer;
  average: real;
  i, tmp: integer;

begin
  randomize;
  for i := 1 to N_SIZE do begin
    n[i] := random(19) - 10;
    write(n[i], ' ');
  end;

  sum := 0;
  for i := 1 to N_SIZE do
    sum := sum + n[i];

  average := sum / N_SIZE;

  writeln;
  writeln('Сумма элементов: ', sum);
  writeln('Среднее арифметическое элементов: ', average:0:5);

  {Сдвинем вправо на один элемент}
  tmp := n[N_SIZE];
  for i := N_SIZE - 1 downto 1 do
    n[i + 1] := n[i];
  n[1] := tmp;
  writeln;
  for i := 1 to N_SIZE do
    write(n[i], ' ');

  {Перевернём}
  for i := 1 to N_SIZE div 2 do begin
    tmp := n[N_SIZE - i + 1];
    n[N_SIZE - i + 1] := n[i];
    n[i] := tmp;
  end;
  writeln;
  for i := 1 to N_SIZE do
    write(n[i], ' ');
  writeln;
end.
