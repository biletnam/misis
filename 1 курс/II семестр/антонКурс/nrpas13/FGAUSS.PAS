PROCEDURE fgauss(x: real; a: glnparam; VAR y: real;
       VAR dyda: glnparam; na: integer);
(* Programs using routine FGAUSS must define the type
TYPE
   glnparam = ARRAY [1..na] OF real;
in the main routine.   *)
VAR
   i,ii: integer;
   fac,ex,arg: real;
BEGIN
   y := 0.0;
   FOR ii := 1 TO (na DIV 3) DO BEGIN
      i := 3*ii-2;
      arg := (x-a[i+1])/a[i+2];
      ex := exp(-sqr(arg));
      fac := a[i]*ex*2.0*arg;
      y := y+a[i]*ex;
      dyda[i] := ex;
      dyda[i+1] := fac/a[i+2];
      dyda[i+2] := fac*arg/a[i+2]
   END
END;
