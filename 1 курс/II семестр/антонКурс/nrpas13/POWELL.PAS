PROCEDURE powell(VAR p: glnarray; VAR xi: glnpbynp; n,np: integer;
       ftol: real; VAR iter: integer; VAR fret: real);
(* Programs using routine POWELL must define the types
TYPE
   glnarray = ARRAY [1..n] OF real;
   glnpbynp = ARRAY [1..np,1..np] OF real;
in the main routine. *)
LABEL 1,99;
CONST
   itmax=200;
VAR
   j,ibig,i: integer;
   t,fptt,fp,del: real;
   pt,ptt,xit: glnarray;
BEGIN
   fret := fnc(p);
   FOR j := 1 TO n DO BEGIN
      pt[j] := p[j]
   END;
   iter := 0;
1: iter := iter+1;
   fp := fret;
   ibig := 0;
   del := 0.0;
   FOR i := 1 TO n DO BEGIN
      FOR j := 1 TO n DO BEGIN
         xit[j] := xi[j,i]
      END;
      fptt := fret;
      linmin(p,xit,n,fret);
      IF (abs(fptt-fret) > del) THEN BEGIN
         del := abs(fptt-fret);
         ibig := i
      END
   END;
   IF (2.0*abs(fp-fret) <= ftol*(abs(fp)+abs(fret))) THEN GOTO 99;
   IF (iter = itmax) THEN BEGIN
      writeln('pause in routine POWELL');
      writeln('too many interations'); readln
   END;
   FOR j := 1 TO n DO BEGIN
      ptt[j] := 2.0*p[j]-pt[j];
      xit[j] := p[j]-pt[j];
      pt[j] := p[j]
   END;
   fptt := fnc(ptt);
   IF (fptt >= fp) THEN GOTO 1;
   t := 2.0*(fp-2.0*fret+fptt)*sqr(fp-fret-del)-del*sqr(fp-fptt);
   IF (t >= 0.0) THEN GOTO 1;
   linmin(p,xit,n,fret);
   FOR j := 1 TO n DO BEGIN
      xi[j,ibig] := xit[j]
   END;
   GOTO 1;
99:   END;
