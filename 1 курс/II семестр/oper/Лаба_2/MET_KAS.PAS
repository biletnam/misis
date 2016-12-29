Program kas;
Uses crt;
Const
  k=1;
Var
  xz,x1,a1,b1,x2,y,y1,y2,t,S,e: real;
  a,b,a2,b2,x,ak1,bk1 : real;
  i:integer;
  txt:text;
Function f(c :real): real;
begin
  f:=exp(c/2)+c*c+2*c-1;
end;

Function f1(c :real): real;
begin
     f1:=1/2*(exp(1/2*c))+2*c+2;
end;

Function fx(ak,bk: real): real;
begin
   fx:=(F(bk)-F(ak)-bk*f1(bk)+ak*f1(ak))/(f1(ak)-f1(bk));
end;

Procedure main;
Begin
  clrscr;
  writeln;
  Write(' a = ');
  readln(a);
  writeln;
  Write(' b = ');
  readln(b);
  writeln;
  Write(' E = ');
  readln(E);
  writeln;
  i:=0;
  a1:=a; b1:=b;
  assign(txt,'fox.txt');
  rewrite(txt);
  writeln(txt,'a=',a:2:4,'  b=',b:2:4,'  e=',E:2:4);
  writeln (txt,' i     a      b     x     f(x)    f(a)     f(b)    f1(a)    f1(b)');
  While (b1-a1)>E do
     begin
        x:=fx(a1,b1);
        t:=f1(x);
        Write(txt,i:2,' ',a1:2:4,' ',b1:2:4,' ',x:2:4,' ',F(x):2:4);
        if t<0 then
          begin
             a2:=x; b2:=b1;
             a1:=a2; b1:=b2;
          end;
        if t>0 then
          begin
             a2:=a1; b2:=x;
             a1:=a2; b1:=b2;
          end;
        ak1:=f1(a1); bk1:=f1(b1);
        Writeln(txt,' ',f(a):2:4,' ',f(b):2:4,' ',ak1:2:4,' ',bk1:2:4);
        inc(i);

     end;
     xz:=x;
     S:=F(xz);
     writeln;
     Writeln(txt,'Минимум найден в точке X = ',xz:2:4,' F(x) = ',S:2:4);
     close(txt);
end;

begin
  textbackground(1);
  { Оператор окрашивающий фон экрана }
  textcolor(15);
  { Оператор окрашивающий текст }
  clrscr;
  main;
  readkey;
end.