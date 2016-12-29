PROCEDURE simp1(a: glmpbynp; mp,np,mm: integer;
      ll: glnparray; nll,iabf: integer;
      VAR kp: integer; VAR bmax: real);
(* Programs using routine SIMP1 must define the types
TYPE
   glmpbynp = ARRAY [1..mp,1..np] OF real;
   glnparray = ARRAY [1..np] OF integer;
in the main routine. *)
LABEL 99;
VAR
   k: integer;
   test: real;
BEGIN
   kp := ll[1];
   bmax := a[mm+1,kp+1];
   IF (nll < 2) THEN GOTO 99;
   FOR k := 2 TO nll DO BEGIN
      IF (iabf = 0) THEN BEGIN
         test := a[mm+1,ll[k]+1]-bmax
      END ELSE BEGIN
         test := abs(a[mm+1,ll[k]+1])-abs(bmax)
      END;
      IF (test > 0.0) THEN BEGIN
         bmax := a[mm+1,ll[k]+1];
         kp := ll[k]
      END
   END;
99:   END;
