PROCEDURE pzextr(iest: integer; xest: real; yest: glyarray;
       VAR yz,dy: glyarray; nv,nuse: integer);
(* Programs using routine PZEXTR must declare
TYPE
   glyarray = ARRAY [1..nv] OF real;
CONST
   glimax=11;
   glnmax=10;
   glncol=7;
VAR
   glx: ARRAY [1..glimax] OF real;
   glqcol: ARRAY [1..glnmax,1..glncol] OF real;
in the main routine. *)
CONST
   nmax=10;
VAR
   m1,k1,j: integer;
   q,f2,f1,delta: real;
   d: ARRAY [1..nmax] OF real;
BEGIN
   glx[iest] := xest;
   FOR j := 1 TO nv DO BEGIN
      dy[j] := yest[j];
      yz[j] := yest[j]
   END;
   IF (iest = 1) THEN BEGIN
      FOR j := 1 TO nv DO BEGIN
         glqcol[j,1] := yest[j]
      END
   END ELSE BEGIN
      IF (iest < nuse) THEN m1 := iest ELSE m1 := nuse;
      FOR j := 1 TO nv DO BEGIN
         d[j] := yest[j]
      END;
      FOR k1 := 1 TO m1-1 DO BEGIN
         delta := 1.0/(glx[iest-k1]-xest);
         f1 := xest*delta;
         f2 := glx[iest-k1]*delta;
         FOR j := 1 TO nv DO BEGIN
            q := glqcol[j,k1];
            glqcol[j,k1] := dy[j];
            delta := d[j]-q;
            dy[j] := f1*delta;
            d[j] := f2*delta;
            yz[j] := yz[j]+dy[j]
         END
      END;
      FOR j := 1 TO nv DO BEGIN
         glqcol[j,m1] := dy[j]
      END
   END
END;
