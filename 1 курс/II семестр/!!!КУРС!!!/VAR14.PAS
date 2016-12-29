uses  crt,matr;
const m:matrix = (  (  3, 1,-1, 2, 1 ),
                    ( -2, 3, 0, 4, 3 ),
                    (  1, 4, 2, 3, 1 ),
                    (  5, 2,-3, 0,-1 ),
                    ( -1, 1, 2, 3, 2 )  );
VAR
  MyMatrix:matrix;
  R:integer;

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
  Write('Введите целое число R: ');
  ReadLn(R);
  MakeMyMatrix(R);
  WriteLn;
  WriteLn('Определитель матрицы');
  WriteLn;
  PrintMatrix(MyMatrix,5);
  WriteLn;
  WriteLn('равен ',Opredelitel(MyMatrix,5));
  ReadKey;
END.