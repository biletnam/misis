UNIT KSPUSK;
INTERFACE
USES CRT;
TYPE
   mas=array[1..2] of real;
   Function f(x1,x2:real;Q:real):real;
   Function Pks(h,e,x1,x2,Q:real):real;
IMPLEMENTATION

Function f(x1,x2:real;Q:real):real;
     begin
        f:= x1*x1 + Q*x1*x2 + x2*x2 - 4*Ln(x1) - 10*Ln(x2) ;
     end;

Function Pks(h,e,x1,x2,Q:real):real;
var x:mas;
    y,l,b,c:real;
    i,n:integer;
begin
   n:=2;
   x[1]:=x1;
   x[2]:=x2;
   l:=h;
   repeat
    For i:=1 to n do
      begin
         b:=0.9E38;
         repeat
           repeat
             x[i]:=x[i]+h;
             y:=f(x[1],x[2],Q);
             c:=b;
             b:=y;
           until y-c<0;
           h:=-h/3;
           until abs(h)>=abs(l/3);
         h:=l;
      end;
      l:=l/9;
      h:=l;
   until e/9<=l;
   Pks:=y;
end;

end.
