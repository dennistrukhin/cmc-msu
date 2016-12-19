program hw4_2;

const
  N_SIZE = 10;

var
  n: array[1..N_SIZE] of integer;
  i: integer;
  sum, count: integer;
  first_even_index: integer;
  has_two_zeros: boolean;

begin
  randomize;
  for i := 1 to N_SIZE do
    n[i] := random(19) - 10;

  sum := 0;
  count := 0;
  first_even_index := 0;
  has_two_zeros := false;
  for i := 1 to N_SIZE do begin
    write(n[i], ' ');
    if (i > 1) and (n[i] = 0) and (n[i - 1] = 0) then
      has_two_zeros := true;
    if (first_even_index = 0) and (n[i] mod 2 = 0) then
      first_even_index := i;
    if (n[i] mod 5 = 0) and (n[i] mod 7 <> 0) then begin
      sum := sum + n[i];
      inc(count);
    end;
  end;

  writeln;

  writeln('Сумма искомых членов: ', sum);
  writeln('Количество искомых членов: ', count);

  if first_even_index > 0 then
    writeln('Первый чётный член: ', first_even_index)
  else
    writeln('В последовательности нет чётных членов');

  write('Имеет два нуля: ');
  if has_two_zeros then
    writeln('да')
  else
    writeln('нет');
end.
