PROCEDURE difeq(k,k1,k2,jsf,is1,isf: integer; indexv: glindex;
      ne: integer; VAR s: glsarray; nsi,nsj: integer;
      y: glyarray; nyj,nyk: integer);
(* Programs using routine DIFEQ must define the types
TYPE
   glindex = ARRAY [1..nyj] OF integer;
   glsarray = ARRAY [1..nsi,1..nsj] OF real;
   glyarray = ARRAY [1..nyj,1..nyk] OF real;
and also declare the global quantities
CONST
   m=41;
VAR
   h,c2,anorm: real;
   mm,n: integer;
   x: ARRAY [1..m] OF real;
in the main routine.   *)
VAR
   temp2,temp: real;
BEGIN
   IF (k = k1) THEN BEGIN
      IF (((n+mm) MOD 2) = 1) THEN BEGIN
         s[3,3+indexv[1]] := 1.0;
         s[3,3+indexv[2]] := 0.0;
         s[3,3+indexv[3]] := 0.0;
         s[3,jsf] := y[1,1]
      END ELSE BEGIN
         s[3,3+indexv[1]] := 0.0;
         s[3,3+indexv[2]] := 1.0;
         s[3,3+indexv[3]] := 0.0;
         s[3,jsf] := y[2,1]
      END
   END ELSE IF (k > k2) THEN BEGIN
      s[1,3+indexv[1]] := -(y[3,m]-c2)/(2.0*(mm+1.0));
      s[1,3+indexv[2]] := 1.0;
      s[1,3+indexv[3]] := -y[1,m]/(2.0*(mm+1.0));
      s[1,jsf] := y[2,m]-(y[3,m]-c2)*y[1,m]/(2.0*(mm+1.0));
      s[2,3+indexv[1]] := 1.0;
      s[2,3+indexv[2]] := 0.0;
      s[2,3+indexv[3]] := 0.0;
      s[2,jsf] := y[1,m]-anorm
   END ELSE BEGIN
      s[1,indexv[1]] := -1.0;
      s[1,indexv[2]] := -0.5*h;
      s[1,indexv[3]] := 0.0;
      s[1,3+indexv[1]] := 1.0;
      s[1,3+indexv[2]] := -0.5*h;
      s[1,3+indexv[3]] := 0.0;
      temp := h/(1.0-sqr(x[k]+x[k-1])*0.25);
      temp2 := 0.5*(y[3,k]+y[3,k-1])-c2*0.25*sqr(x[k]+x[k-1]);
      s[2,indexv[1]] := temp*temp2*0.5;
      s[2,indexv[2]] := -1.0-0.5*temp*(mm+1.0)*(x[k]+x[k-1]);
      s[2,indexv[3]] := 0.25*temp*(y[1,k]+y[1,k-1]);
      s[2,3+indexv[1]] := s[2,indexv[1]];
      s[2,3+indexv[2]] := 2.0+s[2,indexv[2]];
      s[2,3+indexv[3]] := s[2,indexv[3]];
      s[3,indexv[1]] := 0.0;
      s[3,indexv[2]] := 0.0;
      s[3,indexv[3]] := -1.0;
      s[3,3+indexv[1]] := 0.0;
      s[3,3+indexv[2]] := 0.0;
      s[3,3+indexv[3]] := 1.0;
      s[1,jsf] := y[1,k]-y[1,k-1]-0.5*h*(y[2,k]+y[2,k-1]);
      s[2,jsf] := y[2,k]-y[2,k-1]-temp*((x[k]+x[k-1])
         *0.5*(mm+1.0)*(y[2,k]+y[2,k-1])-temp2
         *0.5*(y[1,k]+y[1,k-1]));
      s[3,jsf] := y[3,k]-y[3,k-1]
   END
END;
