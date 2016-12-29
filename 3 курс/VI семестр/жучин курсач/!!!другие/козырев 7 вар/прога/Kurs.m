N = 10; % разбиение стержня
M = 20; % разбиение времени 

lambda = 50;
c = 480;
ro = 7600;
a1 = 70;

L = 0.5; %длина
T = 300; %время
aa = lambda/(c*ro); % параметр
gamma = -a1/lambda;

h = L/N; %шаг по х
tau = T/M; %шаг по t

% задание пространственно-временной сетки
for i=1:N+1
    x(i)=(i-1)*h;  
end;
for i=1:M+1
    t(i)=(i-1)*tau;
end;

% коэффициенты основного уравнения
b = -aa*tau;
c = h*h+2*aa*tau;
d = -aa*tau;

% коэффициенты граничного условия

p = 2*gamma*h-3;
r = 4;
q = -1;

% построение матрицы

A = zeros(N+1);
for i=2:N
    A(i,i-1) = d;
    A(i,i) = c;
    A(i,i+1) = b;
end

A(1,1)=p;
A(1,2)=r;
A(1,3)=q;

A(N+1,N+1) = 1;

% запись начальных условий

for i=1:N+1
    U(1,i) = Phi(x(i));
end

% Решение краевой задачи

for j=2:M+1
    for i=2:N
        D(i) = h*h*tau*F(x(i),t(j)) + h*h*U(j-1,i);
    end
    D(1)=0;
    D(N+1) = Beta(t(j));
    Y=bicg(A,D');
    for s=1:N+1
        U(j,s)=Y(s);
    end
end;

% графический вывод результатов

num = 0;
for p= 1:5:21
num = num+1;
scrsz = get(0,'ScreenSize'); %разрешение экрана
w = scrsz(3)/3; %выставляем ширину окон графиков
h2 = 80; %высота заголовка окна
h = (scrsz(4)-2*h2)/2; %высота окон графиков
figure(num);
if num<=3 upos = [(num-1)*w, h+h2, w, h] ; %1 ряд
else    upos = [(num-4)*w, 0, w, h] ; %2 ряд
end;
set(figure(num),'Position',upos);
plot(x,U(p,:));
axis([0 L 0 50]);
end

% 3D
figure(6);
upos = [2*w, 0, w, h] ;
set(figure(num+1),'Position',upos);
surf(x,t,U);