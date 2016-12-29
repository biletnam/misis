program me;
var
  y:real;               { Y полученный явным методом }
  yn:real;              { Y полученный неявным методом }
  t:real;
  h:real;               { Шаг }
  ns,nps:integer; { Количество шагов всего и между строками таблицы }
  n,i:integer;            { Счетчики }

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
{ Цикл обработки }
  repeat
    writeln(' T=0,  Y=1 ');
    write(' Введите h, количество шагов, шаг сетки таблицы: ');
    read(h,ns,nps);
{ Вывод таблицы с заданным шагом }
    y:=0;
    yn:=0;
    t:=0;
    if (h<>0) then begin
  { Вывод очередной части таблицы с заданным шагом }
      n:=nps;
      writeln(' Шаг: ',h,' Строк в таблице: ',ns div nps);
      write(' t         Y         YN         Yточн.  ');
      writeln('Yточн-Y  Yточн-YN');
      for i:=ns-1 downto 0 do begin
      { Расчет следующих значений }
        y:=y+h*f(t,y);
        yn:=(yn+h*(cos(t+h)+25*sin(t+h)))/(1+25*h);
        t:=t+h;
        n:=n-1;
      { Вывод, если досчитал счетчик пропускаемых строк }
        if (n=0) then begin
          writeln(t:7:6,'  ',y:7:6,'  ',yn:7:6,'  ',tr(t):7:6,
             '  ',tr(t)-y:7:6,'  ',tr(t)-yn:7:6);
          n:=nps;
        end;
      end;
    end;
  until (h<>0);
end.
