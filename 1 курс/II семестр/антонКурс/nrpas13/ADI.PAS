PROCEDURE adi(a,b,c,d,e,f,g: gljmax; VAR u: gljmax;
      jmax,k: integer; alpha,beta,eps: double);
(* Programs using routine ADI must define the type
TYPE
   gljmax = ARRAY [1..jmax,1..jmax] OF double;
in the main routine. *)
LABEL 99;
CONST
   jj=50;
   kk=6;
   nrr=32;      (* nrr=2 to the power (kk-1) *)
   maxits=100;
   zero=0.0;
   two=2.0;
   half=0.5;
TYPE
   gljjarray = ARRAY [1..jj] OF double;
VAR
   i,nr,nits,next,n,l,kits,k1,j,twopwr: integer;
   rfact,resid,disc,anormg,anorm,ab: double;
   aa,bb,cc,rr,uu: gljjarray;
   psi: ARRAY [1..jj,1..jj] OF double;
   alph,bet: ARRAY [1..kk] OF double;
   r: ARRAY [1..nrr] OF double;
   s: ARRAY [1..nrr,1..kk] OF double;
PROCEDURE tridag(a,b,c,r: gljjarray; VAR u: gljjarray; n: integer);
   (* This is a double precision version of TRIDAG for use with ADI,
      which defines the constant jj and the type gljjarray.   *)
   VAR
      j: integer;
      bet: double;
      gam: gljjarray;
   BEGIN
      IF (b[1] = 0.0) THEN BEGIN
         writeln('pause 1 in TRIDAG'); readln END;
      bet := b[1];
      u[1] := r[1]/bet;
      FOR j := 2 TO n DO BEGIN
         gam[j] := c[j-1]/bet;
         bet := b[j]-a[j]*gam[j];
         IF (bet = 0.0) THEN BEGIN
            writeln('pause 2 in TRIDAG'); readln END;
         u[j] := (r[j]-a[j]*u[j-1])/bet
      END;
      FOR j := n-1 DOWNTO 1 DO u[j] := u[j]-gam[j+1]*u[j+1]
   END;
BEGIN
   IF (jmax > jj) THEN BEGIN
      writeln('Pause in routine ADI - increase jj'); readln
   END;
   IF (k > (kk-1)) THEN BEGIN
      writeln('Pause in routine ADI - increase kk'); readln
   END;
   k1 := k+1;
   nr := 1;
   FOR i := 1 TO k DO nr := 2*nr;
   alph[1] := alpha;
   bet[1] := beta;
   FOR j := 1 TO k DO BEGIN
      alph[j+1] := sqrt(alph[j]*bet[j]);
      bet[j+1] := half*(alph[j]+bet[j])
   END;
   s[1,1] := sqrt(alph[k1]*bet[k1]);
   FOR j := 1 TO k DO BEGIN
      ab := alph[k1-j]*bet[k1-j];
      twopwr := 1;
      FOR i := 1 TO (j-1) DO twopwr := 2*twopwr;
      FOR n := 1 TO twopwr DO BEGIN
         disc := sqrt(sqr(s[n,j])-ab);
         s[2*n,j+1] := s[n,j]+disc;
         s[2*n-1,j+1] := ab/s[2*n,j+1]
      END
   END;
   FOR n := 1 TO nr DO r[n] := s[n,k1];
   anormg := zero;
   FOR j := 2 TO (jmax-1) DO BEGIN
      FOR l := 2 TO (jmax-1) DO BEGIN
         anormg := anormg+abs(g[j,l]);
         psi[j,l] := -d[j,l]*u[j,l-1]
            +(r[1]-e[j,l])*u[j,l]-f[j,l]*u[j,l+1]
      END
   END;
   nits := maxits DIV nr;
   FOR kits := 1 TO nits DO BEGIN
      FOR n := 1 TO nr DO BEGIN
         IF (n = nr) THEN next := 1 ELSE next := n+1;
         rfact := r[n]+r[next];
         FOR l := 2 TO (jmax-1) DO BEGIN
            FOR j := 2 TO jmax-1 DO BEGIN
               aa[j-1] := a[j,l];
               bb[j-1] := b[j,l]+r[n];
               cc[j-1] := c[j,l];
               rr[j-1] := psi[j,l]-g[j,l]
            END;
            tridag(aa,bb,cc,rr,uu,jmax-2);
            FOR j := 2 TO (jmax-1) DO BEGIN
               psi[j,l] := -psi[j,l]
                  +two*r[n]*uu[j-1]
            END
         END;
         FOR j := 2 TO (jmax-1) DO BEGIN
            FOR l := 2 TO (jmax-1) DO BEGIN
               aa[l-1] := d[j,l];
               bb[l-1] := e[j,l]+r[n];
               cc[l-1] := f[j,l];
               rr[l-1] := psi[j,l]
            END;
            tridag(aa,bb,cc,rr,uu,jmax-2);
            FOR l := 2 TO (jmax-1) DO BEGIN
               u[j,l] := uu[l-1];
               psi[j,l] := -psi[j,l]+rfact*uu[l-1]
            END
         END
      END;
      anorm := zero;
      FOR j := 2 TO (jmax-1) DO BEGIN
         FOR l := 2 TO (jmax-1) DO BEGIN
            resid := a[j,l]*u[j-1,l]+(b[j,l]+e[j,l])*u[j,l]
               +c[j,l]*u[j+1,l]+d[j,l]*u[j,l-1]
               +f[j,l]*u[j,l+1]+g[j,l];
            anorm := anorm+abs(resid)
         END
      END;
      IF (anorm < (eps*anormg)) THEN GOTO 99
   END;
   writeln('Pause in routine ADI - too many iterations');
99:   END;
