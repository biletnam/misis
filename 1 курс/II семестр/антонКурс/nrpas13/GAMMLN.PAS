FUNCTION gammln(xx: real): real;
CONST
   stp = 2.50662827465;
   half = 0.5;
   one = 1.0;
   fpf = 5.5;
VAR
   x,tmp,ser: double;
   j: integer;
   cof: ARRAY [1..6] OF double;
BEGIN
   cof[1] := 76.18009173;
   cof[2] := -86.50532033;
   cof[3] := 24.01409822;
   cof[4] := -1.231739516;
   cof[5] := 0.120858003e-2;
   cof[6] := -0.536382e-5;
   x := xx-one;
   tmp := x+fpf;
   tmp := (x+half)*ln(tmp)-tmp;
   ser := one;
   FOR j := 1 TO 6 DO BEGIN
      x := x+one;
      ser := ser+cof[j]/x
   END;
   gammln := sngl(tmp+ln(stp*ser))
END;
