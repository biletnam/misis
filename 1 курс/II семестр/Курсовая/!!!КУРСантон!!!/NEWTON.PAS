UNIT Newton;
INTERFACE
USES CRT;
TYPE
   arr_type=array [0..5] of real; { Тип - таблица }
   procedure input(var x:arr_type;var y:arr_type);
   procedure razn(a:arr_type;var b:arr_type;n:integer);
   function nx0(a:arr_type;x:real):integer;
   function dx2n1(xf:real):real;
   function dx2n2(xf:real):real;
   function SecondP(tx:real):real;

VAR x,y:arr_type;         { Табличные значения }
    dy,dy2,dy3:arr_type;  { Конечные разности }
    t:real;               { Общая для методов переменная }
    h:real;               { Общий для методов шаг изменения аргумента }

IMPLEMENTATION

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

{ Расчет второй производной по первой интерполяционной формуле Ньютона }
function dx2n1(xf:real):real;
var n:integer;           { Индекс X0 }
begin
  n:=nx0(x,xf);
  t:=(xf-x[n])/h;
  dx2n1:=(dy2[n]+(t-1)*dy3[n])/(h*h);
end;

{ Расчет второй производной по второй интерполяционной формуле Ньютона }
function dx2n2(xf:real):real;
var n:integer;           { Индекс X0 }
begin
  n:=nx0(x,xf)+1;
  t:=(xf-x[n])/h;
  dx2n2:=(dy2[n-2]+(t+1)*dy3[n-3])/(h*h);
end;

function SecondP(tx:real):real;
begin
  input(x,y);
{ Расчет конечных разностей }
  razn(y,dy,5);
  razn(dy,dy2,4);
  razn(dy2,dy3,3);
  h:=x[1]-x[0];
    if (nx0(x,tx)<3) then
       SecondP:=dx2n1(tx)
    else
       SecondP:=dx2n2(tx);

end;

END.
