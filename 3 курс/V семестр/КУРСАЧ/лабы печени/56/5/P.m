Xmin = round(-10*rand)
Xmax = round(10*rand)

Ymin = round(-10*rand)
Ymax = round(10*rand)

[X,Y] = meshgrid(Xmin:Xmax,Ymin:Ymax)
XY = [X(:),Y(:)]

out0 = XY