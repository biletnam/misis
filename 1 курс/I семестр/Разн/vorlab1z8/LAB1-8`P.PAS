program lab_1_8;
uses CRT;
var
  x,y,z,A,B,F,T:real;

BEGIN
   textbackground(15);
   textcolor(0);
   ClrScr;
   x:=2828.4*exp(-3*10);
   y:=4.1093;
   z:=-7*sqrt(Pi)/9.5;
   A:=((1/y)*(x*exp(2/5*(x+3))
   +y/(sqr(x)+4))/(exp(-x-2)+1/(sqr(x)+4)));
   B:=(1+cos(a+2))/((exp(4*x))/2+sqr(sin(z)));
   T:=ln(abs(A)+sqrt(B));
   F:=arctan(sqrt(1-sqr(T))/T);
   WriteLn(F:2:2);
   Repeat Until KeyPressed;
END.


