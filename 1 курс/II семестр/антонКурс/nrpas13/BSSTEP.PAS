PROCEDURE bsstep(VAR y: glyarray; dydx: glyarray; nv: integer; VAR x: real;
      htry,eps: real; yscal: glyarray; VAR hdid,hnext: real);
(* Programs using routine BSSTEP must define the type
TYPE
   glyarray = ARRAY [1..nv] OF real;
in the main routine. *)
LABEL 99;
CONST
   imax=11;
   nuse=7;
   one=1.0e0;
   shrink=0.95e0;
   grow=1.2e0;
VAR
   j,i: integer;
   xsav,xest,h,errmax: real;
   ysav,dysav,yseq,yerr: glyarray;
   nseq: ARRAY [1..imax] OF integer;
BEGIN
   nseq[1] := 2; nseq[2] := 4; nseq[3] := 6;
   nseq[4] := 8; nseq[5] := 12; nseq[6] := 16;
   nseq[7] := 24; nseq[8] := 32; nseq[9] := 48;
   nseq[10] := 64; nseq[11] := 96;
   h := htry;
   xsav := x;
   FOR i := 1 TO nv DO BEGIN
      ysav[i] := y[i];
      dysav[i] := dydx[i]
   END;
   WHILE true DO BEGIN
      FOR i := 1 TO imax DO BEGIN
         mmid(ysav,dysav,nv,xsav,h,nseq[i],yseq);
         xest := sqr(h/nseq[i]);
         rzextr(i,xest,yseq,y,yerr,nv,nuse);
         errmax := 0.0;
         FOR j := 1 TO nv DO BEGIN
            IF (errmax < abs(yerr[j]/yscal[j])) THEN
               errmax := abs(yerr[j]/yscal[j])
         END;
         errmax := errmax/eps;
         IF (errmax < one) THEN BEGIN
            x := x+h;
            hdid := h;
            IF (i = nuse) THEN hnext := h*shrink
            ELSE IF (i = nuse-1) THEN hnext := h*grow
            ELSE hnext := (h*nseq[nuse-1])/nseq[i];
            GOTO 99
         END
      END;
      h := 0.25*h;
      IF (((imax-nuse) DIV 2) > 0) THEN BEGIN
         FOR i := 1 TO ((imax-nuse) DIV 2) DO h := h/2
      END;
      IF ((x+h) = x) THEN BEGIN
         writeln('pause in routine BSSTEP');
         writeln('step size underflow'); readln
      END
   END;
99:   END;
