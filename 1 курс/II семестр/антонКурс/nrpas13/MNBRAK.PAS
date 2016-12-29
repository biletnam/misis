PROCEDURE mnbrak(VAR ax,bx,cx,fa,fb,fc: real);
(* Programs using routine MNBRAK must supply an external
function func(x:real):real for which a minimum is to be found *)
LABEL 1;
CONST
   gold=1.618034;
   glimit=100.0;
   tiny=1.0e-20;
VAR
   ulim,u,r,q,fu,dum: real;
FUNCTION max(a,b: real): real;
   BEGIN
      IF (a > b) THEN max := a ELSE max := b
   END;
FUNCTION sign(a,b: real): real;
   BEGIN
      IF (b > 0.0) THEN sign := abs(a) ELSE sign := -abs(a)
   END;
BEGIN
   fa := func(ax);
   fb := func(bx);
   IF (fb > fa) THEN BEGIN
      dum := ax;
      ax := bx;
      bx := dum;
      dum := fb;
      fb := fa;
      fa := dum
   END;
   cx := bx+gold*(bx-ax);
   fc := func(cx);
1:   IF (fb >= fc) THEN BEGIN
      r := (bx-ax)*(fb-fc);
      q := (bx-cx)*(fb-fa);
      u := bx-((bx-cx)*q-(bx-ax)*r)/
         (2.0*sign(max(abs(q-r),tiny),q-r));
      ulim := bx+glimit*(cx-bx);
      IF ((bx-u)*(u-cx) > 0.0) THEN BEGIN
         fu := func(u);
         IF (fu < fc) THEN BEGIN
            ax := bx;
            fa := fb;
            bx := u;
            fb := fu;
            GOTO 1 END
         ELSE IF (fu > fb) THEN BEGIN
            cx := u;
            fc := fu;
            GOTO 1
         END;
         u := cx+gold*(cx-bx);
         fu := func(u)
      END ELSE IF  ((cx-u)*(u-ulim) > 0.0) THEN BEGIN
         fu := func(u);
         IF (fu < fc) THEN BEGIN
            bx := cx;
            cx := u;
            u := cx+gold*(cx-bx);
            fb := fc;
            fc := fu;
            fu := func(u)
         END
      END ELSE IF  ((u-ulim)*(ulim-cx) >= 0.0) THEN BEGIN
         u := ulim;
         fu := func(u)
      END ELSE BEGIN
         u := cx+gold*(cx-bx);
         fu := func(u)
      END;
      ax := bx;
      bx := cx;
      cx := u;
      fa := fb;
      fb := fc;
      fc := fu;
      GOTO 1
   END
END;
