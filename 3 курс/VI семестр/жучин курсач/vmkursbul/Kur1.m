N = 50;                    
IntX = 2*pi;            
IntT = 100;           
a = 0.1;                
gamma = -0.1;              
h = IntX/N;              
tt = IntT/N;           
a1 = 1;
b = -a*a*tt;
c = h*h+2*a*a*tt;
d = -a*a*tt;
p = 1;
q = -4;
r = 3+2*h*gamma;
A = zeros(N+1);
for i=1:N+1
   for j=1:N+1
      A(i,i) = c;
      A(i,i+1) = d;
      A(i+1,i) = b;
   end
end
A = A(1:N+1,1:N+1);
A(1,1) = a1;
A(1,2) = 0;
A(N+1,N+1) = r;
A(N+1,N) = q;
A(N+1,N-1) = p;
Temp = -p;
for i=1:N+1
   A(N,i) = A(N,i)/b;
   A(N+1,i) = A(N+1,i)+A(N,i)*Temp;
end
for j=1:N+1 
   x=h*(j-1);
   U(1,j) = Phi(x);
end
if in1 > 2
   U = in2;
end;
i = in1;
   t = tt*(i-2);
   for j=1:N+1
      x = h*(j-1);
      RightSides(j) = tt*h*h*(F(x,t)+in0(j))+U(i-1,j)*h*h; 
   end                                                
   RightSides(1) = Alfa(t);                                   
   RightSides(N+1) = 0;                                          
   RightSides(N) = RightSides(N)/b;                                      
   RightSides(N+1) = RightSides(N+1)+RightSides(N)*Temp;  
   Y = bicg(A,RightSides',0.0001,60);
   for jj=1:N+1
      U(i+1,jj) = Y(jj);      
   end
   out0 = Y;
   out1 = U;