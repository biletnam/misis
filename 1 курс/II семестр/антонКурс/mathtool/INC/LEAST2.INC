{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure LeastSquares{(NumPoints        : integer;
                   var XData             : TNColumnVector;
                   var YData             : TNColumnVector;
                       NumTerms          : integer;
                   var Solution          : TNRowVector;
                   var YFit              : TNColumnVector;
                   var Residuals         : TNColumnVector;
                   var StandardDeviation : Float;
                   var Variance          : Float;
                   var Error             : byte;
                       Fit               : FitType)};

var
  WData : TNColumnVector;          { Transformed X-values  }
  ZData : TNColumnVector;          { Transformed Y-values  }
  Basis : TNmatrix;                { Matrix of basis functions  }

  Multiplier : Float;              { Multiplier and Constant are used in }
  Constant : Float;                { some modules to pass information    }
                                   { from Transform to InverseTransform  }
                                   { or TransformSolution.  These must   }
                                   { therefore have dummy parameters     }
                                   { when Multiplier and Constant are    }
                                   { not used.                           }

procedure InitializeAndFormBasisVectors(NumPoints  : integer;
                                    var XData      : TNColumnVector;
                                    var YData      : TNColumnVector;
                                    var Multiplier : Float;
                                    var Constant   : Float;
                                    var WData      : TNColumnVector;
                                    var ZData      : TNColumnVector;
                                    var NumTerms   : integer;
                                    var Solution   : TNRowVector;
                                    var Basis      : TNmatrix;
                                    var Error      : byte);

{-------------------------------------------------------}
{- Input: NumPoints, XData, NumTerms                   -}
{- Output: Solution, Error                             -}
{-                                                     -}
{- This procedure initializes Solution and Error       -}
{- to zero.  It also checks the data for errors.       -}
{-------------------------------------------------------}
begin
  Error := 0;
  if NumPoints < 2 then
    Error := 1;   { Less than 2 data points  }
  if NumTerms < 1 then
    Error := 2;   { Less than 1 coefficient in the fit  }
  if NumTerms > NumPoints then
    Error := 3;   { Number of data points less than        }
                  { number of terms in Least Squares fit!  }
  FillChar(Solution, SizeOf(Solution), 0);
  if Error = 0 then
  begin
    { The next two procedures are particular to each        }
    { basis.  Consequently, they are included in each       }
    { module, not in this include file.                     }

    { The Transform procedure transforms the input data to  }
    { fit the particular basis.  This may mean taking the   }
    { logarithm, or linearly tranforming the data to a      }
    { particular interval. XData is transformed to WData    }
    { and YData is transformed to ZData.  For some of the   }
    { modules, Multiplier and Constant are used to pass     }
    { information, for others they are dummy variables.     }
    { See the code listing of the appropriate module for    }
    { more information.                                     }
    case Fit of
      Poly    : PolyTransform(NumPoints, XData, YData, Multiplier,
                              Constant, WData, ZData, Error);
      Fourier : FourierTransform(NumPoints, XData, YData, Multiplier,
                                 Constant, WData, ZData, Error);
      Power   : PowerTransform(NumPoints, XData, YData, Multiplier,
                               Constant, WData, ZData, Error);
      Expo    : ExpoTransform(NumPoints, XData, YData, Multiplier,
                              Constant, WData, ZData, Error);
      Log     : LogTransform(NumPoints, XData, YData, Multiplier,
                             Constant, WData, ZData, Error);
      User    : UserTransform(NumPoints, XData, YData, Multiplier,
                              Constant, WData, ZData, Error);
    end;

    if Error = 0 then

      { The CreateBasis procedure creates the matrix of       }
      { basis vectors, Basis.  The elements of Basis are:     }
      { Basis[i, j] = Tj(w[i]) where Tj is the jth basis      }
      { and w[i] is the ith data element of WData.            }
      case Fit of
        Poly    : PolyCreateBasisFunctions(NumPoints, NumTerms, WData, Basis);
        Fourier : FourierCreateBasisFunctions(NumPoints, NumTerms, WData, Basis);
        Power   : PowerCreateBasisFunctions(NumPoints, NumTerms, WData, Basis);
        Expo    : ExpoCreateBasisFunctions(NumPoints, NumTerms, WData, Basis);
        Log     : LogCreateBasisFunctions(NumPoints, NumTerms, WData, Basis);
        User    : UserCreateBasisFunctions(NumPoints, NumTerms, WData, Basis);
      end;
  end;
end; { procedure InitializeAndFormBasisVectors }

procedure CreateAndSolveEquations(NumPoints : integer;
                                  NumTerms  : integer;
                              var Basis     : TNmatrix;
                              var ZData     : TNColumnVector;
                              var Solution  : TNRowVector;
                              var Error     : byte);


var
  Coefficients : TNSquareMatrix;
  Constants : TNRowVector;

{------------------------------------------------------------}
{- Input: NumPoints, NumTerms, Basis, ZData                 -}
{- Output: Solution, Error                                  -}
{- This procedure computes and solves the normal equations. -}
{- The normal equations are represented in matrix notation  -}
{- as      Coefficients - Solution = Constants              -}
{- This matrix equation is solved by Gaussian Elimination   -}
{- with partial pivoting (TNToolbox routine: PARTPIVT.INC). -}
{- If no solution exists, Error 3 is returned.              -}
{------------------------------------------------------------}

procedure ComputeNormalEquations(NumPoints, NumTerms : integer;
                             var Basis               : TNmatrix;
                             var YData               : TNColumnVector;
                             var Coefficients        : TNSquareMatrix;
                             var Constants           : TNRowVector);

{---------------------------------------------------------}
{- Input: NumPoints, NumTerms, Basis, YData              -}
{- Output: Coefficients, Constants                       -}
{-                                                       -}
{- This procedure calculates the normal equations.  The  -}
{- normal equations are of the form Ax=b, where A is the -}
{- Coefficients matrix, b is the Constants vector and X  -}
{- is the least squares solution to our problem in the   -}
{- given basis.                                          -}
{- The normal equations are derived from the basis       -}
{- functions and the condition of least squares.  The    -}
{- algorithm to create them is:                          -}
{-      Coefficients[i, j] = Sum from k=1 to NumPoints   -}
{-                            of Basis[k, i]-Basis[k, j] -}
{-                                                       -}
{-     Constants[i] = Sum from k=1 to NumPoints          -}
{-                     YData[k] - Basis[k, i]            -}
{---------------------------------------------------------}

var
  Row, Column, Index : integer;
  Sum : Float;

begin
  for Column := 1 to NumTerms do
  begin
    Sum := 0;
    for Index := 1 to NumPoints do
    Sum := Sum + YData[Index] * Basis[Index, Column];
    Constants[Column] := Sum;
    for Row := Column to NumTerms do
    begin
      Sum := 0;
      for Index := 1 to NumPoints do
        Sum := Sum + Basis[Index, Row] * Basis[Index, Column];
      Coefficients[Row, Column] := Sum;
      Coefficients[Column, Row] := Sum;
    end;
  end;
end; { procedure ComputeNormalEquations }

{---------------------------------------------------------------------------}

procedure Partial_Pivoting(Dimen        : integer;
                           Coefficients : TNSquareMatrix;
                           Constants    : TNRowVector;
                       var Solution     : TNRowVector;
                       var Error        : byte);

{--------------------------------------------------------------------------}
{-                                                                        -}
{-              Input: Dimen, Coefficients, Constants                     -}
{-             Output: Solution, Error                                    -}
{-                                                                        -}
{-           Purpose : calculate the solution of a linear set of          -}
{-                     equations using Gaussian elimination, maximal      -}
{-                     pivoting and backwards substitution.               -}
{-                                                                        -}
{-  User-defined Types : TNRowVector = array[1..TNArraySize] of real;     -}
{-                 TNSquareMatrix = array[1..TNArraySize] of TNRowVector  -}
{-                                                                        -}
{-  Global Variables : Dimen        : integer;     Dimension of the       -}
{-                                                 square matrix          -}
{-                     Coefficients : TNSquareMatrix; Square matrix       -}
{-                     Constants    : TNRowVector; Constants of           -}
{-                                                 each equation          -}
{-                     Solution     : TNRowVector; Unique solution to     -}
{-                                                 the set of equations   -}
{-                     Error        : integer;     Flags if something     -}
{-                                                 goes wrong.            -}
{-                                                                        -}
{-            Errors : 0: No errors;                                      -}
{-                     1: Dimen < 2                                       -}
{-                     2: no solution exists                              -}
{-                                                                        -}
{--------------------------------------------------------------------------}

procedure Initial(Dimen        : integer;
              var Coefficients : TNSquareMatrix;
              var Constants    : TNRowVector;
              var Solution     : TNRowVector;
              var Error        : byte);

{----------------------------------------------------------}
{- Input: Dimen, Coefficients, Constants                  -}
{- Output: Solution, Error                                -}
{-                                                        -}
{- This procedure test for errors in the value of Dimen.  -}
{- This procedure also finds the solution for the         -}
{- trivial case Dimen = 1.                                -}
{----------------------------------------------------------}

begin
  Error := 0;
  if Dimen < 1 then
    Error := 1
  else
    if Dimen = 1 then
      if ABS(Coefficients[1, 1]) < TNNearlyZero then
        Error := 2
      else
        Solution[1] := Constants[1] / Coefficients[1, 1];
end; { procedure Initial }

procedure EROswitch(var Row1 : TNRowVector;
                    var Row2 : TNRowVector);

{-------------------------------------------------}
{- Input: Row1, Row2                             -}
{- Output: Row1, Row2                            -}
{-                                               -}
{- Elementary row operation - switching two rows -}
{-------------------------------------------------}

var
  DummyRow : TNRowVector;

begin
  DummyRow := Row1;
  Row1 := Row2;
  Row2 := DummyRow;
end; { procedure EROswitch }

procedure EROmultAdd(Multiplier   : Float;
                     Dimen        : integer;
                 var ReferenceRow : TNRowVector;
                 var ChangingRow  : TNRowVector);

{-----------------------------------------------------------}
{- Input: Multiplier, Dimen, ReferenceRow, ChangingRow     -}
{- Output: ChangingRow                                     -}
{-                                                         -}
{- row operation - adding a multiple of one row to another -}
{-----------------------------------------------------------}

var
  Term : integer;

begin
  for Term := 1 to Dimen do
    ChangingRow[Term] := ChangingRow[Term] + Multiplier * ReferenceRow[Term];
end; { procedure EROmult&Add }

procedure UpperTriangular(Dimen        : integer;
                      var Coefficients : TNSquareMatrix;
                      var Constants    : TNRowVector;
                      var Error        : byte);

{-----------------------------------------------------------------}
{- Input: Dimen, Coefficients, Constants                         -}
{- Output: Coefficients, Constants, Error                        -}
{-                                                               -}
{- This procedure makes the coefficient matrix upper triangular. -}
{- The operations which perform this are also performed on the   -}
{- Constants vector.                                             -}
{- If one of the main diagonal elements of the upper triangular  -}
{- matrix is zero, then the Coefficients matrix is singular and  -}
{- no solution exists (Error = 2 is returned).                   -}
{-----------------------------------------------------------------}

var
  Multiplier : Float;
  Row, ReferenceRow : integer;

procedure Pivot(Dimen        : integer;
                ReferenceRow : integer;
            var Coefficients : TNSquareMatrix;
            var Constants    : TNRowVector;
            var Error        : byte);

{----------------------------------------------------------------}
{- Input: Dimen, ReferenceRow, Coefficients                     -}
{- Output: Coefficients, Constants, Error                       -}
{-                                                              -}
{- This procedure searches the ReferenceRow column of the       -}
{- Coefficients matrix for the largest non-zero element below   -}
{- the diagonal. If it finds one, then the procedure switches   -}
{- rows so that the largest non-zero element is on the          -}
{- diagonal. It also switches the corresponding elements in     -}
{- the Constants vector. If it doesn't find a non-zero element, -}
{- the matrix is singular and no solution exists                -}
{- (Error = 2 is returned).                                     -}
{----------------------------------------------------------------}

var
  PivotRow, Row : integer;
  Dummy : Float;

begin
  { First, find the row with the largest element  }
  PivotRow := ReferenceRow;
  for Row := ReferenceRow + 1 to Dimen do
    if ABS(Coefficients[Row, ReferenceRow]) >
       ABS(Coefficients[PivotRow, ReferenceRow]) then
      PivotRow := Row;
  if PivotRow <> ReferenceRow then
    { Second, switch these two rows  }
    begin
      EROswitch(Coefficients[PivotRow], Coefficients[ReferenceRow]);
      Dummy := Constants[PivotRow];
      Constants[PivotRow] := Constants[ReferenceRow];
      Constants[ReferenceRow] := Dummy;
    end
  else
    { If the diagonal element is zero, no solution exists  }
    if ABS(Coefficients[ReferenceRow, ReferenceRow]) < TNNearlyZero then
      Error := 2;     { No solution  }
end; { procedure Pivot }

begin  { procedure UpperTriangular }
  { Make Coefficients matrix upper triangular  }
  ReferenceRow := 0;
  while (Error = 0) and (ReferenceRow < Dimen - 1) do
  begin
    ReferenceRow := Succ(ReferenceRow);
    { Find row with largest element in this column  }
    { and switch this row with the ReferenceRow     }
    Pivot(Dimen, ReferenceRow, Coefficients, Constants, Error);

    if Error = 0 then
      for Row := ReferenceRow + 1 to Dimen do
        { Make the ReferenceRow element of these rows zero  }
        if ABS(Coefficients[Row, ReferenceRow]) > TNNearlyZero then
        begin
          Multiplier := -Coefficients[Row, ReferenceRow] /
                         Coefficients[ReferenceRow,ReferenceRow];
          EROmultAdd(Multiplier, Dimen,
                     Coefficients[ReferenceRow], Coefficients[Row]);
          Constants[Row] := Constants[Row] +
                            Multiplier * Constants[ReferenceRow];
        end;
  end; { while }
  if ABS(Coefficients[Dimen, Dimen]) < TNNearlyZero then
    Error := 2;    { No solution  }
end; { procedure UpperTriangular }

procedure BackwardsSub(Dimen        : integer;
                   var Coefficients : TNSquareMatrix;
                   var Constants    : TNRowVector;
                   var Solution     : TNRowVector);

{----------------------------------------------------------------}
{- Input: Dimen, Coefficients, Constants                        -}
{- Output: Solution                                             -}
{-                                                              -}
{- This procedure applies backwards substitution to the upper   -}
{- triangular Coefficients matrix and Constants vector. The     -}
{- resulting vector is the solution to the set of equations and -}
{- is stored in the vector Solution.                            -}
{----------------------------------------------------------------}

var
  Term, Row : integer;
  Sum : Float;

begin
  Term := Dimen;
  while Term >= 1 do
  begin
    Sum := 0;
    for Row := Term + 1 to Dimen do
      Sum := Sum + Coefficients[Term, Row] * Solution[Row];
    Solution[Term] := (Constants[Term] - Sum) / Coefficients[Term, Term];
    Term := Pred(Term);
  end;
end; { procedure BackwardsSub }

begin { procedure Partial_Pivoting }
  Initial(Dimen, Coefficients, Constants, Solution, Error);
  if Dimen > 1 then
  begin
    UpperTriangular(Dimen, Coefficients, Constants, Error);
    if Error = 0 then
      BackwardsSub(Dimen, Coefficients, Constants, Solution);
  end;
end; { procedure Partial_Pivoting }

{---------------------------------------------------------------------------}

begin { procedure CreateAndSolveEquations }

  { The following procedure computes Coefficients and    }
  { Constants of the normal equations.  The exact        }
  { solution to the square system of normal equations    }
  { will be the least squares fit to the data.           }
  ComputeNormalEquations(NumPoints, NumTerms, Basis, ZData,
                         Coefficients, Constants);
  Partial_Pivoting(NumTerms, Coefficients, Constants, Solution, Error);
  if Error = 2 then { Returned from Partial_Pivoting  }
    Error := 4; { No solution  }
end; { procedure CreateAndSolveEquations }

procedure TransformSolutionAndFindResiduals(NumPoints         : integer;
                                            NumTerms          : integer;
                                        var YData             : TNColumnVector;
                                        var Solution          : TNRowVector;
                                            Multiplier        : Float;
                                            Constant          : Float;
                                        var Basis             : TNmatrix;
                                        var YFit              : TNColumnVector;
                                        var Residuals         : TNColumnVector;
                                        var StandardDeviation : Float;
                                        var Variance          : Float);

{-------------------------------------------------------------------}
{- Input: NumPoints, NumTerms, YData, Solution, Multiplier,        -}
{-        Constant, Basis                                          -}
{- Output: Solution, YFit, Residuals, StandardDeviation            -}
{-                                                                 -}
{- This procedure computes the goodness of fit of the least        -}
{- squares solution.  The residuals and standard deviation of the  -}
{- fit are returned.  Also, this procedure transforms the solution -}
{- according to the procedure TransformSolution in the include     -}
{- module.  See the particular module for details on the           -}
{- transformation.                                                 -}
{-------------------------------------------------------------------}

procedure ComputeYFitAndResiduals(NumPoints         : integer;
                                  NumTerms          : integer;
                                  Multiplier        : Float;
                                  Constant          : Float;
                              var YData             : TNColumnVector;
                              var Solution          : TNRowVector;
                              var Basis             : TNmatrix;
                              var YFit              : TNColumnVector;
                              var Residuals         : TNColumnVector;
                              var StandardDeviation : Float;
                              var Variance          : Float);

{---------------------------------------------------------------}
{- Input: NumPoints, NumTerms,                                 -}
{- Multiplier, Constant, YData, Solution, Basis                -}
{- Output: YFit, Residuals, StandardDeviation                  -}
{-                                                             -}
{- This procedure computes the value of the least squares      -}
{- approximation at the data points, WData.  The difference    -}
{- between the approximation and the actual values are also    -}
{- computed and are returned in the variable Residuals.  The   -}
{- standard deviation is calculated with the formula:          -}
{-                                                             -}
{-      StandardDeviation = SQRT(Variance)                     -}
{-                                                             -}
{-                                        2                    -}
{-      Variance = SUM(YData[i] - YFit[i]) /                   -}
{-                               (degrees of freedom)          -}
{-                                                             -}
{-      degrees of freedom = NumPoints - NumTerms - 2          -}
{-                                                             -}
{---------------------------------------------------------------}

var
  Index, Term : integer;
  Sum : Float;

begin
  Sum := 0;
  for Index := 1 to NumPoints do
  begin
    YFit[Index] := 0;
    for Term := 1 to NumTerms do
      YFit[Index] := YFit[Index] + Solution[Term]*Basis[Index, Term];

    { The next procedure undoes the transformation of    }
    { the YFit values.  For example, if ZData=Ln(YData)  }
    { then InverseTransform performs the function        }
    { YFit[Index] := Exp(YFit[Index]) so that YFit may   }
    { be compared to YData.                              }
    case Fit of
      Poly    : PolyInverseTransform(Multiplier, Constant, YFit[Index]);
      Fourier : FourierInverseTransform(Multiplier, Constant, YFit[Index]);
      Power   : PowerInverseTransform(Multiplier, Constant, YFit[Index]);
      Expo    : ExpoInverseTransform(Multiplier, Constant, YFit[Index]);
      Log     : LogInverseTransform(Multiplier, Constant, YFit[Index]);
      User    : UserInverseTransform(Multiplier, Constant, YFit[Index]);
    end;
    Residuals[Index] := YFit[Index] - YData[Index];
    Sum := Sum + Sqr(Residuals[Index]);
  end;
  Variance := Sum;
  if NumPoints = NumTerms then
    StandardDeviation := 0
  else
    StandardDeviation := Sqrt(Sum/(NumPoints - NumTerms));
end; { procedure ComputeYFitAndResiduals }

begin  { procedure TransformSolutionAndFindResiduals }
  ComputeYFitAndResiduals(NumPoints, NumTerms, Multiplier, Constant,
                          YData, Solution, Basis, YFit,
                          Residuals, StandardDeviation, Variance);
  case Fit of
    Poly    : PolyTransformSolution(NumTerms, Solution, Multiplier, Constant,
              Solution);
    Fourier : FourierTransformSolution(NumTerms, Solution, Multiplier, Constant,
              Solution);
    Power   : PowerTransformSolution(NumTerms, Solution, Multiplier, Constant,
              Solution);
    Expo    : ExpoTransformSolution(NumTerms, Solution, Multiplier, Constant,
              Solution);
    Log     : LogTransformSolution(NumTerms, Solution, Multiplier, Constant,
              Solution);
    User    : UserTransformSolution(NumTerms, Solution, Multiplier, Constant,
              Solution);
  end;
end; { procedure TransformSolutionAndFindResiduals }

begin { procedure LeastSquares }
  InitializeAndFormBasisVectors(NumPoints, XData, YData,
                                Multiplier, Constant, WData, ZData,
                                NumTerms, Solution, Basis, Error);
  if Error = 0  then
    CreateAndSolveEquations(NumPoints, NumTerms, Basis, ZData,
                            Solution, Error);

  if Error = 0 then
    TransformSolutionAndFindResiduals(NumPoints, NumTerms, YData, Solution,
                                      Multiplier, Constant, Basis, YFit,
                                      Residuals, StandardDeviation, Variance);

end; { procedure LeastSquares }
