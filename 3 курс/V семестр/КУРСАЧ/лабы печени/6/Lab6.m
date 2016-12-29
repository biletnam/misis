%                         Лабораторная работа №6

N = 21;                 
aa = 0.3;              
bb = 1;              
h = (bb-aa)/N;  
x = aa-h; 

Alfa0 = 2;
Alfa1 = 0;
Beta0 = -1;
Beta1 = 1;
A = 0.6;
B = 2;                  


%Вычисление коэффициентов системы

for i=1:N
   x = x+h;
   X(i) = x;               
   a(i) = 2-P(x)*h;
   b(i) = 2*Q(x)*h*h-4;
   c(i) = 2+P(x)*h;
   d(i) = 2*F(x)*h*h;
end
a(1) = 2*h*Alfa0-3*Alfa1;
b(1) = 4*Alfa1;
c(1) = -Alfa1;
d(1) = 2*h*A;
a(N) = Beta1;
b(N) = -4*Beta1;
c(N) = 2*h*Beta0+3*Beta1;
d(N) = 2*h*B;


%Заполнение матрицы

for i=1:N
   for j=1:N
      M(i,j) = 0;
      if (i==j)
         M(i,j)= b(i);
      end
      if i-j==1
         M(i,j) = a(i);
      end
      if i-j==-1
         M(i,j)= c(i);
      end
   end
end
M(1,1) = a(1);
M(1,2) = b(1);
M(1,3) = c(1);
M(N,N) = c(N);
M(N,N-1) = b(N);
M(N,N-2) = a(N);

Graphic1=M\d'

Graphic2=bicg(M,d',0.0001,1100)


%Приведение матрицы к трёхдиагональному виду

T = M(2,3);
T2 = -M(1,3);
T3 = M(N-1,N-2);
T4 = -M(N,N-2);
for j=1:N
   M(2,j) = M(2,j)/T;
   M(1,j) = M(1,j)+M(2,j)*T2;
   M(N-1,j) = M(N-1,j)/T3;
   M(N,j) = M(N,j)+M(N-1,j)*T4;
end

d(2) = d(2)/T;                  
d(1) = d(1)+d(2)*T2;
d(N-1) = d(N-1)/T3;
d(N) = d(N)+d(N-1)*T4;


%Выборка элементов матрицы

for i=1:N
   for j=1:N
      if i==j
         b(i)=M(i,j);
      end
      if i-j==-1
         c(i)=M(i,j);
      end
      if i-j==1
         a(i)=M(i,j);
      end
   end
end
a(1) = 0;
c(N) = 0;


%Метод прогонки

%Прямой ход

al(1) = 0;
bet(1) = 0;

for i=2:N+1
   al(i)= -c(i-1)/(b(i-1)+a(i-1)*al(i-1));
   bet(i)= (d(i-1)-a(i-1)*bet(i-1))/(b(i-1)+a(i-1)*al(i-1));
end

%Обратный ход

U(N+2)=0;
i = N+2;
while i>2
   U(i-1)= al(i-1)*U(i)+bet(i-1);
   i = i-1;
end
PR = U'
W = [Graphic1';Graphic2';PR(2:N+1)'];

%  график

plot(X,W')
figure(2)
plot(X,Graphic1)
figure(3)
plot(X,Graphic2)