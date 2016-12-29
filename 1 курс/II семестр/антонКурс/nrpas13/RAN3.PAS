FUNCTION ran3(VAR idum: integer): real;
(* Programs using RAN3 must declare the following variables
VAR
   glinext,glinextp: integer;
   glma: ARRAY [1..55] OF real;
in the main routine. Machines with 4-byte integers can use the integer
implementation of this routine, substituting glma of type integer, the
commented CONST and VAR declarations, and the MOD function in the third
line after the BEGIN. *)
(* CONST
   mbig=1000000000;
   mseed=161803398;
   mz=0;
   fac=1.0e-9;
VAR
   i,ii,k,mj,mk: integer; *)
CONST
   mbig=4.0e6;
   mseed=1618033.0;
   mz=0.0;
   fac=2.5e-7; (* 1/mbig *)
VAR
   i,ii,k: integer;
   mj,mk: real;
BEGIN
   IF (idum < 0) THEN BEGIN
      mj := mseed+idum;
      (* The following IF block is mj := mj MOD mbig; for real variables. *)
      IF mj>=0.0 THEN mj := mj-mbig*trunc(mj/mbig)
         ELSE mj := mbig-abs(mj)+mbig*trunc(abs(mj)/mbig);
      glma[55] := mj;
      mk := 1;
      FOR i := 1 TO 54 DO BEGIN
         ii := 21*i MOD 55;
         glma[ii] := mk;
         mk := mj-mk;
         IF (mk < mz) THEN mk := mk+mbig;
         mj := glma[ii]
      END;
      FOR k := 1 TO 4 DO BEGIN
         FOR i := 1 TO 55 DO BEGIN
            glma[i] := glma[i]-glma[1+((i+30) MOD 55)];
            IF (glma[i] < mz) THEN glma[i] := glma[i]+mbig
         END
      END;
      glinext := 0;
      glinextp := 31;
      idum := 1
   END;
   glinext := glinext+1;
   IF (glinext = 56) THEN glinext := 1;
   glinextp := glinextp+1;
   IF (glinextp = 56) THEN glinextp := 1;
   mj := glma[glinext]-glma[glinextp];
   IF (mj < mz) THEN mj := mj+mbig;
   glma[glinext] := mj;
   ran3 := mj*fac
END;
