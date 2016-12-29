{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Wielandt{(Dimen       : integer;
                   Mat          : TNmatrix;
               var GuessVector  : TNvector;
                   MaxEigens    : integer;
                   MaxIter      : integer;
                   Tolerance    : Float;
               var NumEigens    : integer;
               var Eigenvalues  : TNvector;
               var Eigenvectors : TNmatrix;
               var Iter         : TNIntVector;
               var Error        : byte)};

type
  LevelData = record
                Size : integer;
                ZeroPlace : integer;
                X : TNvector;
                QuasiEVecs : TNmatrix;
              end;

  Ptr = ^ QueueItem;

  QueueItem = record
                Info : LevelData;
                Next : Ptr;
              end;

  Queue = record
            Front : Ptr;
            Back : Ptr;
          end;

var
  TransformInfo : Queue;
  Data : LevelData;

procedure InitializeQueue(var TransformInfo : Queue);
begin
  TransformInfo.Front := nil;
  TransformInfo.Back := nil;
end; { procedure InitializeQueue }

procedure InsertQueue(var Data          : LevelData;
                      var TransformInfo : Queue);

{----------------------------------}
{- Input: Data, TransformInfo     -}
{- Output: TransformInfo          -}
{-                                -}
{- Insert Data onto back of Queue -}
{----------------------------------}

var
  NewNode : Ptr;

begin
  New(NewNode);
  NewNode^.Info := Data;
  NewNode^.Next := nil;
  if TransformInfo.Back = nil then
    TransformInfo.Front := NewNode
  else
    TransformInfo.Back^.Next := NewNode;
  TransformInfo.Back := NewNode;
end; { procedure InsertQueue }

procedure RemoveQueue(var Data          : LevelData;
                      var TransformInfo : Queue);

{---------------------------------}
{- Input: TransformInfo          -}
{- Output: Data, TransformInfo   -}
{-                               -}
{- Remove Data from the front    -}
{- of the queue.                 -}
{---------------------------------}

var
  OldNode : Ptr;

begin
  OldNode := TransformInfo.Front;
  TransformInfo.Front := OldNode^.Next;
  Data := OldNode^.Info;
  if TransformInfo.Front = nil then
    TransformInfo.Back := nil;
  Dispose(OldNode);
end; { procedure RemoveQueue }

procedure FindLargest(Dimen : integer;
                  var Vec   : TNvector;
                  var Posit : integer);

{---------------------------------------}
{- Input: Dimen, Vec                   -}
{- Output: Posit                       -}
{-                                     -}
{- This procedure searches Vec for the -}
{- element of largest absolute value.  -}
{- The position of the largest element -}
{- is returned.                        -}
{---------------------------------------}

var
  Term : integer;
  Largest : Float;

begin
  Largest := Vec[1];
  Posit := 1;
  for Term := 2 to Dimen do
    if ABS(Vec[Term]) > ABS(Largest) then
    begin
      Largest := Vec[Term];
      Posit := Term;
    end;
end; { procedure FindLargest }

procedure DivVecConst(Dimen   : integer;
                      Divisor : Float;
                  var Vec     : TNvector;
                  var Result  : TNvector);

{-----------------------------------}
{- Input: Dimen, Divisor, Vec      -}
{- Output: Result                  -}
{-                                 -}
{- Divide a vector by a constant   -}
{-----------------------------------}

var
  Term : integer;

begin
  for Term := 1 to Dimen do
    Result[Term] := Vec[Term] / Divisor;
end; { procedure DivVecConst }

procedure CrossProduct(Dimen  : integer;
                   var Vec1   : TNvector;
                   var Vec2   : TNvector;
                   var Result : TNmatrix);

{------------------------------------------}
{- Input: Dimen, Vec1, Vec2               -}
{- Output: Result                         -}
{-                                        -}
{- Multiply two vectors to yield a matrix -}
{------------------------------------------}

var
  Row, Column : integer;

begin
  for Row := 1 to Dimen do
    for Column := 1 to Dimen do
      Result[Row, Column] := Vec1[Row] * Vec2[Column];
end; { procedure  CrossProduct }

function DotProduct(Dimen : integer;
                var Vec1  : TNvector;
                var Vec2  : TNvector) : Float;

{--------------------------------------------}
{- Input: Dimen, Vec1, Vec2                 -}
{- Output: DotProduct                       -}
{-                                          -}
{- Calculate the dot product of two vectors -}
{--------------------------------------------}

var
  Row : integer;
  Result : Float;

begin
  Result := 0;
  for Row := 1 to Dimen do
    Result := Result + Vec1[Row] * Vec2[Row];
  DotProduct := Result;
end; { procedure DotProduct }

{-----------------------------------------------------------------------}

procedure Power(Dimen       : integer;
            var Mat         : TNmatrix;
            var GuessVector : TNvector;
                MaxIter     : integer;
                Tolerance   : Float;
            var Eigenvalue  : Float;
            var Eigenvector : TNvector;
            var Iter        : integer;
            var Error       : byte);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-              Input:  Dimen, Mat, GuessVector, MaxIter, Tolerance         -}
{-             Output:  Eigenvalue, Eigenvector, Iter, Error                -}
{-                                                                          -}
{-            Purpose:  The power method approximates the dominant          -}
{-                      eigenvalue of a matrix.  The dominant               -}
{-                      eigenvalue is the eigenvalue of largest             -}
{-                      absolute magnitude. Given a square matrix Mat       -}
{-                      and an arbitrary vector OldApprox, the vector       -}
{-                      NewApprox is constructed by the matrix              -}
{-                      operation NewApprox = Mat - OldApprox .             -}
{-                      NewApprox is divided by its largest element         -}
{-                      ApproxEigenval, thereby normalizing                 -}
{-                      NewApprox. If NewApprox is the same as              -}
{-                      OldApprox then ApproxEigenval is the dominant       -}
{-                      eigenvalue and NewApprox is the associated          -}
{-                      eigenvector of the matrix Mat. If NewApprox         -}
{-                      is not the same as OldApprox then OldApprox         -}
{-                      is set equal to NewApprox and the operation         -}
{-                      repeats until a solution is reached. Aitken's       -}
{-                      delta-squared acceleration is used to speed         -}
{-                      the convergence from linear to quadratic.           -}
{-                                                                          -}
{- User-defined Types:  TNvector = array[1..TNArraySize] of real;           -}
{-                      TNmatrix = array[1..TNArraySize] of TNvector;       -}
{-                                                                          -}
{-   Global Variables:  Dimen       : integer;  Dimension of the matrix     -}
{-                      Mat         : TNmatrix; The matrix                  -}
{-                      GuessVector : TNvector; An initial guess of an      -}
{-                                              eigenvector                 -}
{-                      MaxIter     : integer;  Max. number of iterations   -}
{-                      Tolerance   : real;     Tolerance in answer         -}
{-                      Eigenvalue  : real;     Eigenvalue of the matrix    -}
{-                      Eigenvector : TNvector; Eigenvector of the matrix   -}
{-                      Iter        : integer;  Number of iterations        -}
{-                      Error       : byte;     Flags if something goes     -}
{-                                              wrong                       -}
{-             Errors:  0: No Errors                                        -}
{-                      1: Dimen < 2                                        -}
{-                      2: Tolerance <= 0                                   -}
{-                      3: MaxIter < 1                                      -}
{-                      4: Iter >= MaxIter                                  -}
{-                                                                          -}
{----------------------------------------------------------------------------}

type
  TNThreeMatrix = array[0..2] of TNvector;

var
  OldApprox, NewApprox : TNvector;     { Iteration variables }
  ApproxEigenval : Float;               { Iteration variables }
  AitkenVector : TNThreeMatrix;
  Remainder : integer;
  Found : boolean;
  Index : integer;
  Denom : Float;

procedure Initialize(var GuessVector    : TNvector;
                     var Iter           : integer;
                     var OldApprox      : TNvector;
                     var AitkenVector   : TNThreeMatrix;
                     var ApproxEigenval : Float;
                     var Found          : boolean);

{----------------------------------------------------------}
{- Input: GuessVector                                     -}
{- Output: Iter, OldApprox, AitkenVector, ApproxEigenval  -}
{-         Found                                          -}
{-                                                        -}
{- This procedure initializes the variables.  OldApprox   -}
{- is initialized to be the user's input GuessVector.     -}
{----------------------------------------------------------}

begin
  Iter := 0;
  OldApprox := GuessVector;
  FillChar(AitkenVector, SizeOf(AitkenVector), 0);
  ApproxEigenval := 0;
  Found := false;
end; { procedure Initialize }

procedure TestData(Dimen       : integer;
               var Mat         : TNmatrix;
               var GuessVector : TNvector;
                   Tolerance   : Float;
                   MaxIter     : integer;
               var Eigenvalue  : Float;
               var Eigenvector : TNvector;
               var Found       : boolean;
               var Error       : byte);

{---------------------------------------------------------}
{- Input: Dimen, Mat, GuessVector, Tolerance, MaxIter    -}
{- Output: GuessVector, Eigenvalue, Eigenvector          -}
{-         Found, Error                                  -}
{-                                                       -}
{- This procedure tests the input data for errors        -}
{- If all the elements of the GuessVector are zero, then -}
{- they are all replaced by ones.                        -}
{- If the dimension of the matrix is one, then the       -}
{- eigenvalue is equal to the matrix.                    -}
{---------------------------------------------------------}

var
  Term : integer;
  Sum : Float;

begin
  Error := 0;
  Sum := 0;
  for Term := 1 to Dimen do
    Sum := Sum + Sqr(GuessVector[Term]);
  if Sum < TNNearlyZero then { the GuessVector is the zero vector }
    for Term := 1 to Dimen do
      GuessVector[Term] := 1;
  if Dimen < 1 then
    Error := 1;
  if Tolerance <= 0 then
    Error := 2;
  if MaxIter < 1 then
    Error := 3;
  if Dimen = 1 then
  begin
    Eigenvalue := Mat[1, 1];
    Eigenvector := GuessVector;
    Found := true;
  end;
end; { procedure TestData }

procedure FindLargest(Dimen   : integer;
                  var Vec     : TNvector;
                  var Largest : Float);

{---------------------------------------}
{- Input: Dimen, Vec                   -}
{- Output: Largest                     -}
{-                                     -}
{- This procedure searches Vec for the -}
{- element of largest absolute value.  -}
{---------------------------------------}

var
  Term : integer;

begin
  Largest := Vec[Dimen];
  for Term := Dimen - 1 downto 1 do
    if ABS(Vec[Term]) > ABS(Largest) then
      Largest := Vec[Term];
end; { procedure FindLargest }

procedure Div_Vec_Const(Dimen   : integer;
                    var Vec     : TNvector;
                        Divisor : Float);

{----------------------------------------------}
{- Input: Dimen, Vec, Divisor                 -}
{- Output: Vec                                -}
{-                                            -}
{- This procedure divides each element        -}
{- of the vector Vec by the constant Divisor. -}
{----------------------------------------------}

var
  Term : integer;

begin
  for Term := 1 to Dimen do
    Vec[Term] := Vec[Term] / Divisor;
end; { procedure Div_Vec_Const }

procedure Mult_Mat_Vec(Dimen  : integer;
                   var Mat    : TNmatrix;
                   var Vec    : TNvector;
                   var Result : TNvector);

{----------------------------------------}
{- Input: Dimen, Mat, Vec               -}
{- Output: Result                       -}
{-                                      -}
{- Multiply a vector by a square matrix -}
{----------------------------------------}

var
  Row, Column : integer;
  Entry : Float;

begin
  for Row := 1 to Dimen do
  begin
    Entry := 0;
    for Column := 1 to Dimen do
      Entry := Entry + Mat[Row, Column] * Vec[Column];
    Result[Row] := Entry;
  end;
end; { procedure Mult_Mat_Vec }


procedure TestForConvergence(Dimen     : integer;
                         var OldApprox : TNvector;
                         var NewApprox : TNvector;
                             Tolerance : Float;
                         var Found     : boolean);

{-----------------------------------------------------------------}
{- Input: Dimen, OldApprox, NewApprox, Tolerance,                -}
{- Output: Found                                                 -}
{-                                                               -}
{- This procedure determines if the iterations have converged.   -}
{- on a solution.  If the absolute difference in EACH element of -}
{- the eigenvector between the last two iterations (i.e. between -}
{- OldApprox and NewApprox) is less than Tolerance, then         -}
{- convergence has occurred and Found = true.  Otherwise,        -}
{- Found = false.                                                -}
{-----------------------------------------------------------------}

var
  Index : integer;

begin
  Index := 0;
  Found := true;
  while (Found = true) and (Index < Dimen) do
  begin
    Index := Succ(Index);
    if ABS(OldApprox[Index] - NewApprox[Index]) > Tolerance then
      Found := false;
  end;
end; { procedure TestForConvergence }

begin  { procedure Power }
  Initialize(GuessVector, Iter, OldApprox, AitkenVector,
             ApproxEigenval, Found);
  TestData(Dimen, Mat, GuessVector, Tolerance, MaxIter,
           Eigenvalue, Eigenvector, Found, Error);
  if (Error = 0) and (Found = false) then
  begin
    FindLargest(Dimen, OldApprox, ApproxEigenval);
    Div_Vec_Const(Dimen, OldApprox, ApproxEigenval);
    while (Iter < MaxIter) and not Found do
    begin
      Iter := Succ(Iter);
      Remainder := Iter MOD 3;
      if Remainder = 0 then { Use Aitken's acceleration algorithm to  }
                            { generate the next iterate approximation }
      begin
        OldApprox := AitkenVector[0];
        for Index := 1 to Dimen do
        begin
          Denom := AitkenVector[2, Index] - 2 * AitkenVector[1, Index] +
                   AitkenVector[0, Index];
          if ABS(Denom) > TNNearlyZero then
            OldApprox[Index] := AitkenVector[0, Index] -
                                Sqr(AitkenVector[1, Index] -
                                AitkenVector[0, Index]) / Denom;
        end;
      end;
      { Use the power method to generate }
      { the next iterate approximation   }
      Mult_Mat_Vec(Dimen, Mat, OldApprox, NewApprox);
      FindLargest(Dimen, NewApprox, ApproxEigenval);
      if ABS(ApproxEigenval) < TNNearlyZero then
        begin
          ApproxEigenval := 0;
          Found := true;
        end
      else
        begin
          Div_Vec_Const(Dimen, NewApprox, ApproxEigenval);
          TestForConvergence(Dimen, OldApprox, NewApprox, Tolerance, Found);
          OldApprox := NewApprox;
        end;
      AitkenVector[Remainder] := NewApprox;
    end; { while }
    Eigenvector := OldApprox;
    Eigenvalue := ApproxEigenval;
    if Iter >= MaxIter then
      Error := 4;
  end;
end; { procedure Power }
{-----------------------------------------------------------------------}

procedure TestDataAndInitialize(Dimen         : integer;
                            var Mat           : TNmatrix;
                            var GuessVector   : TNvector;
                                Tolerance     : Float;
                                MaxEigens     : integer;
                                MaxIter       : integer;
                            var NumEigens     : integer;
                            var Eigenvalue    : TNvector;
                            var Eigenvector   : TNmatrix;
                            var TransformInfo : Queue;
                            var Iter          : TNIntVector;
                            var Data          : LevelData;
                            var Error         : byte);

{--------------------------------------------------}
{- Input: Dimen, GuessVector, Tolerance,          -}
{-        MaxEigens, MaxIter                      -}
{- Output: GuessVector, NumEigens, Eigenvalue,    -}
{-         Eigenvector, TransformInfo, Iter,      -}
{-         Data, Error                            -}
{-                                                -}
{- This procedure initializes variable and tests  -}
{- the input data for errors.                     -}
{- If all the elements of the GuessVector are     -}
{- zero, then they are all replaced by ones.      -}
{- If the dimension of the matrix is one, then    -}
{- the eigenvalue is equal to the matrix.         -}
{--------------------------------------------------}

var
  Term : integer;
  Sum : Float;

begin
  Error := 0;
  Sum := 0;
  for Term := 1 to Dimen do
    Sum := Sum + Sqr(GuessVector[Term]);
  if Sum < TNNearlyZero then  { The GuessVector is the zero vector  }
                              { change all the elements to one.     }
    for Term := 1 to Dimen do
      GuessVector[Term] := 1;
  if Tolerance <= 0 then
    Error := 2;
  if MaxIter < 1 then
    Error := 3;
  if (MaxEigens < 1) or (MaxEigens > Dimen) then
    Error := 4;
  if Dimen < 1 then
    Error := 1;
  if Error = 0 then
  begin
    InitializeQueue(TransformInfo);
    FillChar(Iter, SizeOf(Iter), 0);
    FillChar(Data, SizeOf(Data), 0);
    NumEigens := 0;
  end;
  if Dimen = 1 then
  begin
    Eigenvalue[1] := Mat[1, 1];
    Eigenvector[1, 1] := 1;
    NumEigens := 1;
  end;
end; { procedure TestDataAndInitialize }

procedure ConstructX(Size        : integer;
                 var Mat         : TNmatrix;
                 var Eigenvector : TNvector;
                 var ZeroPlace   : integer;
                 var X           : TNvector);

{---------------------------------------------------------}
{- Input: Size, Mat, Eigenvector                         -}
{- Output: ZeroPlace, X                                  -}
{-                                                       -}
{- This procedure creates the vector X.  The formula is: -}
{-   X := Mat[ZeroPlace]/Eigenvector[ZeroPlace]          -}
{- where ZeroPlace is the Index of the largest element   -}
{- in Eigenvector.                                       -}
{---------------------------------------------------------}

begin
  { ZeroPlace is the position of the largest element. }
  FindLargest(Size, Eigenvector, ZeroPlace);
  DivVecConst(Size, Eigenvector[ZeroPlace], Mat[ZeroPlace], X);
end; { procedure ConstructX }

procedure MakeMatrix(Size        : integer;
                 var Mat         : TNmatrix;
                 var Eigenvector : TNvector;
                     ZeroPlace   : integer;
                 var X           : TNvector);

{-----------------------------------------------------------}
{- Input: Size, Mat, Eigenvector, ZeroPlace, X             -}
{- Output: Mat                                             -}
{-                                                         -}
{- This procedure changes the matrix Mat.  The formula is  -}
{-    Mat := Mat - (Eigenvector # X)                       -}
{- where the # represents a cross product.                 -}
{- Then the ZeroPlace row and column are deleted from the  -}
{- matrix.                                                 -}
{-----------------------------------------------------------}

var
  Row, Column : integer;
  TempMatrix : TNmatrix;

begin
  CrossProduct(Size, Eigenvector, X, TempMatrix);
  for Row := 1 to ZeroPlace - 1 do
    for Column := 1 to ZeroPlace - 1 do
      Mat[Row, Column] := Mat[Row, Column] - TempMatrix[Row, Column];
  for Row := 1 to ZeroPlace - 1 do
    for Column := ZeroPlace to Size - 1 do
      Mat[Row, Column] := Mat[Row, Column + 1] - TempMatrix[Row, Column + 1];
  for Row := ZeroPlace to Size - 1 do
    for Column := 1 to ZeroPlace - 1 do
      Mat[Row, Column] := Mat[Row + 1, Column] - TempMatrix[Row + 1, Column];
  for Row := ZeroPlace to Size - 1 do
    for Column := ZeroPlace to Size - 1 do
      Mat[Row, Column] := Mat[Row + 1, Column + 1]
                          - TempMatrix[Row + 1, Column + 1];
end; { procedure MakeMatrix }

procedure InsertZero(Size        : integer;
                 var Eigenvector : TNvector;
                     ZeroPlace   : integer;
                 var TempVector  : TNvector);

{----------------------------------------------------}
{- Input: Size, Eigenvector, ZeroPlace              -}
{- Output: TempVector                               -}
{-                                                  -}
{- This procedure inserts a zero into the ZeroPlace -}
{- element of Eigenvector.  The resulting vector is -}
{- returned in TempVector.                          -}
{----------------------------------------------------}

var
  Index : integer;

begin
  TempVector := Eigenvector;
  for Index := Size - 1 downto ZeroPlace do
    TempVector[Index + 1] := Eigenvector[Index];
  TempVector[ZeroPlace] := 0;
end; { procedure InsertZero }

procedure MakeNewVec(Size         : integer;
                     Eigenval1    : Float;
                     Eigenval2    : Float;
                 var TempVec      : TNvector;
                 var X            : TNvector;
                 var OldQuasiEVec : TNvector;
                 var NewQuasiEVec : TNvector);

{---------------------------------------------------------------}
{- Input: Size, Eigenval1, Eigenval2, TempVec, X, OldQuasiEVec -}
{- Output: NewQuasiEVec                                        -}
{-                                                             -}
{- This procedure transforms the TempVec into NewQuasiEVec.    -}
{- The formula is:                                             -}
{-   NewQuasiEVec = (Eigenval1 - Eigenval2) - TempVec          -}
{-                  + X,TempVec - OldQuasiEVec                 -}
{- where X,TempVec is the dot product of X and TempVec.        -}
{---------------------------------------------------------------}

var
  Difference, Multiplier : Float;
  Index : integer;

begin
  Difference := Eigenval1 - Eigenval2;
  Multiplier := DotProduct(Size, X, TempVec);
  for Index := 1 to Size do
    NewQuasiEVec[Index] := Difference * TempVec[Index]
                           + Multiplier * OldQuasiEVec[Index];
end; { procedure MakeNewVec }

procedure TransformThroughLevels(NumEigens     : integer;
                             var Data          : LevelData;
                             var TransformInfo : Queue;
                             var Eigenvalues   : TNvector);
var
  Index : integer;             { A counter }
  Data1, Data2 : LevelData;    { Data1 is data from a level one }
                               { higher than Data2.  Information }
                               { from Data2 is transformed for Data1 }
  TempVec : TNvector;          { A temporary vector used in calculations }

begin
  Data2 := Data;
  for Index := NumEigens - 1 downto 1 do
  begin
    RemoveQueue(Data1, TransformInfo);
    InsertZero(Data1.Size, Data2.QuasiEVecs[NumEigens],
               Data1.ZeroPlace, TempVec);
    MakeNewVec(Data1.Size, Eigenvalues[NumEigens], Eigenvalues[Index],
               TempVec, Data1.X, Data1.QuasiEVecs[Index],
               Data1.QuasiEVecs[NumEigens]);
    InsertQueue(Data2, TransformInfo);
    Data2 := Data1;
  end;
  InsertQueue(Data2, TransformInfo);
end; { procedure TransformThroughLevels }

procedure FindLastTwoEigens(Dimen         : integer;
                        var NumEigens     : integer;
                        var Mat           : TNmatrix;
                        var Eigenvalues   : TNvector;
                        var Data          : LevelData;
                        var TransformInfo : Queue;
                        var Error         : byte);

{--------------------------------------------------------------------}
{- Input: Dimen, NumEigens, Mat, Eigenvalues                        -}
{- Output: NumEigens, Data, TransformInfo                           -}
{-                                                                  -}
{- This procedure approximates the last eigenvalue/vector.  The     -}
{- matrix Mat will be a two by two.  The last eigenvalue will       -}
{- be the trace of the matrix Mat minus the second to last          -}
{- eigenvalue (since the sum of the eigenvalues of a matrix is      -}
{- the trace). The first element of the eigenvector is arbitrarily  -}
{- made 1 (eigenvectors are only defined to a multiplicative        -}
{- constant) and the second element is simply computed.  This       -}
{- eigenvector of Mat is then transformed to an eigenvector of the  -}
{- original matrix through the procedure TransformThroughLevels.    -}
{--------------------------------------------------------------------}

var
  A, B, C : Float;
  Root1, Root2 : Float;

procedure QuadraticFormula(A     : Float;
                           B     : Float;
                           C     : Float;
                       var Root1 : Float;
                       var Root2 : Float;
                       var Error : byte);

var
  Discrim : Float;

begin
  Discrim := Sqr(B) - 4*A*C;
  if Discrim < -TNNearlyZero then
    Error := 6       { No real roots }
  else
    if ABS(Discrim) < TNNearlyZero then  { Identical roots }
      begin
        Root1 := -B / (2 * A);
        Root2 := Root1;
      end
    else
      begin
        Root1 := (-B - Sqrt(Discrim)) / (2 * A);
        Root2 := -B / A - Root1;
      end;
end; { procedure QuadraticFactor }

begin  { procedure FindLastTwoEigens }
  if (ABS(Mat[1, 2]) < TNNearlyZero) or (ABS(Mat[2, 1]) < TNNearlyZero) then
    { zero on the off diagonal }
    with Data do
    begin
      NumEigens := Dimen - 1;
      Size := 2;
      if (ABS(Mat[1, 2]) < TNNearlyZero) and
         (ABS(Mat[2, 1]) < TNNearlyZero) then
        { Zero's on both off diagonals; distinct }
        { eigenvectors; possibly distinct eigenvalues }
        begin
          Eigenvalues[NumEigens] := Mat[2, 2];
          QuasiEVecs[NumEigens, 1] := 0;
          QuasiEVecs[NumEigens, 2] := 1;
          Eigenvalues[NumEigens + 1] := Mat[1, 1];
          QuasiEVecs[NumEigens + 1, 1] := 1;
          QuasiEVecs[NumEigens + 1, 2] := 0;
        end
      else
        { Only one zero on off diagonal }
        if ABS(Mat[1, 2]) < TNNearlyZero then
          begin
            Eigenvalues[NumEigens] := Mat[2, 2];
            QuasiEVecs[NumEigens, 1] := 0;
            QuasiEVecs[NumEigens, 2] := 1;
            Eigenvalues[NumEigens + 1] := Mat[1, 1];
            if ABS(Mat[1, 1] - Mat[2, 2]) < TNNearlyZero then
              { Degenerate eigenvalues/vectors }
              QuasiEVecs[NumEigens + 1] := QuasiEVecs[NumEigens]
            else
              { Distinct eigenvalues/vectors }
              begin
                QuasiEVecs[NumEigens + 1, 1] := 1;
                QuasiEVecs[NumEigens + 1, 2] := Mat[2, 1] /
                                                (Mat[1, 1] - Mat[2, 2]);
              end;
          end
        else
          { ABS(Mat[2, 1]) < TNNearlyZero }
          begin
            Eigenvalues[NumEigens] := Mat[1, 1];
            QuasiEVecs[NumEigens, 1] := 1;
            QuasiEVecs[NumEigens, 2] := 0;
            Eigenvalues[NumEigens + 1] := Mat[2, 2];
            if ABS(Mat[1, 1] - Mat[2, 2]) < TNNearlyZero then
              { Degenerate eigenvalues/vectors }
              QuasiEVecs[NumEigens + 1] := QuasiEVecs[NumEigens]
            else
              { Distinct eigenvalues/vectors }
              begin
                QuasiEVecs[NumEigens + 1, 2] := 1;
                QuasiEVecs[NumEigens + 1, 1] := Mat[1, 2] / (Mat[2, 2] - Mat[1, 1]);
              end;
          end;
      ConstructX(Size, Mat, QuasiEVecs[NumEigens], ZeroPlace, X);
      TransformThroughLevels(NumEigens, Data, TransformInfo, Eigenvalues);
      NumEigens := Dimen;
      TransformThroughLevels(NumEigens, Data, TransformInfo, Eigenvalues);
    end
  else   { no zero's on the off diagonal }
    begin
      A := 1;
      B := -(Mat[1, 1] + Mat[2, 2]);
      C := Mat[1, 1] * Mat[2, 2] - Mat[1, 2] * Mat[2, 1];
      QuadraticFormula(A, B, C, Root1, Root2, Error);
      if Error = 0 then
      with Data do
      begin
        NumEigens := Dimen - 1;
        Size := 2;
        Eigenvalues[NumEigens] := Root1;
        QuasiEVecs[NumEigens, 1] := 1;
        QuasiEVecs[NumEigens, 2] := (Eigenvalues[NumEigens]
                                    - Mat[1, 1]) / Mat[1, 2];
        Eigenvalues[NumEigens + 1] := Root2;
        QuasiEVecs[NumEigens + 1, 1] := 1;
        QuasiEVecs[NumEigens + 1, 2] := (Eigenvalues[NumEigens + 1]
                                        - Mat[1, 1]) / Mat[1, 2];
        ConstructX(Size, Mat, QuasiEVecs[NumEigens], ZeroPlace, X);
        TransformThroughLevels(NumEigens, Data, TransformInfo, Eigenvalues);
        NumEigens := Dimen;
        TransformThroughLevels(NumEigens, Data, TransformInfo, Eigenvalues);
      end; { with }
    end;
end; { procedure FindLastTwoEigens }

procedure NormalizeEigenvectors(Dimen         : integer;
                                NumEigens     : integer;
                            var TransformInfo : Queue;
                            var Eigenvectors  : TNmatrix);

{--------------------------------------------------------}
{- Input: Dimen, NumEigens, TransformInfo, Eigenvectors -}
{- Output: Eigenvectors                                 -}
{-                                                      -}
{- This procedure normalizes the eigenvectors so that   -}
{- the element of largest absolute value equals 1.      -}
{--------------------------------------------------------}

var
  Index : integer;
  Data : LevelData;
  Posit : integer;

begin
  { The eigenvectors are the }
  { QuasiEVecs of the last Data }
  { removed from the queue. }
  for Index := 1 to NumEigens do
    RemoveQueue(Data, TransformInfo);
  Eigenvectors := Data.QuasiEVecs;
  for Index := 1 to NumEigens do
  begin
    FindLargest(Dimen, Eigenvectors[Index], Posit);
    if ABS(Eigenvectors[Index, Posit]) > TNNearlyZero then
      DivVecConst(Dimen, Eigenvectors[Index, Posit],
                  Eigenvectors[Index], Eigenvectors[Index]);
  end;
end; { procedure NormalizeEigenvectors }

begin { procedure Wielandt }
  TestDataAndInitialize(Dimen, Mat, GuessVector, Tolerance,
                        MaxEigens, MaxIter, NumEigens, Eigenvalues,
                        Eigenvectors, TransformInfo, Iter, Data, Error);
  if (Error = 0) and (Dimen > 1) then
  begin
    with Data do
    while (NumEigens < Dimen - 2) and (NumEigens < MaxEigens) and (Error = 0) do
    begin
      NumEigens := Succ(NumEigens);
      Size := Dimen - (NumEigens - 1);
      Power(Size, Mat, GuessVector, MaxIter,Tolerance, Eigenvalues[NumEigens],
            QuasiEVecs[NumEigens], Iter[NumEigens], Error);
      ConstructX(Size, Mat, QuasiEVecs[NumEigens], ZeroPlace, X);
      if Size > 2 then
        MakeMatrix(Size, Mat, QuasiEVecs[NumEigens], ZeroPlace, X);
      TransformThroughLevels(NumEigens, Data, TransformInfo, Eigenvalues);
    end; { while }
    if Error > 0 then
      Error := 5     { The Error returned from Power means an }
                     { eigen wasn't calculated, but the Error }
                     { code may not be 5.                     }
    else
      if (NumEigens = Dimen - 2) and (NumEigens < MaxEigens) then
        { Then NumEigens = Dimen - 2 and the      }
        { last two eigenvectors can be calculated }
        FindLastTwoEigens(Dimen, NumEigens, Mat, Eigenvalues,
                          Data, TransformInfo, Error);
    NormalizeEigenvectors(Dimen, NumEigens, TransformInfo, Eigenvectors);
  end
end; { procedure Wielandt }

procedure Jacobi{(Dimen       : integer;
                 Mat          : TNmatrix;
                 MaxIter      : integer;
                 Tolerance    : Float;
             var Eigenvalues  : TNvector;
             var Eigenvectors : TNmatrix;
             var Iter         : integer;
             var Error        : byte)};

var
  Row, Column, Diag : integer;
  SinTheta, CosTheta : Float;
  SumSquareDiag : Float;
  Done : boolean;

procedure TestData(Dimen     : integer;
               var Mat       : TNmatrix;
                   MaxIter   : integer;
                   Tolerance : Float;
               var Error     : byte);

{---------------------------------------------------}
{- Input: Dimen, Mat, MaxIter, Tolerance           -}
{- Output: Error                                   -}
{-                                                 -}
{- This procedure tests the input data for errors. -}
{---------------------------------------------------}

var
  Row, Column : integer;

begin
  Error := 0;
  if Dimen < 1 then
    Error := 1;
  if Tolerance <= TNNearlyZero then
    Error := 2;
  if MaxIter < 1 then
    Error := 3;
  if Error = 0 then
    for Row := 1 to Dimen - 1 do
      for Column := Row + 1 to Dimen do
        if ABS(Mat[Row, Column] - Mat[Column, Row]) > TNNearlyZero then
          Error := 4;  { Matrix not symmetric }
end; { procedure TestData }

procedure Initialize(Dimen        : integer;
                 var Iter         : integer;
                 var Eigenvectors : TNmatrix);

{--------------------------------------------}
{- Input: Dimen                             -}
{- Output: Iter, Eigenvectors               -}
{-                                          -}
{- This procedure initializes Iter to zero  -}
{- and Eigenvectors to the identity matrix. -}
{--------------------------------------------}

var
  Diag : integer;

begin
  Iter := 0;
  FillChar(Eigenvectors, SizeOf(Eigenvectors), 0);
  for Diag := 1 to Dimen do
    Eigenvectors[Diag, Diag] := 1;
end; { procedure Initialize }

procedure CalculateRotation(RowRow   : Float;
                            RowCol   : Float;
                            ColCol   : Float;
                        var SinTheta : Float;
                        var CosTheta : Float);


{-----------------------------------------------------------}
{- Input: RowRow, RowCol, ColCol                           -}
{- Output: SinTheta, CosTheta                              -}
{-                                                         -}
{- This procedure calculates the sine and cosine of the    -}
{- angle Theta through which to rotate the matrix Mat.     -}
{- Given the tangent of 2-Theta, the tangent of Theta can  -}
{- be calculated with the quadratic formula.  The cosine   -}
{- and sine are easily calculable from the tangent. The    -}
{- rotation must be such that the Row, Column element is   -}
{- zero. RowRow is the Row,Row element; RowCol is the      -}
{- Row,Column element; ColCol is the Column,Column element -}
{- of Mat.                                                 -}
{-----------------------------------------------------------}

var
  TangentTwoTheta, TangentTheta, Dummy : Float;

begin
  if ABS(RowRow - ColCol) > TNNearlyZero then
    begin
      TangentTwoTheta := (RowRow - ColCol) / (2 * RowCol);
      Dummy := Sqrt(Sqr(TangentTwoTheta) + 1);
      if TangentTwoTheta < 0 then  { Choose the root nearer to zero }
        TangentTheta := -TangentTwoTheta - Dummy
      else
        TangentTheta := -TangentTwoTheta + Dummy;
      CosTheta := 1 / Sqrt(1 + Sqr(TangentTheta));
      SinTheta := CosTheta * TangentTheta;
    end
  else
    begin
      CosTheta := Sqrt(1/2);
      if RowCol < 0 then
        SinTheta := -Sqrt(1/2)
      else
        SinTheta := Sqrt(1/2);
    end;
end; { procedure CalculateRotation }

procedure RotateMatrix(Dimen    : integer;
                       SinTheta : Float;
                       CosTheta : Float;
                       Row      : integer;
                       Col      : integer;
                   var Mat      : TNmatrix);

{--------------------------------------------------------------}
{- Input: Dimen, SinTheta, CosTheta, Row, Col                 -}
{- Output: Mat                                                -}
{-                                                            -}
{- This procedure rotates the matrix Mat through an angle     -}
{- Theta.  The rotation matrix is the identity matrix execept -}
{- for the Row,Row; Row,Col; Col,Col; and Col,Row elements.   -}
{- The rotation will make the Row,Col element of Mat          -}
{- to be zero.                                                -}
{--------------------------------------------------------------}

var
  CosSqr, SinSqr, SinCos : Float;
  MatRowRow, MatColCol, MatRowCol, MatRowIndex, MatColIndex : Float;

  Index : integer;

begin
  CosSqr := Sqr(CosTheta);
  SinSqr := Sqr(SinTheta);
  SinCos := SinTheta * CosTheta;
  MatRowRow := Mat[Row, Row] * CosSqr + 2 * Mat[Row, Col] * SinCos +
               Mat[Col, Col] * SinSqr;
  MatColCol := Mat[Row, Row] * SinSqr - 2 * Mat[Row, Col] * SinCos +
               Mat[Col, Col] * CosSqr;
  MatRowCol := (Mat[Col, Col] - Mat[Row, Row]) * SinCos +
               Mat[Row, Col] * (CosSqr - SinSqr);

  for Index := 1 to Dimen do
    if not(Index in [Row, Col]) then
    begin
      MatRowIndex := Mat[Row, Index] * CosTheta +
                     Mat[Col, Index] * SinTheta;
      MatColIndex := -Mat[Row, Index] * SinTheta +
                      Mat[Col, Index] * CosTheta;
      Mat[Row, Index] := MatRowIndex;
      Mat[Index, Row] := MatRowIndex;
      Mat[Col, Index] := MatColIndex;
      Mat[Index, Col] := MatColIndex;
    end;
  Mat[Row, Row] := MatRowRow;
  Mat[Col, Col] := MatColCol;
  Mat[Row, Col] := MatRowCol;
  Mat[Col, Row] := MatRowCol;
end; { procedure RotateMatrix }

procedure RotateEigenvectors(Dimen        : integer;
                             SinTheta     : Float;
                             CosTheta     : Float;
                             Row          : integer;
                             Col          : integer;
                         var Eigenvectors : TNmatrix);

{--------------------------------------------------------------}
{- Input: Dimen, SinTheta, CosTheta, Row, Col                 -}
{- Output: Eigenvectors                                       -}
{-                                                            -}
{- This procedure rotates the Eigenvectors matrix through an  -}
{- angle Theta.  The rotation matrix is the identity matrix   -}
{- except for the Row,Row; Row,Col; Col,Col; and Col,Row      -}
{- elements.  The Eigenvectors matrix will be the product of  -}
{- all the rotation matrices which operate on Mat.            -}
{--------------------------------------------------------------}

var
  EigenvectorsRowIndex, EigenvectorsColIndex : Float;

  Index : integer;

begin
  { Transform eigenvector matrix }
  for Index := 1 to  Dimen do
  begin
    EigenvectorsRowIndex := CosTheta * Eigenvectors[Row, Index] +
                            SinTheta * Eigenvectors[Col, Index];
    EigenvectorsColIndex := -SinTheta * Eigenvectors[Row, Index] +
                             CosTheta * Eigenvectors[Col, Index];
    Eigenvectors[Row, Index] := EigenvectorsRowIndex;
    Eigenvectors[Col, Index] := EigenvectorsColIndex;
  end;
end; { procedure RotateEigenvectors }

procedure NormalizeEigenvectors(Dimen        : integer;
                            var Eigenvectors : TNmatrix);

{---------------------------------------------------}
{- Input: Dimen, Eigenvectors                      -}
{- Output: Eigenvectors                            -}
{-                                                 -}
{- This procedure normalizes the eigenvectors so   -}
{- that the largest element in each vector is one. -}
{---------------------------------------------------}

var
  Row : integer;
  Largest : Float;

procedure FindLargest(Dimen       : integer;
                  var Eigenvector : TNvector;
                  var Largest     : Float);

{---------------------------------------}
{- Input: Dimen, Eigenvectors          -}
{- Output: Largest                     -}
{-                                     -}
{- This procedure returns the value of -}
{- the largest element of the vector.  -}
{---------------------------------------}

var
  Term : integer;

begin
  Largest := Eigenvector[1];
  for Term := 2 to Dimen do
    if ABS(Eigenvector[Term]) > ABS(Largest) then
      Largest := Eigenvector[Term];
end; { procedure FindLargest }

procedure DivVecConst(Dimen       : integer;
                  var ChangingRow : TNvector;
                      Divisor     : Float);

{--------------------------------------------------------}
{- Input: Dimen, ChangingRow                            -}
{- Output: Divisor                                      -}
{-                                                      -}
{- elementary row operation - dividing by a constant    -}
{--------------------------------------------------------}

var
  Term : integer;

begin
  for Term := 1 to Dimen do
    ChangingRow[Term] := ChangingRow[Term] / Divisor;
end; { procedure DivVecConst }

begin { procedure NormalizeEigenvectors }
  for Row := 1 to Dimen do
  begin
    FindLargest(Dimen, Eigenvectors[Row], Largest);
    DivVecConst(Dimen, Eigenvectors[Row], Largest);
  end;
end; { procedure NormalizeEigenvectors }

begin { procedure Jacobi }
  TestData(Dimen, Mat, MaxIter, Tolerance, Error);
  if Error = 0 then
  begin
    Initialize(Dimen, Iter, Eigenvectors);
    repeat
      Iter := Succ(Iter);
      SumSquareDiag := 0;
      for Diag := 1 to Dimen do
        SumSquareDiag := SumSquareDiag + Sqr(Mat[Diag, Diag]);
      Done := true;
      for Row := 1 to Dimen - 1  do
        for Column := Row + 1 to Dimen do
          if ABS(Mat[Row, Column]) > Tolerance * SumSquareDiag then
          begin
            Done := false;
            CalculateRotation(Mat[Row, Row], Mat[Row, Column],
                              Mat[Column, Column], SinTheta, CosTheta);
            RotateMatrix(Dimen, SinTheta, CosTheta, Row, Column, Mat);
            RotateEigenvectors(Dimen, SinTheta, CosTheta, Row, Column,
                               Eigenvectors);
          end;
    until Done or (Iter > MaxIter);
    for Diag := 1 to Dimen do
      Eigenvalues[Diag] := Mat[Diag, Diag];
    NormalizeEigenvectors(Dimen, Eigenvectors);
    if Iter > MaxIter then
      Error := 5
  end;
end; { procedure Jacobi }
