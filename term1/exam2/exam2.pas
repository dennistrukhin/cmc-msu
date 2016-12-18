program exam2;

const
  DATA_FILE_NAME = 'students.dat';

type
  TGender = (M, F);
  TDate = record
    day: integer;
    month: integer;
    year: integer;
  end;
  TStudent = record
    first_name: string[12];
    last_name: string[12];
    patronim: string[12];
    gender: TGender;
    date_of_birth: TDate;
    group_number: integer;
    city: string[12];
    marks: array[0..2] of integer;
  end;
  PTStudent = ^TStudentListItem;
  TStudentListItem = record
    student: TStudent;
    next: PTStudent;
  end;

var
  input_file: TextFile;
  input_line: string;
  sp: PTStudent;
  student: TStudent;
  head: PTStudent;
  current: PTStudent;

function input_parser(input: string): TStudent;
var
  student: TStudent;
  input_pos: integer;
  student_data: array[0..9] of string;
  i: integer;
begin
  for i := 0 to 9 do begin
    input_pos := pos(' ', input);
    if input_pos = 0 then
      student_data[i] := input
    else begin
      student_data[i] := copy(input, 1, input_pos - 1);
      input := copy(input, input_pos + 1, length (input) - input_pos);
    end;
  end;

  student.first_name := student_data[0];
  student.last_name := student_data[1];
  student.patronim := student_data[2];
  if student_data[3] = 'М' then student.gender := M else student.gender := F;
  student.city := student_data[5];
  val(student_data[6], student.group_number);
  val(student_data[7], student.marks[0]);
  val(student_data[8], student.marks[1]);
  val(student_data[9], student.marks[2]);

  input_pos := pos('.', student_data[4]);
  val(copy(student_data[4], 1, input_pos - 1), student.date_of_birth.day);
  student_data[4] := copy(student_data[4], input_pos + 1, length (student_data[4]) - input_pos);
  input_pos := pos('.', student_data[4]);
  val(copy(student_data[4], 1, input_pos - 1), student.date_of_birth.month);
  val(copy(student_data[4], input_pos + 1, length (student_data[4]) - input_pos), student.date_of_birth.year);

  input_parser := student;
end;

begin
  {прочитаем строки из файла, преобразуем их в записи, создадим односвязный список}
  assign(input_file, DATA_FILE_NAME);
  reset(input_file);
  if not eof(input_file) then begin
    readln(input_file, input_line);
    new(Head);
    head^.next := nil;
    head^.student := input_parser(input_line);
    current := head;
    while not eof(input_file) do begin
      new(current^.next);
      readln(input_file, input_line);
      current^.next^.student := input_parser(input_line);
      current := current^.next;
    end;
    current^.next := nil;
  end else
    writeln('Ошибка: файл с данными пуст');
  close(input_file);

  current := head;
  while current <> nil do begin
    Writeln (current^.student.first_name);
    current := current^.next;
  end;

end.
