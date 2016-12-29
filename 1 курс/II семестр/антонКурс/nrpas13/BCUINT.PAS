PROCEDURE bcuint(y,y1,y2,y12: gl4array; x1l,x1u,x2l,x2u,x1,x2: real;
        VAR ansy,ansy1,ansy2: real);
(* Programs using procedure BCUINT must define the types
TYPE
   gl4array = ARRAY [1..4] OF real;
   gl4by4 = ARRAY [1..4,1..4] OF real;
in the main routine. *)
VAR
   i: integer;
   t,u,d1,d2: real;
   c: gl4by4;
BEGIN
   d1 := x1u-x1l;
   d2 := x2u-x2l;
   bcucof(y,y1,y2,y12,d1,d2,c);
   IF ((x1u = x1l) OR (x2u = x2l)) THEN BEGIN
      writeln('pause in routine BCUINT - bad input'); readln
   END;
   t := (x1-x1l)/d1;
   u := (x2-x2l)/d2;
   ansy := 0.0;
   ansy2 := 0.0;
   ansy1 := 0.0;
   FOR i := 4 DOWNTO 1 DO BEGIN
      ansy := t*ansy+((c[i,4]*u+c[i,3])*u+c[i,2])*u+c[i,1];
      ansy2 := t*ansy2+(3.0*c[i,4]*u+2.0*c[i,3])*u+c[i,2];
      ansy1 := u*ansy1+(3.0*c[4,i]*t+2.0*c[3,i])*t+c[2,i]
   END;
   ansy1 := ansy1/d1;
   ansy2 := ansy2/d2
END;
