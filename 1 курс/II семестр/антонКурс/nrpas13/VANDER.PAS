PROCEDURE vander(x: glnarray; VAR w: glnarray; q: glnarray; n: integer);
(* Programs using the routine VANDER must define the type
TYPE
   glnarray = ARRAY [1..n] OF real;
in the main routine. *)
CONST
   zero=0.0;
   one=1.0;
VAR
   k1,k,j,i: integer;
   xx,t,s,b: real;
   c: glnarray;
BEGIN
   IF (n = 1) THEN BEGIN
      w[1] := q[1]
   END ELSE BEGIN
      FOR i := 1 TO n DO BEGIN
         c[i] := zero
      END;
      c[n] := -x[1];
      FOR i := 2 TO n DO BEGIN
         xx := -x[i];
         FOR j := (n+1-i) TO (n-1) DO BEGIN
            c[j] := c[j]+xx*c[j+1]
         END;
         c[n] := c[n]+xx
      END;
      FOR i := 1 TO n DO BEGIN
         xx := x[i];
         t := one;
         b := one;
         s := q[n];
         k := n;
         FOR j := 2 TO n DO BEGIN
            k1 := k-1;
            b := c[k]+xx*b;
            s := s+q[k1]*b;
            t := xx*t+b;
            k := k1
         END;
         w[i] := s/t
      END
   END
END;
