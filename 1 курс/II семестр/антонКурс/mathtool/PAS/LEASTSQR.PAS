unit LeastSqr;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-  This unit provides procedures for modelling data with a function of a   -}
{-  given type, given a set of data points.                                 -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I Float.inc} { Determines the setting of the $N compiler directive }

interface

{$IFOPT N+}
type
  Float = Double; { 8 byte real, requires 8087 math chip }

const
  TNNearlyZero = 1E-015;
{$ELSE}
type
  Float = real;   { 6 byte real, no math chip required }

const
  TNNearlyZero = 1E-07;
{$ENDIF}

  TNRowSize = 6;                { Maximum number of terms  }
                                { in Least Squares fit     }
  TNColumnSize = 50;            { Maximum number of data points  }

type
  TNColumnVector = array[1..TNColumnSize] of Float;
  TNRowVector = array[1..TNRowSize] of Float;
  TNmatrix = array[1..TNColumnSize] of TNRowVector;
  TNSquareMatrix =array[1..TNRowSize] of TNRowVector;
  TNString40 = string[40];
  FitType = (Expo, Fourier, Log, Poly, Power, User);

function ModuleName(Fit : FitType) : TNString40;

procedure LeastSquares(NumPoints         : integer;
                   var XData             : TNColumnVector;
                   var YData             : TNColumnVector;
                       NumTerms          : integer;
                   var Solution          : TNRowVector;
                   var YFit              : TNColumnVector;
                   var Residuals         : TNColumnVector;
                   var StandardDeviation : Float;
                   var Variance          : Float;
                   var Error             : byte;
                       Fit               : FitType);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-   Input: NumPoints, XData, YData, NumTerms                               -}
{-   Output: Solution, YFit, Residuals, StandardDeviation, Error            -}
{-                                                                          -}
{-   Purpose:  Given NumPoints data points of the form (X, Y), this         -}
{-             procedure finds the least square solution of NumTerms terms  -}
{-             (NumTerms <= NumPoints) to then matrix equation AC = B       -}
{-             where A is a NumPoints by NumTerms matrix, B is a            -}
{-             NumPoints vector and C is the least squares solution.  The   -}
{-             elements of A are A[i, j] = Tj(X[i]) where Tj is the jth     -}
{-             basis vector and X[i] is the X-value of the ith data point.  -}
{-             The basis vectors are created by a separate include file,    -}
{-             or module.  The choice of module will determine whether      -}
{-             the least squares solution is a polynomial fit, trigono-     -}
{-             metric fit (Fourier series), power fit (e.g. Y=ax^b, where   -}
{-             b is fractional), exponential fit (e.g. Y=a-Exp(bx)), or     -}
{-             logarithmic fit (e.g. Y=a-Ln(bx)).  The user may also        -}
{-             create modules for other functional forms.  See the          -}
{-             documentation for details.                                   -}
{-                                                                          -}
{- User-Defined Types: TNColumnVector = array[1..TNColumnSize] of real;     -}
{-                     TNRowVector = array[1..TNRowSize] of real;           -}
{-                                                                          -}
{-     Global Variables: NumPoints         : integer; Number of data points -}
{-                       XData             : TNColumnVector; X-value data   -}
{-                       YData             : TNColumnVector; Y-value data   -}
{-                       NumTerms          : integer; Number of terms in    -}
{_                                                    least squares fit     -}
{-                       Solution          : TNRowVector; Least squares     -}
{_                                                        solution in the   -}
{-                                                        given basis       -}
{-                       YFit              : TNColumnVector; Y-values       -}
{-                                                           predicted by   -}
{-                                                          the LS solution -}
{-                       Residuals         :TNColumnVector Difference       -}
{-                                                      between predicted   -}
{-                                                      and actual Y values -}
{-                       StandardDeviation : real; Root of variance         -}
{-                       Error             : byte; Indicates an error       -}
{-                                                                          -}
{-               Errors: 0: No errors                                       -}
{-                       1: NumPoints < 2                                   -}
{-                       2: NumTerms < 1                                    -}
{-                       3: NumTerms > NumPoints                            -}
{-                       4: solution not possible (exact reason             -}
{-                          will depend upon the particular basis)          -}
{-                                                                          -}
{----------------------------------------------------------------------------}

implementation

{$I Least1.inc}      { Include procedure code }

{$I Least2.inc}

end. { LeastSqr }
