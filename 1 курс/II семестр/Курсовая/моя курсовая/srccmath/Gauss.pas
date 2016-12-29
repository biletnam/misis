{Gauss.pas - solves system of linear algebraic equation by using
 Gauss method
 Includes general matrix operation and useful functions
 Realisation: (c) Meshchaninov Nick,FS2-52}
unit Gauss;

interface
const PAS_DIM=5;{For pascal7.0 compiler,which does not support
                 dynamic arrays}
type TOutput=real;
     TDynamicArray=array of TOutput;
     TMatrix=array{[0..PAS_DIM]} of TDynamicArray; //of //array{[0..PAS_DIM]} of TOutput;
     TNorm=function(Matrix:TMatrix):TOutput;

function LeadGauss(A:TMatrix;var B:TMatrix;Dim,B_col:integer;eps:TOutput):integer;
procedure InitMatrix(var Matrix:TMatrix;dimfirst,dimsec:integer);
procedure CopyMatrix(Source:TMatrix;var Destination:TMatrix);
function OctahedricNorm(Matrix:TMatrix):TOutput;
function InfNorm(Matrix:TMatrix):TOutput;
function EuclidNorma(Matrix:TMatrix):Double;
function EuclidNormaWithoutDiag(Matrix:TMatrix):double;
function EuclidNormaDownTri(Matrix:TMatrix):double;
procedure MakeUnitMatrix(var Matrix:TMatrix;dim:integer);
procedure MatrixSubtraction(var Reduced:TMatrix;Deducted:TMatrix);
procedure GetInverseMatrix(A:TMatrix;var invA:TMatrix;eps:TOutput);
function Pow(number,pow:TOutput):TOutput;
procedure MultQuadMatrix(Mul,ToMul:TMatrix;var Result:TMatrix);
procedure MultMatrix(M1,M2:TMatrix;var Res:Tmatrix);
procedure AAT(A:TMatrix;var Res:TMatrix);
procedure Transpose(A:TMatrix;var Res:TMatrix);
procedure ZeroMatrix(A:TMatrix);
implementation

function LeadGauss(A:TMatrix;var B:TMatrix;Dim,B_col:integer;eps:TOutput):integer;
{A-matrix of the coefficients
 B-matrix of the free elements
 Dim-dimension of the matrixes A & B - (rows)
 B_col-number of columns in matrix B
 eps-sets precision of calculation
 }
var i,j,k,guide_i,guide_j:integer;
    buff,guide:TOutput;
begin
guide:=0;
{modify system}
for i:=0 to Dim do
begin
     {choose the guide element...}
     guide:=a[i][i];
     guide_i:=i;guide_j:=i;
     for j:=i to Dim do
         for k:=i to Dim do
             if abs(a[k][j])>=abs(guide) then
                begin
                     guide:=a[k][j];
                     guide_i:=j;
                     guide_j:=k;
                end;{if}
     {!guiding elements were chosen}
     if (abs(guide)<eps) then
     begin
        LeadGauss:=-1;  {does not has a solution}
        exit;
     end;
     {Rearrangement of rows...}
     for j:=i to dim do
             begin
                  buff:=a[guide_j][j];
                  a[guide_j][j]:=a[i][j];{divide at once}
                  a[i][j]:=buff/guide;
             end;
     for j:=0 to B_col do
         begin
              buff:=b[guide_j][j];
              b[guide_j][j]:=b[i][j];
              b[i][j]:=buff/guide;
         end;
     {Rearrangement of cols...}
     for j:=0 to dim do
         begin
             buff:=a[j][i];
             a[j][i]:=a[j][guide_i];
             a[j][guide_i]:=buff;
         end;
     {Gaussian transform}
     for j:=i+1 to dim do   {j changes by hight}
         begin
            buff:=a[j][i];
            for k:=i to dim do
                a[j][k]:=a[j][k]-buff*a[i][k];
            for k:=0 to b_col do {k changes by width (by columns)}
                b[j][k]:=b[j][k]-buff*b[i][k];
         end;
     if (i=0) then
        {set markers which indicates how cols were moved}
        for j:=0 to dim do
            a[j][0]:=j;
     buff:=a[guide_i][0];      {move markers}
     a[guide_i][0]:=a[i][0];
     a[i][0]:=buff;            {markers were moved}
