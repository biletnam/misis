FUNCTION poidev(xm: real; VAR idum: integer): real;
(* Programs using POIDEV must declare the variables
VAR
   gloldm,glsq,glalxm,glg: real;
in the main program and should intialize gloldm to
   gloldm := -1.0;   *)
CONST
   pi=3.141592654;
VAR
   em,t,y: real;
BEGIN
   IF (xm < 12.0) THEN BEGIN
      IF (xm <> gloldm) THEN BEGIN
         gloldm := xm;
         glg := exp(-xm)
      END;
      em := -1;
      t := 1.0;
      REPEAT
         em := em+1.0;
         t := t*ran3(idum);
      UNTIL (t <= glg)
   END ELSE BEGIN
      IF (xm <> gloldm) THEN BEGIN
         gloldm := xm;
         glsq := sqrt(2.0*xm);
         glalxm := ln(xm);
         glg := xm*glalxm-gammln(xm+1.0)
      END;
      REPEAT
         REPEAT
            y := pi*ran3(idum);
            y := sin(y)/cos(y);
            em := glsq*y+xm;
         UNTIL (em >= 0.0);
         em := trunc(em);
         t := 0.9*(1.0+sqr(y))*exp(em*glalxm-gammln(em+1.0)-glg);
      UNTIL (ran3(idum) <= t)
   END;
   poidev := em
END;
