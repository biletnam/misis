PROCEDURE shootf(nvar: integer; VAR v1: gln2array; VAR v2: gln1array;
       delv1: gln2array; delv2: gln1array; n1,n2: integer;
       x1,x2,xf,eps,h1,hmin: real; VAR f: glnvar;
       VAR dv1: gln2array; VAR dv2: gln1array);
(* Programs using routine SHOOTF must define the types
TYPE
   gln1array = ARRAY [1..n1] OF real;
   gln2array = ARRAY [1..n2] OF real;
   glnvar = ARRAY [1..nvar] OF real;
   glnvarbynvar = ARRAY [1..nvar,1..nvar];
   glindx = ARRAY [1..nvar] OF integer;
   glnpbynp = glnvarbynvar;
in the main routine, and set the variable kmax of ODEINT to zero. *)
VAR
   nok,nbad,j,iv,i: integer;
   sav,det: real;
   y,f1,f2: glnvar;
   dfdv: glnvarbynvar;
   indx: glindx;
BEGIN
   load1(x1,v1,y);
   odeint(y,nvar,x1,xf,eps,h1,hmin,nok,nbad);
   score(xf,y,f1);
   load2(x2,v2,y);
   odeint(y,nvar,x2,xf,eps,h1,hmin,nok,nbad);
   score(xf,y,f2);
   j := 0;
   FOR iv := 1 TO n2 DO BEGIN
      j := j+1;
      sav := v1[iv];
      v1[iv] := v1[iv]+delv1[iv];
      load1(x1,v1,y);
      odeint(y,nvar,x1,xf,eps,h1,hmin,nok,nbad);
      score(xf,y,f);
      FOR i := 1 TO nvar DO BEGIN
         dfdv[i,j] := (f[i]-f1[i])/delv1[iv]
      END;
      v1[iv] := sav
   END;
   FOR iv := 1 TO n1 DO BEGIN
      j := j+1;
      sav := v2[iv];
      v2[iv] := v2[iv]+delv2[iv];
      load2(x2,v2,y);
      odeint(y,nvar,x2,xf,eps,h1,hmin,nok,nbad);
      score(xf,y,f);
      FOR i := 1 TO nvar DO BEGIN
         dfdv[i,j] := (f2[i]-f[i])/delv2[iv]
      END;
      v2[iv] := sav
   END;
   FOR i := 1 TO nvar DO BEGIN
      f[i] := f1[i]-f2[i];
      f1[i] := -f[i]
   END;
   ludcmp(dfdv,nvar,nvar,indx,det);
   lubksb(dfdv,nvar,nvar,indx,f1);
   j := 0;
   FOR iv := 1 TO n2 DO BEGIN
      j := j+1;
      v1[iv] := v1[iv]+f1[j];
      dv1[iv] := f1[j]
   END;
   FOR iv := 1 TO n1 DO BEGIN
      j := j+1;
      v2[iv] := v2[iv]+f1[j];
      dv2[iv] := f1[j]
   END
END;
