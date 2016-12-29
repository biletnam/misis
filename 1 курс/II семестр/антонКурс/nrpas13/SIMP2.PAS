PROCEDURE simp2(a: glmpbynp; m,n,mp,np: integer;
      l2: glmparray; nl2: integer; VAR ip: integer;
      kp: integer; VAR q1: real);
(* Programs using routine SIMP2 must define the types
TYPE
   glmpbynp = ARRAY [1..mp,1..np] OF real;
   glmparray = ARRAY [1..mp] OF integer;
in the main routine. *)
LABEL 2,6,99;
VAR
   k,ii,i: integer;
   qp,q0,q: real;
BEGIN
   ip := 0;
   IF (nl2 < 1) THEN GOTO 99;
   FOR i := 1 TO nl2 DO BEGIN
      IF (a[l2[i]+1,kp+1] < 0.0) THEN GOTO 2
   END;
   GOTO 99;
2:   q1 := -a[l2[i]+1,1]/a[l2[i]+1,kp+1];
   ip := l2[i];
   IF ((i+1) > nl2) THEN GOTO 99;
   FOR i := i+1 TO nl2 DO BEGIN
      ii := l2[i];
      IF (a[ii+1,kp+1] < 0.0) THEN BEGIN
         q := -a[ii+1,1]/a[ii+1,kp+1];
         IF (q < q1) THEN BEGIN
            ip := ii;
            q1 := q
         END ELSE IF (q = q1) THEN BEGIN
            FOR k := 1 TO n DO BEGIN
               qp := -a[ip+1,k+1]/a[ip+1,kp+1];
               q0 := -a[ii+1,k+1]/a[ii+1,kp+1];
               IF (q0 <> qp) THEN GOTO 6
            END;
6:            IF (q0 < qp) THEN ip := ii
         END
      END
   END;
99:   END;
