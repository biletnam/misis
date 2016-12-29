unit metodof;

interface
uses crt,ustp,VibFo;

{--Нахождение оптимума по методу  "золотого" сечения--}
procedure GoldSech(ff:fyn; n:integer; a,b,eps:real; var fil:text);


implementation
  {$F+}

{--Нахождение оптимума по методу  "золотого" сечения--}
procedure GoldSech(ff:fyn; n:integer; a,b,eps:real; var fil:text);
var
  mx,mf:real;
  kk:byte;

  procedure goldmin(ff:fyn; n:integer; a,b,eps:real; var x,f:real; var k:byte);
   var c,f1,h,t,t1:real;
   begin
         t1:=2/(sqrt(5)+1);
         t:=1-t1;
         c:=a+t*(b-a);
         x:=a+b-c;
         f:=ff(c,n,fil);f1:=ff(x,n,fil);
         k:=0;
         REPEAT
           IF f1<f THEN
             BEGIN
              h:=b-c;a:=c;c:=x;x:=a+h*t1;f:=f1;f1:=ff(x,n,fil)
             END
           ELSE
             BEGIN
              h:=x-a; b:=x; x:=c; c:=a+h*t; f1:=f; f:=ff(c,n,fil)
             END;
             k:=k+1;
         textcolor(12);
         writeln('   x = ',x:7:4,'   a = ',a:7:4,'   b = ',b:7:4,'  F = ',mf:0:4);
         textcolor(15);
         writeln(fil,'x = ',x:7:4,'   a = ',a:7:4,'   b = ',b:7:4,'  F = ',mf:0:4);
         UNTIL (h<eps) or (k>500);
         x:=(c+x)/2; f:=ff(x,n,fil)
   end;
begin
   writeln;
   writeln('    Нахождение оптимума по методу  "золотого" сечения');
   writeln(fil,'    Нахождение оптимума по методу  "золотого" сечения');
   goldmin(ff,n,a,b,eps,mx,mf,kk);
   writeln;
   if kk>500 then
      begin
        writeln(   'Минимум не найден по методу "золотого" сечения');
        writeln(   'Проверьте вводимые параметры!');
        writeln(fil,'    Минимум не найден по методу "золотого" сечения');
        writeln(fil,'    Проверьте вводимые параметры!');
      end
     else
      begin
        writeln('    Минимум найден по методу "золотого" сечения');
        writeln(fil,'    Минимум найден по методу "золотого" сечения');
       writeln('    При Xmin =',mx:7:4,' значение функции  Fmin =',mf:7:4);
       writeln(fil,'При Xmin =',mx:7:4,' значение функции  Fmin =',mf:7:4);
      end;
   writeln('    Количество вычислений k =',kk);
   writeln(fil,'    Количество вычислений k =',kk);
   writeln(fil);
end;

end.
