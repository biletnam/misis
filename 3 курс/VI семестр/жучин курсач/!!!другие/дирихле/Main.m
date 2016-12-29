x1 = 0;
x2 = 1;
y1 = 0;
y2 = 1;

N = 10;

h = (x2-x1)/N;

for i=1:N+1
    x(i)=(i-1)*h;
    y(i)=(i-1)*h;
end;

% запись начальных условий

for i=1:N+1
    U(1,i) = F2(0,i);
    U(i,1) = F1(i,0);
    U(N+1,i) = F2(0,i);
    U(i,N+1) = F1(i,0);
end



M = 0;
e = 0.1;

%while M>e

for i=2:N
   for j=2:N
      v = 1/4 * (U(i+1,j) + U(i-1,j) + U(i,j+1)+U(i,j-1));
      d = abs(v - U(i,j));
      U(i,j) = d
      if (M<d) 
          M=d;
      end;
   end; 
end;

%end;

figure(1);
surf(x,y,U);