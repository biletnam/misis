FUNCTION rtsafe(x1,x2,xacc: real): real;
(* Programs using routine RTSAFE must externally define procedure
funcd(x,f,df:real) which returns the function value f and its
derivative df at the point x. *)
LABEL 99;
CONST
   maxit=100;
VAR
   df,dx,dxold,f,fh,fl: real;
   swap,temp,xh,xl,rts: real;
   j: integer;
BEGIN
   funcd(x1,fl,df);
   funcd(x2,fh,df);
   IF (fl*fh >= 0.0) THEN BEGIN
      writeln('pause in routine RTSAFE');
      writeln('root must be bracketed'); readln
   END;
   IF (fl < 0.0) THEN BEGIN
      xl := x1;
      xh := x2
   END ELSE BEGIN
      xh := x1;
      xl := x2;
      swap := fl;
      fl := fh;
      fh := swap
   END;
   rts := 0.5*(x1+x2);
   dxold := abs(x2-x1);
   dx := dxold;
   funcd(rts,f,df);
   FOR j := 1 TO maxit DO BEGIN
      IF((((rts-xh)*df-f)*((rts-xl)*df-f) >= 0.0)
      OR (abs(2.0*f) > abs(dxold*df))) THEN BEGIN
         dxold := dx;
         dx := 0.5*(xh-xl);
         rts := xl+dx;
         IF (xl = rts) THEN GOTO 99 END
      ELSE BEGIN
         dxold := dx;
         dx := f/df;
         temp := rts;
         rts := rts-dx;
         IF (temp = rts) THEN GOTO 99
      END;
      IF (abs(dx) < xacc) THEN GOTO 99;
      funcd(rts,f,df);
      IF (f < 0.0)  THEN BEGIN
         xl := rts;
         fl := f
      END ELSE BEGIN
         xh := rts;
         fh := f
      END
   END;
   writeln('pause in RTSAFE');
   writeln('maximum number of iterations exceeded'); readln;
99:   rtsafe := rts
END;
