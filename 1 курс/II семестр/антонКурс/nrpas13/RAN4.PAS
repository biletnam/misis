FUNCTION ran4(VAR idum: integer): real;
(* Programs using routine RAN4 must define the global variables
TYPE
   gl64array = ARRAY [1..64] OF integer;
   gl65reals = ARRAY [1..65] OF real;
VAR
   glnewkey: integer;
   glinp,glkey: gl64array;
   glpow: gl65reals;
in the main routine. The initialization block, IF (idum < 0), has been
written in real arithmetic to avoid overflow on machines with 2-byte
integers. With 4-byte integers, this block can be simplified with MOD
and DIV. *)
CONST
   im=11979;
   rm=11979.0;
   a=430.0;
   c=2531.0;
   nacc=24;
VAR
   isav,j: integer;
   jot: gl64array;
   r4,dum: real;
BEGIN
   IF (idum < 0) THEN BEGIN
      dum := idum MOD im;
      IF (dum < 0.0) THEN dum := dum+rm;
      glpow[1] := 0.5;
      FOR j := 1 TO 64 DO BEGIN
         dum := dum*a+c;
         dum := dum-rm*trunc(dum/rm);
         glkey[j] := trunc(2.0*dum/rm);
         glinp[j] := trunc(4.0*dum/rm) MOD 2;
         glpow[j+1] := 0.5*glpow[j]
      END;
      idum := round(dum);
      glnewkey := 1
   END;
   isav := glinp[64];
   IF (isav <> 0) THEN BEGIN
      glinp[4] := 1-glinp[4];
      glinp[3] := 1-glinp[3];
      glinp[1] := 1-glinp[1]
   END;
   FOR j := 64 DOWNTO 2 DO BEGIN
      glinp[j] := glinp[j-1]
   END;
   glinp[1] := isav;
   des(glinp,glkey,glnewkey,0,jot);
   r4 := 0;
   FOR j := 1 TO nacc DO BEGIN
      IF (jot[j] <> 0) THEN r4 := r4+glpow[j]
   END;
   ran4 := r4
END;
