N = 50; % разбиение струны
M = 40; % разбиение времени

L = 0.5; %длина
T = 0.4; %время
T2 = 0.8; %натяжение
ro = 0.15; %плотность
aa = T2/ro; % параметр

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
b = -aa*tau*tau;
c = h*h+2*aa*tau*tau;
d = -aa*tau*tau;

% коэффициенты граничного условия
p = -3;
r = 4;
q = -1;

p2 = 1;
r2 = -4;
q2 = 3;

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

A(N+1,N-1) = p2;
A(N+1,N) = r2;
A(N+1,N+1) = q2;

% запись начальных условий

for i=1:N+1
    U(1,i) = Fi(x(i));
    U(2,i) = tau * Psi(x(i)) + U(1,i);
end

% Решение краевой задачи

for j=3:M+1
    for i=2:N
        D(i) = h*h*tau*tau*(F(x(i),t(j))) + 2*h*h*U(j-1,i)-h*h*U(j-2,i);   
    end
    D(1)=2*h*Alfa(t(j));
    D(N+1) = 2*h*Beta(t(j));
    Y=bicg(A,D');
    for s=1:N+1
        U(j,s)=Y(s);
    end
end;

% графический вывод результатов

num = 0;
for p= 1:10:41
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
axis([0 L -0.01 0.05]);
end

% 3D
figure(6);
upos = [2*w, 0, w, h] ;
set(figure(num+1),'Position',upos);
surf(x,t,U);