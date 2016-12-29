unit VibFo;

interface
uses ustp;

{--Непосредственое вычисление значения функции--}
function FO(x:real; n_f:integer; var fil:text):real;

{--Вычисление производных--}
function PrFo(x:real; n_f:integer; var fil:text):real;
{--Вычисление вторых производных--}
function ddFo(x:real; n_f:integer; var fil:text):real;


implementation
uses crt;
  {$F+}


{--Непосредственое вычисление значения функции--}
 function FO(x:real; n_f:integer; var fil:text):real;
  begin
     FO:=((x+6.4)*(x+6.4)+exp(-1.4*x));
 end;

{--Вычисление производных--}
 function PrFo(x:real; n_f:integer; var fil:text):real;
 var g1,vr:real;
 begin
   g1:=0;
   if x<>0 then
      PrFO:=exp(-x)*ln(x)-exp(-x)*(1/x)
   else
    begin
      writeln('Ошибка! Деление на ноль! Пересмотрите вводимые параметры!');
      writeln(fil,'Ошибка! Деление на ноль! Пересмотрите вводимые параметры!');
      writeln(fil);
      close(fil);delay(2500); halt(2);
    end;
   end;

{--Вычисление вторых производных--}
function ddFo(x:real; n_f:integer; var fil:text):real;
  var g1,vr:real;
 begin
   g1:=0;
  case n_f of
1: if (x<>0) then
   ddFO:=exp(-x)*ln(x)-exp(-x)*(1/x)+exp(-x)*(1/x)+exp(-x)*(1/(x*x))
     else begin
      writeln('Ошибка! Деление на ноль! Пересмотрите вводимые параметры!');
      writeln(fil,'Ошибка! Деление на ноль! Пересмотрите вводимые параметры!');
      writeln(fil);
      close(fil);delay(2500); halt(2);end;

end;
end;


end.
