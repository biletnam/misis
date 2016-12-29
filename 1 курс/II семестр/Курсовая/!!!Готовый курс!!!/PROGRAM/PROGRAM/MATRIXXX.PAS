unit MATRIXXX;

interface

const n=25;

type matrix=array[1..n,1..n] of real;

Procedure PrintMatr(m:matrix;n:integer);
Function MinorMatrix(a:matrix;n:integer):real;
Function Opredelitel(a:matrix;n:integer):real;

implementation

var a,b:matrix;
    i,j:longint;
    Opr,Minor:real;

Procedure PrintMatr(m:matrix;n:integer);
var i,j:integer;
begin
   for i:=1 to n do
      begin
         for j:=1 to n do
         if (i=1) and (j=1) then write('  R  ':4) else
         write(m[i,j]:4,' ');writeln;
      end;
end;

Procedure GetMatr(a:matrix; var b:matrix; m,i,j:integer);
var ki,kj,di,dj:integer;
begin
   di:=0;
   for ki:=1 to m-1 do
      begin
         if (ki=i) then di:=1;dj:=0;
         for kj:=1 to m-1 do
            begin
               if (kj=j) then dj:=1;
               b[ki,kj]:=a[ki+di,kj+dj];
            end;
      end;
end;

Function Opredelitel(a:matrix;n:integer):real;
var
   i,j,k:longint;
   b:matrix;
   Opr:real;
begin
   Opr:=0; k:=1;
      if n=1 then Opr:=a[1,1] else
      if n=2 then Opr:=a[1,1]*a[2,2]-a[2,1]*a[1,2] else
      for i:=1 to n do
         begin
            GetMatr(a,b,n,i,1);
            Opr:=Opr+k*a[i,1]*Opredelitel(b,n-1);
            k:=-k;
         end;
   Opredelitel:=Opr;
end;

Function MinorMatrix(a:matrix;n:integer):real;
var i,j,k:longint;b:matrix;Minor:real;
begin
   Minor:=0; k:=1;
      if n=1 then Minor:=a[1,1] else
      if (n=2) then Minor:=a[1,1]*a[2,2]-a[2,1]*a[1,2] else
      for i:=2 to n do
         begin
            GetMatr(a,b,n,i,1);
            Minor:=Minor+k*a[i,1]*Opredelitel(b,n-1);;
            k:=-k;
         end;
   MinorMatrix:=Minor;
end;

END.