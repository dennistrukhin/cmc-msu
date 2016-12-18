program exam2;

const
  DATA_FILE_NAME = 'students.dat';
  {Если терминал не поддерживает cp-1251, пересохраняем .dat и .pas в UTF-8
   и ставим STRING_MAX_LENGTH = 24}
  STRING_MAX_LENGTH = 24;
  GROUP_LOWER_NUMBER = 301;
  GROUP_HIGHER_NUMBER = 329;
  MODALITY_TYPE_PATRONYM = 'patronim';
  MODALITY_TYPE_MONTH = 'month';
  MODALITY_TYPE_CITY = 'city';

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
    patronym: string[STRING_MAX_LENGTH];
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
  PTModality = ^TModalityItem;
  TModalityItem = record
    next: PTModality;
    param: string;
    value: string[STRING_MAX_LENGTH];
    count: integer;
  end;
  TStudentListItem = record
    student: TStudent;
    next: PTStudent;
  end;

var
  input_file: TextFile;
  input_line: string;
  head_student, last_student, current_student: PTStudent;
  head_modality, last_modality, current_modality: PTModality;
  tmp_last, tmp_current: PTStudent;
  student: TStudent;
  groups: array[GROUP_LOWER_NUMBER..GROUP_HIGHER_NUMBER] of TGroup;
  i: integer;
  inserted: boolean;
  tmp_string: string;
  max_count_patronym, max_count_month, max_count_city: integer;

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

  student.first_name := student_data[1];
  student.last_name := student_data[0];
  student.patronym := student_data[2];
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
  isOneThirdFromCitiesSubset := (group.total_students > 0) and ((group.students_from_cities / group.total_students) > (1.0 / 3.0));
end;


function isInGroupSubset(student: TStudent): boolean;
var
  i: integer;
begin
  isInGroupSubset := false;
  for i := GROUP_LOWER_NUMBER to GROUP_HIGHER_NUMBER do
    isInGroupSubset := isInGroupSubset or isOneThirdFromCitiesSubset(groups[i]) and (student.group_number = i);
end;


function getStudentFullName(student: TStudent): string;
begin
  getStudentFullName := student.last_name + ' ' + student.first_name + ' ' + student.patronym;
end;


function getModalityItem(modality_type: string; value: string): PTModality;
var
  found: boolean;
  tmp_modality: PTModality;
begin
  found := false;
  if head_modality = nil then begin
    new(current_modality);
    current_modality^.next := nil;
    current_modality^.param := modality_type;
    current_modality^.value := value;
    head_modality := current_modality;
    getModalityItem := current_modality
  end else begin
    tmp_modality := head_modality;
    while (tmp_modality <> nil) and (not found) do begin
      if (tmp_modality^.param = modality_type) and (tmp_modality^.value = value) then begin
        getModalityItem := tmp_modality;
        found := true;
      end;
      last_modality := tmp_modality;
      tmp_modality := tmp_modality^.next;
    end;
    if not found then begin
      new(current_modality);
      current_modality^.next := nil;
      current_modality^.param := modality_type;
      current_modality^.value := value;
      last_modality^.next := current_modality;
      getModalityItem := current_modality;
    end;
  end;
end;


