unit idvvod;
interface
uses ustp;
{----Процедуры ввода исходных данных для методов оптимизации----}

{--Для метода  покоординатного спуска--}
procedure VvodIsxD_PS(n:integer; var x:mas; var d,d1,r:real; var m2:integer;
                     var fil_name:text);
implementation
  {$F+}
{----Процедуры ввода исходных данных для методов оптимизации----}

{--Для метода  покоординатного спуска--}
procedure VvodIsxD_PS(n:integer; var x:mas; var d,d1,r:real; var m2:integer;
                      var fil_name:text);
var i:integer;
begin
   n:=2;
   writeln(fil_name,'Исходные данные для метода покоординатного спуска');
   writeln;
   writeln('Ввод исходных данных для метода покоординатного спуска');
   writeln('Введите ',n,' координаты начальной точки поиска р: ');
   write(fil_name,'Введите ',n,' координаты начальной точки поиска р:');
   for i:=1 to n do
   begin read(x[i]); write(fil_name,'  ',x[i]:12:4);end;
   writeln;writeln(fil_name);
   write('Шаг d (например 0.12): ');readln(d);
   write('Коэффициент изменения шага r (например 1.01): ');readln(r);
   write('Минимальная величина шага d1 (например 0.25): ');readln(d1);
   writeln(fil_name,'Шаг d (например 0.12): ',d:12:4);
   writeln(fil_name,'Коэффициент изменения шага r (например1.01): ',r:12:4);
   writeln(fil_name,'Минимальная величина шага d1 (например 0.25): ',d1:12:4);
   write('Введите максимальное количество вычислений функции m2: ');
   readln(m2);
   writeln(fil_name,'Максимальное количество вычислений функции m2: ',m2);

end;

end.