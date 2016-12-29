PROCEDURE pinvs(ie1,ie2,je1,jsf,jc1,k: integer; VAR c: glcarray;
      nci,ncj,nck: integer; VAR s: glsarray; nsi,nsj: integer);
(* Programs using routine PINVS must define the types
TYPE
   glcarray = ARRAY [1..nci,1..ncj,1..nck] OF real;
   glsarray = ARRAY [1..nsi,1..nsj] OF real;
in the main routine. *)
CONST
   zero=0.0;
   one=1.0;
   nmax=10;
VAR
   js1,jpiv,jp,je2,jcoff,j,irow,ipiv,id,icoff,i: integer;
   pivinv,piv,dum,big: real;
   pscl: ARRAY [1..nmax] OF real;
   indxr: ARRAY [1..nmax] OF integer;
BEGIN
   je2 := je1+ie2-ie1;
   js1 := je2+1;
   FOR i := ie1 TO ie2 DO BEGIN
      big := zero;
      FOR j := je1 TO je2 DO IF (abs(s[i,j]) > big) THEN  big := abs(s[i,j]);
      IF (big = zero) THEN BEGIN
         writeln('pause in routine PINVS');
         writeln('singular matrix - row all 0'); readln
      END;
      pscl[i] := one/big;
      indxr[i] := 0
   END;
   FOR id := ie1 TO ie2 DO BEGIN
      piv := zero;
      FOR i := ie1 TO ie2 DO BEGIN
         IF (indxr[i] = 0)  THEN BEGIN
            big := zero;
            FOR j := je1 TO je2 DO BEGIN
               IF (abs(s[i,j]) > big)  THEN BEGIN
                  jp := j;
                  big := abs(s[i,j])
               END
            END;
            IF (big*pscl[i] > piv)  THEN BEGIN
               ipiv := i;
               jpiv := jp;
               piv := big*pscl[i]
            END
         END
      END;
      IF (s[ipiv,jpiv] = zero) THEN BEGIN
         writeln('pause in routine PINVS');
         writeln('singular matrix'); readln
      END;
      indxr[ipiv] := jpiv;
      pivinv := one/s[ipiv,jpiv];
      FOR j := je1 TO jsf DO s[ipiv,j] := s[ipiv,j]*pivinv;
      s[ipiv,jpiv] := one;
      FOR i := ie1 TO ie2 DO BEGIN
         IF (indxr[i] <> jpiv)  THEN BEGIN
            IF (s[i,jpiv] <> zero)  THEN BEGIN
               dum := s[i,jpiv];
               FOR j := je1 TO jsf DO s[i,j] := s[i,j]-dum*s[ipiv,j];
               s[i,jpiv] := zero
            END
         END
      END
   END;
   jcoff := jc1-js1;
   icoff := ie1-je1;
   FOR i := ie1 TO ie2 DO BEGIN
      irow := indxr[i]+icoff;
      FOR j := js1 TO jsf DO c[irow,j+jcoff,k] := s[i,j]
   END
END;
