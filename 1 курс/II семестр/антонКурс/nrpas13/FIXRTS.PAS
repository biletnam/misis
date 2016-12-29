PROCEDURE fixrts(VAR d: glnparray; npoles: integer);
(* Programs using routine FIXRTS must define the type
TYPE
   glnparray = ARRAY [1..npoles] OF real;
   glcarray = ARRAY [1..2*npoles+2] OF real;
in the main routine. *)
VAR
   j,i: integer;
   size,dum: real;
   polish: boolean;
   a,roots: glcarray;
BEGIN
   a[2*npoles+1] := 1.0;
   a[2*npoles+2] := 0.0;
   FOR j := npoles DOWNTO 1 DO BEGIN
      a[2*j-1] := -d[npoles+1-j];
      a[2*j] := 0.0
   END;
   polish := true;
   zroots(a,npoles,roots,polish);
   FOR j := 1 TO npoles DO BEGIN
      size := sqr(roots[2*j-1])+sqr(roots[2*j]);
      IF (size > 1.0) THEN BEGIN
         roots[2*j-1] := roots[2*j-1]/size;
         roots[2*j] := roots[2*j]/size
      END
   END;
   a[1] := -roots[1];
   a[2] := -roots[2];
   a[3] := 1.0;
   a[4] := 0.0;
   FOR j := 2 TO npoles DO BEGIN
      a[2*j+1] := 1.0;
      a[2*j+2] := 0.0;
      FOR i := j DOWNTO 2 DO BEGIN
         dum := a[2*i-1];
         a[2*i-1] := a[2*i-3]-a[2*i-1]*roots[2*j-1]
               +a[2*i]*roots[2*j];
         a[2*i] := a[2*i-2]-dum*roots[2*j]
               -a[2*i]*roots[2*j-1]
      END;
      dum := a[1];
      a[1] := -a[1]*roots[2*j-1]+a[2]*roots[2*j];
      a[2] := -dum*roots[2*j]-a[2]*roots[2*j-1]
   END;
   FOR j := 1 TO npoles DO BEGIN
      d[npoles+1-j] := -a[2*j-1]
   END
END;
