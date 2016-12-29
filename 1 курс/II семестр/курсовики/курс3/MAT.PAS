unit Mat;
interface
         Type
         Func=function(X0:real):real;
         procedure Korni (F:Func;S,M,X0,E:real;var Kop0:real);
implementation
         procedure Korni;
         begin
              while Abs(S-M)>=E do
              begin
                   X0:=(S+M)/2;
                   if F(S)*F(X0)<0 then M:=X0 else S:=X0;
                   if F(M)*F(X0)<0 then S:=X0 else M:=X0;
                   WriteLn(X0:0:3,'  ',F(X0):0:3,'  ',S:0:3,'  ',F(S):0:3,'  ',M:0:3,'  ',F(M):0:3);
              end;
              WriteLn;
              Kop0:=(S+M)/2;
         end;
end.