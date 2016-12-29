function Dihotom = Dihotom(a1,b1,e,l,xjk,ed,grad)

k=1
a(1)=a1
b(1)=b1
y(k)=(a(k)+b(k)-e)/2
z(k)=(a(k)+b(k)+e)/2

if Func(y(k),xjk,ed,grad) <= Func(z(k),xjk,ed,grad)
   a(k+1)=a(k)
   b(k+1)=z(k)
else
   a(k+1)=y(k)
   b(k+1)=b(k)
end   
  
while abs(b(k+1)-a(k+1)) >= l
    
      k=k+1
      y(k)=(a(k)+b(k)-e)/2
      z(k)=(a(k)+b(k)+e)/2

      if Func(y(k),xjk,ed,grad) <= Func(z(k),xjk,ed,grad)
         a(k+1)=a(k)
         b(k+1)=z(k)
      else
         a(k+1)=y(k)
         b(k+1)=b(k)
      end
  end      

Dihotom = (a(k+1)+b(k+1))/2