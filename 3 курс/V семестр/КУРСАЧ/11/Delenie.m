function Delenie = Delenie(a1,b1,e,xk,grad)

a(1)=a1
b(1)=b1
k = 1

xc(k) = (a(k) + b(k))/2
L(k)= abs(b(k) - a(k))

while L(k)>=e

y(k)=a(k)+L(k)/4
z(k)=b(k)-L(k)/4
if Func(y(k),xk,grad) < Func(xc(k),xk,grad)
   b(k+1)=xc(k)
   a(k+1)=a(k)
   xc(k+1)=y(k)
else
   if Func(z(k),xk,grad) < Func(xc(k),xk,grad)
      a(k+1)=xc(k)
      b(k+1)=b(k)
      xc(k+1)=z(k)
  else    
      a(k+1)=y(k)
      b(k+1)=z(k)
      xc(k+1)=xc(k)
  end    
end   

L(k+1) = abs(b(k+1) - a(k+1))

k=k+1

end

Delenie = xc(k)