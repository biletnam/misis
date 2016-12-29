PROCEDURE spctrm(VAR p: glmarray; m,k: integer; ovrlap: boolean;
       VAR w1: gl4marray; VAR w2: glmarray);
(* Programs using routine SPCTRM must include 'dfile' as
a main routine parameter, and declare
VAR
   dfile: text;
They must open and close this file appropriately.
Also they must define data types
TYPE
   glmarray = ARRAY [1..m] OF real;
   gl4marray = ARRAY [1..4*m] OF real;
and must declare two workspace matrices w1,w2 with types as shown
in the arguments above. *)
VAR
   mm,m44,m43,m4,kk,joffn,joff,j2,j,jj: integer;
   w,sumw,facp,facm,den: real;
FUNCTION window(j: integer; facm,facp: real): real;
   BEGIN
      window := (1.0-abs(((j-1)-facm)*facp))      (* Parzen *)
(*      window := 1.0            *)   (* Square *)
(*      window := (1.0-sqr(((j-1)-facm)*facp))    *)   (* Welch  *)
   END;
BEGIN
   mm := m+m;
   m4 := mm+mm;
   m44 := m4+4;
   m43 := m4+3;
   den := 0.0;
   facm := m-0.5;
   facp := 1.0/(m+0.5);
   sumw := 0.0;
   FOR j := 1 TO mm DO sumw := sumw+sqr(window(j,facm,facp));
   FOR j := 1 TO m DO p[j] := 0.0;
   IF (ovrlap) THEN BEGIN
      FOR j := 1 TO m DO read(dfile,w2[j])
   END;
   FOR kk := 1 TO k DO BEGIN
      FOR joff := -1 TO 0 DO BEGIN
         IF (ovrlap) THEN BEGIN
            FOR j := 1 TO m DO w1[joff+j+j] := w2[j];
            FOR j := 1 TO m DO read(dfile,w2[j]);
            joffn := joff+mm;
            FOR j := 1 TO m DO w1[joffn+j+j] := w2[j] END
         ELSE BEGIN
            FOR jj := 0 TO ((m4-joff-2) DIV 2) DO BEGIN
               j := joff+2+2*jj;
               read(dfile,w1[j])
            END
         END
      END;
      FOR j := 1 TO mm DO BEGIN
         j2 := j+j;
         w := window(j,facm,facp);
         w1[j2] := w1[j2]*w;
         w1[j2-1] := w1[j2-1]*w
      END;
      four1(w1,mm,1);
      p[1] := p[1]+sqr(w1[1])+sqr(w1[2]);
      FOR j := 2 TO m DO BEGIN
         j2 := j+j;
         p[j] := p[j]+sqr(w1[j2])+sqr(w1[j2-1])
            +sqr(w1[m44-j2])+sqr(w1[m43-j2])
      END;
      den := den+sumw
   END;
   den := m4*den;
   FOR j := 1 TO m DO p[j] := p[j]/den
END;
