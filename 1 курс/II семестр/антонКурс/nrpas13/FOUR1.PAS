PROCEDURE four1(VAR data: gldarray; nn,isign: integer);
(* Programs using routine FOUR1 must define type
TYPE
   gldarray = ARRAY [1..nn2] OF real;
in the calling routine, where nn2=nn+nn. *)
VAR
   ii,jj,n,mmax,m,j,istep,i: integer;
   wtemp,wr,wpr,wpi,wi,theta: double;
   tempr,tempi: real;
BEGIN
   n := 2*nn;
   j := 1;
   FOR ii := 1 TO nn DO BEGIN
      i := 2*ii-1;
      IF (j > i) THEN BEGIN
         tempr := data[j];
         tempi := data[j+1];
         data[j] := data[i];
         data[j+1] := data[i+1];
         data[i] := tempr;
         data[i+1] := tempi
      END;
      m := n DIV 2;
      WHILE ((m >= 2) AND (j > m))  DO BEGIN
         j := j-m;
         m := m DIV 2
      END;
      j := j+m
   END;
   mmax := 2;
   WHILE (n > mmax) DO BEGIN
      istep := 2*mmax;
      theta := 6.28318530717959/(isign*mmax);
      wpr := -2.0*sqr(sin(0.5*theta));
      wpi := sin(theta);
      wr := 1.0;
      wi := 0.0;
      FOR ii := 1 TO (mmax DIV 2) DO BEGIN
         m := 2*ii-1;
         FOR jj := 0 TO ((n-m) DIV istep) DO BEGIN
            i := m + jj*istep;
            j := i+mmax;
            tempr := sngl(wr)*data[j]-sngl(wi)*data[j+1];
            tempi := sngl(wr)*data[j+1]+sngl(wi)*data[j];
            data[j] := data[i]-tempr;
            data[j+1] := data[i+1]-tempi;
            data[i] := data[i]+tempr;
            data[i+1] := data[i+1]+tempi
         END;
         wtemp := wr;
         wr := wr*wpr-wi*wpi+wr;
         wi := wi*wpr+wtemp*wpi+wi
      END;
      mmax := istep
   END
END;