end;{for i}
{inverse step : extracting variables}
for i:=0 to b_col do
    for j:=dim-1 downto 0 do       {by rows}
        for k:=dim downto j+1 do   {by columns}
               b[j][i]:=b[j][i]-a[j][k]*b[k][i];
{restore initial order}
j:=0;
for i:=0 to dim do
begin
     if a[i][0]=i then
        inc(j)
     else
          for k:=0 to b_col do
          begin
               buff:=b[trunc(a[i][0])][k];
               b[trunc(a[i][0])][k]:=b[i][k];
               b[i][k]:=buff;
               a[trunc(a[i][0])][0]:=a[i][0];
          end;
end;
end;

procedure InitMatrix(var Matrix:TMatrix;dimfirst,dimsec:integer);
var i:integer;
begin
SetLength(Matrix,dimfirst);
for i:=0 to dimfirst-1 do
    Setlength(Matrix[i],dimsec);
end;

procedure CopyMatrix(Source:TMatrix;var Destination:TMatrix);
var i,j,dimfirst,dimsec:integer;
begin
dimfirst:=Length(Source);
dimsec:=Length(Source[0]);
InitMatrix(Destination,dimfirst,dimsec);
for i:=0 to dimfirst-1 do
    for j:=0 to dimsec-1 do
        Destination[i][j]:=Source[i][j];
end;

function OctahedricNorm(Matrix:TMatrix):TOutput;
var i,j:integer;
    sum,max:TOutput;
begin
Max:=0;
for i:=0 to Length(Matrix)-1 do
    Max:=Max+abs(Matrix[i][0]);
for i:=1 to Length(Matrix[0])-1 do
begin
    sum:=0;
    for j:=0 to Length(Matrix)-1 do
        sum:=sum+abs(Matrix[j][i]);
    if Sum>max then Max:=sum;
end;
Result:=max;
end;

function InfNorm(Matrix:TMatrix):TOutput;
var i,j:Integer;
    Max,sum:TOutput;
begin
Max:=0;
For i:=0 to Length(Matrix[0])-1 do
    Max:=Max+abs(Matrix[0][i]);
for i:=1 to length(Matrix)-1 do
begin
    sum:=0;
    for j:=0 to length(Matrix[0])-1 do
        sum:=sum+abs(Matrix[i][j]);
    if sum>Max then Max:=sum;
end;
Result:=max;
end;

function EuclidNorma(Matrix:TMatrix):Double;
var i,j:integer;
begin
Result:=0;
for i:=0 to length(Matrix)-1 do
   for j:=0 to length(Matrix[i])-1 do
       Result:=Result+sqr(Matrix[i][j]);
Result:=sqrt(Result);
end;

function EuclidNormaWithoutDiag(Matrix:TMatrix):double;
var i,j:Integer;
begin
Result:=0;
for i:=0 to length(Matrix)-1 do
   for j:=0 to length(Matrix[i])-1 do
     if i<>j then  Result:=Result+sqr(Matrix[i][j]);
Result:=sqrt(Result);
end;

procedure MakeUnitMatrix(var Matrix:TMatrix;dim:integer);
var i,j:integer;
begin
InitMatrix(Matrix,dim,dim);
for i:=0 to dim-1 do
 for j:=0 to dim-1 do
   if i=j then
    Matrix[i][j]:=1
   else
    Matrix[i][j]:=0;
end;

function EuclidNormaDownTri(Matrix:TMatrix):double;
var i,j,n:integer;
begin
n:=Length(Matrix);
Result:=0;
for i:=1 to n-1 do
  for j:=0 to i-1 do
     Result:=Result+sqr(Matrix[i][j]);
