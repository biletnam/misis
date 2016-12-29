PROCEDURE ks(key: gl64array; n: integer; VAR kn: gl48array);
(* Programs using routine KS must define the types
TYPE
   gl48array = ARRAY [1..48] OF integer;
   gl56array = ARRAY [1..56] OF integer;
   gl64array = ARRAY [1..64] OF integer;
in the main routine. They must also declare the variables
VAR
   glicd,ipc1: gl56array;
   ipc2: gl48array;
   ksflg: boolean;
and initialize ksflg to true. The values of ipc1 and ipc2 are read from
the file ksinpu.dat whose contents are given at the end of this routine. The
procedure GLOPEN assigns ksinpu.dat to infile and opens the file for reading. *)
VAR
   j,it,id,ic,i: integer;
   infile: text;
BEGIN
  IF ksflg THEN BEGIN
      ksflg := false;
      glopen(infile,'ksinpu.dat');
      FOR i := 1 TO 56 DO read(infile,ipc1[i]);
      FOR i := 1 TO 48 DO read(infile,ipc2[i]);
      close(infile)
   END;
   IF (n = 1) THEN BEGIN
      FOR j := 1 TO 56 DO BEGIN
         glicd[j] := key[ipc1[j]]
      END
   END;
   it := 2;
   IF ((n = 1) OR (n = 2) OR (n = 9) OR (n = 16)) THEN it := 1;
   FOR i := 1 TO it DO BEGIN
      ic := glicd[1];
      id := glicd[29];
      FOR j := 1 TO 27 DO BEGIN
         glicd[j] := glicd[j+1];
         glicd[j+28] := glicd[j+29]
      END;
      glicd[28] := ic;
      glicd[56] := id
   END;
   FOR j := 1 TO 48 DO kn[j] := glicd[ipc2[j]]
END;
(* Contents of the file ksinpu.dat
57 49 41 33 25 17 9 1 58 50 42 34 26 18 10 2 59 51 43 35 27 19 11 3 60 52 44 36
63 55 47 39 31 23 15 7 62 54 46 38 30 22 14 6 61 53 45 37 29 21 13 5 28 20 12 4
14 17 11 24 1 5 3 28 15 6 21 10 23 19 12 4 26 8 16 7 27 20 13 2
41 52 31 37 47 55 30 40 51 45 33 48 44 49 39 56 34 53 46 42 50 36 29 32 *)
PROCEDURE cyfun(ir: gl32array; k: gl48array; VAR iout: gl32array);
(* Programs using routine CYFUN must define the types
TYPE
   gl32array = ARRAY [1..32] OF integer;
   gl48array = ARRAY [1..48] OF integer;
in the main routine. They must also declare the variables
VAR
   iet: gl48array;
   ipp: gl32array;
   is: ARRAY[1..16,1..4,1..8] OF integer;
   ibin: ARRAY[1..4,1..16] OF integer;
   cyflg: boolean;
and initialize cyflg to true. The values of iet, ipp, is and ibin are read
from the file cyfuni.dat. The procedure GLOPEN assigns cyfuni.dat to
infile and opens the file for reading. *)
VAR
   jj,irow,icol,kk,iss,ki,j: integer;
   ie: gl48array;
   itmp: gl32array;
   infile: text;
BEGIN
   IF cyflg THEN BEGIN
      cyflg := false;
      glopen(infile,'cyfuni.dat');
      FOR j := 1 TO 48 DO read(infile,iet[j]);
      FOR j := 1 TO 32 DO read(infile,ipp[j]);
      FOR jj := 1 TO 8 DO
         FOR ki := 1 TO 4 DO
            FOR j := 1 TO 16 DO read(infile,is[j,ki,jj]);
      FOR j := 1 TO 16 DO
         FOR ki := 1 TO 4 DO read(infile,ibin[ki,j]);
      close(infile)
   END;
   FOR j := 1 TO 48 DO ie[j] := (((ir[iet[j]]+k[j]) MOD 2)+2) MOD 2;
   FOR jj := 1 TO 8 DO BEGIN
      j := 6*jj-5;
      irow := 2*ie[j]+ie[j+5];
      icol := 8*ie[j+1]+4*ie[j+2]+2*ie[j+3]+ie[j+4];
      iss := is[icol+1,irow+1,jj];
      kk := 4*(jj-1);
      FOR ki := 1 TO 4 DO itmp[kk+ki] := ibin[ki,iss+1]
   END;
   FOR j := 1 TO 32 DO iout[j] := itmp[ipp[j]]
