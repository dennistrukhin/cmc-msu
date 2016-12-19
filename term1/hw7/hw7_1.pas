program hw7_1;

const
  N = 2;
  M = 2;

type
  Matrix = array[1..N, 1..M] of real;

var
  A, B: Matrix;

procedure initMatrix(var D: Matrix);
var
  i, j: integer;
begin
  for i := 1 to N do
    for j := 1 to M do
      D[i, j] := random;
end;


procedure getMaxElementIndex(D: Matrix; var max_i: integer; var max_j: integer);
var
  max: real;
  is_first_element: boolean;
  i, j: integer;
begin
  max := 0;
  is_first_element := true;
  for i := 1 to N do
    for j := 1 to M do
      if is_first_element or (D[i, j] > max) then begin
        is_first_element := false;
        max := D[i, j];
        max_i := i;
        max_j := j;
      end;
end;


procedure swap(var A: Matrix; var B: Matrix);
var
  A_max_i, A_max_j, B_max_i, B_max_j: integer;
  tmp: real;
begin
  getMaxElementIndex(A, A_max_i, A_max_j);
  getMaxElementIndex(B, B_max_i, B_max_j);
  tmp := B[B_max_i, B_max_j];
  B[B_max_i, B_max_j] := A[A_max_i, A_max_j];
  A[A_max_i, A_max_j] := tmp;
end;


begin
  randomize;
  initMatrix(A);
  initMatrix(B);

end.
