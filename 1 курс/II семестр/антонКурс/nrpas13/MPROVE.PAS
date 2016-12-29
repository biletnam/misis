PROCEDURE mprove(a,alud: glnpbynp; n,np: integer; indx: glindx;
       b: glnarray; VAR x: glnarray);
(* Programs using routine MPROVE must define the types
TYPE
   glnarray = ARRAY [1..n] OF real;
   glindx = ARRAY [1..n] OF integer;
   glnpbynp = ARRAY [1..np,1..np] OF real;
in the main routine. *)
VAR
   j,i: integer;
   sdp: double;
   r: glnarray;
BEGIN
   FOR i := 1 TO n DO BEGIN
      sdp := -b[i];
      FOR j := 1 TO n DO BEGIN
         sdp := sdp+a[i,j]*x[j]
      END;
      r[i] := sngl(sdp)
   END;
   lubksb(alud,n,np,indx,r);
   FOR i := 1 TO n DO BEGIN
      x[i] := x[i]-r[i]
   END
END;
