unit ustp;
interface
const n_m=40;
type mas=array[1..n_m] of real;
type mass=array[1..n_m,1..n_m] of real;

type fyn=function (x:real; n:integer; var fil:text):real;
type fun=function (x:mas; n_f:integer; var fil:text):real;
type fpr=function (x:mas; n_f,n:integer; var g:mas; var fil:text):real;

type funo=function (x:real):real;
type funn=function (x:mas):real;
type funpr=function (x:mas; n:integer; var g:mas):real;

{--Получение имени файла для ввода результатов--}
procedure GetInputName(var fil_name:Text);
{--Проверка соответствия значения--}
procedure proverka(x:real; var p:byte; var fil:text);
{--Определение знака--}
function sgn(c:real; b:real):real;
{--Возведение числа (выражения) в степень k (целое)--}
function stp(y:real;k:integer):real;


implementation
uses crt;
  {$F+}
{--Получение имени файла для ввода результатов--}
procedure GetInputName(var fil_name:Text);
  var FName:string;
      IOCode:word;
  begin
    repeat
    textColor(12);
    writeln('     Задайте имя файла в который будете выводить результаты');
{    writeln('(для вывода на экран - CON)');}
    HighVideo;
    readln(FName);
    LowVideo;
    textColor(10);
    writeln('     Подсказка: Файл результатов находиться в директории из которой');
    writeln('                был запущен файл turbo.exe  или  программа (*.exe).');
    Assign(fil_name,FName);
   {$I-} { Отключить аварийное завершение при возникновении ошибки I/O}
    Reset(fil_name);
   {$I+}
   IOCode:=IOResult;
   if IOCode>0 then begin
               Rewrite(fil_name);
               writeln(fil_name,'Результаты нахождение оптимума');
               Exit;
              end
          else begin
               Append(fil_name);
               writeln(fil_name,'Результаты нахождение оптимума');
               end;
   until IOCode=0;
end;


{--Проверка соответствия значения--}
procedure proverka(x:real; var p:byte; var fil:text);
begin
 if abs(x) >= 1e+17 then
      begin writeln('    Ошибка! Переполнение! Минимум не найден !!!');
            writeln('    Пересмотрите вводимые параметры!');
            writeln(fil,'    Ошибка! Переполнение! Минимум не найден!');
            writeln(fil,'    Пересмотрите вводимые параметры!');
            writeln(fil);close(fil);
            p:=1; delay(2500); Halt(1);
      end
    else p:=0;
end;


{--Определение знака--}
function sgn(c:real; b:real):real;
   var a:real;
    begin
      a:=c-b;
       if a>=0 then sgn:=1
          else sgn:=-1;
    end;


{--Возведение числа (выражения) в степень k (целое)--}
function stp(y:real;k:integer):real;
var i:integer;
    s:real;
begin
      s:=1;
      for i:=1 to k do s:=s*y;
      stp:=s;
end;

end.