Result:=Sqrt(Result);
end;

procedure MatrixSubtraction(var Reduced:TMatrix;Deducted:TMatrix);
var i,j:integer;
begin
for i:=0 to Length(Reduced)-1 do
    for j:=0 to Length(Reduced[0])-1 do
        Reduced[i][j]:=Reduced[i][j]-Deducted[i][j];
end;

procedure GetInverseMatrix(A:TMatrix;var invA:TMatrix;eps:TOutput);
var cpyA:TMatrix;
    i,j:integer;
begin
SetLength(invA,length(A));
CopyMatrix(A,cpyA);
for i:=0 to length(A)-1 do
    SetLength(invA[i],length(A[0]));
for i:=0 to length(A)-1 do
    for j:=0 to Length(a)-1 do
        if i=j then
           InvA[i][j]:=1
        else InvA[i][j]:=0;
LeadGauss(cpyA,InvA,length(A)-1,Length(A)-1,eps);
end;

function Pow(number,pow:TOutput):TOutput;
var i:integer;
    tmp:TOutput;
begin
Result:=number;
if frac(pow)=0 then
   for i:=0 to trunc(pow)-1 do
       Result:=Result*number
else
    Result:=exp(pow*ln(abs(number)));
end;

procedure MultQuadMatrix(Mul,ToMul:TMatrix;var Result:TMatrix);
var
   i,j,k,l,MSize:LongInt;

  function CalcSumm(row,col:integer;qm1,qm2:TMatrix;RSize:Integer):Real;
  var
        a,b,c:LongInt;
        summ:real;
  begin{CalcSumm}
   summ:=0;
   for a:=0 to RSize do
      summ:=summ+qm1[row][a]*qm2[a][col];
   CalcSumm:=summ;
  end;{CalcSumm}

Begin{MultQuadMatrix}
mSize:=Length(Mul)-1;
  for i:=0 to MSize do
    begin
       for j:=0 to MSize do
          Result[i][j]:=CalcSumm(i,j,Mul,ToMul,MSize)
    end;{for}
End;{MultQuadMatrix}

procedure MultMatrix(M1,M2:TMatrix;var Res:Tmatrix);
var i,j,k:integer;
    s:double;
begin
//     row  col
//M1 -(n  x  m)
//	     	=> Res -(n x k)
//M2 - (m x k)
InitMatrix(Res,Length(M1),Length(M2[0]));
{SetLength(Res,Length(M1));
for i:=0 to Length(Res)-1 do
   SetLength(Res[i],Length(M2[0]));}
for i:=0 to Length(M1)-1 do
  for j:=0 to Length(M2[0])-1 do
   begin
    s:=0;
    for k:=0 to Length(M1[0])-1 do
	s:=s+M1[i][k]*M2[k][j];
    Res[i][j]:=s;
   end;
end;

procedure Transpose(A:TMatrix;var Res:TMatrix);
var i,j:integer;
    T:TMatrix;
begin
InitMatrix(T,Length(A[0]),Length(A));
for i:=0 to Length(A)-1 do
   for j:=0 to length(A[0])-1 do
      T[j][i]:=A[i][j];
CopyMatrix(T,Res);
end;

procedure AAT(A:TMatrix;var Res:TMatrix);
var i,j,k:integer;
    s:double;
    T,T2:TMatrix;
//Result:=A*A^T (A by A transposed)
begin
InitMatrix(T,Length(A[0]),Length(A));
for i:=0 to Length(A)-1 do
   for j:=0 to length(A[0])-1 do
      T[j][i]:=A[i][j];
//FreeMem(Res);
InitMatrix(Res,Length(A),Length(A));
MultMatrix(A,T,Res);
end;

procedure ZeroMatrix(A:TMatrix);
var i,j:integer;
begin
for i:=0 to length(A)-1 do
   for j:=0 to length(A[0])-1 do
   	A[i][j]:=0;
end;

end.
