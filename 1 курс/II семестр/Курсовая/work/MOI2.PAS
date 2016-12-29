Program Kurs;
Uses crt;
Type
   mas=array[1..20] of real;



  Function Func(a1,a2:real;Q:integer):real;
  begin
    { Func:=a1*a1+Q*a1*a2+a2*a2-4*Ln(a1)-10-Ln(a2);}
    Func:=a1*a1+2*a1+a2*a2-Sin(a1*a2);
  end;

  Procedure MinKS(Q:integer);
  label 1,2;
  Var a:mas;
      y,h,e,l,b,c: real;
      i,n:integer;
      F:text;
  Begin
     Assign(F,'log.txt');
     Rewrite(F);
     n:=2;
     WriteLn('Введите начальный шаг поиска');
     ReadLn(h);
     WriteLn('Введите точность');
     ReadLn(e);
     For i:=1 to n do
     begin
        Write('Введите начальные х',i,'= ');
        ReadLn(a[i]);
     end;
     l:=h;
     1: For i := 1 to n do
        begin
           b:=0.9E38;
     2:    a[i]:=a[i]+h;
           y:=Func(a[1],a[2],Q);
           c:=b;
           b:=y;

           Write(F,'y = ');Write(F,y);Write(F,'      c = ');Write(F,c);Write(F,'      b = ');Write(F,b);
           Write(F,'      x[');Write(F,i);Write(F,'] = ');WriteLn(F,a[i]);

           If y-c < 0 then goto 2;
           h:=-h/3;

           Write(F,'h = ');WriteLn(F,h);

           If abs(h)>=abs(l/3) then goto 2;
           h:=l;

           Write(F,'h = ');WriteLn(F,h);

         end;
        l:=l/9;
        h:=l;

        Write(F,'l = ');Write(F,l);Write(F,'      h = '); Writeln(F,h);

        If e/9<=l then goto 1;
        WriteLn('Fmin = ',y:4:10);
        For i:= 1 to n do
        begin
           WriteLn('x',i,'min=',a[i]:4:10)
        end;
  End;

BEGIN
   clrscr;
   MinKS(0);
   readkey;
END.