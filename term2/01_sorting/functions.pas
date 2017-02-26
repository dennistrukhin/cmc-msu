unit functions;

interface

uses
  dataTypes,
  Sysutils;

procedure drawTable(stats: TStatsArray; sort_name: str);
function compareDates(d1, d2: TDate; var counter: integer): integer;
procedure sortShuttle(var list: TDateArray; length: integer; var counter_cmp: integer; var counter_move: integer);
function str(s: TType): TTypeStr; overload;
function str(s: TLength): TTypeStr; overload;
function importListFromFile(t: TType; l: TLength): TDateArray;

implementation

procedure drawTable(stats: TStatsArray; sort_name: str);
var
  i, avg: integer;
  t: TType;
  types: TTypes;
  lengths: TLengths;
begin

types := [asc, desc, both, random1, random2];
lengths := [10, 20, 50, 100];
  writeln('               ', sort_name);
  writeln('======================================================');
  writeln('|   N | Param   |         Set  number      | Average |');
  writeln('|     |         |    1    2    3    4    5 |         |');
  writeln('======================================================');
  for i := 0 to 3 do begin
    write('| ', stats[i].length:3, ' | Compare |');
    avg := 0;
    for t in types do begin
      write(stats[i].cmp[t]:5);
      avg := avg + stats[i].cmp[t];
    end;
    avg := round(avg / 5);
    write(' |   ', avg: 5, ' |');
    writeln;
    write('|     | Move    |');
    avg := 0;
    for t in types do begin
      write(stats[i].move[t]:5);
      avg := avg + stats[i].move[t];
    end;
    avg := round(avg / 5);
    write(' |   ', avg: 5, ' |');
    writeln;
    if i < 3 then
      writeln('|----------------------------------------------------|');
  end;
  writeln('======================================================');
  writeln;
end;


function str(s: TType): TTypeStr;
begin
  case s of
    asc: str := 'asc';
    desc: str := 'desc';
    both: str := 'both';
    random1: str := 'random1';
    random2: str := 'random2';
  end;
end;

function str(s: TLength): TTypeStr;
begin
  case s of
    10: str := '10';
    20: str := '20';
    50: str := '50';
    100: str := '100';
  end;
end;


function importListFromFile(t: TType; l: TLength): TDateArray;
var
  fi: textfile;
  s: string[9];
  i: integer;
begin
  assign(fi, 'data/' + str(t) + '_' + str(l) + '.txt');
  reset(fi);
  i := 1;
  while not eof(fi) do begin
    readln(fi, s);
    importListFromFile[i].year  := strtoint(copy(s, 7, 2));
    importListFromFile[i].month := strtoint(copy(s, 4, 2));
    importListFromFile[i].day   := strtoint(copy(s, 1, 2));
    inc(i);
  end;
  close(fi);
end;


function compareDates(d1, d2: TDate; var counter: integer): integer;
var
  date1, date2: longint;
begin
  {У нас все даты лежат в промежутке 01.01.00 и 31.12.99, поэтому}
  {достаточно собрать два шестизначных числа вида YYMMDD и сравнить их между собой}
  date1 := d1.year * 10000 + d1.month * 100 + d1.day;
  date2 := d2.year * 10000 + d2.month * 100 + d2.day;
  if date1 > date2 then
    compareDates := 1
  else if date1 < date2 then
    compareDates := -1
  else
    compareDates := 0;
  inc(counter);
end;


procedure sortShuttle(var list: TDateArray; length: integer; var counter_cmp: integer; var counter_move: integer);
var
  left, right, i: integer;
  x: TDate;
begin
  left := 1;
  right := length - 1;

  while left <= right do begin
    for i := left to right do
      if compareDates(list[i], list[i + 1], counter_cmp) > 0 then begin
        x := list[i + 1];
        list[i + 1] := list[i];
        list[i] := x;
        inc(counter_move);
      end;
    right := right - 1;

    for i := right downto left do
      if compareDates(list[i - 1], list[i], counter_cmp) > 0 then begin
        x := list[i - 1];
        list[i - 1] := list[i];
        list[i] := x;
        inc(counter_move);
      end;
    left := left + 1;
  end;
end;

end.
