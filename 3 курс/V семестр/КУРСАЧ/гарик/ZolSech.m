function ZolSech = ZolSech(a1,b1,l,xjk,ed,grad)

k=1
a(1)=a1
b(1)=b1

y(1)=a(1) + ((3-sqrt(5))/2)*(b(1)-a(1))
z(1)=a(1)+b(1)-y(1)

if Func(y(k),xjk,ed,grad) <= Func(z(k),xjk,ed,grad)
   a(k+1) = a(k)
   b(k+1) = z(k)
   y(k+1) = a(k+1) + b(k+1) - y(k)
   z(k+1) = y(k)
else
   a(k+1) = y(k)
   b(k+1) = b(k)
   y(k+1) = z(k)
   z(k+1) = a(k+1) + b(k+1) - z(k)
end

while abs(a(k+1)-b(k+1)) >= l
    k=k+1
    if Func(y(k),xjk,ed,grad) <= Func(z(k),xjk,ed,grad)
       a(k+1) = a(k)
       b(k+1) = z(k)
       y(k+1) = a(k+1) + b(k+1) - y(k)
       z(k+1) = y(k)
    else
       a(k+1) = y(k)
       b(k+1) = b(k)
       y(k+1) = z(k)
       z(k+1) = a(k+1) + b(k+1) - z(k)
    end
end

ZolSech = (a(k+1) + b(k+1))/2