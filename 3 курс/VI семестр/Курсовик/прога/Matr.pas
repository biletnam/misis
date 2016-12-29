UNIT MATR;
INTERFACE
USES CRT;
TYPE
   matrix = array[1..5,1..5] of integer;
   Procedure Minor(a,b,n:integer;m:matrix);
   Function Opredelitel(matr:matrix;n:integer):integer;
VAR
   mat:matrix;
IMPLEMENTATION

Procedure Minor(a,b,n:integer;m:matrix);
var i,j,t1,t2:integer;
begin
 for i:= 1 to n do
 begin
    for j:=1 to n do
    begin
       t1:=0;
       t2:=0;
       If (i>=a) then t1:=1;
       If (j>=b) then t2:=1;
       mat[i,j]:=m[i+t1,j+t2];
    end;
 end;
end;

Function Opredelitel(matr:matrix;n:integer):integer;
var t,i,opr:integer;
begin
opr:=0;
if n=1 then Opredelitel:=matr[1,1];
if n=2 then Opredelitel:=matr[1,1]*matr[2,2]-matr[2,1]*matr[1,2];
if n>=3 then
   begin
      t:=1;
      for i:=1 to n do
      begin
         Minor(1,i,n,matr);
         writeln; }
         opr:=opr+matr[1,i]*Opredelitel(mat,n-1)*t;
         t:=t*(-1);
      end;
   Opredelitel:=Opr;
   end;
end;

end.
