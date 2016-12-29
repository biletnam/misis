PROCEDURE sncndn(uu,emmc: real; VAR sn,cn,dn: real);
LABEL 1;
CONST
   ca=0.0003;
VAR
   a,b,c,d,emc,u: real;
   i,ii,l: integer;
   bo: boolean;
   em,en: ARRAY [1..13] OF real;
FUNCTION cosh(u: real): real;
   BEGIN cosh := 0.5*(exp(u)+exp(-u)) END;
FUNCTION tanh(u: real): real;
   VAR
      u2,epu,emu: real;
   BEGIN
      epu := exp(u);
      emu := 1.0/epu;
      IF (abs(u)<0.3) THEN BEGIN
         u2 := u*u;
         tanh := 2*u*(1+u2/6*(1+u2/20*(1+u2/42*(1+u2/72))))/(epu+emu) END
      ELSE BEGIN tanh := (epu-emu)/(epu+emu) END
   END;
BEGIN
   emc := emmc;
   u := uu;
   IF (emc <> 0.0) THEN BEGIN
      bo := (emc < 0.0);
      IF (bo) THEN BEGIN
         d := 1.0-emc;
         emc := -emc/d;
         d := sqrt(d);
         u := d*u
      END;
      a := 1.0;
      dn := 1.0;
      FOR i := 1 TO 13 DO BEGIN
         l := i;
         em[i] := a;
         emc := sqrt(emc);
         en[i] := emc;
         c := 0.5*(a+emc);
         IF (abs(a-emc) <= ca*a) THEN GOTO 1;
         emc := a*emc;
         a := c
      END;
1:      u := c*u;
      sn := sin(u);
      cn := cos(u);
      IF (sn <> 0.0) THEN BEGIN
         a := cn/sn;
         c := a*c;
         FOR ii := l DOWNTO 1 DO BEGIN
            b := em[ii];
            a := c*a;
            c := dn*c;
            dn := (en[ii]+a)/(b+a);
            a := c/b
         END;
         a := 1.0/sqrt(sqr(c)+1.0);
         IF (sn < 0.0) THEN sn := -a
         ELSE sn := a;
         cn := c*sn
      END;
      IF (bo) THEN BEGIN
         a := dn;
         dn := cn;
         cn := a;
         sn := sn/d
      END;
   END ELSE BEGIN
      cn := 1.0/cosh(u);
      dn := cn;
      sn := tanh(u)
   END
END;
