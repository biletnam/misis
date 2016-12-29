PROCEDURE simplx(VAR a: glmpbynp; m,n,mp,np,m1,m2,m3: integer;
       VAR icase: integer; VAR izrov: glnarray;
       VAR iposv: glmarray);
(* Programs using routine SIMPLX must define the types
TYPE
   glmpbynp = ARRAY [1..mp,1..np] OF real;
   glnarray = ARRAY [1..n] OF integer;
   glmarray = ARRAY [1..m] OF integer;
   glmparray = ARRAY [1..mp] OF integer;
   glnparray = ARRAY [1..np] OF integer;
in the main routine. *)
LABEL 1,2,10,20,30,99;
CONST eps=1.0e-6;
VAR
   nl2,nl1,m12,kp,kh,k,is,ir,ip,i: integer;
   q1,bmax: real;
   l1: glnparray;
   l2,l3: glmparray;
BEGIN
   IF (m <> (m1+m2+m3)) THEN BEGIN
      writeln('pause in routine SIMPLX');
      writeln('bad input constraint counts'); readln
   END;
   nl1 := n;
   FOR k := 1 TO n DO BEGIN
      l1[k] := k;
      izrov[k] := k
   END;
   nl2 := m;
   FOR i := 1 TO m DO BEGIN
      IF (a[i+1,1] < 0.0) THEN BEGIN
         writeln('pause in routine SIMPLX');
         writeln('bad input tableau'); readln
      END;
      l2[i] := i;
      iposv[i] := n+i
   END;
   FOR i := 1 TO m2 DO BEGIN
      l3[i] := 1
   END;
   ir := 0;
   IF ((m2+m3) = 0) THEN GOTO 30;
   ir := 1;
   FOR k := 1 TO n+1 DO BEGIN
      q1 := 0.0;
      FOR i := m1+1 TO m DO BEGIN
         q1 := q1+a[i+1,k]
      END;
      a[m+2,k] := -q1
   END;
10:   simp1(a,mp,np,m+1,l1,nl1,0,kp,bmax);
   IF ((bmax <= eps) AND (a[m+2,1] < -eps)) THEN BEGIN
      icase := -1; GOTO 99 END
   ELSE IF ((bmax <= eps) AND (a[m+2,1] <= eps)) THEN BEGIN
      m12 := m1+m2+1;
      IF (m12 <= m) THEN BEGIN
         FOR ip := m12 TO m DO BEGIN
            IF (iposv[ip] = (ip+n)) THEN BEGIN
               simp1(a,mp,np,ip,l1,nl1,1,kp,bmax);
               IF (bmax > 0.0) THEN GOTO 1
            END
         END
      END;
      ir := 0;
      m12 := m12-1;
      IF ((m1+1) > m12) THEN GOTO 30;
      FOR i := m1+1 TO m12 DO BEGIN
         IF (l3[i-m1] = 1) THEN BEGIN
            FOR k := 1 TO n+1 DO BEGIN
               a[i+1,k] := -a[i+1,k]
            END
         END
      END;
      GOTO 30
   END;
   simp2(a,m,n,mp,np,l2,nl2,ip,kp,q1);
   IF (ip = 0) THEN BEGIN
      icase := -1; GOTO 99
   END;
1:   simp3(a,mp,np,m+1,n,ip,kp);
   IF (iposv[ip] >= (n+m1+m2+1)) THEN BEGIN
      FOR k := 1 TO nl1 DO BEGIN
         IF (l1[k] = kp) THEN GOTO 2
      END;
2:      nl1 := nl1-1;
      FOR is := k TO nl1 DO BEGIN
         l1[is] := l1[is+1]
      END
   END ELSE BEGIN
      IF (iposv[ip] < (n+m1+1)) THEN GOTO 20;
      kh := iposv[ip]-m1-n;
      IF (l3[kh] = 0) THEN GOTO 20;
      l3[kh] := 0
   END;
   a[m+2,kp+1] := a[m+2,kp+1]+1.0;
   FOR i := 1 TO m+2 DO BEGIN
      a[i,kp+1] := -a[i,kp+1]
   END;
20:   is := izrov[kp];
   izrov[kp] := iposv[ip];
   iposv[ip] := is;
   IF (ir <> 0) THEN GOTO 10;
30:   simp1(a,mp,np,0,l1,nl1,0,kp,bmax);
   IF (bmax <= 0.0) THEN BEGIN
      icase := 0; GOTO 99
   END;
   simp2(a,m,n,mp,np,l2,nl2,ip,kp,q1);
   IF (ip = 0) THEN BEGIN
      icase := 1; GOTO 99
   END;
   simp3(a,mp,np,m,n,ip,kp);
   GOTO 20;
99:   END;
