PROCEDURE poldiv(u: glnarray; n: integer; v: glnvarray; nv: integer;
       VAR q,r: glnarray);
(* Programs using routine POLDIV must define the types
TYPE
   glnarray = ARRAY [1..n] OF real;
   glnvarray = ARRAY [1..nv] OF real;
in the main routine. *)
VAR
   k,j: integer;
BEGIN
   FOR j := 1 TO n DO BEGIN
      r[j] := u[j];
      q[j] := 0.0
   END;
   FOR k := n-nv DOWNTO 0 DO BEGIN
      q[k+1] := r[nv+k]/v[nv];
      FOR j := nv+k-1 DOWNTO k+1 DO BEGIN
         r[j] := r[j]-q[k+1]*v[j-k]
      END
   END;
   r[nv] := 0.0
END;
