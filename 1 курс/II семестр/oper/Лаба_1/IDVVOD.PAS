unit idvvod;
interface
uses crt,ustp;
{--Для метода "золотого" сечения--}
procedure VvodIsxD_GS(var a,b,e:real; var fil:text);

{--}

implementation
  {$F+}

{--Для метода "золотого" сечения--}
procedure VvodIsxD_GS(var a,b,e:real; var fil:text);
var i:integer;
begin
   textbackground(1);
   { Оператор окрашивающий фон экрана }
   textcolor(15);
   { Оператор окрашивающий текст }
   writeln(fil,'      Исходные данные для метода золотого сечения');
   writeln;
   writeln('      Ввод исходных данных для метода золотого сечения');
   writeln('      Задайте интервал (a,b)');
   readln(a,b);
   write(fil,'    Интервал (a,b):  ');
   writeln(fil,'  a = ',a:12:4,',    b = ',b:12:4);
   writeln('      Задайте EPSILON (точность)');
   readln(e);
   writeln(fil,'      EPSILON (точность) E= ',e:0:4);
end;


end.