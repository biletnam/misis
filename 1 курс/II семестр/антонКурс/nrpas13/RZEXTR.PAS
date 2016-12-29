PROCEDURE rzextr(iest: integer; xest: real; yest: glyarray;
       VAR yz,dy: glyarray; nv,nuse: integer);
(* Programs using routine RZEXTR must declare
TYPE
   glyarray = ARRAY [1..nv] OF real;
CONST
   glimax=11;
   glnmax=10;
   glncol=7;
VAR
   glx: ARRAY [1..glimax] OF real;
   gld: ARRAY [1..glnmax,1..glncol] OF real;
in the main routine. *)
CONST
   ncol=7;
VAR
   m1,k,j: integer;
   yy,v,ddy,c,b1,b: real;
   fx: ARRAY [1..ncol] OF real;
BEGIN
   glx[iest] := xest;
   IF (iest = 1) THEN BEGIN
      FOR j := 1 TO nv DO BEGIN
         yz[j] := yest[j];
         gld[j,1] := yest[j];
         dy[j] := yest[j]
      END
   END ELSE BEGIN
      IF (iest < nuse) THEN m1 := iest ELSE m1 := nuse;
      FOR k := 1 TO m1-1 DO BEGIN
         fx[k+1] := glx[iest-k]/xest
      END;
      FOR j := 1 TO nv DO BEGIN
         yy := yest[j];
         v := gld[j,1];
         c := yy;
         gld[j,1] := yy;
         FOR k := 2 TO m1 DO BEGIN
            b1 := fx[k]*v;
            b := b1-c;
            IF (b <> 0.0) THEN BEGIN
               b := (c-v)/b;
               ddy := c*b;
               c := b1*b
            END ELSE ddy := v;
            IF (k <> m1) THEN v := gld[j,k];
            gld[j,k] := ddy;
            yy := yy+ddy
         END;
         dy[j] := ddy;
         yz[j] := yy
      END
   END
END;
