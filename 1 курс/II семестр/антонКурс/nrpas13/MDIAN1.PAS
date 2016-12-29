PROCEDURE mdian1(VAR x: narray; n: integer; VAR xmed: real);
(* Program using routine MDIAN1 must define the type
TYPE
   narray = ARRAY [1..n] OF real;
in the calling routine *)
VAR
   n2: integer;
BEGIN
   sort(n,x);
   n2 := n DIV 2;
   IF (2*n2 = n) THEN xmed := 0.5*(x[n2]+x[n2+1])
   ELSE xmed := x[n2+1]
END;
