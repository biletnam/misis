program kr;
uses crt;
type arr_type=array [0..5] of real; { Тип - таблица }
var
  x,y:arr_type;         { Табличные значения }
  dy,dy2,dy3:arr_type;  { Конечные разности }
  t:real;               { Общая для методов переменная }
  h:real;               { Общий для методов шаг изменения аргумента }
  tx:real;              { Точка, в которой находится производная }
  c:char;               { Считанный с клавиатуры символ }
  n:integer;            { Счетчик }
{ Процедура чтения таблицы из файла }
procedure input(var x:arr_type;var y:arr_type);
var
  n:integer;            { Счетчик }
  f:text;               { Файл значений }
begin
  assign(f,'tabl.dat');
  reset (f);
  for n:=0 to 5 do begin
    read(f,x[n]);
    readln(f,y[n]);
  end;
  close(f);
end;
{ Процедура подсчета конечной разности очередного подуровня }
procedure razn(a:arr_type;var b:arr_type;n:integer);
var i:integer;          { Счетчик }
begin
  for i:=0 to n-1 do b[i]:=a[i+1]-a[i];
end;
{ Функция получения индекса левой границы содержащего X интервала }
function nx0(a:arr_type;x:real):integer;
var n:integer;
begin
  if (x<a[0])or(x>a[5]) then n:=-1 else begin
    n:=0;
    while (a[n]<x) do n:=n+1;
  end;
  nx0:=n-1;
end;
{ Расчет первой производной по первой интерполяционной формуле Ньютона }
function dxn1(xf:real):real;
var n:integer;           { Индекс X0 }
begin
  n:=nx0(x,xf);
  t:=(xf-x[n])/h;
  dxn1:=(dy[n]+(2*t-1)*dy2[n]/2+(3*t*t-6*t+2)*dy3[n]/6)/h;
end;
{ Расчет второй производной по первой интерполяционной формуле Ньютона }
function dx2n1(xf:real):real;
var n:integer;           { Индекс X0 }
begin
  n:=nx0(x,xf);
  t:=(xf-x[n])/h;
  dx2n1:=(dy2[n]+(t-1)*dy3[n])/(h*h);
end;
{ Расчет первой производной по второй интерполяционной формуле Ньютона }
function dxn2(xf:real):real;
var n:integer;           { Индекс X0 }
begin
  n:=nx0(x,xf)+1;
  t:=(xf-x[n])/h;
  dxn2:=(dy[n-1]+(2*t+1)*dy2[n-2]*dy2[n-2]/2+(3*t*t+6*t+2)*dy3[n-3]/6)/h;
end;
{ Расчет второй производной по второй интерполяционной формуле Ньютона }
function dx2n2(xf:real):real;
var n:integer;           { Индекс X0 }
begin
  n:=nx0(x,xf)+1;
  t:=(xf-x[n])/h;
  dx2n2:=(dy2[n-2]+(t+1)*dy3[n-3])/(h*h);
end;
{ Основная программа }
begin
{ Ввод данных }
  input(x,y);
{ Расчет конечных разностей }
  razn(y,dy,5);
  razn(dy,dy2,4);
  razn(dy2,dy3,3);
  repeat
{ Вывод запроса }
    clrscr;
    for n:=0 to 5 do writeln(' X= ',x[n]:4:4,' Y= ',y[n]:4:4);
    writeln;write(' Введите координату X: ');
    readln(tx);
{ Расчет и вывод результата }
    h:=x[1]-x[0];
    if (nx0(x,tx)<3) then begin
      writeln(' Первая произовдная F(',tx:4:4,')= ',dxn1(tx):4:4);
      writeln(' Вторая произовдная F(',tx:4:4,')= ',dx2n1(tx):4:4);
    end else begin
      writeln(' Первая произовдная F(',tx:4:4,')= ',dxn2(tx):4:4);
      writeln(' Вторая произовдная F(',tx:4:4,')= ',dx2n2(tx):4:4);
    end;
{ Вывод запроса и продолжение если ENTER}
    writeln;
    writeln(' Нажмите ENTER для продолжения. Любая другая клавиша - выход ');
    c:=readkey;
  until (c<>#13);
{ Выход }
  clrscr;
end.
