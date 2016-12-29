PROCEDURE fit(x,y: glndata; ndata: integer; sig: glndata; mwt: integer;
         VAR a,b,siga,sigb,chi2,q: real);
(* Programs using routine FIT must define the type
TYPE
   glndata = ARRAY [1..ndata] OF real;
in the main routine.   *)
VAR
   i: integer;
   wt,t,sy,sxoss,sx,st2,ss,sigdat: real;
BEGIN
   sx := 0.0;
   sy := 0.0;
   st2 := 0.0;
   b := 0.0;
   IF (mwt <> 0)THEN BEGIN
      ss := 0.0;
      FOR i := 1 TO ndata DO BEGIN
         wt := 1.0/sqr(sig[i]);
         ss := ss+wt;
         sx := sx+x[i]*wt;
         sy := sy+y[i]*wt
      END
   END ELSE BEGIN
      FOR i := 1 TO ndata DO BEGIN
         sx := sx+x[i];
         sy := sy+y[i]
      END;
      ss := ndata
   END;
   sxoss := sx/ss;
   IF (mwt <> 0)THEN BEGIN
      FOR i := 1 TO ndata DO BEGIN
         t := (x[i]-sxoss)/sig[i];
         st2 := st2+t*t;
         b := b+t*y[i]/sig[i]
      END
   END ELSE BEGIN
      FOR i := 1 TO ndata DO BEGIN
         t := x[i]-sxoss;
         st2 := st2+t*t;
         b := b+t*y[i]
      END
   END;
   b := b/st2;
   a := (sy-sx*b)/ss;
   siga := sqrt((1.0+sx*sx/(ss*st2))/ss);
   sigb := sqrt(1.0/st2);
   chi2 := 0.0;
   IF (mwt = 0)THEN BEGIN
      FOR i := 1 TO ndata DO BEGIN
         chi2 := chi2+sqr(y[i]-a-b*x[i])
      END;
      q := 1.0;
      sigdat := sqrt(chi2/(ndata-2));
      siga := siga*sigdat;
      sigb := sigb*sigdat
   END ELSE BEGIN
      FOR i := 1 TO ndata DO BEGIN
         chi2 := chi2+sqr((y[i]-a-b*x[i])/sig[i])
      END;
      q := gammq(0.5*(ndata-2),0.5*chi2)
   END;
END;
