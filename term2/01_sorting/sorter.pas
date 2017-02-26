program sorter;

uses
  CRT,
  dataTypes,
  functions;

var
  types: TTypes;
  t: TType;
  lengths: TLengths;
  l: shortint;
  stats: array[0..1] of TStatsArray;
  i: integer;
  cnt_move, cnt_cmp: integer;
  fi: textfile;
  list: TDateArray;

begin
  clrscr;

  types := [asc, desc, both, random1, random2];
  lengths := [10, 20, 50, 100];

  i := 0;
  for l in lengths do begin
    stats[0][i].length := l;
    stats[1][i].length := l;
    for t in types do begin
      list := importListFromFile(t, l);
      cnt_move := 0;
      cnt_cmp := 0;
      sortShuttle(list, l, cnt_cmp, cnt_move);
      stats[0][i].cmp[t] := cnt_cmp;
      stats[0][i].move[t] := cnt_move;

      cnt_move := 0;
      cnt_cmp := 0;
      stats[1][i].cmp[t] := cnt_cmp;
      stats[1][i].move[t] := cnt_move;
    end;
    inc(i);
  end;

  drawTable(stats[0], 'Binary inserts');
  drawTable(stats[1], 'Recursive quick sort');


end.
