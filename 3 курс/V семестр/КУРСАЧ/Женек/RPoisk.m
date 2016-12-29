function RPoisk = RPoisk(a,b,h,xk,grad)

min = a

for x = a:h:b
    t = x
    if Func(x,xk,grad)<Func(min,xk,grad)
       min=x
    end
end

RPoisk = min