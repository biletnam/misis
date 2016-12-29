function Progonka = Progonka(A,D,N)

d(1)=A(1,2);
c(1)=A(1,1);
for i=2:N
    c(i)=A(i,i);
    d(i)=A(i,i+1);
    b(i)=A(i,i-1);
end

b(N+1)=A(N+1,N);
c(N+1)=A(N+1,N+1);
d(N+1)=0;

alfa(1)=-d(1)/c(1);     %прямой ход
beta(1)=D(1)/c(1);

for i=2:(N+1)
    alfa(i)= -d(i)/(c(i)+b(i)*alfa(i-1));
    beta(i)= (D(i)-b(i)*beta(i-1))/(c(i)+b(i)*alfa(i-1));
end



Y(N+2)=0;                 %обратный ход
i=N+1;
while i>=1
    Y(i)=alfa(i)*Y(i+1)+beta(i);
    i=i-1;
end
    Progonka = Y;
