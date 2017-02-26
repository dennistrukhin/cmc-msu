program test1;

uses
  dataTypes,
  functions,
  Sysutils;

var
  fi: textfile;
  str: string[9];
  list: TDateArray;
  i: integer;
  cnt_move, cnt_cmp: integer;

begin
  assign(fi, 'data/random1_10.txt');
  reset(fi);
  i := 1;
  while not eof(fi) do begin
    readln(fi, str);
    list[i].year  := strtoint(copy(str, 7, 2));
    list[i].month := strtoint(copy(str, 4, 2));
    list[i].day   := strtoint(copy(str, 1, 2));
    inc(i);
  end;

  cnt_move := 0;
  cnt_cmp := 0;
  sortShuttle(list, 10, cnt_cmp, cnt_move);

  writeln(cnt_cmp, ' ', cnt_move);

  for i := 1 to 10 do begin
    writeln(list[i].day:2, ' ', list[i].month:2, ' ', list[i].year:2);
  end;

  close(fi);
end.
