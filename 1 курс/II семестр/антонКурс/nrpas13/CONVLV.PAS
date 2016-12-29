PROCEDURE convlv(data: glnarray; n: integer; respns: glnarray; m: integer;
       isign: integer; VAR ans: gln2array);
(* Programs using routine CONVLV must define the types
TYPE
   glnarray = ARRAY [1..n] OF real;
   gln2array = ARRAY [1..n2] OF real;
where n is the dimension of the data and n2=2*n. NOTE: when used with CONVLV,
the data dimension in FOUR1 and in TWOFFT must be the same as gln2array here.
i.e. TYPE  gldarray = gln2array; gl2narray = gln2array *)
VAR
   no2,i,ii: integer;
   dum,mag2: real;
   fft: gln2array;
BEGIN
   FOR i := 1 TO ((m-1) DIV 2) DO BEGIN
      respns[n+1-i] := respns[m+1-i]
   END;
   FOR i := ((m+3) DIV 2) TO (n-((m-1) DIV 2)) DO BEGIN
      respns[i] := 0.0
   END;
   twofft(data,respns,fft,ans,n);
   no2 := n DIV 2;
   FOR i := 1 TO (no2+1) DO BEGIN
      ii := 2*i;
      IF (isign = 1) THEN BEGIN
         dum := ans[ii-1];
         ans[ii-1] := (fft[ii-1]*ans[ii-1]-fft[ii]*ans[ii])/no2;
         ans[ii] := (fft[ii]*dum+fft[ii-1]*ans[ii])/no2
      END ELSE IF (isign = -1) THEN BEGIN
         IF ((sqr(ans[ii-1])+sqr(ans[ii])) = 0.0) THEN BEGIN
            writeln('pause in routine CONVLV');
            writeln('deconvolving at response zero'); readln
         END;
         dum := ans[ii-1];
         mag2 := sqr(ans[ii-1])+sqr(ans[ii]);
         ans[ii-1] := (fft[ii-1]*ans[ii-1]+fft[ii]*ans[ii])/mag2/no2;
         ans[ii] := (fft[ii]*dum-fft[ii-1]*ans[ii])/mag2/no2
      END ELSE BEGIN
         writeln('pause in routine CONVLV');
         writeln('no meaning for ISIGN'); readln
      END
   END;
   ans[2] := ans[n+1];
   realft(ans,no2,-1)
END;
