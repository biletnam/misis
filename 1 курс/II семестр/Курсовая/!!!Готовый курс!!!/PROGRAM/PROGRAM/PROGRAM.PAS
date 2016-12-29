uses matrixxx,crt;
const n=3;
var a:matrix;i,j:longint;
O,M,R:real;
BEGIN
clrscr;
writeln('Введите матрицу ',n,'-го порядка');
for i:=1 to n do
    begin
         for j:=1 to n do read(a[i,j]);
    end;clrscr;
PrintMatr(a,n);
O:=Opredelitel(a,n);
M:=MinorMatrix(a,n);
R:=M/(O+M);
writeln('Определитель матрицы = ',O);
writeln('Минор = ',M);
writeln('Число R = ',R);
readkey;
END.
