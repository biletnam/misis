PROCEDURE fpoly(x: real; VAR p: glnparray; np: integer);
(* Programs using routine FPOLY must define the type
TYPE
   glnparray = ARRAY [1..np] OF real;
in the main routine.   *)
VAR
   j: integer;
BEGIN
   p[1] := 1.0;
   FOR j := 2 TO np DO BEGIN
      p[j] := p[j-1]*x
   END
END;
