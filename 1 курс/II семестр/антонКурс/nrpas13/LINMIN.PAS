PROCEDURE linmin(VAR p,xi: glnarray; n: integer; VAR fret: real);
(* Programs using routine LINMIN must define the type
TYPE
   glnarray = ARRAY [1..n] OF real;
They must also declare the variables
VAR
   ncom: integer;
   pcom,xicom: glnarray;
in the main routine. Also the function FUNC referenced by BRENT
and MNBRAK must be set to return the function F1DIM. *)
CONST
   tol=1.0e-4;
VAR
   j: integer;
   xx,xmin,fx,fb,fa,bx,ax: real;
BEGIN
   ncom := n;
   FOR j := 1 TO n DO BEGIN
      pcom[j] := p[j];
      xicom[j] := xi[j]
   END;
   ax := 0.0;
   xx := 1.0;
   bx := 2.0;
   mnbrak(ax,xx,bx,fa,fx,fb);
   fret := brent(ax,xx,bx,tol,xmin);
   FOR j := 1 TO n DO BEGIN
      xi[j] := xmin*xi[j];
      p[j] := p[j]+xi[j]
   END
END;
