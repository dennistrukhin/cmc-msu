program hw3;

var
  x, y: real;
  result: boolean;

begin
  writeln('Введите координаты точки x, y:');
  readln(x, y);

  result := (x >= 0) and (x <= 2) and (y >= 0) and (y <= 1);
  if result then
    writeln('Задание А: да')
  else
    writeln('Задание А: нет');

  result := (x >= 0) and (y - x >= -2) and (y + x <= 2) or (x < 0) and (sqr(x) + sqr(y) < 4);
  if result then
    writeln('Задание Б: да')
  else
    writeln('Задание Б: нет');

  result := (sqr(x) + sqr(y) <= 1) and (abs(x) + abs(y) >= 1);
  if result then
    writeln('Задание В: да')
  else
    writeln('Задание В: нет');

  result := (sqr(x) + sqr(y) >= 4) and (abs(y) <= 2) and (x <= 0) and (x >= -2) or (x >= 0) and (x <= 2) and (y <= 0) and (y >= -2);
  if result then
    writeln('Задание Г: да')
  else
    writeln('Задание Г: нет');
end.

If res then writeln('Данная точка попадает в заштрихованную область') else writeln('Данная точка не попадает в заштрихованную область');
Readln
End.

Program zadanie3В;
Var x,y: real; res: boolean;
Begin
Writeln ('Введите координаты точки x,y');
Readln(x,y);
{Res:=((sqr(x)+sqr(y))<=1)and(((y+x)>=1)or((y-x)<=-1)or((y+x)<=-1)or((y-x)>=1));}
{Res:=((sqr(x)+sqr(y))<=1)and((y+x)>=1)or((sqr(x)+sqr(y))<=1)and((y-x)<=-1) or((sqr(x)+sqr(y))<=1)and((y+x)<=-1)or((sqr(x)+sqr(y))<=1)and((y-x)>=1); }
If res then writeln('Данная точка попадает в заштрихованную область') else writeln('Данная точка не попадает в заштрихованную область');
Readln
End.

Program zadanie3Г;
Var x,y: real; res: boolean;
Begin
Writeln ('Введите координаты точки x,y');
Readln(x,y);
Res:= ((sqr(x)+sqr(y))>=4)and((abs(y)<=2)and(x<=0)and(x>=-2)) or((x>0)and(x<=2)and(y<=0)and(y>-2));
If res then writeln('Данная точка попадает в заштрихованную область') else writeln('Данная точка не попадает в заштрихованную область');
Readln
End.
