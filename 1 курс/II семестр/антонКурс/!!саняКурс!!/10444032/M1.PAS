program p1;
uses crt,graph;
var
  x:real;                   {}
  xs,xe:real;               { Начало и конец просматриваемого диапазона }
  h:real;                   { Шаг }
  drv,mode:integer;         { Для инициализации графики }
  mn:real;                  { Множитель для вывода на дисплей }
  tz:integer;               { Положение нулевой линии }
  c:char;                   { Для организации ожидания нажатия на клавишу }
  otv:array [0..10] of real;{ Массив найденных решений }
  num:integer;              { Количество найденных решений }
  n:integer;                { Счетчик }

{ Заданная функция }
function f(x:real):real;
begin
  f:=x*x*(x-3);
end;

{ Функция получения знака числа }
function sgn(a:real):integer;
begin
   sgn:=trunc(a/abs(a));
end;

{ Процедура последовательного приближения ответа }
procedure find(x1:real;x3:real);
var x2,x4:real;
begin
  x2:=(x3+x1)/2;
  repeat
    { Деление отрезка пополам }
    x4:=(x1+x2)/2;
    if (sgn(f(x1)-f(x4))<>sgn(f(x4)-f(x2))) then
      x3:=x2 else x1:=x2;
    x2:=(x3+x1)/2;
  until (abs(x3-x1)>0.00001);
  otv[num]:=x2;
  num:=num+1;
end;

{ Основная программа }
begin
  { Запрс интервала поиска решений }
  clrscr;
  num:=0;
  write(' Введите интервал поиска: ');
  readln(xs,xe);
  { Определение шага грубого просмотра }
  h:=(xe-xs)/1000;
  x:=xs;
  { Грубый просмотр интервала }
  repeat
    if (sgn(f(x)-f(x+h))<>sgn(f(x+h)-f(x+2*h))) then begin
    { Вызов процедуры более тщательного просмотра диапазона,
      содержащего решение }
      find(x,x+2*h);
      x:=x+h;
    end;
    x:=x+h;
  until x>xe;
  { Инициализация графики }
  drv:=DETECT;
  initgraph(drv,mode,'');
  { Вывод системы координат }
  setcolor(14);
  line(0,240,640,240);
  { Расчет множителя }
  mn:=640/(xe-xs);
  tz:=-trunc(mn*xs);
  line(tz,0,tz,480);
  for n:=0 to 10 do begin
    line(tz+trunc(n*mn)-2,238,tz+trunc(n*mn)+2,242);
    line(tz-trunc(n*mn)-2,238,tz-trunc(n*mn)+2,242);
    line(322,238-trunc(n*mn),318,242-trunc(n*mn));
    line(322,238+trunc(n*mn),318,242+trunc(n*mn));
  end;
  setcolor(15);
  { Вывод графика }
  for n:=0 to 640 do begin
    putpixel(n,240-trunc(mn*f(n/mn+xs)),15);
    if (num<>0) then begin
      { Проверка на экстремум в данной точке }
      for tz:=0 to num-1 do
        if (abs(otv[tz]-(n/mn+xs))<0.01) then line(n,0,n,480);
    end;
  end;
  { Ожидание нажатия клавиши }
  c:=readkey;
  closegraph;
  { Вывод таблицы полученных экстремумов }
  writeln(' Полученные экстремумы функции: ');
  writeln;
  for n:=0 to num-1 do writeln(' Точка экстремума: X= ',otv[n]:6:5);
  c:=readkey;
end.
