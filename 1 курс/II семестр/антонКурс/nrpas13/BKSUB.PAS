PROCEDURE bksub(ne,nb,jf,k1,k2: integer; VAR c: glcarray;
      nci,ncj,nck: integer);
(* Programs using routine BKSUB must define the type
TYPE
   glcarray = ARRAY [1..nci,1..ncj,1..nck] OF real;
in the main routine. *)
VAR
   nbf,kp,k,j,i,im: integer;
   xx: real;
BEGIN
   nbf := ne-nb;
   im := 1;
   FOR k := k2 DOWNTO k1 DO BEGIN
      IF (k = k1) THEN im := nbf+1;
      kp := k+1;
      FOR j := 1 TO nbf DO BEGIN
         xx := c[j,jf,kp];
         FOR i := im TO ne DO BEGIN
            c[i,jf,k] := c[i,jf,k]-c[i,j,k]*xx
         END
      END
   END;
   FOR k := k1 TO k2 DO BEGIN
      kp := k+1;
      FOR i := 1 TO nb DO BEGIN
         c[i,1,k] := c[i+nbf,jf,k]
      END;
      FOR i := 1 TO nbf DO BEGIN
         c[i+nb,1,k] := c[i,jf,kp]
      END
   END
END;
