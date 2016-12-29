Unit Matemat;
Interface
type func = function (Y1 : real):real;
procedure Korni_ur(A,B,E: real; N1,M: integer; Fun: func; var Er: byte; var Y: real);
Implementation
procedure Korni_ur(A,B,E: real;N1,M: integer; Fun: func; var Er: byte; var Y: real);
var N : integer;
Y0,Yn : real;
begin
Er := 0;
N := 0;
repeat
N := N +1;
Y0 := Yn;
Yn := Fun (Y0);
until (abs(Yn - Y0) <E) or (N = N1);
if (Yn >= A) and (Yn <= B) then
  Y:= Yn
else Er := 1;

{if (yn >= a) and (yn <= b) then  begin a := yn;
writeln (' pri r = ',Rpar:0:3,' i x= ',Xpar:0:2, ' v zadannom promegytke kop = ', yn :0:m); end
else writeln (' pri r = ',Rpar:0:3,' i x= ',Xpar:0:2, ' v zadannom promegytke kop net');}
end;
end.
