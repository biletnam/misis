function Fibo = Fibo(a1,b1,l,e,xk,Ak,grad)

a(1)=a1
b(1)=b1

F(1)=1
F(2)=1
N=2
while F(N) < abs((b1-a1)/l)
      N=N+1
      F(N)=F(N-1)+F(N-2)
end

k=1
N
y(1)=a(1) + (F(N-2)/F(N))*(b(1)-a(1))
z(1)=a(1) + (F(N-1)/F(N))*(b(1)-a(1))

while k < (N-3)

if Func(y(k),xk,Ak,grad)<= Func(z(k),xk,Ak,grad)
   
   a(k+1) = a(k)
   b(k+1) = z(k)
   z(k+1) = y(k)
   y(k+1) = a(k+1) + (F(N-k-3)/F(N-k-1))*(b(k+1)-a(k+1))
   
else
    
   a(k+1) = y(k)
   b(k+1) = b(k)
   y(k+1) = z(k)
   z(k+1) = a(k+1) + (F(N-k-2)/F(N-k-1))*(b(k+1)-a(k+1)) 

end

k=k+1
end

   N=N-1
   
   y(N-1)=(a(N-2)+b(N-2))/2
   y(N-2)=(a(N-2)+b(N-2))/2
   z(N-2)=(a(N-2)+b(N-2))/2
   z(N-1)=y(N-1) + e
   
   if Func(y(N-1),xk,Ak,grad) <= Func(z(N-1),xk,Ak,grad)
      a(N-1)=a(N-2)
      b(N-1)=z(N-1)
   else
      a(N-1)=y(N-1)
      b(N-1)=b(N-2)
  end


Fibo = (a(N-1)+b(N-1))/2