unit VibFn;

interface
uses ustp;
{Вывод списка функций на экран}
procedure v_fun(var n_f:integer; var nn:integer);
{--Непосредственое вычисление значения функции--}
function f(x:mas; n_f:integer; var fil:text):real;
{--Вычисление частных производных--}
procedure gradient(x:mas; n_f:integer; var g:mas; var fil:text);
{--Вычисление значения градиента--}
function pr(x:mas; n:integer):real;


implementation
uses crt;
  {$F+}
{Вывод списка функций на экран}
procedure v_fun(var n_f:integer; var nn:integer);
begin
writeln(' -------*****------Список функций------*****---------');
writeln('   F(x1,x2)=16.1x1-3.5x2+exp(1.4x1x1+2.8x2x2)');
 nn:=2;
 n_f:=2;
   writeln('Число переменных n = ',nn);
end;

{--Непосредственое вычисление значения функции--}
 function f(x:mas; n_f:integer; var fil:text):real;
 var
     k:integer;
 begin
     k:=8;
     f:=1.15*k*x[1]-0.25*k*x[2]+exp(0.1*k*x[1]*x[1]+0.2*k*x[2]*x[2]);
 end;

{--Вычисление частных производных--}
procedure gradient(x:mas; n_f:integer; var g:mas; var fil:text);
 begin
 end;
{--Вычисление значения градиента--}
function pr(x:mas; n:integer):real;
  var
  k:integer;
  g:mas;
  g1,vr:real;
  i:integer;
 begin
     k:=8;
     g1:=0;
     g[1]:=1.15*k*x[1]-0.25*k*x[2]+exp(0.1*k*x[1]*x[1]+0.2*k*x[2]*x[2]);
     g[2]:=(1.15*k-0.25*k+exp(0.1*k*x[1]*x[1]+0.2*k*x[2]*x[2]));
     g1:=g1+sqr(g[1]);
     g1:=g1+sqr(g[2]);
     pr:=sqrt(sqrt(g1));
  end;


end.
