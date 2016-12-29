program ThreeD;
{reference: 'Simple 3-D graphics', Byte, Jan. '86, p.154}
var x0,y0,xl,yl,xr,yr,dx,dy: integer;
    phi,psi: real;

function z(x,y: real): real;
begin
{      z := sin(y/10) * sqr(x - y)/150;}
{      z := -8*exp(sin(x*y/784))    }
       z := 20*sin(x/20)*cos(y/20);
end;

procedure draw3D(phi,psi: real;x0,xl,xr,dx,
                 y0,yl,yr,dy:integer; axes:boolean);
const XLIM = 279;
      YLIM = 189;
var hb: array [0..XLIM] of integer;
    x, xb, x1, y, yb, y1: integer;
    i, j, nx, ny: integer;
    Cphi,Cpsi,Sphi,Spsi: real;

procedure minmax(x,y:integer;var a,b:integer);
begin
     if x < y then begin
        a := x; b := y; end
     else begin
        b := x; a := y; end;
end;

procedure movemask;
var m,c: real;
    a,b,j,k: integer;
begin
     m := (y1 - yb) / (x1 -xb);
     c := yb + m*xb;
     minmax(xb,x1,a,b);
        for j := a to b do begin
            k := trunc(-m*j + c);
            if k < hb[j] then hb[j] := k;
            end;
end;

function xp(x,y:real): integer;
begin  xp := trunc(x0 + x*Cphi - y*Cpsi)  end;

function yp(x,y:real): integer;
begin  yp := trunc(y0 - x*Sphi - y*Spsi - z(x,y))  end;

begin
     Cphi := cos(phi);  Cpsi := cos(psi);
     Sphi := sin(phi);  Spsi := sin(psi);
     Graphmode;
     graphWindow(0,0,279,189);  {size of Apple screen}
     if axes then begin
        draw(x0,y0,xp(xr,y0), yp(xr,y0),3);
        draw(x0,y0,xp(x0,yr),yp(x0,yr),3);
        draw(x0,y0,x0,y0-250,3);
     end;
     for i := 0 to XLIM do hb[i] := YLIM; {set to bottom of window}
     nx := trunc((xr - xl) / dx);
     ny := trunc((yr - yl) / dy);
     for i := 0 to nx do begin
        x := xl + i*dx;
        xb := xp(x,yl);  yb := yp(x,yl);
        for j := 1 to ny do begin
           y := yl + j*dy;
           x1 := xp(x, y);
           y1 := yp(x, y);
           if (x1 >= 0) and (x1 <= XLIM) then begin
              if (y1 <= hb[x1]){ and (yb <= hb[xb])} then begin
                   draw(xb,yb,x1,y1,3);
                   movemask;
                   end;
              end;
           xb := x1;  yb := y1;
           end;
        end;
     for i := 0 to XLIM do hb[i] := YLIM;
     for i := 0 to ny do begin
        y := yl + i*dy;
        xb := xp(xl,y);  yb := yp(xl,y);
        for j := 1 to nx do begin
           x := xl + j*dx;
           y1 := yp(x, y);
           x1 := xp(x, y);
           if (y1 >= 0) and (y1 <= YLIM) then begin
              if (y1 <= hb[x1]) and (yb <= hb[xb]) then begin
                   draw(xb,yb,x1,y1,3);
                   movemask;
                   end;
              end;
           xb := x1;  yb := y1;
           end;
        end;
     repeat until keypressed;
     Textmode(C80);
end;

begin
    { x0 := 140;  y0 := 100;
     xl := -70;  yl := -70;
     xr := 70;   yr := 70;
     dx := 5;   dy := 5;
     phi := 0.3; psi := 0.3;}
     x0 := 110;  y0 := 180;
     xl := 0;    yl := 0;
     xr := 170;  yr := 100;
     dx := 5;    dy := 5;
     phi := 0.5; psi := 0.4;
     draw3D(phi,psi,x0,xl,xr,dx,y0,yl,yr,dy,false);
end.