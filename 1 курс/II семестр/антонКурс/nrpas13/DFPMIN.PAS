PROCEDURE dfpmin(VAR p: glnarray; n: integer; ftol: real;
       VAR iter: integer; VAR fret: real);
(* Programs using routine DFPMIN must supply a
FUNCTION fnc(p: glnarray):real; and a
PROCEDURE dfnc(p: glnarray; VAR g: glnarray);
which evaluate a function and its gradient. They must
also define the types
TYPE
   glnarray = ARRAY [1..n] OF real;
   glnbyn = ARRAY [1..n,1..n] OF real;
in the main routine. *)
LABEL 99;
CONST
   itmax=200;
   eps=1.0e-10;
VAR
   j,i,its: integer;
   fp,fae,fad,fac: real;
   xi,g,dg: glnarray;
   hdg: glnarray;
   hessin: glnbyn;
BEGIN
   fp := fnc(p);
   dfnc(p,g);
   FOR i := 1 TO n DO BEGIN
      FOR j := 1 TO n DO BEGIN
         hessin[i,j] := 0.0
      END;
      hessin[i,i] := 1.0;
      xi[i] := -g[i]
   END;
   FOR its := 1 TO itmax DO BEGIN
      iter := its;
      linmin(p,xi,n,fret);
      IF ((2.0*abs(fret-fp)) <= (ftol*(abs(fret)+abs(fp)+eps)))
         THEN GOTO 99;
      fp := fret;
      FOR i := 1 TO n DO BEGIN
         dg[i] := g[i]
      END;
      fret := fnc(p);
      dfnc(p,g);
      FOR i := 1 TO n DO BEGIN
         dg[i] := g[i]-dg[i]
      END;
      FOR i := 1 TO n DO BEGIN
         hdg[i] := 0.0;
         FOR j := 1 TO n DO BEGIN
            hdg[i] := hdg[i]+hessin[i,j]*dg[j]
         END
      END;
      fac := 0.0;
      fae := 0.0;
      FOR i := 1 TO n DO BEGIN
         fac := fac+dg[i]*xi[i];
         fae := fae+dg[i]*hdg[i]
      END;
      fac := 1.0/fac;
      fad := 1.0/fae;
      FOR i := 1 TO n DO BEGIN
         dg[i] := fac*xi[i]-fad*hdg[i]
      END;
      FOR i := 1 TO n DO BEGIN
         FOR j := 1 TO n DO BEGIN
            hessin[i,j] := hessin[i,j]+fac*xi[i]*xi[j]
            -fad*hdg[i]*hdg[j]+fae*dg[i]*dg[j];
         END
      END;
      FOR i := 1 TO n DO BEGIN
         xi[i] := 0.0;
         FOR j := 1 TO n DO BEGIN
            xi[i] := xi[i]-hessin[i,j]*g[j]
         END
      END
   END;
   writeln('pause in routine DFPMIN');
   writeln('too many iterations'); readln;
99:   END;
