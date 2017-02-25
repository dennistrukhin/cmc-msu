program sorter;

uses
  CRT;

type
  TType = (asc, desc, both, random1, random2);
  TTypes = set of TType;
  TLengths = set of 1..100;
  TStats = record
    t: TType;
    cmp: array[TType] of integer;
    move: array[TType] of integer;
  end;
  TStatsArray = array[0..3] of TStats;

var
  types: TTypes;
  t: TType;
  lengths: TLengths;
  l: shortint;
  stats: TStatsArray;
  i: integer;


procedure drawTable(stats: TStatsArray);
begin
  clrscr;
  write(chr(210));
end;


begin
  types := [asc, desc, both, random1, random2];
  lengths := [10, 20, 50, 100];

  i := 0;
  for l in lengths do begin
    for t in types do begin
      stats[i].t := t;
      writeln(l, t);
    end;
    inc(i);
  end;

  drawTable(stats);


end.
