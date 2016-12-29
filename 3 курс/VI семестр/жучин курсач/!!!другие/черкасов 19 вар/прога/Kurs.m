N = 100; % число отрезков 
L = 0.4; % длина
lambda = 46; % параметр
xmin = 0; % начальное значние x
ymin = 0; % начальное значение y

h = L/N; % шаг 

% создаем сетку
for i=1:N+1
    x(i)=xmin + (i-1)*h;
    y(i)=ymin + (i-1)*h;
end;

U = zeros(N+1); 

% записываем граничные условия
for i=1:N+1
    for j=1:N+1
        U(1,j)=Fi(x(1),y(j));
        U(N+1,j)=Fi(x(N+1),y(j));
        U(i,1)=Fi(x(i),y(1));
        U(i,N+1)=Fi(x(i),y(N+1));
    end;
end;

M = 0; % начальное приближение
e = 0.01; % точность

% первая итерация
for i=2:N
    for j=2:N
        v = (U(i+1,j)+U(i-1,j)+U(i,j+1)+U(i,j-1)-(-F(x(i),y(j))/lambda)*h*h)/4;
        d = abs(v-U(i,j));
        U(i,j) = v;
        if (M < d) M = d;
        end;
    end;
end;

% достигаем требуемой точности
while (M > e)  
for i=2:N
    for j=2:N
        v = (U(i+1,j)+U(i-1,j)+U(i,j+1)+U(i,j-1)-(-F(x(i),y(j))/lambda)*h*h)/4;
        d = abs(v-U(i,j));
        U(i,j) = v;
        if (M < d) M = d;
        end;
    end;
end;
end;

% вывод графика
figure(1);
surf(x,y,U);