unit funclevel;

interface
uses   Windows;
type
   TWorldPoint=record   {saves a point in world coord}
        x,y:double;
   end;
   TScreenPoint=record  {saves new point in screen coord}
        x,y:integer;
   end;
   TDoubleRect=record   {saves a range of definition}
        lx,ly,rx,ry:double;
   end;
var alpha:double;
{function prototypes}
procedure DrawLevels(HWND:longInt;Window:TRect;Area:TDoubleRect;N:integer);
procedure CorrectPoint(Value:Double;CurrentPoint:TWorldPoint;Var NewPoint:TWorldPoint);
procedure World2Screen(Area:TDoubleRect;Window:TRect;world:TWorldPoint;var screen:TScreenPoint);
procedure Screen2World(Area:TDoubleRect;Window:TRect;screen:TScreenPoint;var world:TWorldPoint);
function func(x,y:double):double;
procedure GradientFunc(x,y:double;var grad:TWorldPoint);
function GetMax(Area:TDoubleRect):double;
function GetMin(Area:TDoubleRect):double;
procedure GetNextPoint(x,y:double;var NextPoint:TWorldPoint);
procedure SetPrecision(newprec:Double);
procedure GradientLevels(HWND:longInt;Window:TRect;Area:TDoubleRect;N:integer);
function GetPrecision:double;
implementation
var Precision:double;

procedure DrawLevels(HWND:longInt;Window:TRect;Area:TDoubleRect;N:integer);
var x,y,s,min,max:double;
    i:integer;
    cs:array of double;
    w:TWorldPoint;
    scr:TScreenPoint;
begin
x:=area.lx;
y:=area.ly;
if N=0 then N:=10;
min:=getMin(Area);max:=GetMax(area);
s:=(max-min)/N;
Setlength(cs,N);
for i:=0 to N-1 do
   cs[i]:=min+i*s;
while x<area.rx do
begin
 while y<area.ry do
   begin
       for i:=0 to N-1 do
         if (abs(func(x,y)-cs[i])<precision) then
            begin
                w.x:=x;w.y:=y;
                World2Screen(Area,Window,w,scr);
                SetPixelV(hwnd,scr.x,scr.y,0);
                //OutPut.Canvas.pixels[scr.x,scr.y]:=0;
                break;
            end;
      y:=y+Precision;
    end;
   x:=x+Precision;
   y:=area.ly;
end;

end;

function GetMax(Area:TDoubleRect):double;
var x,y,max:double;
begin
x:=area.lx;y:=area.ly;
max:=func(x,y);
while (x<area.rx) do
begin
  while (y<area.ry) do
    begin
      if (func(x,y)>max) then
          max:=func(x,y);
      y:=y+0.1;
    end;
   x:=x+0.1;
   y:=area.ly;
end;
Result:=max;
end;

function GetMin(Area:TDoubleRect):double;
var x,y,min:double;
begin
x:=area.lx;y:=area.ly;
min:=func(x,y);
while (x<area.rx) do
begin
  while (y<area.ry) do
    begin
      if (func(x,y)<min) then
          min:=func(x,y);
      y:=y+0.1;
    end;
   x:=x+0.1;
   y:=area.ly;
end;
Result:=min;
end;

procedure SetPrecision(newprec:Double);
begin
if newprec<>0 then
        Precision:=abs(newprec);
end;

function GetPrecision:double;
begin
result:=precision;
end;

function func(x,y:double):double;
var sqrt5:double;
begin
//my function
   sqrt5:=sqrt(5);
   Result:=8*x*x-4*x*y+5*y*y+8*sqrt5*(x+2*y)+64;
   //sample function
 //Result:=2*sqr(x)+2*sqr(y)-2*x*y-4*x-6*y;
   //Jonny's function
 //  Result:=11*sqr(x)+3*sqr(y)+6*x*y-2*sqrt(10)*(x-3*y)-22;
//   Result:=sqr(x)-4*x+sqr(y)-2*y;
//lena's function
//         Result:=2*sqr(x)-4*x*y+5*sqr(y)-4*sqrt(5)*(x-y)+4;
//sonya's function
//    Result:=6*sqr(x)+3*sqr(y)-4*x*y+4*sqrt5*(x+2*y)+22;
//     result:=ln(abs(x*sin(y))+abs(cos(y)));
//     Result:=cos(x)-sqr(y);
 // Result:=8*sqr(cos(x))-4*sin(x)*sin(y)+5*sqr(sin(y))+8*sqrt(5)*(sin(x)+2*cos(Y))+64;
//Функция Розенброка
 //result:=alpha*sqr(sqr(x)-y)+sqr(x-1);
//Функция Химмельблау
//result:=sqr(sqr(x)+y-11)+sqr(x+sqr(y)-7);
end;

procedure GradientFunc(x,y:double;var grad:TWorldPoint);
var sqrt5:double;
begin
        sqrt5:=sqrt(5);
        grad.x:=-(16*x-4*y+8*sqrt5);
        grad.y:=-(-4*x+10*y+16*sqrt5);
//sample gradient
   // 	grad.x:=-(4*x-2*y-4);
    //    grad.y:=-(4*y-2*x-6);
//Jonny's functions gradient
 //  	grad.x:=-(22*x+6*y-2*sqrt(10));
