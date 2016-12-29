PROCEDURE red(iz1,iz2,jz1,jz2,jm1,jm2,jmf,ic1,jc1,jcf,kc: integer;
         c: glcarray; nci,ncj,nck: integer;
         VAR s: glsarray; nsi,nsj: integer);
(* Programs using routine RED must define the types
TYPE
   glcarray = ARRAY [1..nci,1..ncj,1..nck] OF real;
   glsarray = ARRAY [1..nsi,1..nsj] OF real;
in the main routine. *)
VAR
   loff,l,j,ic,i: integer;
   vx: real;
BEGIN
   loff := jc1-jm1;
   ic := ic1;
   FOR j := jz1 TO jz2 DO BEGIN
      FOR l := jm1 TO jm2 DO BEGIN
         vx := c[ic,l+loff,kc];
         FOR i := iz1 TO iz2 DO s[i,l] := s[i,l]-s[i,j]*vx
      END;
      vx := c[ic,jcf,kc];
      FOR i := iz1 TO iz2 DO s[i,jmf] := s[i,jmf]-s[i,j]*vx;
      ic := ic+1
   END
END;
