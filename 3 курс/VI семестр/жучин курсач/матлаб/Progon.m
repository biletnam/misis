function Progon = Progon(A,d,N)

%Ввыборка элементов матрицы:

for i=1:N+1
   for j=1:N+1
      if i==j
         b(i)=A(i,j);
      end
      if i-j==-1
         c(i)=A(i,j);
      end
      if i-j==1
         a(i)=A(i,j);
      end
   end
end
a(1) = 0;
c(N+1) = 0;

                           %Метод прогонки
%Прямой ход:
k(1) = 0;
t(1) = 0;

for i=2:N+1
   k(i)= -c(i-1)/(b(i-1)+a(i-1)*k(i-1));
   t(i)= (d(i-1)-a(i-1)*t(i-1))/(b(i-1)+a(i-1)*k(i-1));
end

%Обратный ход:

Y(N+2)=0;
i = N+2;
while i>2
   Y(i-1)= k(i-1)*Y(i)+t(i-1);
   i = i-1;
end
Progon=Y;