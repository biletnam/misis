function Func = Func(t,xk,Ak,grad)


T = xk - t * Ak * grad

Func = f (T(1),T(2),T(3),T(4))