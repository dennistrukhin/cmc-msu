program hw5_3;

var
  i, x, y: integer;
  is_prime: boolean;
begin
  write('Введите натуральное число x > 1: ');
  readln(x);
  if x <= 1 then
    writeln('Неверный ввод')
  else begin
    is_prime := true;
    if x > 3 then begin
      for i := 2 to trunc(sqrt(x)) + 1 do
        if x mod i = 0 then
          is_prime := false;
    end;
    if is_prime then
      writeln('Число ', x, ' простое')
    else
      writeln('Число ', x, ' составное');
  end;

End.
