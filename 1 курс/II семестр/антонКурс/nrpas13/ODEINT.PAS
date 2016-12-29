PROCEDURE odeint(VAR ystart: glnarray; nvar: integer;
       x1,x2,eps,h1,hmin: real; VAR nok,nbad: integer);
(* Programs using routine ODEINT must provide a
PROCEDURE derivs(x:real; y:glnarray; VAR dydx:glnarray);
which returns the derivatives dydx at location x, given both x
and the function values y. They must also define the type
TYPE
   glnarray = ARRAY [1..nvar] OF real;
and must declare the following parameters
VAR
   kmax,kount: integer;
   dxsav: real;
   xp: ARRAY [1..200] OF real;
   yp: ARRAY [1..10,1..200] OF real;
and must initialize kmax and dxsav in the main routine. *)
LABEL 99;
CONST
   maxstp=10000;
   two=2.0;
   zero=0.0;
   tiny=1.0e-30;
VAR
   nstp,i: integer;
   xsav,x,hnext,hdid,h: real;
   yscal,y,dydx: glnarray;
BEGIN
   x := x1;
   IF (x2 > x1) THEN h := abs(h1) ELSE h := -abs(h1);
   nok := 0;
   nbad := 0;
   kount := 0;
   FOR i := 1 TO nvar DO BEGIN
      y[i] := ystart[i]
   END;
   IF (kmax > 0) THEN xsav := x-dxsav*two;
   FOR nstp := 1 TO maxstp DO BEGIN
      derivs(x,y,dydx);
      FOR i := 1 TO nvar DO BEGIN
         yscal[i] := abs(y[i])+abs(dydx[i]*h)+tiny
      END;
      IF (kmax > 0) THEN BEGIN
         IF (abs(x-xsav) > abs(dxsav)) THEN BEGIN
            IF (kount < kmax-1) THEN BEGIN
               kount := kount+1;
               xp[kount] := x;
               FOR i := 1 TO nvar DO BEGIN
                  yp[i,kount] := y[i]
               END;
               xsav := x
            END
         END
      END;
      IF (((x+h-x2)*(x+h-x1)) > zero) THEN h := x2-x;
      rkqc(y,dydx,nvar,x,h,eps,yscal,hdid,hnext);
      IF (hdid = h) THEN BEGIN
         nok := nok+1
      END ELSE BEGIN
         nbad := nbad+1
      END;
      IF (((x-x2)*(x2-x1)) >= zero) THEN BEGIN
         FOR i := 1 TO nvar DO BEGIN
            ystart[i] := y[i]
         END;
         IF (kmax <> 0) THEN BEGIN
            kount := kount+1;
            xp[kount] := x;
            FOR i := 1 TO nvar DO BEGIN
               yp[i,kount] := y[i]
            END
         END;
         GOTO 99
      END;
      IF (abs(hnext) < hmin) THEN BEGIN
         writeln('pause in routine ODEINT');
         writeln('stepsize too small'); readln
      END;
      h := hnext;
   END;
   writeln('pause in routine ODEINT - too many steps'); readln;
99:   END;
