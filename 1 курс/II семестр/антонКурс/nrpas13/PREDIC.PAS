PROCEDURE predic(data: gldarray; ndata: integer; d: glnparray;
      npoles: integer; VAR future: glnfarray; nfut: integer);
(* Programs using routine PREDIC must define the types
TYPE
   gldarray = ARRAY [1..ndata] OF real;
   glnparray = ARRAY [1..npoles] OF real;
   glnfarray = ARRAY [1..nfut] OF real;
in the main routine. *)
VAR
   k,j: integer;
   sum,discrp: real;
   reg: glnparray;
BEGIN
   FOR j := 1 TO npoles DO BEGIN
      reg[j] := data[ndata+1-j]
   END;
   FOR j := 1 TO nfut DO BEGIN
      discrp := 0.0;
      sum := discrp;
      FOR k := 1 TO npoles DO BEGIN
         sum := sum+d[k]*reg[k]
      END;
      FOR k := npoles DOWNTO 2 DO BEGIN
         reg[k] := reg[k-1]
      END;
      reg[1] := sum;
      future[j] := sum
   END
END;
