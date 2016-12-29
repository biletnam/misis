PROCEDURE pearsn(x,y: nparray; n: integer; VAR r,prob,z: real);
(* Programs using routine PEARSN must define type
TYPE
   nparray = ARRAY [1..n] OF real;
in the main routine. *)
CONST
   tiny=1.0e-20;
VAR
   j: integer;
   yt,xt,t,syy,sxy,sxx,df,ay,ax: real;
BEGIN
   ax := 0.0;
   ay := 0.0;
   FOR j := 1 TO n DO BEGIN
      ax := ax+x[j];
      ay := ay+y[j]
   END;
   ax := ax/n;
   ay := ay/n;
   sxx := 0.0;
   syy := 0.0;
   sxy := 0.0;
   FOR j := 1 TO n DO BEGIN
      xt := x[j]-ax;
      yt := y[j]-ay;
      sxx := sxx+sqr(xt);
      syy := syy+sqr(yt);
      sxy := sxy+xt*yt;
   END;
   r := sxy/sqrt(sxx*syy);
   z := 0.5*ln(((1.0+r)+tiny)/((1.0-r)+tiny));
   df := n-2;
   t := r*sqrt(df/(((1.0-r)+tiny)*((1.0+r)+tiny)));
   prob := betai(0.5*df,0.5,df/(df+sqr(t)))
(*   prob := erfcc(abs(z*sqrt(n-1.0))/1.4142136)   *)
END;
