PROCEDURE shoot(nvar: integer; VAR v: gln2array; delv: gln2array;
      n2: integer; x1,x2,eps,h1,hmin: real; VAR f,dv: glnvar);
(* Programs using routine SHOOT must define the types
TYPE
   gln2array = ARRAY [1..n2] OF real;
   glnvar = ARRAY [1..nvar] OF real;
   gln2byn2 = ARRAY [1..n2,1..n2] OF real;
   glinvar = ARRAY [1..nvar] OF integer;
   glnpbynp = gln2byn2;
in the main routine, and set the variable kmax of ODEINT to zero. *)
VAR
   nok,nbad,iv,i: integer;
   sav,det: real;
   y: glnvar;
   dfdv: gln2byn2;
   indx: glinvar;
BEGIN
   load(x1,v,y);
   odeint(y,nvar,x1,x2,eps,h1,hmin,nok,nbad);
   score(x2,y,f);
   FOR iv := 1 TO n2 DO BEGIN
      sav := v[iv];
      v[iv] := v[iv]+delv[iv];
      load(x1,v,y);
      odeint(y,nvar,x1,x2,eps,h1,hmin,nok,nbad);
      score(x2,y,dv);
      FOR i := 1 TO n2 DO BEGIN
         dfdv[i,iv] := (dv[i]-f[i])/delv[iv]
      END;
      v[iv] := sav
   END;
   FOR iv := 1 TO n2 DO BEGIN
      dv[iv] := -f[iv]
   END;
   ludcmp(dfdv,n2,nvar,indx,det);
   lubksb(dfdv,n2,nvar,indx,dv);
   FOR iv := 1 TO n2 DO BEGIN
      v[iv] := v[iv] + dv[iv]
   END
END;
