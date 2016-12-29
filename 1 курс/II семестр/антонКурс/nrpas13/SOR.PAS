PROCEDURE sor(a,b,c,d,e,f: gljmax; VAR u: gljmax;
         jmax: integer; rjac: double);
(* Programs using routine SOR must define the type
TYPE
   gljmax = ARRAY [1..jmax,1..jmax] OF double;
in the main routine. *)
LABEL 99;
CONST
   maxits=1000;
   eps=1.0e-5;
   zero=0.0;
   half=0.5;
   qtr=0.25;
   one=1.0;
VAR
   n,l,j: integer;
   resid,omega,anormf,anorm: double;
BEGIN
   anormf := zero;
   FOR j := 2 TO jmax-1 DO BEGIN
      FOR l := 2 TO jmax-1 DO BEGIN
         anormf := anormf+abs(f[j,l])
      END
   END;
   omega := one;
   FOR n := 1 TO maxits DO BEGIN
      anorm := zero;
      FOR j := 2 TO (jmax-1) DO BEGIN
         FOR l := 2 TO (jmax-1) DO BEGIN
            IF (((j+l) MOD 2) = (n MOD 2)) THEN BEGIN
               resid := a[j,l]*u[j+1,l]+b[j,l]*u[j-1,l]
                  +c[j,l]*u[j,l+1]+d[j,l]*u[j,l-1]
                  +e[j,l]*u[j,l]-f[j,l];
               anorm := anorm+abs(resid);
               u[j,l] := u[j,l]-omega*resid/e[j,l]
            END
         END
      END;
      IF (n = 1) THEN BEGIN
         omega := one/(one-half*sqr(rjac))
      END ELSE BEGIN
         omega := one/(one-qtr*sqr(rjac)*omega)
      END;
      IF ((n > 1) AND (anorm < (eps*anormf))) THEN GOTO 99
   END;
   writeln('pause in routine SOR');
   writeln('too many iterations'); readln;
99:   END;
