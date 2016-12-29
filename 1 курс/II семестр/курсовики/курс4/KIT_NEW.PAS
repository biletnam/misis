Uses Crt,Matemat;
var
Y,Yn,E,R,X,R1,R2,A,B,Rpr: real;
N,N1,M: integer;
Er: byte;
function Ur (y1: real): real; far;
begin
ur := Exp((1/5)*Ln(R*Y1 + X));
end;


begin
ClrScr;
WriteLn ( 'nach prom-ka r, bolshe 0');
ReadLn (R1);
while R1 < 0 do
begin
WriteLn('pri proshlom vvode proiz oshibka, bylo vvedeno otric chiclo');
WriteLn('nach prom-ka r, bolshe 0');
ReadLn (R1);
end;
WriteLn ('kon prom-ka r');
ReadLn(R2);
WriteLn ('nach prom-ka func');
ReadLn(A);
WriteLn ('kon prom-ka func');
ReadLn(B);
WriteLn ('tochnost');
ReadLn(E);
WriteLn ('KolIter');
ReadLn(N1);
WriteLn ('Kol zn posle zap');
ReadLn(m);
WriteLn ('priraschenie R');
ReadLn(Rpr);
R := R1;
ClrScr;
WriteLn ('Otvety:');
Yn := A;
repeat
X := 0.1;
repeat
 Korni_ur(A,B,E,N1,M,Ur,Er,Y);

if Er = 1 then
WriteLn (' pri r = ',R:0:3,' i x= ',X:0:2, ' na zadannom promegytke kop net')
else WriteLn (' pri r = ',R:0:3,' i x= ',X:0:2, ' na zadannom promegytke kop= ',y :0:m );
X := X + 0.02;
until X >= 0.32;
R := R + Rpr;
until r > r2;
writeln ('Podschet kornei okonchen! ');
ReadKey;
end.
