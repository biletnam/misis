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
function pr(x:mas; n_f,n:integer; var g:mas; var fil:text):real;



implementation
uses crt;
  {$F+}
{Вывод списка функций на экран}
procedure v_fun(var n_f:integer; var nn:integer);
begin
   writeln(' -------*****------Список функций------*****---------');
   writeln('  F(x1,x2)=16.1x1-3.5x2+exp(1.4x1x1+2.8x2x2)');
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
   g[1]:=(16.1+2.8*x[1]*exp(1.4*x[1]*x[1]+2.8*x[2]*x[2]));
   g[2]:=(-3.5+5.6*x[2]*exp(1.4*x[1]*x[1]+2.8*x[2]*x[2]));
end;



{--Вычисление значения градиента--}
function pr(x:mas; n_f,n:integer; var g:mas; var fil:text):real;
  var g1,vr:real;
      i:integer;
 begin
     g1:=0;
     gradient(x,n_f,g,fil);
     for i:=1 to 2 do
     g1:=g1+(g[i]*g[i]);
     vr:=sqrt(g1);
     pr:=vr;
  end;




end.
