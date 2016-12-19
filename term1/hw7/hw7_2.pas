program hw7_2;

const
  N_SIZE = 10;

type
  vector = array[1..N_SIZE] of integer;

var
  N: vector;
  D: array[-9..-1] of boolean;
  i: integer;

procedure initSet(var N: vector);
begin
  for i := 1 to N_SIZE do begin
    N[i] := random(19) - 9;
    write(N[i]:3);
  end;
  writeln;
end;


procedure checkNumbers(var N: vector);
var
  i: integer;
begin
  for i := 1 to N_SIZE do
    if N[i] < 0 then begin
      D[N[i]] := true;
      N[i] := 0;
    end;
end;

begin
  randomize;
  initSet(N);
  checkNumbers(N);

  for i := 1 to N_SIZE do
    write(N[i]:3);
  writeln;

  writeln('Удалённые числа:');
  for i := -9 to -1 do
    if D[i] then
      write(i:3);
  writeln;

end.
