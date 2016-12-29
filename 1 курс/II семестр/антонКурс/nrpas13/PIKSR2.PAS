PROCEDURE piksr2(n: integer; VAR arr,brr: glsarray);
(* Programs using routine PIKSR2 must define the type
TYPE
   glsarray = ARRAY [1..np] OF real;
in the main routine, with np >= n.   *)
LABEL 10;
VAR
   j,i: integer;
   b,a: real;
BEGIN
   FOR j := 2 TO n DO BEGIN
      a := arr[j];
      b := brr[j];
      FOR i := j-1 DOWNTO 1 DO BEGIN
         IF (arr[i] <= a) THEN GOTO 10;
         arr[i+1] := arr[i];
         brr[i+1] := brr[i]
      END;
      i := 0;
10:      arr[i+1] := a;
      brr[i+1] := b
   END
END;
