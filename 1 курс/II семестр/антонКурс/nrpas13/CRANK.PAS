PROCEDURE crank(n: integer; VAR w: narray; VAR s: real);
(* Programs using routine CRANK must define type
TYPE
   narray = ARRAY [1..n] OF real;
in the calling routine *)
LABEL 2;
VAR
   j,ji,jt,lbl1,lbl2: integer;
   t,rank: real;
BEGIN
   s := 0.0;
   j := 1;
   WHILE (j < n) DO BEGIN
      IF (w[j+1] <> w[j]) THEN BEGIN
         w[j] := j;
         j := j+1
      END ELSE BEGIN
         FOR jt := j+1 TO n DO BEGIN
            IF (w[jt] <> w[J]) THEN GOTO 2;
         END;
         jt := n+1;
2:         rank := 0.5*(j+jt-1);
         FOR ji := j TO jt-1 DO W[ji] := rank;
         t := jt-j;
         s := s+t*t*t-t;
         j := jt
      END
   END;
   IF (j = n) THEN w[n] := n
END;
