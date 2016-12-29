{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Power{(Dimen      : integer;
            var Mat         : TNmatrix;
            var GuessVector : TNvector;
                MaxIter     : integer;
                Tolerance   : Float;
            var Eigenvalue  : Float;
            var Eigenvector : TNvector;
            var Iter        : integer;
            var Error       : byte)};

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

procedure TestDataAndInitialize(Dimen          : integer;
                            var Mat            : TNmatrix;
                            var GuessVector    : TNvector;
                                Tolerance      : Float;
                                MaxIter        : integer;
                            var Eigenvalue     : Float;
                            var Eigenvector    : TNvector;
                            var Found          : boolean;
                            var Iter           : integer;
                            var OldApprox      : TNvector;
                            var AitkenVector   : TNThreeMatrix;
                            var ApproxEigenval : Float;
                            var Error          : byte);

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
  if Sum < TNNearlyZero then { The GuessVector is the zero vector }
    for Term := 1 to Dimen do
      GuessVector[Term] := 1;
  if Dimen < 1 then
    Error := 1;
  if Tolerance <= 0 then
    Error := 2;
  if MaxIter < 1 then
    Error := 3;
  if Error = 0 then
  begin
    Iter := 0;
    OldApprox := GuessVector;
    FillChar(AitkenVector, SizeOf(AitkenVector), 0);
    ApproxEigenval := 0;
    Found := false;
  end;
  if Dimen = 1 then
  begin
    Eigenvalue := Mat[1, 1];
    Eigenvector[1] := 1;
    Found := true;
  end;
end; { procedure TestDataAndInitialize }

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
  end; { while }
end; { procedure TestForConvergence }

begin { procedure Power }
  TestDataAndInitialize(Dimen, Mat, GuessVector, Tolerance, MaxIter,
                        Eigenvalue, Eigenvector, Found, Iter,
                        OldApprox, AitkenVector, ApproxEigenval, Error);
  if (Error = 0) and (Found = false) then
  begin
    FindLargest(Dimen, OldApprox, ApproxEigenval);
    Div_Vec_Const(Dimen, OldApprox, ApproxEigenval);
    while (Iter < MaxIter) and not Found do
    begin
      Iter := Succ(Iter);
      Remainder := Iter MOD 3;
      if Remainder = 0 then  { Use Aitken's acceleration algorithm to  }
                             { generate the next iterate approximation }
      begin
        OldApprox := AitkenVector[0];
        for Index := 1 to Dimen do
        begin
          Denom := AitkenVector[2, Index] -
                   2 * AitkenVector[1, Index] + AitkenVector[0, Index];
          if ABS(Denom) > TNNearlyZero then
            OldApprox[Index] := AitkenVector[0, Index] -
            Sqr(AitkenVector[1, Index] - AitkenVector[0, Index]) / Denom;
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

procedure InversePower{(Dimen      : integer;
                       Mat         : TNmatrix;
                   var GuessVector : TNvector;
                       ClosestVal  : Float;
                       MaxIter     : integer;
                       Tolerance   : Float;
                   var Eigenvalue  : Float;
                   var Eigenvector : TNvector;
                   var Iter        : integer;
                   var Error       : byte)};

var
  OldApprox, NewApprox : TNvector;     { Iteration variables }
  ApproxEigenval : Float;               { Iteration variables }
  Found : boolean;

procedure TestDataAndInitialize(Dimen          : integer;
                            var Mat            : TNmatrix;
                            var GuessVector    : TNvector;
                                Tolerance      : Float;
                                MaxIter        : integer;
                            var Eigenvalue     : Float;
                            var Eigenvector    : TNvector;
                            var Found          : boolean;
                            var Iter           : integer;
                            var OldApprox      : TNvector;
                            var ClosestVal     : Float;
                            var ApproxEigenval : Float;
                            var Error          : byte);

{--------------------------------------------------------}
{- Input: Dimen, Mat, GuessVector, Tolerance, MaxIter   -}
{- Output: Guess, Eigenvalue, Eigenvector, Found,       -}
{-         Iter, OldApprox, ClosestVal, ApproxEigenval, -}
{-         Error                                        -}
{-                                                      -}
{- This procedure tests the input data for errors       -}
{- If all the elements of the GuessVector are           -}
{- zero, then they are all replaced by ones.            -}
{- If the dimension of the matrix is one, then the      -}
{- eigenvalue equals the matrix.                        -}
{--------------------------------------------------------}

var
  Term : integer;
  Sum : Float;

begin
  Error := 0;
  Sum := 0;
  for Term := 1 to Dimen do
    Sum := Sum + Sqr(GuessVector[Term]);
  if Sum < TNNearlyZero then { The GuessVector is the zero vector }
    for Term := 1 to Dimen do
      GuessVector[Term] := 1;
  if Dimen < 1 then
    Error := 1;
  if Tolerance <= 0 then
    Error := 2;
  if MaxIter < 1 then
    Error := 3;
  Found := false;
  if Dimen = 1 then
  begin
    Eigenvalue := Mat[1, 1];
    Eigenvector[1] := 1;
    Found := true;
  end;
  if Error = 0 then
  begin
    Iter := 0;
    OldApprox := GuessVector;
    { Subtract ClosestVal from the main diagonal of Mat }
    for Term := 1 to Dimen do
      Mat[Term, Term] := Mat[Term, Term] - ClosestVal;
    ApproxEigenval := 0;
  end;
end; { procedure TestDataAndInitialize }

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

procedure GetNewApprox(Dimen     : integer;
                   var Mat       : TNmatrix;
                   var OldApprox : TNvector;
                   var NewApprox : TNvector;
                       Iter      : integer;
                   var Error     : byte);

{---------------------------------------------}
{- Input: Dimen, Mat, OldApprox, Iter        -}
{- Output: NewApprox, Error                  -}
{-                                           -}
{- This procedure uses Gaussian elimination  -}
{- with partial pivoting to solve the linear -}
{- system:                                   -}
{-   Mat - NewApprox = OldApprox             -}
{- If no unique solution exists, then        -}
{- Error = 5 is returned.                    -}
{---------------------------------------------}

var
  Decomp: TNmatrix;
  Permute : TNmatrix;

{----------------------------------------------------------------------------}

procedure Decompose(Dimen        : integer;
                    Coefficients : TNmatrix;
                var Decomp       : TNmatrix;
                var Permute      : TNmatrix;
                var Error        : byte);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-                Input: Dimen, Coefficients                                -}
{-               Output: Decomp, Permute, Error                             -}
{-                                                                          -}
{-             Purpose : Decompose a square matrix into an upper            -}
{-                       triangular and lower triangular matrix such that   -}
{-                       the product of the two triangular matrices is      -}
{-                       the original matrix. This procedure also returns   -}
{-                       a permutation matrix which records the             -}
{-                       permutations resulting from partial pivoting.      -}
{-                                                                          -}
{-  User-defined Types : TNvector = array[1..TNArraySize] of real           -}
{-                       TNmatrix = array[1..TNArraySize] of TNvector       -}
{-                                                                          -}
{-    Global Variables : Dimen        : integer;  Dimen of the coefficients -}
{-                                                matrix                    -}
{-                       Coefficients : TNmatrix; Coefficients matrix       -}
{-                       Decomp       : TNmatrix; Decomposition of          -}
{-                                                coefficients matrix       -}
{-                       Permute      : TNmatrix; Record of partial         -}
{-                                                pivoting                  -}
{-                       Error        : integer;  Flags if something goes   -}
{-                                                wrong.                    -}
{-                                                                          -}
{-              Errors : 0: No errors;                                      -}
{-                       1: Dimen < 1                                       -}
{-                       2: No decomposition possible; singular matrix      -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure TestInput(Dimen : integer;
                var Error : byte);

{---------------------------------------}
{- Input: Dimen                        -}
{- Output: Error                       -}
{-                                     -}
{- This procedure checks to see if the -}
{- value of Dimen is greater than 1.   -}
{---------------------------------------}

begin
  Error := 0;
  if Dimen < 1 then
    Error := 1;
end; { procedure TestInput }

function RowColumnMult(Row    : integer;
                   var Lower  : TNmatrix;
                       Column : integer;
                   var Upper  : TNmatrix) : Float;

{----------------------------------------------------}
{- Input: Row, Lower, Column, Upper                 -}
{- Function return: dot product of row Row of Lower -}
{-                  and column Column of Upper      -}
{----------------------------------------------------}

var
  Term : integer;
  Sum : Float;

begin
  Sum := 0;
  for Term := 1 to Row - 1 do
    Sum := Sum + Lower[Row, Term] * Upper[Term, Column];
  RowColumnMult := Sum;
end; { function RowColumnMult }


procedure Pivot(Dimen        : integer;
                ReferenceRow : integer;
            var Coefficients : TNmatrix;
            var Lower        : TNmatrix;
            var Upper        : TNmatrix;
            var Permute      : TNmatrix;
            var Error        : byte);

{----------------------------------------------------------------}
{- Input: Dimen, ReferenceRow, Coefficients,                    -}
{-        Lower, Upper, Permute                                 -}
{- Output: Coefficients, Lower, Permute, Error                  -}
{-                                                              -}
{- This procedure searches the ReferenceRow column of the       -}
{- Coefficients matrix for the element in the Row below the     -}
{- main diagonal which produces the largest value of            -}
{-                                                              -}
{-         Coefficients[Row, ReferenceRow] -                    -}
{-                                                              -}
{-          SUM K=1 TO ReferenceRow - 1 of                      -}
{-                  Upper[Row, k] - Lower[k, ReferenceRow]      -}
{-                                                              -}
{- If it finds one, then the procedure switches                 -}
{- rows so that this element is on the main diagonal. The       -}
{- procedure also switches the corresponding elements in the    -}
{- Permute matrix and the Lower matrix. If the largest value of -}
{- the above expression is zero, then the matrix is singular    -}
{- and no solution exists (Error = 2 is returned).              -}
{----------------------------------------------------------------}

var
  PivotRow, Row : integer;
  ColumnMax, TestMax : Float;

procedure EROswitch(var Row1 : TNvector;
                    var Row2 : TNvector);

{-------------------------------------------------}
{- Input: Row1, Row2                             -}
{- Output: Row1, Row2                            -}
{-                                               -}
{- Elementary row operation - switching two rows -}
{-------------------------------------------------}

var
  DummyRow : TNvector;

begin
  DummyRow := Row1;
  Row1 := Row2;
  Row2 := DummyRow;
end; { procedure EROswitch }

begin { procedure Pivot }
  { First, find the row with the largest TestMax }
  PivotRow := ReferenceRow;
  ColumnMax := ABS(Coefficients[ReferenceRow, ReferenceRow] -
               RowColumnMult(ReferenceRow, Lower, ReferenceRow, Upper));
  for Row := ReferenceRow + 1 to Dimen do
  begin
    TestMax := ABS(Coefficients[Row, ReferenceRow] -
               RowColumnMult(Row, Lower, ReferenceRow, Upper));
    if TestMax > ColumnMax then
    begin
      PivotRow := Row;
      ColumnMax := TestMax;
    end;
  end;
  if PivotRow <> ReferenceRow then
    { Second, switch these two rows }
    begin
      EROswitch(Coefficients[PivotRow], Coefficients[ReferenceRow]);
      EROswitch(Lower[PivotRow], Lower[ReferenceRow]);
      EROswitch(Permute[PivotRow], Permute[ReferenceRow]);
    end
  else { If ColumnMax is zero, no solution exists }
    if ColumnMax < TNNearlyZero then
      Error := 2;     { No solution exists }
end; { procedure Pivot }

procedure LU_Decompose(Dimen        : integer;
                   var Coefficients : TNmatrix;
                   var Decomp       : TNmatrix;
                   var Permute      : TNmatrix;
                   var Error        : byte);

{---------------------------------------------------------}
{- Input: Dimen, Coefficients                            -}
{- Output: Decomp, Permute, Error                        -}
{-                                                       -}
{- This procedure decomposes the Coefficients matrix     -}
{- into two triangular matrices, a lower and an upper    -}
{- one.  The lower and upper matrices are combined       -}
{- into one matrix, Decomp.  The permutation matrix,     -}
{- Permute, records the effects of partial pivoting.     -}
{---------------------------------------------------------}

var
  Upper, Lower : TNmatrix;
  Term, Index : integer;

procedure Initialize(Dimen   : integer;
                 var Lower   : TNmatrix;
                 var Upper   : TNmatrix;
                 var Permute : TNmatrix);

{---------------------------------------------------}
{- Output: Dimen, Lower, Upper, Permute            -}
{-                                                 -}
{- This procedure initializes the above variables. -}
{- Lower and Upper are initialized to the zero     -}
{- matrix and Diag is initialized to the identity  -}
{- matrix.                                         -}
{---------------------------------------------------}

var
  Diag : integer;

begin
  FillChar(Upper, SizeOf(Upper), 0);
  FillChar(Lower, SizeOf(Lower), 0);
  FillChar(Permute, SizeOf(Permute), 0);
  for Diag := 1 to Dimen do
    Permute[Diag, Diag] := 1;
end; { procedure Permute }

begin
  Initialize(Dimen, Lower, Upper, Permute);
  { Perform partial pivoting on row 1 }
  Pivot(Dimen, 1, Coefficients, Lower, Upper, Permute, Error);
  if Error = 0 then
  begin
    Lower[1, 1] := 1;
    Upper[1, 1] := Coefficients[1, 1];
    for Term := 1 to Dimen do
    begin
      Lower[Term, 1] := Coefficients[Term, 1] / Upper[1, 1];
      Upper[1, Term] := Coefficients[1, Term] / Lower[1, 1];
    end;
  end;
  Term := 1;
  while (Error = 0) and (Term < Dimen - 1) do
  begin
    Term := Succ(Term);
    { Perform partial pivoting on row Term }
    Pivot(Dimen, Term, Coefficients, Lower, Upper, Permute, Error);
    Lower[Term, Term] := 1;
    Upper[Term, Term] := Coefficients[Term, Term] -
                         RowColumnMult(Term, Lower, Term, Upper);
    if ABS(Upper[Term, Term]) < TNNearlyZero then
      Error := 2   { No solutions }
    else
      for Index := Term + 1 to Dimen do
      begin
        Upper[Term, Index] := Coefficients[Term, Index] -
                              RowColumnMult(Term, Lower, Index, Upper);
        Lower[Index, Term] := (Coefficients[Index, Term] -
                              RowColumnMult(Index, Lower,Term, Upper)) /
                              Upper[Term, Term];
      end
  end; { while }
  Lower[Dimen, Dimen] := 1;
  Upper[Dimen, Dimen] := Coefficients[Dimen, Dimen] -
                         RowColumnMult(Dimen, Lower, Dimen, Upper);
  if ABS(Upper[Dimen, Dimen]) < TNNearlyZero then
    Error := 2;
  { Combine the upper and lower triangular matrices into one }
  Decomp := Upper;

  for Term := 2 to Dimen do
    for Index := 1 to Term - 1 do
      Decomp[Term, Index] := Lower[Term, Index];
end; { procedure LU_Decompose }

begin  { procedure Decompose }
  TestInput(Dimen, Error);
  if Error = 0 then
    if Dimen = 1 then
      begin
        Decomp := Coefficients;
        Permute[1, 1] := 1;
      end
    else
      LU_Decompose(Dimen, Coefficients, Decomp, Permute, Error);
end; { procedure Decompose }

procedure Solve_LU_Decomposition(Dimen     : integer;
                             var Decomp    : TNmatrix;
                                 Constants : TNvector;
                             var Permute   : TNmatrix;
                             var Solution  : TNvector;
                             var Error     : byte);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-                Input: Dimen, Decomp, Constants, Permute                  -}
{-               Output: Solution, Error                                    -}
{-                                                                          -}
{-             Purpose : Calculate the solution of a linear set of          -}
{-                       equations using an LU decomposed matrix, a         -}
{-                       permutation matrix and backwards substitution.     -}
{-                                                                          -}
{-  User_defined Types : TNvector = array[1..TNArraySize] of real           -}
{-                       TNmatrix = array[1..TNArraySize] of TNvector       -}
{-                                                                          -}
{-    Global Variables : Dimen     : integer;   Dimen of the square         -}
{-                                              matrix                      -}
{-                       Decomp    : TNmatrix;  Decomposition of            -}
{-                                              the matrix                  -}
{-                       Constants : TNvector;  Constants of each equation  -}
{-                       Permute   : TNmatrix;  Permutation matrix from     -}
{-                                              partial pivoting            -}
{-                       Solution  : TNvector;  Unique solution to the      -}
{-                                              set of equations            -}
{-                       Error     : integer;   Flags if something goes     -}
{-                                              wrong.                      -}
{-                                                                          -}
{-              Errors : 0: No errors;                                      -}
{-                       1: Dimen < 1                                       -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Initial(Dimen    : integer;
              var Solution : TNvector;
              var Error    : byte);

{----------------------------------------------------}
{- Input: Dimen                                     -}
{- Output: Solution, Error                          -}
{-                                                  -}
{- This procedure initializes the Solution vector.  -}
{- It also checks to see if the value of Dimen is   -}
{- greater than 1.                                  -}
{----------------------------------------------------}

begin
  Error := 0;
  FillChar(Solution, SizeOf(Solution), 0);
  if Dimen < 1 then
    Error := 1;
end; { procedure Initial }

procedure FindSolution(Dimen     : integer;
                   var Decomp    : TNmatrix;
                   var Constants : TNvector;
                   var Solution  : TNvector);

{---------------------------------------------------------------}
{- Input: Dimen, Decomp, Constants                             -}
{- Output: Solution                                            -}
{-                                                             -}
{- The Decom matrix contains a lower and upper triangular      -}
{- matrix.                                                     -}
{- This procedure performs a two step backwards substitution   -}
{- to compute the solution to the system of equations.  First, -}
{- backwards substitution is applied to the lower triangular   -}
{- matrix and Constants vector yielding PartialSolution.  Then -}
{- backwards substitution is applied to the Upper matrix and   -}
{- the PartialSolution vector yielding Solution.               -}
{---------------------------------------------------------------}

var
  PartialSolution : TNvector;
  Term, Index : integer;
  Sum : Float;

begin { procedure FindSolution }
  { First solve the lower triangular matrix }
  PartialSolution[1] := Constants[1];
  for Term := 2 to Dimen do
  begin
    Sum := 0;
    for Index := 1 to Term - 1 do
      if Term = Index then
        Sum := Sum + PartialSolution[Index]
      else
        Sum := Sum + Decomp[Term, Index] * PartialSolution[Index];
    PartialSolution[Term] := Constants[Term] - Sum;
  end;
  { Then solve the upper triangular matrix }
  Solution[Dimen] := PartialSolution[Dimen]/Decomp[Dimen, Dimen];
  for Term := Dimen - 1 downto 1 do
  begin
    Sum := 0;
    for Index := Term + 1 to Dimen do
      Sum := Sum + Decomp[Term, Index] * Solution[Index];
    Solution[Term] := (PartialSolution[Term] - Sum) / Decomp[Term, Term];
  end;
end; { procedure FindSolution }

procedure PermuteConstants(Dimen     : integer;
                       var Permute   : TNmatrix;
                       var Constants : TNvector);

var
  Row, Column : integer;
  Entry : Float;
  TempConstants : TNvector;

begin
  for Row := 1 to Dimen do
  begin
    Entry := 0;
    for Column := 1 to Dimen do
      Entry := Entry + Permute[Row, Column] * Constants[Column];
    TempConstants[Row] := Entry;
  end;  {FOR Row}
  Constants := TempConstants;
end; { procedure PermuteConstants }

begin { procedure Solve_LU_Decompostion }
  Initial(Dimen, Solution, Error);
  if Error = 0 then
    PermuteConstants(Dimen, Permute, Constants);
  FindSolution(Dimen, Decomp, Constants, Solution);
end; { procedure Solve_LU_Decomposition }

{----------------------------------------------------------------------------}

begin { procedure GetNewApprox }
  if Iter = 1 then
  begin
    Decompose(Dimen, Mat, Decomp, Permute, Error);
    if Error = 2 then { Returned from Decompose - matrix is singular }
      Error := 5;     { eigenvalue/eigenvector can't   }
                      { be calculated with this method }
  end;
  if Error = 0 then
    Solve_LU_Decomposition(Dimen, Decomp, OldApprox, Permute, NewApprox, Error);
end; { procedure GetNewApprox }

procedure TestForConvergence(Dimen     : integer;
                         var OldApprox : TNvector;
                         var NewApprox : TNvector;
                             Tolerance : Float;
                         var Found     : boolean);

{-----------------------------------------------------------------}
{- Input: Dimen, OldApprox, NewApprox, Tolerance,                -}
{- Output: Found                                                 -}
{-                                                               -}
{- This procedure determines if the iterations have converged    -}
{- on a solution.  If the absolute difference in each element of -}
{- the eigenvector between the last two iterations (i.e. between -}
{- OldApprox and NewApprox) is less than Tolerance, then         -}
{- convergence has occurred and Found = true.  Otherwise,        -}
{- Found = false.                                                -}
{-----------------------------------------------------------------}

var
  Index : integer;
  Difference : Float;

begin
  Index := 0;
  Found := true;
  while (Found = true) and (Index < Dimen) do
  begin
    Index := Succ(Index);
    if (ABS(OldApprox[Index]) > TNNearlyZero) and
       (ABS(NewApprox[Index]) > TNNearlyZero) then
      begin
        Difference := ABS(OldApprox[Index] - NewApprox[Index]);
        if Difference > Tolerance then
          Found := false;
      end;
  end; { while }
end; { procedure TestForConvergence }

begin  { procedure InversePower }
  TestDataAndInitialize(Dimen, Mat, GuessVector, Tolerance, MaxIter,
                        Eigenvalue, Eigenvector, Found, Iter, OldApprox,
                        ClosestVal, ApproxEigenval, Error);

  if (Error = 0) and (Found = false) then
  begin
    FindLargest(Dimen, OldApprox, ApproxEigenval);
    Div_Vec_Const(Dimen, OldApprox, ApproxEigenval);
    while (Iter < MaxIter) and not Found and (Error = 0) do
    begin
      Iter := Succ(Iter);
      GetNewApprox(Dimen, Mat, OldApprox, NewApprox, Iter, Error);
      if Error = 0 then
      begin
        FindLargest(Dimen, NewApprox, ApproxEigenval);
        Div_Vec_Const(Dimen, NewApprox, ApproxEigenval);
        TestForConvergence(Dimen, OldApprox, NewApprox, Tolerance, Found);
        OldApprox := NewApprox;
      end;
    end; { while }
    if Error = 5 then { Eigenvalue/vector not calculated }
      Eigenvalue := ClosestVal
    else
      begin
        Eigenvector := OldApprox;
        Eigenvalue := 1 / ApproxEigenval + ClosestVal;
      end;
    if Iter >= MaxIter then
      Error := 4;
  end;
end; { procedure InversePower }