begin
  {прочитаем строки из файла, преобразуем их в записи, создадим односвязный список}
  assign(input_file, DATA_FILE_NAME);
  reset(input_file);
  if not eof(input_file) then begin
    readln(input_file, input_line);
    new(current_student);
    current_student^.next := nil;
    current_student^.student := input_parser(input_line);
    head_student := current_student;
    last_student := current_student;
    while not eof(input_file) do begin
      {будем сразу же упорядочивать студентов по имени, чтобы в дальнейшем
       при алфавитном выводе достаточно было идти по списку}
      new(current_student);
      readln(input_file, input_line);
      current_student^.student := input_parser(input_line);
      current_student^.next := nil;
      {Переберем весь существующий список и найдем два элемента:
      tmp_last - элемент, после которого надо вставить текущий
      tmp_current - элемент, перед которым надо вставить текущий}
      tmp_current := head_student;
      tmp_last := tmp_current;
      inserted := false;
      while (tmp_current <> nil) do begin
        if (getStudentFullName(current_student^.student) < getStudentFullName(tmp_current^.student)) and (not inserted) and (current_student^.next = nil) then begin
          inserted := true;
          if tmp_current = head_student then begin
            current_student^.next := head_student;
            head_student := current_student;
          end else begin
            current_student^.next := tmp_current;
            tmp_last^.next := current_student;
          end;
        end;
        tmp_last := tmp_current;
        tmp_current := tmp_current^.next;
      end;
      if not inserted then begin
        tmp_last^.next := current_student;
        current_student^.next := nil;
      end;
    end;
  end else
    writeln('Ошибка: файл с данными пуст');
  close(input_file);

  for i := GROUP_LOWER_NUMBER to GROUP_HIGHER_NUMBER do begin
    groups[i].number := i;
    groups[i].total_students := 0;
    groups[i].students_from_cities := 0;
  end;

  current_student := head_student;
  last_student := current_student;
  while current_student <> nil do begin
    inc(groups[current_student^.student.group_number].total_students);
    if isStudentFromCitiesSubset(current_student^.student) then
      inc(groups[current_student^.student.group_number].students_from_cities);
    last_student := current_student;
    current_student := current_student^.next;
  end;

  {Теперь удалим всех лишних студентов из списка}
  current_student := head_student;
  last_student := current_student;
  while current_student <> nil do begin
    if isInGroupSubset(current_student^.student) then begin
      last_student := current_student;
    end else begin
      last_student^.next := current_student^.next;
    end;
    current_student := current_student^.next;
  end;

  for i := GROUP_LOWER_NUMBER to GROUP_HIGHER_NUMBER do
    if groups[i].total_students > 0 then begin
      writeln('## Группа ', i);
      writeln('Всего студентов: ', groups[i].total_students);
      writeln('Из указанных городов: ', groups[i].students_from_cities);
    end;

  writeln('Отобраны для работы следующие группы:');
  for i := GROUP_LOWER_NUMBER to GROUP_HIGHER_NUMBER do
    if isOneThirdFromCitiesSubset(groups[i]) then
      writeln(i);

  {Просчитаем встречаемость каждого элемента}
  {Мы изнчально не знаем, сколько у нас будет таких элементов, поэтому}
  {будем использовать однсвязный список, чтобы легко добавлять новые элементы}
  current_student := head_student;
  head_modality := nil;
  while current_student <> nil do begin
    writeln(getStudentFullName(current_student^.student), ' ', current_student^.student.group_number, ' ', current_student^.student.date_of_birth.month);
    current_modality := getModalityItem(MODALITY_TYPE_PATRONYM, current_student^.student.patronym);
    inc(current_modality^.count);
    current_modality := getModalityItem(MODALITY_TYPE_CITY, current_student^.student.city);
    inc(current_modality^.count);
    str(current_student^.student.date_of_birth.month, tmp_string);
    current_modality := getModalityItem(MODALITY_TYPE_MONTH, tmp_string);
    inc(current_modality^.count);

    current_student := current_student^.next;
  end;

  current_modality := head_modality;
  while current_modality <> nil do begin
    writeln(current_modality^.param, ' ', current_modality^.value, ' ', current_modality^.count);
    current_modality := current_modality^.next;
  end;

  {Почистим список моадльностей и оставим в нём только сами моды (максимальные значения)}
  max_count_city := 0;
  max_count_patronym := 0;
  max_count_month := 0;
  current_modality := head_modality;
  while current_modality <> nil do begin
    if (current_modality^.param = MODALITY_TYPE_CITY) and (current_modality^.count > max_count_city) then
      max_count_city := current_modality^.count;
    if (current_modality^.param = MODALITY_TYPE_MONTH) and (current_modality^.count > max_count_month) then
      max_count_month := current_modality^.count;
    if (current_modality^.param = MODALITY_TYPE_PATRONYM) and (current_modality^.count > max_count_patronym) then
      max_count_patronym := current_modality^.count;
    current_modality := current_modality^.next;
  end;
  writeln('city: ', max_count_city, ', patronym: ', max_count_patronym, ', month: ', max_count_month);
  current_modality := head_modality;
  last_modality := current_modality;
  while current_modality <> nil do begin
    if (current_modality^.param = MODALITY_TYPE_CITY) and (current_modality^.count < max_count_city)
      or (current_modality^.param = MODALITY_TYPE_MONTH) and (current_modality^.count < max_count_month)
      or (current_modality^.param = MODALITY_TYPE_PATRONYM) and (current_modality^.count < max_count_patronym) then begin
      writeln('Unsetting ', current_modality^.param, ' ', current_modality^.value);
      if current_modality = head_modality then begin
        head_modality := current_modality^.next;
      end else begin
        last_modality^.next := current_modality^.next;
      end;
    end else
      last_modality := current_modality;
    current_modality := current_modality^.next;
  end;

  writeln('=== Модальные параметры ===');
  current_modality := head_modality;
  while current_modality <> nil do begin
    case current_modality^.param of
      MODALITY_TYPE_CITY: write('Город: ');
      MODALITY_TYPE_MONTH: write('Месяц: ');
      MODALITY_TYPE_PATRONYM: write('Отчество: ');
    end;
    writeln(current_modality^.value);
    current_modality := current_modality^.next;
  end;

end.
