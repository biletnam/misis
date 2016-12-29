Unit Mathem;
Interface
Type
	Func = Function(X, Y: Real): Real;
Procedure SystIter(F1, F2: Func; Xk, Yk: Real; E: Real; N: Integer; var Error: Byte; var X, Y: Real);
Implementation
Procedure SystIter;
var
	X0, Y0, Modul1, Modul2: Real;
	K: Integer;
Begin
	K:=0;
	Error:=0;
	Repeat
	K:=K+1;
 	X0:=Xk;
	Y0:=Yk;
	Xk:=F1(X0, Y0);
	Yk:=F2(X0, Y0);
	if (X0-Xk)<0 then Modul1:=(X0-Xk)*(-1);
	if (Y0-Yk)<0 then Modul2:=(Y0-Yk)*(-1);
     	Until ((Modul1<E) and (Modul2<E)) or (K=N);
      if ((Modul1<E) and (Modul2<E)) then
	begin
      X:=Xk; Y:=Yk;
      end
	else Error:=1;
End;
end.
