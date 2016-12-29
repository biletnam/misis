unit idvvod;
interface
uses ustp;
{----Процедуры ввода исходных данных для методов оптимизации----}

{--Для градиентных методов--}
{--Для метода наискорейшего спуска--}
procedure VvodIsxD_NS(n:integer; var x:mas; var h,eps:real; var fil:text);

{--}


implementation
  {$F+}
{--Для метода наискорейшего спуска--}
procedure VvodIsxD_NS(n:integer; var x:mas; var h,eps:real; var fil:text);
var i:integer;
begin
     writeln;
     writeln(fil,'Исходные данные для метода наискорейшего спуска');
     writeln('Ввод исходных данных для метода наискорейшего спуска');
     writeln('Введите начальную точку (',n,' координаты):');
     writeln(fil,'Начальная точка:');
     n:=2;
     for i:=1 to n do
     begin
          read(x[i]);
          write(fil,'  ',x[i]:4:2);
          end;
     write('Введите начальный шаг h:');
     readln(h);
     writeln(fil);
     writeln (fil,'Начальный шаг h: ',h:4:2);
     write('Введите погрешность eps: ');
     readln (eps);
     writeln (fil,'Погрешность eps: ',eps);
end;

end.