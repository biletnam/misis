UNIT TRAPINT;
INTERFACE
USES CRT;
Function f(x:real):real;
Function Trap(a,b:real;n:integer):real;
IMPLEMENTATION
{ Интегрируемая функция }
function f(x:real):real;
begin
  f:=exp(x)*SIN(x*x);
end;
{ Метод трапеций }
Function Trap(a,b:real;n:integer):real;
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

END.
