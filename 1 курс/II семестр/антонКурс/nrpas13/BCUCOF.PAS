PROCEDURE bcucof(y,y1,y2,y12: gl4array; d1,d2: real; VAR c: gl4by4);
(* Programs using routine BCUCOF must define the types
TYPE
   gl4array = ARRAY [1..4] OF real;
   gl4by4 = ARRAY [1..4,1..4] OF real;
in the main routine. They must also declare the variables
VAR
   glflag: boolean;
   wt: ARRAY [1..16,1..16] OF real;
and initialize glflag to true. The values of wt are read from the file
bcucof.dat whose contents are listed at the end of this routine. The procedure
GLOPEN assigns bcucof.dat to infile and opens the file for reading. *)
VAR
   l,k,j,i: integer;
   xx,d1d2: real;
   cl,x: ARRAY[1..16] OF real;
   infile: text;
BEGIN
   IF glflag THEN BEGIN
      glflag := FALSE;
      glopen(infile,'bcucof.dat');
      FOR i := 1 TO 16 DO FOR k := 1 TO 16 DO read(infile,wt[k,i]);
      close(infile)
   END;
   d1d2 := d1*d2;
   FOR i := 1 TO 4 DO BEGIN
      x[i] := y[i];
      x[i+4] := y1[i]*d1;
      x[i+8] := y2[i]*d2;
      x[i+12] := y12[i]*d1d2
   END;
   FOR i := 1 TO 16 DO BEGIN
      xx := 0.0;
      FOR k := 1 TO 16 DO xx := xx+wt[i,k]*x[k];
      cl[i] := xx
   END;
   l := 0;
   FOR i := 1 TO 4 DO
      FOR j := 1 TO 4 DO BEGIN
          l := l+1;
          c[i,j] := cl[l]
      END
END;
(* Contents of the file bcucof.dat
1 0 -3 2 0 0 0 0 -3 0 9 -6 2 0 -6 4 0 0 0 0 0 0 0 0 3 0 -9 6 -2 0 6 -4
0 0 0 0 0 0 0 0 0 0 9 -6 0 0 -6 4 0 0 3 -2 0 0 0 0 0 0 -9 6 0 0 6 -4
0 0 0 0 1 0 -3 2 -2 0 6 -4 1 0 -3 2 0 0 0 0 0 0 0 0 -1 0 3 -2 1 0 -3 2
0 0 0 0 0 0 0 0 0 0 -3 2 0 0 3 -2 0 0 0 0 0 0 3 -2 0 0 -6 4 0 0 3 -2
0 1 -2 1 0 0 0 0 0 -3 6 -3 0 2 -4 2 0 0 0 0 0 0 0 0 0 3 -6 3 0 -2 4 -2
0 0 0 0 0 0 0 0 0 0 -3 3 0 0 2 -2 0 0 -1 1 0 0 0 0 0 0 3 -3 0 0 -2 2
0 0 0 0 0 1 -2 1 0 -2 4 -2 0 1 -2 1 0 0 0 0 0 0 0 0 0 -1 2 -1 0 1 -2 1
0 0 0 0 0 0 0 0 0 0 1 -1 0 0 -1 1 0 0 0 0 0 0 -1 1 0 0 2 -2 0 0 -1 1 *)
