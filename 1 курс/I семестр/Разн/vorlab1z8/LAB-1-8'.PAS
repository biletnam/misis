{      Лабораторная работа   № 3
                    задача   № 20.
   Дополнительные сведения
                ФИО автора   Крынина Елена Александровна
                    группа   ДИС-2000
        программа написана   26 февраляя 2001г 15:02
                    версия   для распечатки
}

program lab_3_20;
uses CRT;
const
  N=40;
var
  i:byte;
  Sum:real;

function S(i:byte):real;
begin
  S:=(1-sqr(i))*cos(sqrt(i+1));
end;

BEGIN
   ClrScr;
   for i:=1 to N do
   if S(i)<=-1.5 then Sum:=Sum+S(i);
   WriteLn(Sum:5:2);
   Repeat Until KeyPressed;
END.


