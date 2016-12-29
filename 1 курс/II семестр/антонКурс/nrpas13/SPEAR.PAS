PROCEDURE spear(data1,data2: narray; n: integer;
      VAR wksp1,wksp2: narray;
      VAR d,zd,probd,rs,probrs: real);
(* Programs using routine SPEAR must define types
TYPE
   narray = ARRAY [1..n] OF real;
   glsarray = narray;
in the calling routine *)
VAR
   j: integer;
   vard,t,sg,sf,fac,en3n,en,df,aved: real;
BEGIN
   FOR j := 1 TO n DO BEGIN
      wksp1[j] := data1[j];
      wksp2[j] := data2[j]
   END;
   sort2(n,wksp1,wksp2);
   crank(n,wksp1,sf);
   sort2(n,wksp2,wksp1);
   crank(n,wksp2,sg);
   d := 0.0;
   FOR j := 1 TO n DO d := d+sqr(wksp1[j]-wksp2[j]);
   en := n;
   en3n := en*en*en-en;
   aved := en3n/6.0-(sf+sg)/12.0;
   fac := (1.0-sf/en3n)*(1.0-sg/en3n);
   vard := ((en-1.0)*sqr(en)*sqr(en+1.0)/36.0)*fac;
   zd := (d-aved)/sqrt(vard);
   probd := erfcc(abs(zd)/1.4142136);
   rs := (1.0-(6.0/en3n)*(d+0.5*(sf+sg)))/fac;
   t := rs*sqrt((en-2.0)/((1.0+rs)*(1.0-rs)));
   df := en-2.0;
   probrs := betai(0.5*df,0.5,df/(df+sqr(t)))
END;
