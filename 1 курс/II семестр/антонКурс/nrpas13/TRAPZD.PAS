PROCEDURE trapzd(a,b: real; VAR s: real; n: integer);
(* Programs calling TRAPZD must provide a function
func(x:real):real which is to be integrated. They must
also define the variable
VAR
   glit: integer;
in the main routine. *)
VAR
   j: integer;
   x,tnm,sum,del: real;
BEGIN
   IF (n = 1) THEN BEGIN
      s := 0.5*(b-a)*(func(a)+func(b));
      glit := 1
   END
   ELSE BEGIN
      tnm := glit;
      del := (b-a)/tnm;
      x := a+0.5*del;
      sum := 0.0;
      FOR j := 1 TO glit DO BEGIN
         sum := sum+func(x);
         x := x+del
      END;
      s := 0.5*(s+(b-a)*sum/tnm);
      glit := 2*glit
   END
END;
