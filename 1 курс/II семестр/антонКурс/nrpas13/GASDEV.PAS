FUNCTION gasdev(VAR idum: integer): real;
(* Programs using GASDEV must declare the variables
VAR
   gliset: integer;
   glgset: real;
in the main routine and must intialize gliset to
   gliset := 0;   *)
VAR
   fac,r,v1,v2: real;
BEGIN
   IF  (gliset = 0)  THEN BEGIN
      REPEAT
         v1 := 2.0*ran3(idum)-1.0;
         v2 := 2.0*ran3(idum)-1.0;
         r := sqr(v1)+sqr(v2);
      UNTIL (r < 1.0);
      fac := sqrt(-2.0*ln(r)/r);
      glgset := v1*fac;
      gasdev := v2*fac;
      gliset := 1
   END ELSE BEGIN
      gasdev := glgset;
      gliset := 0
   END
END;
