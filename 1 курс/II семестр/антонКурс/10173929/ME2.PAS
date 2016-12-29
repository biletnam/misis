program me;
var
  y:real;               { Y полученный явным методом }
  yp:real;
  yn:real;              { Y полученный неявным методом }
  ykn:real;             { предыдущий Y полученный неявным методом }
  t:real;
  h:real;               { Шаг }
  ns,nps:integer; { Количество шагов всего и между строками таблицы }
  n:integer;          { Счетчики }
  fl:text;              { Файл для вывода результата }

{ Заданная функция}
function f(t,y:real):real;
begin
  f:=-25*y+cos(t)+25*sin(t);
end;

{ Явное решение }
function tr(t:real):real;
begin
  tr:=sin(t)+exp(-25*t);
end;

begin
{ Вывод в файл с именем rez.txt }
  assign (fl,'rez.txt');
  rewrite(fl);
  h:=0.1;
  y:=0;
  yn:=0;
  t:=0;
  write(fl,'  t        Y        YN      Yточн. ');
  writeln(fl,' Yточн-Y  Yточн-YN   Шаг');
{ Вывод таблицы с заданным шагом }
  repeat
  { Итерационная обработка }
    yp:=y;
    h:=0.1;
    repeat
    { Вычисление грубого приближения }
      y:=yp+h*f(t,yp);
      yn:=y;
      n:=0;
    { Уточнение решения }
      repeat
        ykn:=yn;
        yn:=y+h*(f(t,y)+f(t+h,ykn))/2;
        n:=n+1;
      until ((trunc(ykn*1000)=trunc(yn*1000))or(n>5));
      if (n>4) then h:=h/2;
    until (n<=4);
  { Вывод очередной строки таблицы }
    writeln(fl,t:6:5,'  ',y:6:5,'  ',yn:6:5,'  ',tr(t):6:5,
            '  ',tr(t)-y:6:5,'  ',tr(t)-yn:6:5,'  ',h:5:4);
    t:=t+h;
    y:=yn;
  until (t>=1);
  close (fl);
end.
