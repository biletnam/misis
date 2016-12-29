PROGRAM badluk(input,output);
LABEL 1,2;
CONST
   zon=-5.0;
   iybeg=1900;
   iyend=2000;
VAR
   timzon,frac: real;
   ic,icon,idwk,im: integer;
   iyyy,jd,jday,n: integer;
(*$I MODFILE.PAS *)
(*$I JULDAY.PAS *)
(*$I FLMOON.PAS *)
BEGIN
   timzon := zon/24.0;
   writeln('Full moons on Friday the 13th from',iybeg:5,' to',iyend:5);
   FOR iyyy := iybeg TO iyend DO BEGIN
      FOR im := 1 TO 12 DO BEGIN
         jday := julday(im,13,iyyy);
         idwk := (jday+1) MOD 7;
         IF (idwk = 5)  THEN BEGIN
            n := trunc(12.37*(iyyy-1900+(im-0.5)/12.0));
            icon := 0;
1:            flmoon(n,2,jd,frac);
            frac := 24.0*(frac+timzon);
            IF (frac < 0.0) THEN BEGIN
               jd := jd-1;
               frac := frac+24.0
            END;
            IF (frac > 12) THEN BEGIN
               jd := jd+1;
               frac := frac-12.0
            END ELSE BEGIN
               frac := frac+12.0
            END;
            IF (jd = jday) THEN BEGIN
               writeln;
               writeln(im:2,'/',13:2,'/',iyyy:4);
               writeln('Full moon ',frac:5:1,
                  ' hrs after midnight (EST).');
               GOTO 2 END
            ELSE BEGIN
               IF (jday >= jd) THEN ic := 1 ELSE ic := -1;
               IF (ic = -icon) THEN GOTO 2;
               icon := ic;
               n := n+ic
            END;
            GOTO 1;
2:         END
      END
   END
END.
