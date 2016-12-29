%
%   Метод золотого сечения 
%
a=-1
b=0
e=0.00001
k1=0.61803
k2=0.38197
y=k1*a+k2*b
z=k1*b+k2*a
fy=f(y)
fz=f(z)
i=2
while b-a > e
    if fy < fz
        b=z
        z=y
        fz=fy
        y=k1*a+k2*b
        fy=f(y)
    else
        a=y
        y=z
        fy=fz
        z=k1*b+k2*a
    end
    i=i+1  
end
X=(a+b)/2
Y=f(X)
I=i