//        grad.y:=-(6*y+6*x+6*sqrt(10));
//тестоввая функция
//   Result:=sqr(x)-4*x+sqR(y)-2*y;
//     grad.x:=-(2*x-4);
//     grad.y:=-(2*y-2);
//Функция Розенброка
//      grad.x:=-(alpha*4*(sqr(x)-y)*x+2*x-2);
//       grad.y:=-(-alpha*2*(sqr(x)-y));
//Функция Химмельблау
//	grad.x:=-(4*(sqr(x)+y-11)*x+2*(x+sqr(y)-7));
//        grad.y:=-(2*(sqr(x)+y-11)+4*(x+sqr(y)-7)*y);
//
//        grad.x:=-(12*x-4*y+4*sqrt5);
//        grad.y:=-(6*y-4*x+4*sqrt5*2);
{        grad.x:=-16*cos(x)*sin(x)-4*cos(x)*sin(y)+8*sqrt5*cos(x);
        grad.y:=-4*sin(x)*cos(y)+10*sin(y)*cos(y)-16*sqrt5*sin(y);}
end;

procedure GetNextPoint(x,y:double;var NextPoint:TWorldPoint);
var gradval:TWorldPoint;
begin
        GradientFunc(x,y,gradval);
        NextPoint.x:=x+Precision*gradval.y;
        NextPoint.y:=y-precision*gradval.x;
end;

procedure GradientLevels(HWND:longInt;Window:TRect;Area:TDoubleRect;N:integer);
var CellPoints:array of TWorldPoint;
    i,j,ni,k:integer;
    s1,s2:double;
    notstop:boolean;
    NextPoint:TWorldPoint;
    scr,PrevPoint,ScreenFirst:TScreenPoint;
    brush,ans:longint;

begin
SetLength(CellPoints,N);
ni:=trunc(sqrt(N));
s1:=(Area.rx-Area.lx)/ni;
s2:=(Area.ry-Area.ly)/ni;
k:=0;
for i:=0 to ni-1 do
   for j:=0 to ni-1 do
     begin
        CellPoints[k].x:=Area.lx+i*s1;
        CellPoints[k].y:=Area.ly+j*s2;
        inc(k);
     end;
{end of cell generation}
//notstop:=true;
for i:=0 to N-1 do
begin
 NextPoint:=CellPoints[i];
 s1:=func(NextPoint.x,NextPoint.y);
 World2Screen(Area,Window,NextPoint,PrevPoint);
 World2Screen(Area,Window,NextPoint,ScreenFirst);
 MoveToEx(hwnd,prevpoint.x,prevpoint.y,nil);
 brush:=CreateSolidBrush(trunc(16777216/(i+1)));
 ans:=SelectObject(hwnd,brush);
 while notstop do
   begin
        GetNextPoint(NextPoint.x,NextPoint.y,NextPoint);
        CorrectPoint(s1,NextPoint,NextPoint);
 {       if ((abs(NextPoint.x-CellPoints[i].x)<10*precision) and
           (abs(NextPoint.y-CellPoints[i].y)<10*precision)) then
           break
        else
            begin}
                 PrevPoint:=scr;
                 World2Screen(Area,Window,NextPoint,scr);
                 if ((abs(ScreenFirst.x-scr.x)=0) and (abs(ScreenFirst.y-scr.y)=0)) then
                  begin
                    notstop:=false;
                    break;
                  end
                 else
                    {if (NextPoint.x>Area.rx) or (NextPoint.x<Area.lx) or (NextPoint.y>Area.ry) or
                       (NextPoint.y<Area.ry) then
                       GetLostPoint(NextPoint,Area,NextPoint);} 
                    LineTo(hwnd,scr.x,scr.y);
//            end;{if}

   end;{while}
 DeleteObject(Brush);
 notstop:=true;
end;{for}
end;

procedure CorrectPoint(Value:Double;CurrentPoint:TWorldPoint;Var NewPoint:TWorldPoint);
var x,y,delta,err,cx,cy:double;
begin
delta:=4*Precision;
x:=CurrentPoint.x-delta;
y:=CurrentPoint.y-delta;
err:=16777216.0;
while x<CurrentPoint.x+delta do
 begin
    while y<CurrentPoint.y+Delta do
      begin
           if abs(func(x,y)-value)<err then
              begin
                err:=abs(func(x,y)-value);
                cx:=x;
                cy:=y;
              end;
           y:=y+precision;
      end;{while y}
      y:=CurrentPoint.y-Delta;
      x:=x+precision;
 end;{while x}
NewPoint.x:=cx;
NewPoint.y:=cy;
end;

procedure World2Screen(Area:TDoubleRect;Window:TRect;world:TWorldPoint;var screen:TScreenPoint);
var M11,M22:double;
begin
with Screen do
begin
    M11:=(Window.Right-Window.Left)/(Area.rx-Area.lx);
    M22:=-(Window.Top-Window.Bottom)/(Area.ry-Area.ly);
    x:=trunc(M11*world.x+Window.Left-M11*Area.lx);
    y:=window.Bottom-trunc(M22*world.y-M22*Area.ly);
end;
end;

procedure Screen2World(Area:TDoubleRect;Window:TRect;screen:TScreenPoint;var world:TWorldPoint);
var M11,M22:double;
begin
    M11:=(Window.Right-Window.Left)/(Area.rx-Area.lx);
    M22:=-(Window.Top-Window.Bottom)/(Area.ry-Area.ly);
    World.x:=(screen.x-(Window.Left-M11*Area.lx))/M11;
    World.y:=(Window.Bottom-screen.y+M22*Area.ly)/M22;
end;

end.
