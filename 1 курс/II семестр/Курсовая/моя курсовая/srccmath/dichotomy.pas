unit dichotomy;

interface
uses funclevel;

type
    T1DFunction=function(x:double):double;

var
   xk,uk:TWorldPoint;

function MakeDichotomy(a,b,eps,prec:double;func:T1DFunction):double;
function Pseudo1D(x:double):double;
implementation


function MakeDichotomy(a,b,eps,prec:double;func:T1DFunction):double;
var xk1,xk2:double;
    cx:TWorldPoint;
begin
while (b-a)>eps do
begin
     xk1:=(a+b)/2-prec;
     xk2:=(a+b)/2+prec;
     if func(xk1)<func(xk2) then
        begin
             a:=a;
             if b<>xk2 then
              begin
                  b:=xk2 ;
              end
             else
                 break;
        end
     else
         begin
              if a<>xk1 then
              begin
                  a:=xk1 ;
              end
              else
                  break;
              b:=b;
         end;
end;{while};
Result:=(a+b)/2;
end;

function Pseudo1D(x:double):double;
begin
     Result:=Func(xk.x+x*uk.x,xk.y+x*uk.y);
end;

end.
