PROCEDURE chder(a,b: real; c: glcarray; VAR cder: glcarray; n: integer);
(* Programs using routine CHDER must define the type glcarray
as in routine CHEBFT. *)
VAR
   j: integer;
   con: real;
BEGIN
   cder[n] := 0.0;
   cder[n-1] := 2*(n-1)*c[n];
   IF (n >= 3) THEN BEGIN
      FOR j := n-2 DOWNTO 1 DO BEGIN
         cder[j] := cder[j+2]+2*j*c[j+1]
      END
   END;
   con := 2.0/(b-a);
   FOR j := 1 TO n DO BEGIN
      cder[j] := cder[j]*con
   END
END;
