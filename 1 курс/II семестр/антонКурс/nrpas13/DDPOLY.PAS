PROCEDURE ddpoly(c: glcarray; nc: integer; x: real;
       VAR pd: glpdarray; nd: integer);
(* Programs using routine DDPOLY must define the types
TYPE
   glcarray = ARRAY [1..nc] OF integer;
   glpdarray = ARRAY [1..nd] OF integer;
in the main routine. *)
VAR
   nnd,j,i: integer;
   cnst: real;
BEGIN
   pd[1] := c[nc];
   FOR j := 2 TO nd DO BEGIN
      pd[j] := 0.0
   END;
   FOR i := nc-1 DOWNTO 1 DO BEGIN
      IF (nd < (nc+1-i)) THEN nnd := nd ELSE nnd := nc+1-i;
      FOR j := nnd DOWNTO 2 DO BEGIN
         pd[j] := pd[j]*x+pd[j-1]
      END;
      pd[1] := pd[1]*x+c[i]
   END;
   cnst := 2.0;
   FOR i := 3 TO nd DO BEGIN
      pd[i] := cnst*pd[i];
      cnst := cnst*i
   END
END;
