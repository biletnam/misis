PROCEDURE solvde(itmax: integer; conv,slowc: real; scalv: glscalv;
       indexv: glindex; ne,nb,m: integer; VAR y: glyarray;
       nyj,nyk: integer; VAR c: glcarray; nci,ncj,nck: integer;
       VAR s: glsarray; nsi,nsj: integer);
(* Programs using routine SOLVDE must define the types
TYPE
   glindex = ARRAY [1..nyj] OF integer;
   glscalv = ARRAY [1..nyj] OF real;
   glyarray = ARRAY [1..nyj,1..nyk] OF real;
   glcarray = ARRAY [1..nci,1..ncj,1..nck] OF real;
   glsarray = ARRAY [1..nsi,1..nsj] OF real;
in the main routine. *)
LABEL 99;
CONST
   nmax=10;
VAR
   err,errj,fac,vmax,vz: real;
   ic1,ic2,ic3,ic4,it: integer;
   j,j1,j2,j3,j4,j5,j6,j7,j8,j9: integer;
   jc1,jcf,jv,k,k1,k2,km,kp,nvars: integer;
   ermax: ARRAY [1..nmax] OF real;
   kmax: ARRAY [1..nmax] OF integer;
BEGIN
   k1 := 1;
   k2 := m;
   nvars := ne*m;
   j1 := 1;
   j2 := nb;
   j3 := nb+1;
   j4 := ne;
   j5 := j4+j1;
   j6 := j4+j2;
   j7 := j4+j3;
   j8 := j4+j4;
   j9 := j8+j1;
   ic1 := 1;
   ic2 := ne-nb;
   ic3 := ic2+1;
   ic4 := ne;
   jc1 := 1;
   jcf := ic3;
   FOR it := 1 TO itmax DO BEGIN
      k := k1;
      difeq(k,k1,k2,j9,ic3,ic4,indexv,ne,s,nsi,nsj,y,nyj,nyk);
      pinvs(ic3,ic4,j5,j9,jc1,k1,c,nci,ncj,nck,s,nsi,nsj);
      FOR k := k1+1 TO k2 DO BEGIN
         kp := k-1;
         difeq(k,k1,k2,j9,ic1,ic4,indexv,ne,s,nsi,nsj,y,nyj,nyk);
         red(ic1,ic4,j1,j2,j3,j4,j9,ic3,jc1,jcf,kp,c,nci,ncj,nck,s,nsi,nsj);
         pinvs(ic1,ic4,j3,j9,jc1,k,c,nci,ncj,nck,s,nsi,nsj)
      END;
      k := k2+1;
      difeq(k,k1,k2,j9,ic1,ic2,indexv,ne,
         s,nsi,nsj,y,nyj,nyk);
      red(ic1,ic2,j5,j6,j7,j8,j9,ic3,jc1,jcf,k2,
         c,nci,ncj,nck,s,nsi,nsj);
      pinvs(ic1,ic2,j7,j9,jcf,k2+1,
         c,nci,ncj,nck,s,nsi,nsj);
      bksub(ne,nb,jcf,k1,k2,c,nci,ncj,nck);
      err := 0.0;
      FOR j := 1 TO ne DO BEGIN
         jv := indexv[j];
         errj := 0.0;
         km := 0;
         vmax := 0.0;
         FOR k := k1 TO k2 DO BEGIN
            vz := abs(c[j,1,k]);
            IF (vz > vmax)  THEN BEGIN
                vmax := vz;
                km := k
            END;
            errj := errj+vz
         END;
         err := err+errj/scalv[jv];
         ermax[j] := c[j,1,km]/scalv[jv];
         kmax[j] := km
      END;
      err := err/nvars;
      fac := 1.0;
      IF (err > slowc) THEN fac := slowc/err;
      FOR jv := 1 TO ne DO BEGIN
         j := indexv[jv];
         FOR k := k1 TO k2 DO BEGIN
            y[j,k] := y[j,k]-fac*c[jv,1,k]
         END
      END;
      writeln;
      writeln('Iter.':8,'Error':9,'FAC':9);
      writeln(it:6,err:12:6,fac:11:6);
      writeln('Var.':8,'Kmax':8,'Max. Error':14);
      FOR j := 1 TO ne DO writeln(indexv[j]:6,
         kmax[j]:9,ermax[j]:14:6);
      IF (err < conv) THEN GOTO 99
   END;
   writeln('pause in routine SOLVDE');
   writeln('too many iterations'); readln;
99:   END;
