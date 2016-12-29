PROCEDURE midinf(aa,bb: real; VAR s: real; n: integer);
(* Programs using MIDINF must define the function to be integrated
with the declaration FUNCTION func(x: real): real; They must also declare
the global variable
VAR
   glit: integer; *)
VAR
   j: integer;
   x,tnm,sum,del,ddel,b,a: real;
FUNCTION funk(x: real): real;
   BEGIN
      funk := func(1.0/x)/sqr(x)
   END;
BEGIN
   b := 1.0/aa;
   a := 1.0/bb;
   IF (n = 1) THEN BEGIN
      s := (b-a)*funk(0.5*(a+b));
      glit := 1
   END ELSE BEGIN
      tnm := glit;
      del := (b-a)/(3.0*tnm);
      ddel := del+del;
      x := a+0.5*del;
      sum := 0.0;
      FOR j := 1 TO glit DO BEGIN
         sum := sum+funk(x);
         x := x+ddel;
         sum := sum+funk(x);
         x := x+del
      END;
      s := (s+(b-a)*sum/tnm)/3.0;
      glit := 3*glit
   END
END;