END;
(* Contents of the file cyfuni.dat
32 1 2 3 4 5 4 5 6 7 8 9 8 9 10 11 12 13 12 13 14 15 16 17
16 17 18 19 20 21 20 21 22 23 24 25 24 25 26 27 28 29 28 29 30 31 32 1
16 7 20 21 29 12 28 17 1 15 23 26 5 18 31 10
2 8 24 14 32 27 3 9 19 13 30 6 22 11 4 25
14 4 13 1 2 15 11 8 3 10 6 12 5 9 0 7 0 15 7 4 14 2 13 1 10 6 12 11 9 5 3 8
4 1 14 8 13 6 2 11 15 12 9 7 3 10 5 0 15 12 8 2 4 9 1 7 5 11 3 14 10 0 6 13
15 1 8 14 6 11 3 4 9 7 2 13 12 0 5 10 3 13 4 7 15 2 8 14 12 0 1 10 6 9 11 5
0 14 7 11 10 4 13 1 5 8 12 6 9 3 2 15 13 8 10 1 3 15 4 2 11 6 7 12 0 5 14 9
10 0 9 14 6 3 15 5 1 13 12 7 11 4 2 8 13 7 0 9 3 4 6 10 2 8 5 14 12 11 15 1
13 6 4 9 8 15 3 0 11 1 2 12 5 10 14 7 1 10 13 0 6 9 8 7 4 15 14 3 11 5 2 12
7 13 14 3 0 6 9 10 1 2 8 5 11 12 4 15 13 8 11 5 6 15 0 3 4 7 2 12 1 10 14 9
10 6 9 0 12 11 7 13 15 1 3 14 5 2 8 4 3 15 0 6 10 1 13 8 9 4 5 11 12 7 2 14
2 12 4 1 7 10 11 6 8 5 3 15 13 0 14 9 14 11 2 12 4 7 13 1 5 0 15 10 3 9 8 6
4 2 1 11 10 13 7 8 15 9 12 5 6 3 0 14 11 8 12 7 1 14 2 13 6 15 0 9 10 4 5 3
12 1 10 15 9 2 6 8 0 13 3 4 14 7 5 11 10 15 4 2 7 12 9 5 6 1 13 14 0 11 3 8
9 14 15 5 2 8 12 3 7 0 4 10 1 13 11 6 4 3 2 12 9 5 15 10 11 14 1 7 6 0 8 13
4 11 2 14 15 0 8 13 3 12 9 7 5 10 6 1 13 0 11 7 4 9 1 10 14 3 5 12 2 15 8 6
1 4 11 13 12 3 7 14 10 15 6 8 0 5 9 2 6 11 13 8 1 4 10 7 9 5 0 15 14 2 3 12
13 2 8 4 6 15 11 1 10 9 3 14 5 0 12 7 1 15 13 8 10 3 7 4 12 5 6 11 0 14 9 2
7 11 4 1 9 12 14 2 0 6 10 13 15 3 5 8 2 1 14 7 4 10 8 13 15 12 9 0 3 5 6 11
0 0 0 0 0 0 0 1 0 0 1 0 0 0 1 1 0 1 0 0 0 1 0 1 0 1 1 0 0 1 1 1
1 0 0 0 1 0 0 1 1 0 1 0 1 0 1 1 1 1 0 0 1 1 0 1 1 1 1 0 1 1 1 1 *)
