PROCEDURE eigsrt(VAR d: glnp; VAR v: glnpnp; n: integer);
(* Programs using routine EIGSRT must define the types
TYPE
   glnp = ARRAY [1..np] OF real;
   glnpnp = ARRAY [1..np,1..np] OF real;
where np is the physical dimension of the arrays to be used (v and d) *)
VAR
   k,j,i: integer;
   p: real;
BEGIN
   FOR i := 1 TO n-1 DO BEGIN
      k := i;
      p := d[i];
      FOR j := i+1 TO n DO BEGIN
         IF (d[j] >= p) THEN BEGIN
            k := j;
            p := d[j]
         END
      END;
      IF (k <> i) THEN BEGIN
         d[k] := d[i];
         d[i] := p;
         FOR j := 1 TO n DO BEGIN
            p := v[j,i];
            v[j,i] := v[j,k];
            v[j,k] := p
         END
      END
   END
END;
