uses  crt,matr;
const m:matrix = (  (  3, 1,-1, 2, 1 ),
                    ( -2, 3, 0, 4, 3 ),
                    (  1, 4, 2, 3, 1 ),
                    (  5, 2,-3, 0,-1 ),
                    ( -1, 1, 2, 3, 2 )  );
VAR
  MyMatrix:matrix;
  Rmin, Rmax, R:integer;
  Det: integer;
  num: integer;
  OutFile: text;

Procedure MakeMyMatrix(R:integer);
begin
  MyMatrix:=m;
  MyMatrix[2,3]:=R;
  MyMatrix[4,4]:=R;
end;

BEGIN
  ClrScr;
  WriteLn   ('    3    1   -1    2    1');
  WriteLn   ('   -2    3    R    4    3');
  WriteLn   ('    1    4    2    3    1');
  WriteLn   ('    5    2   -3    R   -1');
  WriteLn   ('   -1    1    2    3    2');
  WriteLn;
  Write('Введите начальное значение R: ');
  ReadLn(Rmin);
  Write('Введите конечное значение  R: ');
  ReadLn(Rmax);
  WriteLn('Значения R, при которых определитель не превышает 157:');
  WriteLn;
  num:=0;
  Assign(OutFile,'Out.txt');
  Rewrite(OutFile);
  For R:= Rmin to Rmax do
  begin
    MakeMyMatrix(R);
    Det := Opredelitel(MyMatrix,5);
    If Det <= 157 then
     begin
       Write('R = ',R);
       WriteLn(' Определитель = ',Det);
       num:=num+1;
       WriteLn(OutFile,'R = ',R,'  ','Det = ',Det);
     end;
  end;
  WriteLn;
  WriteLn('Всего R, удовлетворяющих условию, в данном диапазоне: ',num);
  Close(OutFile);
  ReadKey;
END.