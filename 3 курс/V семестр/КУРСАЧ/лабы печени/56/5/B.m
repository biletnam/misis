X = in0(:,1)
Y = in0(:,2)
R = in1
n = in2
m = in3

k = 1
for i = 0:n
    for j = 0:m
        F(:,k) = (X.^(n-i)).*(Y.^(m-j))
        k = k+1
    end
end

B = pinv(F'*F)*F'*R


out0 = round(B)
