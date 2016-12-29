PROCEDURE laguer(a: glcarray; m: integer; VAR x: gl2array;
       eps: real; polish: boolean);
(* Programs using routine LAGUER must define in the main routine the types
TYPE
   glcarray = ARRAY [1..2*m+2] OF real;
   gl2array = ARRAY [1..2] OF real; *)
LABEL 99;
CONST
   epss=6.0e-8;
   mxit=100;
VAR
   j,iter: integer;
   err,dxold,cdx,abx,dum: real;
   sq,h,gp,gm,g2,g: gl2array;
   b,d,dx,f,x1,cdum: gl2array;
PROCEDURE cdiv(a,b: gl2array; VAR c:gl2array);
(* Complex division of a by b, answer in c *)
VAR
   r,den: real;
BEGIN
   IF (abs(b[1]) >= abs(b[2])) THEN BEGIN
      r := b[2]/b[1];
      den := b[1]+r*b[2];
      c[1] := (a[1]+a[2]*r)/den;
      c[2] := (a[2]-a[1]*r)/den
   END ELSE BEGIN
      r := b[1]/b[2];
      den := b[2]+r*b[1];
      c[1] := (a[1]*r+a[2])/den;
      c[2] := (a[2]*r-a[1])/den
   END
END;
FUNCTION cabs(a: gl2array): real;
(* Complex absolute value of a *)
VAR
   x,y : real;
BEGIN
   x := abs(a[1]);
   y := abs(a[2]);
   IF (x = 0.0) THEN cabs := y
   ELSE IF (y = 0.0) THEN cabs := x
   ELSE IF (x > y) THEN cabs := x*sqrt(1.0+sqr(y/x))
   ELSE cabs := y*sqrt(1.0+sqr(x/y))
END;
PROCEDURE csqrt(a: gl2array; VAR b: gl2array);
(* Returns complex square root of a in b *)
VAR
   x,y,u,v,w,r : real;
BEGIN
   IF ((a[1] = 0.0) AND (a[2] = 0.0)) THEN BEGIN
      u := 0.0;
      v := 0.0
   END ELSE BEGIN
      x := abs(a[1]);
      y := abs(a[2]);
      IF (x >= y) THEN
         w := sqrt(x)*sqrt(0.5*(1.0+sqrt(1.0+sqr(y/x))))
      ELSE BEGIN
         r := x/y;
         w := sqrt(y)*sqrt(0.5*(r+sqrt(1.0+sqr(r))))
      END;
      IF (a[1] >= 0.0) THEN BEGIN
         u := w;
         v := a[2]/(2.0*u)
      END ELSE BEGIN
         IF (a[2] >= 0.0) THEN v := w
         ELSE v := -w;
         u := a[2]/(2.0*v)
      END
   END;
   b[1] := u;
   b[2] := v;
END;   
BEGIN
   dxold := cabs(x);
   FOR iter := 1 TO mxit DO BEGIN
      b[1] := a[2*m+1];
      b[2] := a[2*m+2];
      err := cabs(b);
      d[1] := 0.0;
      d[2] := 0.0;
      f[1] := 0.0;
      f[2] := 0.0;
      abx := cabs(x);
      FOR j := m DOWNTO 1 DO BEGIN
         dum := f[1];
         f[1] := x[1]*f[1]-x[2]*f[2]+d[1];
         f[2] := x[1]*f[2]+x[2]*dum+d[2];
         dum := d[1];
         d[1] := x[1]*d[1]-x[2]*d[2]+b[1];
         d[2] := x[1]*d[2]+x[2]*dum+b[2];
         dum := b[1];
         b[1] := x[1]*b[1]-x[2]*b[2]+a[2*j-1];
         b[2] := x[1]*b[2]+x[2]*dum+a[2*j];
         err := cabs(b)+abx*err
      END;
      err := epss*err;
      IF (cabs(b) <= err) THEN BEGIN
         dx[1] := 0.0;
         dx[2] := 0.0;
         GOTO 99
      END ELSE BEGIN
         cdiv(d,b,g);
         g2[1] := sqr(g[1])-sqr(g[2]);
         g2[2] := 2.0*g[1]*g[2];
         cdiv(f,b,cdum);
         h[1] := g2[1]-2.0*cdum[1];
         h[2] := g2[2]-2.0*cdum[2];
         cdum[1] := (m-1)*(m*h[1]-g2[1]);
         cdum[2] := (m-1)*(m*h[2]-g2[2]);
         csqrt(cdum,sq);
         gp[1] := g[1]+sq[1];
         gp[2] := g[2]+sq[2];
         gm[1] := g[1]-sq[1];
         gm[2] := g[2]-sq[2];
         IF(cabs(gp) < cabs(gm)) THEN BEGIN
            gp[1] := gm[1];
            gp[2] := gm[2]
         END;
         cdum[1] := m;
         cdum[2] := 0.0;
         cdiv(cdum,gp,dx);
      END;
      x1[1] := x[1]-dx[1];
      x1[2] := x[2]-dx[2];
      IF ((x[1] = x1[1]) AND (x[2] = x1[2])) THEN GOTO 99;
      x[1] := x1[1];
      x[2] := x1[2];
      cdx := cabs(dx);
      IF ((iter > 6) AND (cdx >= dxold)) THEN GOTO 99;
      dxold := cdx;
      IF (not polish) THEN
         IF (cabs(dx) <= eps*cabs(x)) THEN GOTO 99
   END;
   writeln('pause in routine LAGUER - too many iterations'); readln;
99:   END;
