program exam2;

const
  DATA_FILE_NAME = 'students.dat';
  {Если терминал не поддерживает cp-1251, пересохраняем .dat и .pas в UTF-8
   и ставим STRING_MAX_LENGTH = 24}
  STRING_MAX_LENGTH = 24;
  GROUP_LOWER_NUMBER = 301;
  GROUP_HIGHER_NUMBER = 329;

type
  {У меня fpc не поддерживает перечисляемыет типы с русскими символами
   (особенности платформы?), поэтому пришлось использовать латиницу и
   подменять при чтении}
  TGender = (M, F);
  TDate = record
    day: integer;
    month: integer;
    year: integer;
  end;
  TStudent = record
    first_name: string[STRING_MAX_LENGTH];
    last_name: string[STRING_MAX_LENGTH];
    patronim: string[STRING_MAX_LENGTH];
    gender: TGender;
    date_of_birth: TDate;
    group_number: integer;
    city: string[STRING_MAX_LENGTH];
    marks: array[0..2] of integer;
  end;
  TGroup = record
    number: integer;
    total_students: integer;
    students_from_cities: integer;
  end;
  PTStudent = ^TStudentListItem;
  TStudentListItem = record
    student: TStudent;
    next: PTStudent;
  end;

var
  input_file: TextFile;
  input_line: string;
  head_student, current_student: PTStudent;
  groups: array[GROUP_LOWER_NUMBER..GROUP_HIGHER_NUMBER] of TGroup;
  i: integer;

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
  {Здесь 'М' в сравнении - это кириллическая М}
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


function isStudentFromCitiesSubset(student: TStudent): boolean;
begin
  isStudentFromCitiesSubset := (student.city = 'ВЛАДИМИР')
    or (student.city = 'ИВАНОВО')
    or (student.city = 'КАЛУГА')
    or (student.city = 'МОСКВА')
    or (student.city = 'РЯЗАНЬ')
    or (student.city = 'СМОЛЕНСК')
    or (student.city = 'ТВЕРЬ');
end;


function isOneThirdFromCitiesSubset(group: TGroup): boolean;
begin
  isOneThirdFromCitiesSubset := (group.students_from_cities / group.total_students) > (1.0 / 3.0);
end;


begin
  {прочитаем строки из файла, преобразуем их в записи, создадим односвязный список}
  assign(input_file, DATA_FILE_NAME);
  reset(input_file);
  if not eof(input_file) then begin
    readln(input_file, input_line);
    new(head_student);
    head_student^.next := nil;
    head_student^.student := input_parser(input_line);
    current_student := head_student;
    while not eof(input_file) do begin
      new(current_student^.next);
      readln(input_file, input_line);
      current_student^.next^.student := input_parser(input_line);
      current_student := current_student^.next;
    end;
    current_student^.next := nil;
  end else
    writeln('Ошибка: файл с данными пуст');
  close(input_file);

  current_student := head_student;
  while current_student <> nil do begin
    inc(groups[current_student^.student.group_number].total_students);
    if isStudentFromCitiesSubset(current_student^.student) then
      inc(groups[current_student^.student.group_number].students_from_cities);

    current_student := current_student^.next;
  end;

  for i := GROUP_LOWER_NUMBER to GROUP_HIGHER_NUMBER do
    if groups[i].total_students > 0 then begin
      writeln('## Группа ', i);
      writeln('Всего студентов: ', groups[i].total_students);
      writeln('Из указанных городов: ', groups[i].students_from_cities);
    end;

end.
