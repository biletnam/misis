PROCEDURE zroots(a: glcarray; m: integer; VAR roots: glcarray;
       polish: boolean);
(* Programs using routine ZROOTS must define the types
TYPE
   glcarray = ARRAY [1..2*m+2] OF real;
   gl2array = ARRAY [1..2] OF real;
in the main routine. *)
LABEL 10;
CONST
   eps=2.0e-6;
VAR
   jj,j,i: integer;
   dum: real;
   b,c,x: gl2array;
   ad: glcarray;
BEGIN
   FOR j := 1 TO 2*(m+1) DO BEGIN
      ad[j] := a[j]
   END;
   FOR j := m DOWNTO 1 DO BEGIN
      x[1] := 0.0;
      x[2] := 0.0;
      laguer(ad,j,x,eps,false);
      IF (abs(x[2]) <= (2.0*eps*abs(x[1]))) THEN BEGIN
         x[2] := 0.0
      END;
      roots[2*j-1] := x[1];
      roots[2*j] := x[2];
      b[1] := ad[2*j+1];
      b[2] := ad[2*j+2];
      FOR jj := j DOWNTO 1 DO BEGIN
         c[1] := ad[2*jj-1];
         c[2] := ad[2*jj];
         ad[2*jj-1] := b[1];
         ad[2*jj] := b[2];
         dum := b[1];
         b[1] := b[1]*x[1]-b[2]*x[2]+c[1];
         b[2] := dum*x[2]+b[2]*x[1]+c[2]
      END
   END;
   IF (polish) THEN BEGIN
      FOR j := 1 TO m DO BEGIN
         x[1] := roots[2*j-1];
         x[2] := roots[2*j];
         laguer(a,m,x,eps,true);
         roots[2*j-1] := x[1];
         roots[2*j] := x[2]
      END
   END;
   FOR j := 2 TO m DO BEGIN
      x[1] := roots[2*j-1];
      x[2] := roots[2*j];
      FOR i := j-1 DOWNTO 1 DO BEGIN
         IF (roots[2*i-1] <= x[1]) THEN GOTO 10;
         roots[2*i+1] := roots[2*i-1];
         roots[2*i+2] := roots[2*i]
      END;
      i := 0;
10:      roots[2*i+1] := x[1];
      roots[2*i+2] := x[2]
   END
END;
