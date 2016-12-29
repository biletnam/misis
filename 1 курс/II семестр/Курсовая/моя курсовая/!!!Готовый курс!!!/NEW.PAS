Uses Crt,KSpusk;
Var
  a,b,c,d,h,e,x1,x2,Q:real;
  i:integer;
BEGIN
   ClrScr;
   WriteLn('Введите начальный шаг поиска');
   ReadLn(h);
   WriteLn('Введите точность ');
   ReadLn(e);
   Write('Введите начальные x1=');
   ReadLn(x1);
   Write('Введите начальные x2=');
   ReadLn(x2);
   ClrScr;
   a:=-100;
   b:=100;
   d:=-20.45;
   repeat
     c:=(a+b)/2;
     If Pks(h,e,x1,x2,c)>d then b:=c else a:=c;
   until ABS(Pks(h,e,x1,x2,c)-d)<=e;
   Writeln('При Q <= ',c:1:4);
   Writeln('Fmin не превышает величины в ',d:1:2);
   readkey;
END.