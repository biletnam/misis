PROCEDURE indexx(n: integer; arrin: glsarray; VAR indx: gliarray);
(* Programs using routine INDEXX must define the types
TYPE
   glsarray = ARRAY [1..np] OF real;
   gliarray = ARRAY [1..np] OF integer;
in the main routine, with np >= n.   *)
LABEL 99;
VAR
   l,j,ir,indxt,i: integer;
   q: real;
BEGIN
   FOR j := 1 TO n DO BEGIN
      indx[j] := j
   END;
   l := (n DIV 2) + 1;
   ir := n;
   WHILE true DO BEGIN
      IF (l > 1) THEN BEGIN
            l := l-1;
            indxt := indx[l];
            q := arrin[indxt]
      END ELSE BEGIN
         indxt := indx[ir];
         q := arrin[indxt];
         indx[ir] := indx[1];
         ir := ir-1;
         IF (ir = 1) THEN BEGIN
            indx[1] := indxt;
            GOTO 99
         END
      END;
      i := l;
      j := l+l;
      WHILE (j <= ir) DO BEGIN
         IF (j < ir) THEN BEGIN
             IF (arrin[indx[j]] < arrin[indx[j+1]]) THEN j := j+1
         END;
         IF (q < arrin[indx[j]]) THEN BEGIN
            indx[i] := indx[j];
            i := j;
            j := j+j
         END ELSE
            j := ir+1
      END;
      indx[i] := indxt
   END;
99:   END;
