{      Лабораторная работа   № 1
                    задача   № 8.
   Дополнительные сведения
                ФИО автора   Крынина Елена Александровна
                    группа   ДИС-2000
        программа написана   26 февраляя 2001г 17:38
                    версия   первая
}
program lab_1_8;
uses CRT;

var
  x,y,z:real;
  F:real;

procedure Oformlenie;
    procedure win_col( tbg:integer; x1,y1,x2,y2:integer);
    begin
      Window(x1,y1,x2,y2);
      TextBackGround(tbg);
      ClrScr
    end;
  begin
    TextColor(3);
    TextBackGround(5);
    ClrScr;
    win_col( 0, 11,5,74,22 );
    win_col( 1, 10,4,73,21 );
    win_col( 1, 14,5,70,20 );
    WriteLn('Вас приветствует автор данной программы ');
    WriteLn('студентка ЭПИ МИСиСа, группы ДИС-2000');
    WriteLn('        Крынина Елена! ');
  end;

function A(x,y:real):real;
begin
  A:=((1/y)*(x*exp(2/5*(x+3))+y/(sqr(x)+4))/(exp(-x-2)+1/(sqr(x)+4)));
end;

function B(x,z,A:real):real;
begin
  B:=(1+cos(a+2))/((exp(4*x))/2+sqr(sin(z)));
end;

BEGIN
   x:=2828.4*exp(-3*10);
   y:=4.1093;
   z:=-7*sqrt(Pi)/9.5;
   Oformlenie;                   {Заставка программы}
   F:=Pi/2-arctan((ln(abs(a(x,y)+sqrt(b(x,z,A(x,y))))))/sqrt(1-sqr(ln(abs(a(x,y)+sqrt(b(x,z,A(x,y))))))));
   WriteLn(F:2:2);
   Repeat Until KeyPressed;
END.


