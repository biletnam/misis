PROCEDURE correl(data1,data2: glnarray; n: integer; VAR ans: gl2narray);
(* Programs using routine CORREL must define the type
TYPE
   glnarray = ARRAY [1..n] OF real;
   gl2narray = ARRAY [1..2*n] OF real;
in the main routine. *)
VAR
   no2,i,ii: integer;
   dum: real;
   fft: gl2narray;
BEGIN
   twofft(data1,data2,fft,ans,n);
   no2 := n DIV 2;
   FOR i := 1 TO (no2+1) DO BEGIN
      ii := 2*i;
      dum := ans[ii-1];
      ans[ii-1] := (fft[ii-1]*ans[ii-1]+fft[ii]*ans[ii])/no2;
      ans[ii] := (fft[ii]*dum-fft[ii-1]*ans[ii])/no2
   END;
   ans[2] := ans[n+1];
   realft(ans,no2,-1)
END;
