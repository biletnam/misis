program tr_s;
uses crt,graph;
var
  a,b:real;    { Границы отрезка }
  r,r2:real;   { Предыдущее и текущее приближенные значения интеграла }
  n:integer;   { Счетчик }
{ Интегрируемая функция }
function f(x:real):real;
begin
  f:=1/(x*ln(x)*0.43429);
end;
{ Метод трапеций }
function trap(a,b:real;n:integer):real;
var
  s:real;      { Полученная сумма }
  h:real;      { Шаг }
  m:integer;   { Счетчик }
begin
  h:=(b-a)/(n-1);                   { Определяется шаг }
  s:=(f(a)+f(b))/2;                 { Начальное значение суммы }
  for m:=1 to n-2 do s:=s+f(a+m*h); { Суммиование остальных элементов }
  trap:=s*h;                        { Возвращается значение интеграла }
end;
{ Метод Симпсона }
function simpson(a,b:real;n:integer):real;
var
  s:real;      { Сумма }
  h:real;      { Шаг }
  m:integer;   { Счетчик }
  mn:integer;  { Очередной множитель }
begin
  h:=(b-a)/(n-1);                   { Рассчитывается шаг }
  s:=f(a)+f(b);                     { Начальное значение шага }
  mn:=4;                            { Первый мнодитель - 4 }
{ Суммирование остальных элементов }
  for m:=1 to n-2 do begin
    s:=s+mn*f(a+h*m);
    if (mn=4) then mn:=2 else mn:=4;{ Именение мноителя 2<>4 }
  end;
  simpson:=s*h/3;                   { Возвращается вычисленное значение }
end;

{ Процедура вычисления порядка числа }
procedure norm(a:real);
var n:real;
begin
{ Если число слишком мало - возвращается ноль }
  if (a<0.00001) then n:=0
  else begin
{ Если число меньше единицы }
    if (a<1) then begin
      n:=1;
      repeat
        a:=a*10;
        n:=n/10;
      until (trunc(a)<>0);
    end else begin
{ Если число больше единицы }
      n:=1;
      repeat
        a:=a/10;
        n:=n*10;
      until (trunc(a)=0);
    end;
  end;
  a:=n;
end;

{ Построение графика функции }
procedure out_grp(xmin,xmax,ymin,ymax:real);
var
  drv,mode:integer;
  mx,my:real;      { Масштабы по осям }
  xx,yy:real;      { Текущие координаты }
  sx:real;         { Шаг по оси X }
  dltx,dlty:integer;{ Приращение на графике при смещении графика }
  s:string;        { Строка }
begin
{ Инициализация графики }
  drv:=VGA;
  mode:=VGAHi;
  initgraph(drv,mode,'');
{ Выяснение порядков минимумов и максимумов }
  norm(xmax);
  norm(ymax);
  norm(ymin);ymin:=ymin/10;
  norm(xmin);ymin:=ymin/10;
  if (xmin/xmax)>0.01 then dltx:=20 else dltx:=0;
  if (ymin/ymax)>0.01 then dlty:=20 else dlty:=0;
{ Расчет масштабов }
  mx:=500/(xmax-xmin);
  my:=400/(ymax-ymin);
{ Расчет приращения по X }
  sx:=(xmax-xmin)/550;
{ Вывод системы координат }
  settextjustify(1,1);
  xx:=xmin;
  repeat
    setcolor(1);
    line(trunc(40+mx*(xx-xmin)+dltx),20,trunc(40+mx*(xx-xmin)+dltx),469);
    str(xx:4:2,s);
    setcolor(15);
    outtextxy(trunc(40+mx*(xx-xmin)+dltx),475,s);
    xx:=xx+50*sx;
  until (xx>(xmax+50*sx));
  yy:=ymin+(ymax-ymin)/10;
  repeat
    setcolor(1);
    line(41,trunc(470-my*(yy-ymin)-dlty),630,trunc(470-my*(yy-ymin)-dlty));
    str(yy:4:2,s);
    setcolor(15);
    outtextxy(20,trunc(470-my*(yy-ymin)-dlty),s);
    yy:=yy+(ymax-ymin)/10;
  until (yy>(ymax+(ymax-ymin)/10));
  line(40,0,40,480);
  line(0,470,640,470);
  line(40,0,38,10);
  line(40,0,42,10);
  line(640,470,630,472);
  line(640,470,630,468);
{ Вывод графика }
  xx:=xmin;
  repeat
    yy:=f(xx);
    putpixel(trunc(40+mx*(xx-xmin)+dltx),trunc(470-my*(yy-ymin)-dlty),7);
    xx:=xx+sx;
  until (xx>xmax);
  outtextxy(300,10,' Press ESC to continue ');
  repeat until (readkey=#27);
  closegraph;
end;

{ Основная программа }
begin
{ Ввод границ отрезков }
  clrscr;
  write(' Введите A,B: ');
  readln(a,b);
{ Выводится график функции }
  out_grp(a,b,f(b),f(a));
{ Вычисляется интеграл по методу трапеций }
  n:=3;
  r:=trap(a,b,n);         { Начальное значение }
  repeat
    r2:=r;                { Запоминается предыдущее значение }
    n:=n+2;               { Увеличивается количество шагов }
    r:=trap(a,b,n);       { Рассчитывается новое значение }
  until (abs(r-r2)<0.001);{ Повторяется до достижения необходимой точности }
{ Вывод результатов }
  writeln(' Резльтат по методу трапеций равен: ',r:6:3);
  writeln(' для получения необходимой точности интервал был разбит на ');
  writeln(n,' отрезков');
{ Вычисляется интеграл по методу Симпсона }
  n:=3;
  r:=simpson(a,b,n);      { Начальное значение }
  repeat
    r2:=r;                { Запоминается предыдущее значение }
    n:=n+2;               { Увеличивается количество шагов }
    r:=simpson(a,b,n);       { Рассчитывается новое значение }
  until (abs(r-r2)<0.001);{ Повторяется до достижения необходимой точности }
{ Вывод результатов }
  writeln;
  writeln(' Резльтат по методу Симпсона равен: ',r:6:3);
  writeln(' для получения необходимой точности интервал был разбит на ');
  writeln(n,' отрезков');
end.
