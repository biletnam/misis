PROCEDURE polcof(xa,ya: glnarray; n: integer; VAR cof: glnarray);
(* Programs using routine POLCOF must define the type
TYPE
   glnarray = ARRAY [1..n] OF real;
in the main routine. *)
VAR
   k,j,i: integer;
   xmin,dy: real;
   x,y: glnarray;
BEGIN
   FOR j := 1 TO n DO BEGIN
      x[j] := xa[j];
      y[j] := ya[j]
   END;
   FOR j := 1 TO n DO BEGIN
      polint(x,y,n+1-j,0.0,cof[j],dy);
      xmin := 1.0E38;
      k := 0;
      FOR i := 1 TO n+1-j DO BEGIN
         IF (abs(x[i]) < xmin) THEN BEGIN
            xmin := abs(x[i]);
            k := i
         END;
         IF (x[i] <> 0.0) THEN y[i] := (y[i]-cof[j])/x[i]
      END;
      IF (k < (n+1-j)) THEN BEGIN
         FOR i := k+1 TO n+1-j DO BEGIN
            y[i-1] := y[i];
            x[i-1] := x[i]
         END
      END
   END
END;
