PROCEDURE locate(xx: glnarray; n: integer;
         x: real; VAR j: integer);
(* Programs which use routine LOCATE must define the type
TYPE
   glnarray = ARRAY [1..n] OF real;
in the main routine. *)
VAR
   ju,jm,jl: integer;
BEGIN
   jl := 0;
   ju := n+1;
   WHILE (ju-jl > 1) DO BEGIN
      jm := (ju+jl) DIV 2;
      IF ((xx[n] > xx[1]) = (x > xx[jm])) THEN jl := jm
      ELSE ju := jm
   END;
   j := jl
END;
