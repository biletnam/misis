Uses Crt,Mat;
var
     E,R,Rn,Rkon,Shag,A,Kop,B,X,B0:real;
     N,K:integer;
function F(X:real):real;far;
begin
     F:=X*cos(X)/sin(X)-R;
end;
begin
     ClrScr;
     A:=-7*pi;
     B:=13*pi;
     B0:=B;
     Write('vvedite kol-vo iterac. ciklov N=');
     ReadLn(N);
     K:=0;
     Write('vvedite tochnost E=');
     ReadLn(E);
     Write('nach. zn. prom. R=');
     ReadLn(Rn);
     Write('kon. zn. prom. R=');
     ReadLn(Rkon);
     Write('prir. R=');
     ReadLn(Shag);
     WriteLn('X   F(X)   A   F(A)   B   F(B)');
     R:=Rn;
     repeat
           repeat
                 if K<>0 then
                 if F(A+E)*F(B)>0 then break;
                 Korni(F,A,B,X,E,Kop);
                 if Kop<>0 then
                 WriteLn('Kop=',Kop:4:20);
                 A:=Kop;
                 B:=B0;
                 K:=K+1;
           until K>=N;
           R:=R+Shag;
     until R>=Rkon+Shag;
     ReadKey;
end.