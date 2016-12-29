Program lab_Mas_2;
uses crt;
var A:array[1..10] of integer;
    B:array[1..3,1..4] of integer;
    i,j,S:integer;
    Sr:real;
BEGIN
ClrScr;
randomize;
writeln('Массив А:');
for i:= 1 to 10 do
begin
A[i]:=random(21)-10;
S:=S+A[i];
write(A[i]:4);
end;
writeln;
writeln;
Sr:=S/10;
writeln('Среднее арифметическое значение элементов массива А: ',Sr:4:2);
writeln;
writeln('Массив В:');
For i:=1 to 3 do
begin
For j:=1 to 4 do
begin
B[i,j]:= Random(21)-10;
write(B[i,j]:4);
end;
writeln;
end;
writeln;
writeln('Измененный массив В:');
For i:=1 to 3 do
begin
For j:=1 to 4 do
begin
if ((i+j) mod 2<>0) and (B[i,j]>Sr) then B[i,j]:=0;
write(B[i,j]:4);
end;
writeln;
end;

ReadKey;
END.