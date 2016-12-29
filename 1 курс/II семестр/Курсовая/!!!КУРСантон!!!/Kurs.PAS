program kr;

uses crt,newton;

var
  tx:real;              { Точка, в которой находится производная }
  n:integer;            { Счетчик }
  R:integer;
  FileCoord:text;

  {Вычисление функции}
  Function F(x:real;R:integer):real;
  begin
     F:=x-Ln( abs(Exp(x*Ln(2))+Ln(x*x+R)/Ln(10)+Sqrt(Exp(2*x)+R*Exp(x)+1)));
  end;

  {Создание файла значений}
  Procedure MakeFile(R:integer);
  var i:real;
  begin
     Assign(FileCoord,'TABL.DAT');
     Rewrite(FileCoord);
     For n:= 8 to 13 do
     begin
        i:=0.001*n;
        Write(FileCoord,i);
        Write(FileCoord,' ');
        WriteLn(FileCoord,F(i,R));
     end;
     Close(FileCoord);
  end;

BEGIN
  ClrScr;
  WriteLn('                                    _________________');
  WriteLn('              |  x        2        |  2x        x      |');
  WriteLn('y(x) =  x - Ln| 2  +  Lg(x + R) + \| e    +  R*e  + 1  |');
  WriteLn;
  WriteLn('x = 0,011');
  WriteLn;
  For R:= 1 to 18  do
  begin
     MakeFile(R);
     SecondP(0.011);
     Write('R  =',R:4,'   ');
     WriteLn('y"  =  ',SecondP(0.011):4:4);
  end;
  readkey;
END.
