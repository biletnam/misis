PROCEDURE rkqc(VAR y,dydx: glarray; n: integer; VAR x: real;
      htry,eps: real; yscal: glarray; VAR hdid,hnext: real);
(* Programs using routine RKQC must provide a
PROCEDURE derivs(x:real; y:glnarray; VAR dydx:glnarray);
which returns the derivatives dydx at location x, given both x and the
function values y. They must also define the type
TYPE
   glarray = ARRAY [1..n] OF real;
in the main routine.   *)
LABEL 1;
CONST
   pgrow=-0.20;
   pshrnk=-0.25;
   fcor=0.06666666;   (* 1.0/15.0 *)
   one=1.0;
   safety=0.9;
   errcon=6.0e-4;
VAR
   i: integer;
   xsav,hh,h,temp,errmax: real;
   dysav,ysav,ytemp: glarray;
BEGIN
   xsav := x;
   FOR i := 1 TO n DO BEGIN
      ysav[i] := y[i];
      dysav[i] := dydx[i]
   END;
   h := htry;
1:   hh := 0.5*h;
   rk4(ysav,dysav,n,xsav,hh,ytemp);
   x := xsav+hh;
   derivs(x,ytemp,dydx);
   rk4(ytemp,dydx,n,x,hh,y);
   x := xsav+h;
   IF (x = xsav) THEN BEGIN
      writeln('pause in routine RKQC');
      writeln('stepsize too small'); readln
   END;
   rk4(ysav,dysav,n,xsav,h,ytemp);
   errmax := 0.0;
   FOR i := 1 TO n DO BEGIN
      ytemp[i] := y[i]-ytemp[i];
      temp := abs(ytemp[i]/yscal[i]);
      IF (errmax < temp) THEN errmax := temp
   END;
   errmax := errmax/eps;
   IF (errmax > one) THEN BEGIN
      h := safety*h*exp(pshrnk*ln(errmax));
      GOTO 1 END
   ELSE BEGIN
      hdid := h;
      IF (errmax > errcon) THEN BEGIN
         hnext := safety*h*exp(pgrow*ln(errmax))
      END ELSE BEGIN
         hnext := 4.0*h
      END
   END;
   FOR i := 1 TO n DO BEGIN
      y[i] := y[i]+ytemp[i]*fcor
   END
END;
