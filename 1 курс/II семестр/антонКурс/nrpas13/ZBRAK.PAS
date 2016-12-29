PROCEDURE zbrak(x1,x2: real; n: integer;
      VAR xb1,xb2: glnbmax; VAR nb: integer);
(* Programs using routine ZBRAK must externally define a function
fx(x:real):real which is to be analyzed for roots. Also, the
calling program must define type
TYPE
   glnbmax = ARRAY [1..nbmax] OF real;
where nbmax is the maximum number to be required for 'nb'. *)
LABEL 99;
VAR
   nbb,i: integer;
   x,fp,fc,dx: real;
BEGIN
   nbb := nb;
   nb := 0;
   x := x1;
   dx := (x2-x1)/n;
   fp := fx(x);
   FOR i := 1 TO n DO BEGIN
      x := x+dx;
      fc := fx(x);
      IF ((fc*fp) < 0.0)  THEN BEGIN
         nb := nb+1;
         xb1[nb] := x-dx;
         xb2[nb] := x
      END;
      fp := fc;
      IF (nbb = nb) THEN GOTO 99;
   END;
99:   END;
