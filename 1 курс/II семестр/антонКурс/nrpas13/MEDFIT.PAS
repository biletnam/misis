PROCEDURE medfit(x,y: glndata; ndata: integer; VAR a,b,abdev: real);
(* Programs using routine MEDFIT must define the type
TYPE
   glndata = ARRAY [1..ndata] OF real;
in the main routine. MEDFIT also assumes that the instructions
at the beginning of ROFUNC have been carried out so that arrays
x,y and arr, and real variables aa and abdevt exist as globally
defined variables. *)
LABEL 3;
VAR
   j: integer;
   sy,sxy,sxx,sx,sigb,f2,f1,f: real;
   del,chisq,bb,b2,b1: real;
BEGIN
   sx := 0.0;
   sy := 0.0;
   sxy := 0.0;
   sxx := 0.0;
   FOR j := 1 TO ndata DO BEGIN
      sx := sx+x[j];
      sy := sy+y[j];
      sxy := sxy+x[j]*y[j];
      sxx := sxx+sqr(x[j])
   END;
   del := ndata*sxx-sx*sx;
   aa := (sxx*sy-sx*sxy)/del;
   bb := (ndata*sxy-sx*sy)/del;
   chisq := 0.0;
   FOR j := 1 TO ndata DO BEGIN
      chisq := chisq+sqr(y[j]-(aa+bb*x[j]))
   END;
   sigb := sqrt(chisq/del);
   b1 := bb;
   f1 := rofunc(b1);
   IF (f1 > 0.0) THEN BEGIN
      b2 := bb+abs(3.0*sigb)
   END ELSE BEGIN
      b2 := bb-abs(3.0*sigb)
   END;
   f2 := rofunc(b2);
   WHILE ((f1*f2) > 0.0) DO BEGIN
      bb := 2.0*b2-b1;
      b1 := b2;
      f1 := f2;
      b2 := bb;
      f2 := rofunc(b2)
   END;
   sigb := 0.01*sigb;
   WHILE (abs(b2-b1) > sigb) DO BEGIN
      bb := 0.5*(b1+b2);
      IF ((bb = b1) OR (bb = b2)) THEN GOTO 3;
      f := rofunc(bb);
      IF ((f*f1) >= 0.0) THEN BEGIN
         f1 := f;
         b1 := bb
      END ELSE BEGIN
         f2 := f;
         b2 := bb
      END
   END;
3:   a := aa;
   b := bb;
   abdev := abdevt/ndata
END;
