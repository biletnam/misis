Uses CRT, Mathem;
var
	R, Q, Rn, Rkon, Qn, Qkon, X, Y, X1, X2, Y1, Y2, Xk, Yk, E, Step: Real;
	N: Integer;
	Err: Byte;
Function Func1(X, Y: Real): Real; far;
begin
	Func1:=Q+cos(Y+R);
end;

Function Func2(X, Y: Real): Real; far;
begin
      Func2:=sin(X-Q)-R;
end;
Begin
      ClrScr;
	X1:=0; X2:=1; Y1:=-2; Y2:=-1.5;
	Write('Введите начало промежутка R => ');
	Readln(Rn);
	Write('Введите конец промежутка R => ');
      Readln(Rkon);
      Write('Введите начало промежутка Q => ');
      Readln(Qn);
	Write('Введите конец промежутка Q => ');
      Readln(Qkon);
	Write('Введите точность вычислений Е => ');
      Readln(E);
	Write('Введите количество итерационных циклов N => ');
      Readln(N);
	Write('Введите приращение R и Q => ');
      Readln(Step);
	ClrScr;
      R:=Rn;
      Xk:=0; Yk:=-2;
      repeat
      Q:=Qn;
	repeat
	SystIter(Func1, Func2, Xk, Yk, E, N, Err, X, Y);
	if (((X>=X1) and (X<=X2)) and ((Y>=Y1) and (Y<=Y2))) and (Err<>1) then
	Writeln('R = ',R:1:4,'    Q = ',Q:1:4,'   X =  ',X:1:4,'   Y = ',Y:1:4);
	Q:=Q+Step;
	until Q>=Qkon+Step;
	R:=R+Step;
	until R>=Rkon+Step;
	repeat until keypressed;
End.