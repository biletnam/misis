PROCEDURE rank(n: integer; indx: gliarray; VAR irank: gliarray);
(* Programs using routine RANK must define type
TYPE
   gliarray = ARRAY [1..np] OF real;
in the main routine, with np >= n.   *)
VAR
   j: integer;
BEGIN
   FOR j := 1 TO n DO BEGIN
      irank[indx[j]] := j
   END
END;
