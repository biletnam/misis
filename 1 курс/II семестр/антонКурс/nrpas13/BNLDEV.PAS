FUNCTION bnldev(pp: real; n: integer; VAR idum: integer): real;
LABEL 1;
CONST
   pi=3.141592654;
VAR
   am,em,en,g,angle: real;
   oldg,p,pc,bnl: real;
   pclog,plog,pold,sq,t,y: real;
   j,nold: integer;
BEGIN
   nold := -1;
   pold := -1.0;
   IF (pp <= 0.5) THEN p := pp ELSE p := 1.0-pp;
   am := n*p;
   IF (n < 25) THEN BEGIN
      bnl := 0.0;
      FOR j := 1 TO n DO BEGIN
         IF (ran3(idum) < p) THEN bnl := bnl+1.0
      END
   END ELSE IF (am < 1.0) THEN BEGIN
      g := exp(-am);
      t := 1.0;
      FOR j := 0 TO n DO BEGIN
         t := t*ran3(idum);
         IF (t < g) THEN GOTO 1
      END;
      j := n;
1:      bnl := j
   END ELSE BEGIN
      IF (n <> nold) THEN BEGIN
         en := n;
         oldg := gammln(en+1.0);
         nold := n
      END;
      IF (p <> pold) THEN BEGIN
         pc := 1.0-p;
         plog := ln(p);
         pclog := ln(pc);
         pold := p
      END;
      sq := sqrt(2.0*am*pc);
      REPEAT
         REPEAT
            angle := pi*ran3(idum);
            y := sin(angle)/cos(angle);
            em := sq*y+am;
         UNTIL ((em >= 0.0) AND (em < en+1.0));
         em := trunc(em);
         t := 1.2*sq*(1.0+sqr(y))*exp(oldg-gammln(em+1.0)
            -gammln(en-em+1.0)+em*plog+(en-em)*pclog);
      UNTIL (ran3(idum) <= t);
      bnl := em
   END;
   IF (p <> pp) THEN bnl := n-bnl;
   bnldev := bnl
END;
