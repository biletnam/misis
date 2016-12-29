PROCEDURE polint(xa,ya: glnarray; n: integer;
       x: real; VAR y,dy: real);
(* Programs using routine POLINT must define the type
TYPE
   glnarray = ARRAY [1..n] OF real;
in the main routine. *)
VAR
   ns,m,i: integer;
   w,hp,ho,dift,dif,den: real;
   c,d: glnarray;
BEGIN
   ns := 1;
   dif := abs(x-xa[1]);
   FOR i := 1 TO n DO BEGIN
      dift := abs(x-xa[i]);
      IF (dift < dif) THEN BEGIN
         ns := i;
         dif := dift
      END;
      c[i] := ya[i];
      d[i] := ya[i]
   END;
   y := ya[ns];
   ns := ns-1;
   FOR m := 1 TO n-1 DO BEGIN
      FOR i := 1 TO n-m DO BEGIN
         ho := xa[i]-x;
         hp := xa[i+m]-x;
         w := c[i+1]-d[i];
         den := ho-hp;
         IF (den = 0.0) THEN BEGIN
            writeln ('pause in routine POLINT'); readln END;
         den := w/den;
         d[i] := hp*den;
         c[i] := ho*den
      END;
      IF ((2*ns) < (n-m)) THEN BEGIN
         dy := c[ns+1]
      END ELSE BEGIN
         dy := d[ns];
         ns := ns-1
      END;
      y := y+dy
   END
END;
