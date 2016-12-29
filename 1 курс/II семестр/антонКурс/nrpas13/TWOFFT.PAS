PROCEDURE twofft(data1,data2: glnarray;
       VAR fft1,fft2: gl2narray; n: integer);
(* Programs using routine TWOFFT must define types
TYPE
   glnarray = ARRAY [1..n] OF real;
   gl2narray = ARRAY [1..2*n] OF real;
where n is the dimension of the real-valued data arrays. *)
VAR
   nn3,nn2,nn,jj,j: integer;
   rep,rem,aip,aim: real;
BEGIN
   nn := n+n;
   nn2 := nn+2;
   nn3 := nn+3;
   FOR j := 1 TO n DO BEGIN
      jj := j+j;
      fft1[jj-1] := data1[j];
      fft1[jj] := data2[j]
   END;
   four1(fft1,n,1);
   fft2[1] := fft1[2];
   fft1[2] := 0.0;
   fft2[2] := 0.0;
   FOR jj := 1 TO (n DIV 2) DO BEGIN
      j := 2*jj+1;
      rep := 0.5*(fft1[j]+fft1[nn2-j]);
      rem := 0.5*(fft1[j]-fft1[nn2-j]);
      aip := 0.5*(fft1[j+1]+fft1[nn3-j]);
      aim := 0.5*(fft1[j+1]-fft1[nn3-j]);
      fft1[j] := rep;
      fft1[j+1] := aim;
      fft1[nn2-j] := rep;
      fft1[nn3-j] := -aim;
      fft2[j] := aip;
      fft2[j+1] := -rem;
      fft2[nn2-j] := aip;
      fft2[nn3-j] := rem
   END
END;
