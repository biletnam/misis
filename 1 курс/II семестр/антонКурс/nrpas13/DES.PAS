PROCEDURE des(input,key: gl64array; VAR newkey: integer;
         isw: integer; VAR jotput: gl64array);
(* Programs using routine DES must define the type
TYPE
   gl32array = ARRAY [1..32] OF integer;
   gl64array = ARRAY [1..64] OF integer;
   gl48array = ARRAY [1..48] OF real;
in the main routine. They must also declare the variables
VAR
   ip,ipm: gl64array;
   desflg: boolean;
and initialize desflg to true. The values of ip and ipm are read from
the file desinp.dat whose contents are listed at the end of this routine.
The procedure GLOPEN is used to assign desinp.dat to infile and open the file
for reading. *)
VAR
   j,ii,ic,i: integer;
   titmp,icf: gl32array;
   itmp: gl64array;
   kns: ARRAY[1..48,1..16] OF integer;
   tkns: gl48array;
   infile: text;
BEGIN
   IF desflg THEN BEGIN
      desflg := false;
      glopen(infile,'desinp.dat');
      FOR i := 1 TO 64 DO read(infile,ip[i]);
      FOR i := 1 TO 64 DO read(infile,ipm[i]);
      close(infile)
   END;
   IF (newkey <> 0) THEN BEGIN
      newkey := 0;
      FOR i := 1 TO 16 DO BEGIN
         ks(key,i,tkns);
         FOR j := 1 TO 48 DO kns[j,i] := tkns[j]
      END
   END;
   FOR j := 1 TO 64 DO itmp[j] := input[ip[j]];
   FOR i := 1 TO 16 DO BEGIN
      ii := i;
      IF (isw = 1) THEN ii := 17-i;
      FOR j := 1 TO 48 DO tkns[j] := kns[j,ii];
      FOR j := 1 TO 32 DO titmp[j] := itmp[32+j];
      cyfun(titmp,tkns,icf);
      FOR j := 1 TO 32 DO BEGIN
         ic := icf[j]+itmp[j];
         itmp[j] := itmp[j+32];
         itmp[j+32] := abs(ic MOD 2)
      END
   END;
   FOR j := 1 TO 32 DO BEGIN
      ic := itmp[j];
      itmp[j] := itmp[j+32];
      itmp[j+32] := ic
   END;
   FOR j := 1 TO 64 DO jotput[j] := itmp[ipm[j]]
END;
(* Contents of the file desinp.dat
58 50 42 34 26 18 10 2 60 52 44 36 28 20 12 4 62 54 46
38 30 22 14 6 64 56 48 40 32 24 16 8 57 49 41 33 25 17 9 1 59 51
43 35 27 19 11 3 61 53 45 37 29 21 13 5 63 55 47 39 31 23 15 7
40 8 48 16 56 24 64 32 39 7 47 15 55 23 63 31 38 6 46 14
54 22 62 30 37 5 45 13 53 21 61 29 36 4 44 12 52 20 60 28 35 3
43 11 51 19 59 27 34 2 42 10 50 18 58 26 33 1 41 9 49 17 57 25 *)
