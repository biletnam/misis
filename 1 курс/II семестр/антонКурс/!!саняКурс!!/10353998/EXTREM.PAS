program ex;
uses crt,graph,dos;
var drv,mode:integer;           { Для инициализации графики }
    x,y,py:real;                { X,Y функции и предыдущее значение функции}
    h,ph:real;                  { Значение и предыдущее значение
                                  характеристической функции }
    c:char;                     { Считанный с клаиатуры символ }
    oh:array [1..50] of real;   { Значения по методу характеристической функции }
    ol:array [1..50] of real;   { Значения по Лагранжу }
    mn:real;                    { Частота }
    ohnum,olnum:integer;        { Количество значений по методу
                                  характеристической функции и по Лагранжу }
    y1,y2,y3:real;              { Прошедшие значения функции }
    n:longint;                  { Счетчик тактов }
    pl,l:real;                  { Предыдущее и текущее значения по Лагранжу }
    th,tm,ts,tss:word;          { Для получения времени }
    tih,til:word;               { Время выполнения }
const step=0.01;                { Шаг дискретизации }

function f(x:real):real;  {функция вычисления синуса х}
begin
  f:=sin(x*mn);
end;

begin
  clrscr;
  write(' Введите частоту: ');
  readln(mn);
  drv:=detect;
  initgraph(drv,mode,'');       {инициализация графики}
  setcolor(12);
  line(10,0,10,480);
  line(8,10,10,0);
  line(10,0,12,10);
  line(5,120,630,120);
  line(630,120,620,118);    {вывод на экран осей координат}
  line(630,120,620,122);
  line(5,320,630,320);
  line(630,320,620,318);
  line(630,320,620,322);
  setcolor(15);
  line(0,210,640,210);
  outtextxy(14,2,'Y');
  outtextxy(620,110,'X');   {вывод надписей на оси}
  outtextxy(620,310,'X');
  outtextxy(320,10,'f(x)');
  setcolor(14);
  outtextxy(320,220,'H-funct.');
  setcolor(5);
  outtextxy(200,220,'f(x)`');
  setcolor(8);
  x:=0;
  py:=f(0-step);
  ph:=1;             {установка начальных переменных}
  n:=0;
  ohnum:=0;
  olnum:=0;
{ Вывод графика функции }
  repeat
    y:=f(x);   { вычисления значения sin(x) }
    putpixel(round(x*80+10),round(120-y*80),14); {построение точки}
    x:=x+step; {увеличение х на 0.1}
    py:=y;
  until (x>6.28318); {если х>2Pi то выход из цикла}
  x:=0;
  py:=f(0-step);
{ Расчет характеристической функции }
  repeat gettime(th,tm,ts,tss) until (tss<>0); {зацикливание пока
                                       сотые доли секунды <> 0 }
  repeat
    y:=f(x);  { вычисления значения sin(x) }
    if (y>py) then h:=1 else h:=-1; {если функция возрастает то h=1}
                                    {если убывает то h=-1}
    x:=x+step; {увеличение х на 0.1}
    putpixel(round(x*80+10),round(320-h*80),14);  {построение точки}
    if (ph<>h) then begin
  { Вывод и запись в массив значения экстремума }
      ohnum:=ohnum+1;
      oh[ohnum]:=x;
      line(round(x*80+10),10,round(x*80+10),470);
      outtextxy(round(x*80+12),310,'Xe');
    end;
    ph:=h;
    py:=y;
  until (x>6.28318);
  gettime(th,tm,ts,tih);
  x:=0;
  n:=0;
{ Расчет по Лагранжу }
  repeat gettime(th,tm,ts,tss) until (tss<>0);
  repeat
    { Вычисление функции }
    y:=f(x);
    x:=x+step;
    if (n>2) then begin
    { Вычисление производной функции по Лагранжу }
      l:=(y-y1)/(2*step);
      putpixel(round((x-step)*80+10),round(320-l*80/mn),5);
      if ((n<>3)and(pl*l<=0)) then begin
        { Запись значения экстремума по Лагранжу }
        olnum:=olnum+1;
        ol[olnum]:=x-step;
      end;
      pl:=l;
    end;
    n:=n+1;
    y1:=y2;
    y2:=y;
  until (x>6.28318);
  gettime(th,tm,ts,til);
  c:=readkey;
  closegraph;
{ Вывод результатов }
  writeln(' Полученные результаты:');
  writeln(' По методу с использованием интерполяционных формул Лагранжа: ');
  writeln(' Всего найдено ',olnum,' экстремума. Их ординаты: ');
  for n:=1 to olnum do writeln(ol[n]);
  writeln;
  writeln(' На рассчеты затраченно ',til,' сотых секунды ');
  writeln;
  writeln(' По методу с использованием характеристической функции: ');
  writeln(' Всего найдено ',ohnum,' экстремума. Их ординаты: ');
  writeln;
  writeln(' На рассчеты затраченно ',tih,' сотых секунды ');
  writeln;
  for n:=1 to ohnum do writeln(oh[n]);
  c:=readkey;
end.