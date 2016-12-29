function F = F(x,y);

if ((x>=0.29 & x<=0.31)&(y>=0.29 & y<=0.31))
    F = -200;
elseif ((x>=0.09 & x<=0.11) & (y>=0.09 & y<=0.11))
    F = 150;
else
    F = 0;
end;