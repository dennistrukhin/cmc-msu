unit dataTypes;

interface

type
  TType = (asc, desc, both, random1, random2);
  TTypeStr = string[7];
  TTypes = set of TType;
  TLength = 1..100;
  TLengths = set of TLength;
  TStats = record
    length: integer;
    cmp: array[TType] of integer;
    move: array[TType] of integer;
  end;
  TDate = record
    day: integer;
    month: integer;
    year: integer;
  end;
  TDateArray = array[0..99] of TDate;
  TStatsArray = array[0..3] of TStats;
  str = string[32];

implementation

end.
