PROCEDURE midpnt(a,b: real; VAR s: real; n: integer);
(* Programs using routine MIDPNT must supply a function
func(x:real):real which is to be integrated. They must also
declare an iteration counter
VAR
   glit: integer; *)
VAR
   j: integer;
   x,tnm,sum,del,ddel: real;
BEGIN
   IF  (n = 1)  THEN BEGIN
      s := (b-a)*func(0.5*(a+b));
      glit := 1
   END ELSE BEGIN
      tnm := glit;
      del := (b-a)/(3.0*tnm);
      ddel := del+del;
      x := a+0.5*del;
      sum := 0.0;
      FOR j := 1 TO glit DO BEGIN
         sum := sum+func(x);
         x := x+ddel;
         sum := sum+func(x);
         x := x+del
      END;
      s := (s+(b-a)*sum/tnm)/3.0;
      glit := 3*glit
   END
END;
