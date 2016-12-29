PROCEDURE simp3(VAR a: glmpbynp; mp,np,i1,k1,ip,kp: integer);
(* Programs using routine SIMP3 must define the type
TYPE
   glmpbynp = ARRAY [1..mp,1..np] OF real;
in the main routine. *)
VAR
   kk,ii: integer;
   piv: real;
BEGIN
   piv := 1.0/a[ip+1,kp+1];
   IF (i1 >= 0) THEN BEGIN
      FOR ii := 1 TO (i1+1) DO BEGIN
         IF ((ii-1) <> ip) THEN BEGIN
            a[ii,kp+1] := a[ii,kp+1]*piv;
            FOR kk := 1 TO k1+1 DO BEGIN
               IF ((kk-1) <> kp) THEN BEGIN
                  a[ii,kk] := a[ii,kk]
                   -a[ip+1,kk]*a[ii,kp+1]
               END
            END
         END
      END
   END;
   FOR kk := 1 TO k1+1 DO BEGIN
      IF ((kk-1) <> kp) THEN a[ip+1,kk] := -a[ip+1,kk]*piv
   END;
   a[ip+1,kp+1] := piv
END;
