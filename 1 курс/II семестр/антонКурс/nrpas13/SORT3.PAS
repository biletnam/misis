PROCEDURE sort3(n: integer; VAR ra,rb,rc,wksp: glsarray;
      VAR iwksp: gliarray);
(* Programs using routine SORT3 must define the types
TYPE
   glsarray = ARRAY [1..np] OF real;
   gliarray = ARRAY [1..np] OF integer;
in the main routine, with np >= n.   *)
VAR
   j: integer;
BEGIN
   indexx(n,ra,iwksp);
   FOR j := 1 TO n DO BEGIN
      wksp[j] := ra[j]
   END;
   FOR j := 1 TO n DO BEGIN
      ra[j] := wksp[iwksp[j]]
   END;
   FOR j := 1 TO n DO BEGIN
      wksp[j] := rb[j]
   END;
   FOR j := 1 TO n DO BEGIN
      rb[j] := wksp[iwksp[j]]
   END;
   FOR j := 1 TO n DO BEGIN
      wksp[j] := rc[j]
   END;
   FOR j := 1 TO n DO BEGIN
      rc[j] := wksp[iwksp[j]]
   END
END;
