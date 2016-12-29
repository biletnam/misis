{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{----------------------------------------------------------------------------}

function ModuleName{(Fit : FitType) : TNString40};
begin
  case Fit of
    Poly    : ModuleName := '       Polynomial Least Squares Fit';
    Fourier : ModuleName := ' Finite Fourier Series Least Squares Fit';
    Power   : ModuleName := '       Power Law Least Squares Fit';
    Expo    : ModuleName := '      Exponential Least Squares Fit';
    Log     : ModuleName := '      Logarithmic Least Squares Fit';
    User    : ModuleName := '  User''s Fit - currently powers of X';
  end;
end; { function ModuleName }

{-------------------------------------------------------------------------}
{-                                                                       -}
{-            Chebyshev Polynomials                                      -}
{-                                                                       -}
{- This module creates basis vectors to find a least squares solution    -}
{- of the form    f(X) = SUM from i=1 to n of (a[i] * Ti[X]), where Ti   -}
{- is the ith Chebyshev polynomial.  The coefficients of the Ti[X] are   -}
{- converted to coefficients of X^(i-1).                                 -}
{-                                                                       -}
{- The function  ModuleName identifies this as the polynomial fit.       -}
{- The procedure TransformPoly translates and scales the XData to the    -}
{-               interval [-1, 1]. The YData is unchanged.               -}
{- The procedure InverseTransform doesn't do anything in this module.    -}
{- The procedure CreateBasisFunctions creates above basis vectors.       -}
{- The procedure TransformSolution changes the solution vector from      -}
{- coefficients of the Chebyshev polynomials to coefficients of a power  -}
{- series, including adjusting for the shifted data done in TransformPoly-}
{-                                                                       -}
{-------------------------------------------------------------------------}
procedure PolyTransform(NumPoints  : integer;
                    var XData      : TNColumnVector;
                    var YData      : TNColumnVector;
                    var Multiplier : Float;
                    var Constant   : Float;
                    var WData      : TNColumnVector;
                    var ZData      : TNColumnVector;
                    var Error      : byte);

{---------------------------------------------------------------}
{- Input : NumPoints, XData, YData,                            -}
{- Output: WData, ZData, Error                                 -}
{-                                                             -}
{- This procedure maps the XData linearly into the interval    -}
{- [-1, 1] returning the transformed data in WData.  The YData -}
{- is passed to ZData unchanged.                               -}
{---------------------------------------------------------------}

var
  XDataMin, XDataMax : Float;
  Row : integer;

begin
  XDataMin := XData[1];
  XDataMax := XData[1];
  for Row := 1 to NumPoints do
  begin
    if XDataMin > XData[Row] then
      XDataMin := XData[Row];
    if XDataMax < XData[Row] then
      XDataMax := XData[Row];
  end;
  Multiplier := 2.0 / (XDataMax - XDataMin);
  Constant := - Multiplier * (XDataMax + XDataMin) / 2.0;
  for Row := 1 to NumPoints do
    WData[ Row ] := Multiplier * XData[ Row ] + Constant;
  ZDAta := YData;
end; { procedure PolyTransform }

procedure PolyInverseTransform(Multiplier : Float;
                               Constant   : Float;
                           var YFit       : Float);

{---------------------------------------------------}
{- Input: Multiplier, Constant, YFit               -}
{- Output: YFit                                    -}
{-                                                 -}
{- This procedure undoes the transformation of     -}
{- the YFit values.  Here, no inverse transform    -}
{- is performed because there was no               -}
{- transformation of Y values in procedure         -}
{- PolyTransform.                                  -}
{---------------------------------------------------}

begin
end; { procedure PolyInverseTransform }

procedure PolyCreateBasisFunctions(NumPoints : integer;
                                   NumTerms  : integer;
                               var WData     : TNColumnVector;
                               var Basis     : TNmatrix);

{---------------------------------------------------------}
{- Input: NumPoints, NumTerms, WData                     -}
{- Output: Basis                                         -}
{-                                                       -}
{- This procedure creates a matrix of basis vectors.     -}
{- The basis vectors are the CHEBYSHEV POLYNOMIALS.      -}
{-                                                       -}
{- The elements of the matrix are:                       -}
{-     Basis[i, j] = T[j](WData[i])                      -}
{- where T[j](WData[i]) is the jth basis vector          -}
{- evaluated at the value WData[i].                      -}
{-                                                       -}
{- The vectors are:                                      -}
{-   T[1] = 1                                            -}
{-   T[2] = X                                            -}
{-   T[3] = 2x*X - 1                                     -}
{-   T[4] = (4x*X - 3)*X                                 -}
{-   T[5] = (8x*X - 8)*X*X + 1                           -}
{-   etc.                                                -}
{-                                                       -}
{- The Chebyshev Polynomials can be defined recursively: -}
{-   T[1] = 1, T[2] = X                                  -}
{-   T[j] = 2x * T[j - 1] - T[j - 2]                     -}
{-                                                       -}
{---------------------------------------------------------}

var
  Row, Column : integer;

begin
  for Row := 1 to NumPoints do
  begin
    Basis[Row, 1] := 1;
    Basis[Row, 2] := WData[Row];
    for Column := 3 to NumTerms do
      Basis[Row, Column] := 2 * WData[Row] * Basis[Row, Column - 1]
                            - Basis[Row, Column - 2];
  end;
end; { procedure PolyCreateBasisFunctions }

procedure PolyTransformSolution(NumTerms    : integer;
                            var OldSolution : TNRowVector;
                                Multiplier  : Float;
                                Constant    : Float;
                            var NewSolution : TNRowVector);

{--------------------------------------------------------------}
{- Input: NumTerms, OldSolution, Multiplier, Constant         -}
{- Output: NewSolution                                        -}
{-                                                            -}
{- The least squares solution will be more useful if it is    -}
{- expressed as a linear expansion of powers of X, rather     -}
{- than as a linear expansion of Chebyshev polynomials.       -}
{-                                                            -}
{- This procedure converts the coefficients of the Chebyshev  -}
{- polynomials to coefficients of powers of X.                -}
{- The vectors ConversionVec and OldConversionVec store       -}
{- information about the relationship between these two sets  -}
{- of coefficients.  This relationship is defined recursively -}
{- above in the procedure PolyCreateBasisFunctions.           -}
{- The parameters Multiplier and Constant define the linear   -}
{- transformation of the XData, so this is accounted for in   -}
{- finding the polynomial coefficients.                       -}
{--------------------------------------------------------------}

var
  Index, Term : integer;
  Sum : Float;
  OldConversionVec, ConversionVec : TNRowVector;

begin
  FillChar(OldConversionVec, SizeOf(OldConversionVec), 0);
  for Index := 1 to NumTerms do
  begin
    Sum := 0;
    if Index > 1 then
      ConversionVec[Index - 1] := 0;
    for Term := Index to NumTerms do
    begin
      if Term = 1 then
        ConversionVec[Term] := 1.0
      else
        if Term = 2 then
          begin
            if Index = 1 then
              ConversionVec[Term] := Constant
            else
              ConversionVec[Term] := Multiplier
          end
        else
          ConversionVec[Term] := 2 * Multiplier * OldConversionVec[Term - 1]
                                 + 2 * Constant * ConversionVec[Term - 1]
                                 - ConversionVec[Term - 2];
      Sum := Sum + ConversionVec[Term] * OldSolution[Term];
    end;
    NewSolution[Index] := Sum;
    OldConversionVec := ConversionVec;
  end;
end; { procedure PolyTransformSolution }

{-------------------------------------------------------------------------}
{-                                                                       -}
{-            Fourier series                                             -}
{-                                                                       -}
{- This module creates basis vectors to find a least squares solution    -}
{- of the form:  f(x) = a[0] + SUM from i=1 to n/2 of (a[i] - Cos(ix) +  -}
{- a[i+1] - Sin(ix)).  A least squares fit with basis vectors 1, Cos(x), -}
{- Sin(x), Cos(2x), Sin(2x), etc. is made to the data (x, y).            -}
{-                                                                       -}
{- The function ModuleName identifies this as the finite Fourier         -}
{-                              series fit.                              -}
{- The procedure Transform doesn't do anything in this module.           -}
{- The procedure InverseTransform doesn't do anything in this module.    -}
{- The procedure CreateBasisFunctions creates the above basis vectors.   -}
{- The procedure TransformSolution doesn't do anything in this module.   -}
{- The first element of the solution vector will be the constant,        -}
{- the second element will be the coefficient of Cos(x), the third       -}
{- element will be the coefficient of Sin(x), the fourth element will    -}
{- be the coefficient of Cos(2x), etc.                                   -}
{-                                                                       -}
{-------------------------------------------------------------------------}

procedure FourierTransform(NumPoints       : integer;
                       var XData           : TNColumnVector;
                       var YData           : TNColumnVector;
                           DummyMultiplier : Float;
                           DummyConstant   : Float;
                       var WData           : TNColumnVector;
                       var ZData           : TNColumnVector;
                       var Error           : byte);

{---------------------------------------------------------------}
{- Input : NumPoints, XData, YData, DummyMultiplier,           -}
{-         DummyConstant                                       -}
{- Output: WData, ZData, Error                                 -}
{-                                                             -}
{- No transformations are needed for Fourier Series            -}
{---------------------------------------------------------------}

begin
  WData := XData;
  ZData := YData;
end; { procedure FourierTransform }

procedure FourierInverseTransform(DummyMultiplier : Float;
                                  DummyConstant   : Float;
                              var YFit            : Float);

{---------------------------------------------------}
{- Input: DummyMultiplier, DummyConstant, YFit     -}
{- Output: YFit                                    -}
{-                                                 -}
{- This procedure undoes the transformation of     -}
{- the YFit values.  Here, no inverse transform    -}
{- is performed because there was no               -}
{- transformation in procedure Transform.          -}
{---------------------------------------------------}

begin
end; { procedure FourierInverseTransform }

procedure FourierCreateBasisFunctions(NumPoints : integer;
                                      NumTerms  : integer;
                                  var WData     : TNColumnVector;
                                  var Basis     : TNmatrix);

{-------------------------------------------------------------}
{- Input: NumPoints, NumTerms, WData                         -}
{- Output: Basis                                             -}
{-                                                           -}
{- This procedure creates a matrix of basis vectors.         -}
{- The basis vectors are the FOURIER SERIES.                 -}
{-                                                           -}
{- The elements of the matrix are:                           -}
{-     Basis[i, j] = F[j](WData[i])                          -}
{- where F[j](WData[i]) is the jth basis vector              -}
{- evaluated at the value WData[i].                          -}
{-                                                           -}
{- The vectors are:                                          -}
{-      F[1] = 1                                             -}
{-      F[2] = Cos(x);                                       -}
{-      F[3] = Sin(x);                                       -}
{-      F[4] = Cos(2x);                                      -}
{-      F[5] = Sin(2x);                                      -}
{-      F[6] = Cos(3x);                                      -}
{-      F[7] = Sin(3x);                                      -}
{-      etc.                                                 -}
{-                                                           -}
{- This series is defined recursively by:                    -}
{-      F[1] = 1, F[2] = Cos(x),  F[3] = Sin(x)              -}
{-      F[j] = F[2] - F[j - 2] - F[3] - F[j - 1]  for even j -}
{-      F[j] = F[3] - F[j - 3] + F[2] - F[j - 2]  for odd j  -}
{-------------------------------------------------------------}

var
  Row, Column : integer;

begin
  for Row := 1 to NumPoints do
  begin
    Basis[Row, 1] := 1;
    Basis[Row, 2] := Cos(WData[Row]);
    Basis[Row, 3] := Sin(WData[Row]);
    for Column := 4 to NumTerms do
      if Odd(Column) then
        Basis[Row, Column] := Basis[Row, 3] * Basis[Row, Column-3]
                            + Basis[Row, 2] * Basis[Row, Column-2]
      else
        Basis[Row, Column] := Basis[Row, 2] * Basis[Row, Column-2]
                            - Basis[Row, 3] * Basis[Row, Column-1];
  end;
end; { procedure FourierCreateBasisFunctions }


procedure FourierTransformSolution(NumTerms        : integer;
                               var OldSolution     : TNRowVector;
                                   DummyMultiplier : Float;
                                   DummyConstant   : Float;
                               var NewSolution     : TNRowVector);

{----------------------------------------------------}
{- Input: NumTerms, OldSolution, DummyMultiplier,   -}
{-        DummyConstant                             -}
{- Output: NewSolution                              -}
{-                                                  -}
{- No need to change the coefficients of the        -}
{- Fourier series.                                  -}
{----------------------------------------------------}

begin
  NewSolution := OldSolution    { no transformation  }
end; { procedure FourierTransformSolution }

{----------------------------------------------------------------------------}
{-                                                                          -}
{-            Y = AX^B                                                      -}
{-                                                                          -}
{- This module creates basis vectors to find a least squares solution       -}
{- of the form    f(X) = A * X^B.  Taking the logarithm of both sides:      -}
{- Ln(f(X)) = Ln(A) + B * Ln(X).  A linear least squares fit                -}
{- (i.e. with basis vectors Ln(X) and 1) is then made to the data           -}
{- (Ln(X), Ln(Y)). The slope will be B, and the intercept will be Ln(A).    -}
{-                                                                          -}
{- The function ModuleName identifies this as the power law fit.            -}
{- The procedure Transform converts the data from (X, Y) to (Ln(X), Ln(Y)). -}
{- The procedure InverseTransform converts from YFit to Exp(YFit)           -}
{- The procedure CreateBasisFunctions creates the vectors Ln(X) and 1.      -}
{- The procedure TransformSolution changes the solution vector from         -}
{- (Ln(A), B) to (A, B).  Therefore, the first coefficient is A,            -}
{- and the second coefficient is B.                                         -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure PowerTransform(NumPoints     : integer;
                     var XData         : TNColumnVector;
                     var YData         : TNColumnVector;
                     var Multiplier    : Float;
                         DummyConstant : Float;
                     var WData         : TNColumnVector;
                     var ZData         : TNColumnVector;
                     var Error         : byte);

{---------------------------------------------------------------}
{- Input : NumPoints, XData, YData, Multiplier, DummyConstant  -}
{- Output: WData, ZData, Error                                 -}
{-                                                             -}
{- This procedure transforms the X and Y values to their       -}
{- logarithms.  A linear least squares fit will then be made   -}
{- to to Ln(Y) = B * Ln(X) + Ln(A). If the Y values are of     -}
{- differing sign, Error = 3 is returned.                      -}
{---------------------------------------------------------------}

var
  Index : integer;
  YPoint : Float;

begin
  Index := 0;
  if YData[1] < 0 then
    Multiplier := -1
  else
    Multiplier := 1;
  while (Index < NumPoints) and (Error = 0) do
  begin
    Index := Succ(Index);
    if XData[Index] <= 0 then
      Error := 3
    else
      begin
        YPoint := Multiplier * YData[Index];
        if YPoint <= 0 then { The data must all have the same sign  }
          Error := 3
        else
          begin
            WData[Index] := Ln(XData[Index]);
            ZData[Index] := Ln(YPoint);
          end;
      end;
  end; { while }
end; { procedure PowerTransform }

procedure PowerInverseTransform(Multiplier    : Float;
                                DummyConstant : Float;
                            var YFit          : Float);

{-------------------------------------------------}
{- Input: Multiplier, DummyConstant, YFit        -}
{- Output: YFit                                  -}
{-                                               -}
{- This procedure undoes the transformation of   -}
{- the YFit values.  Here, the function          -}
{- YFit := Exp(YFit) is performed to undo the    -}
{- Ln transformation in procedure Transform.     -}
{-------------------------------------------------}

begin
  YFit := Multiplier * Exp(YFit);
end; { procedure PowerInverseTransform }

procedure PowerCreateBasisFunctions(NumPoints : integer;
                                var NumTerms  : integer;
                                var WData     : TNColumnVector;
                                var Basis     : TNmatrix);

{---------------------------------------------------------}
{- Input: NumPoints, NumTerms, WData                     -}
{- Output: Basis                                         -}
{-                                                       -}
{- This procedure creates a matrix of basis vectors.     -}
{- The elements of the matrix are:                       -}
{-     Basis[i, j] = C[j](WData[i])                      -}
{- where C[j](WData[i]) is the jth basis vector          -}
{- evaluated at the value WData[i].                      -}
{-                                                       -}
{-                                                       -}
{- The vectors are:                                      -}
{-   C[1] = 1                                            -}
{-   C[2] = X                                            -}
{---------------------------------------------------------}

var
  Row : integer;

begin
  NumTerms := 2;  { This is only a straight line least squares  }
  for Row := 1 to NumPoints do
  begin
    Basis[Row, 1] := 1;
    Basis[Row, 2] := WData[Row];
  end;
end; { procedure PowerCreateBasisFunctions }

procedure PowerTransformSolution(NumTerms      : integer;
                             var OldSolution   : TNRowVector;
                                 Multiplier    : Float;
                                 DummyConstant : Float;
                             var NewSolution   : TNRowVector);

{--------------------------------------------------------------}
{- Input: NumTerms, OldSolution, Multiplier, DummyConstant    -}
{- Output: NewSolution                                        -}
{-                                                            -}
{- The least squares solution will be more useful if it is    -}
{- expressed in terms of Y = AX^B, rather than in terms       -}
{- of Ln(Y) = B * Ln(X) + Ln(A).                              -}
{--------------------------------------------------------------}

begin
  NewSolution[1] := Multiplier * Exp(OldSolution[1]);
end; { procedure PowerTransformSolution }

{-------------------------------------------------------------------------}
{-                                                                       -}
{-            Y = A * Exp(bx)                                            -}
{-                                                                       -}
{- This module creates basis vectors to find a least squares solution    -}
{- of the form    f(X) = A * Exp(bx).  Taking the logarithm of both      -}
{- sides:   Ln(f(X)) = Ln(A) + B * X. A linear least squares fit         -}
{- (i.e. with basis vectors X and 1) is then made to the data            -}
{- (X, Ln(Y)). The slope will be B, and the intercept will be Ln(A).     -}
{-                                                                       -}
{- The function ModuleName identifies this as the exponential fit        -}
{- The procedure Transform converts the data from (X, Y) to (X, Ln(Y)).  -}
{- The procedure InverseTransform converts from YFit to Exp(YFit)        -}
{- The procedure CreateBasisFunctions creates the vectors 1 and X.       -}
{- The procedure TransformSolution changes the solution vector from      -}
{- (Ln(A), B) to (A, B).  Therefore, the first coefficient is a,         -}
{- and the second coefficient is B.                                      -}
{-                                                                       -}
{-------------------------------------------------------------------------}

procedure ExpoTransform(NumPoints     : integer;
                    var XData         : TNColumnVector;
                    var YData         : TNColumnVector;
                    var Multiplier    : Float;
                        DummyConstant : Float;
                    var WData         : TNColumnVector;
                    var ZData         : TNColumnVector;
                    var Error         : byte);

{---------------------------------------------------------------}
{- Input : NumPoints, XData, YData, Multiplier, DummyConstant  -}
{- Output: WData, ZData, Error                                 -}
{-                                                             -}
{- This procedure transforms the Y values to their             -}
{- logarithms.  A linear least squares fit will then be made   -}
{- to Ln(Y) = bx + Ln(A). If the Y values are of different     -}
{- sign, then Error = 3 is returned.                           -}
{---------------------------------------------------------------}

var
  Index : integer;
  YPoint : Float;

begin
  WData := XData;
  if  YData[1] < 0 then
    Multiplier := -1
  else
    Multiplier := 1;
  Index := 0;
  while (Index < NumPoints) and (Error = 0) do
  begin
    Index := Succ(Index);
    YPoint := Multiplier * YData[Index];
    if YPoint <= 0 then
      Error := 3   { The Y values must all have the same sign }
    else
      ZData[Index] := Ln(YPoint);
  end;
end; { procedure ExpoTransform }

procedure ExpoInverseTransform(Multiplier    : Float;
                               DummyConstant : Float;
                           var YFit          : Float);

{-------------------------------------------------}
{- Input: Multiplier, DummyConstant, YFit        -}
{- Output: YFit                                  -}
{-                                               -}
{- This procedure undoes the transformation of   -}
{- the YFit values.  Here, the function          -}
{- YFit := Exp(YFit) is performed to undo the    -}
{- Ln transformation in procedure Transform.     -}
{-------------------------------------------------}

begin
  YFit := Multiplier * Exp(YFit);
end; { procedure ExpoInverseTransform }

procedure ExpoCreateBasisFunctions(NumPoints : integer;
                               var NumTerms  : integer;
                               var WData     : TNColumnVector;
                               var Basis     : TNmatrix);

{---------------------------------------------------------}
{- Input: NumPoints, NumTerms, WData                     -}
{- Output: Basis                                         -}
{-                                                       -}
{- This procedure creates a matrix of basis vectors.     -}
{-                                                       -}
{- The elements of the matrix are:                       -}
{-     Basis[i, j] = C[j](WData[i])                      -}
{- where C[j](WData[i]) is the jth basis vector          -}
{- evaluated at the value WData[i].                      -}
{-                                                       -}
{- The vectors are:                                      -}
{-   C[1] = 1                                            -}
{-   C[2] = X                                            -}
{---------------------------------------------------------}

var
  Row : integer;

begin
  NumTerms := 2;  { This is only a straight line least squares }
  for Row := 1 to NumPoints do
  begin
    Basis[Row, 1] := 1;
    Basis[Row, 2] := WData[Row];
  end;
end; { procedure ExpoCreateBasisFunctions }

procedure ExpoTransformSolution(NumTerms      : integer;
                            var OldSolution   : TNRowVector;
                                Multiplier    : Float;
                                DummyConstant : Float;
                            var NewSolution   : TNRowVector);

{--------------------------------------------------------------}
{- Input: NumTerms, OldSolution, Multiplier, DummyConstant    -}
{- Output: NewSolution                                        -}
{-                                                            -}
{- The least squares solution will be more useful if it is    -}
{- expressed in terms of Y = A - Exp(bx), rather than in      -}
{- terms of Ln(Y) = B - X + Ln(A).                            -}
{--------------------------------------------------------------}

begin
  NewSolution[1] := Multiplier * Exp(OldSolution[1]);
end; { procedure ExpoTransformSolution }

{-------------------------------------------------------------------------}
{-                                                                       -}
{-            Y = A * Ln(bx)                                             -}
{-                                                                       -}
{- This module creates basis vectors to find a least squares solution    -}
{- of the form    f(X) = A * Ln(bx).  Rewriting the right side of the    -}
{- equation:  f(X) = A * Ln(X) + A * Ln(B).  A linear least squares fit  -}
{- (i.e. with basis vectors Ln(X) and 1) is then made to the data        -}
{- (Ln(X), Y). The slope will be A, and the intercept will be A * Ln(B). -}
{-                                                                       -}
{- The function ModuleName identifies this as the logarithmic fit        -}
{- The procedure Transform converts the data from (X, Y) to (Ln(X), Y).  -}
{- The procedure InverseTransform doesn't do anything in this module.    -}
{- The procedure CreateBasisFunctions creates the vectors Ln(X) and 1.   -}
{- The procedure TransformSolution changes the solution vector from      -}
{- (A, A * Ln(B)) to (A, B).  Therefore, the first coefficient is A,     -}
{- and the second coefficient is B.                                      -}
{-                                                                       -}
{-------------------------------------------------------------------------}

procedure LogTransform(NumPoints     : integer;
                   var XData         : TNColumnVector;
                   var YData         : TNColumnVector;
                   var Multiplier    : Float;
                       DummyConstant : Float;
                   var WData         : TNColumnVector;
                   var ZData         : TNColumnVector;
                   var Error         : byte);

{---------------------------------------------------------------}
{- Input : NumPoints, XData, YData, Multiplier, DummyConstant  -}
{- Output: WData, ZData, Error                                 -}
{-                                                             -}
{- This procedure transforms the X values to their             -}
{- logarithms.  A linear least squares fit will then be made   -}
{- to Y = ALn(X) + ALn(B).  If the X values are of different   -}
{- sign, then Error = 3 is returned.                           -}
{---------------------------------------------------------------}

var
  Index : integer;
  XPoint : Float;

begin
  ZData := YData;
  if  XData[1] < 0 then
    Multiplier := -1
  else
    Multiplier := 1;
  Index := 0;
  while (Index < NumPoints) and (Error = 0) do
  begin
    Index := Succ(Index);
    XPoint := Multiplier * XData[Index];
    if XPoint <= 0 then
      Error := 3   { The X values must all have the same sign  }
    else
      WData[Index] := Ln(XPoint);
  end;
end; { procedure LogTransform }

procedure LogInverseTransform(Multiplier    : Float;
                              DummyConstant : Float;
                          var YFit          : Float);

{---------------------------------------------------}
{- Input: Multiplier, DummyConstant, YFit          -}
{- Output: YFit                                    -}
{-                                                 -}
{- This procedure undoes the transformation of     -}
{- the YFit values.  Here, no inverse transform    -}
{- is performed because the was no transformation  -}
{- in procedure Transform.                         -}
{---------------------------------------------------}

begin
end;{ procedure LogInverseTransform }

procedure LogCreateBasisFunctions(NumPoints : integer;
                              var NumTerms  : integer;
                              var WData     : TNColumnVector;
                              var Basis     : TNmatrix);

{---------------------------------------------------------}
{- Input: NumPoints, NumTerms, WData                     -}
{- Output: Basis                                         -}
{-                                                       -}
{- This procedure creates a matrix of basis vectors.     -}
{-                                                       -}
{- The elements of the matrix are:                       -}
{-     Basis[i, j] = C[j](WData[i])                      -}
{- where C[j](WData[i]) is the jth basis vector          -}
{- evaluated at the value WData[i].                      -}
{-                                                       -}
{- The vectors are:                                      -}
{-   C[1] = X                                            -}
{-   C[2] = 1                                            -}
{---------------------------------------------------------}

var
  Row : integer;

begin
  NumTerms := 2; { This is only a straight line least squares  }
  for Row := 1 to NumPoints do
  begin
    Basis[Row, 1] := WData[Row];
    Basis[Row, 2] := 1;
  end;
end; { procedure LogCreateBasisFunctions }

procedure LogTransformSolution(NumTerms      : integer;
                           var OldSolution   : TNRowVector;
                               Multiplier    : Float;
                               DummyConstant : Float;
                           var NewSolution   : TNRowVector);

{--------------------------------------------------------------}
{- Input: NumTerms, OldSolution, Multiplier, DummyConstant    -}
{- Output: NewSolution                                        -}
{-                                                            -}
{- The least squares solution will be more useful if it is    -}
{- expressed in terms of Y = A - Ln(bx), rather than in       -}
{- terms of Y = ALn(X) + ALn(B).                              -}
{--------------------------------------------------------------}

begin
  NewSolution[2] := Multiplier * Exp(OldSolution[2]/OldSolution[1]);
end; { procedure LogTransformSolution }

{-------------------------------------------------------------------------}
{-                                                                       -}
{-            User Defined function                                      -}
{-                                                                       -}
{- This module provides the format for the user to create her own basis  -}
{- vectors.                                                              -}
{-                                                                       -}
{- The function ModuleName identifies this as the user's Module.         -}
{-   This function should be changed to identify the user's basis.       -}
{- The procedure Transform converts the data from (X, Y) to an           -}
{-   appropriate format (e.g. (Ln(X), Ln(Y)) ). If no transformation     -}
{-   is needed, this procedure should not be changed.                    -}
{- The procedure InverseTransform undoes the transformation of the       -}
{-   Y-coordinate.  In the above example, the procedure would perform    -}
{-   the function YFit := Exp(YFit).  This allows comparison between     -}
{-   least squares approximation and the actual Y-values.                -}
{- The procedure CreateBasisFunctions creates the  basis vectors. The    -}
{-   least squares solution will be coefficients of these basis vectors. -}
{-   Currently the basis vectors are powers of X.                        -}
{- The procedure TransformSolution transforms the solution vector to     -}
{-   an appropriate format.  This usually undoes the transformation made -}
{-   in procedure Transform. If no transformation is needed, this        -}
{-   procedure should not be changed.                                    -}
{-                                                                       -}
{-------------------------------------------------------------------------}

procedure UserTransform(NumPoints       : integer;
                    var XData           : TNColumnVector;
                    var YData           : TNColumnVector;
                    var DummyMultiplier : Float;
                    var DummyConstant   : Float;
                    var WData           : TNColumnVector;
                    var ZData           : TNColumnVector;
                    var Error           : byte);

{---------------------------------------------------------------}
{- Input : NumPoints, XData, YData, DummyMultiplier,           -}
{-         DummyConstant                                       -}
{- Output: WData, ZData, Error                                 -}
{-                                                             -}
{- This procedure transforms the input data to an appropriate  -}
{- format.  The transformed (or possibly unchanged) data is    -}
{- returned in WData, ZData.                                   -}
{---------------------------------------------------------------}

var
  Index : integer;

begin
  WData := XData;     { No transformation  }
  ZData := YData;     { No transformation  }
end; { procedure UserTransform }

procedure UserInverseTransform(DummyMultiplier : Float;
                               DummyConstant   : Float;
                           var YFit            : Float);

{---------------------------------------------------}
{- Input: DummyMultiplier, DummyConstant, YFit     -}
{- Output: YFit                                    -}
{-                                                 -}
{- This procedure undoes the transformation of     -}
{- the YFit values.  No inverse transformation     -}
{- may be necessary.                               -}
{---------------------------------------------------}

begin
end; { procedure UserInverseTransform }

procedure UserCreateBasisFunctions(NumPoints : integer;
                               var NumTerms  : integer;
                               var WData     : TNColumnVector;
                               var Basis     : TNmatrix);

{---------------------------------------------------------}
{- Input: NumPoints, NumTerms, WData                     -}
{- Output: Basis                                         -}
{-                                                       -}
{- This procedure creates a matrix of basis vectors.     -}
{- The user must modify this procedure.                  -}
{-                                                       -}
{- The elements of the matrix must be:                   -}
{-     Basis[i, j] = Bj(WData[i])                        -}
{- where Bj(WData[i]) is the jth basis vector evaluated  -}
{- at the value WData[i].                                -}
{-                                                       -}
{- For example, the basis vector might be powers of X:   -}
{-   B1 = 1                                              -}
{-   B2 = X                                              -}
{-   B3 = X^2                                            -}
{-   B4 = X^3                                            -}
{-   etc.                                                -}
{-                                                       -}
{- These vectors can be defined recursively:             -}
{-   B1 = 1                                              -}
{-   Bj = X * B[j - 1]                                   -}
{---------------------------------------------------------}

var
  Row, Column : integer;

begin
  for Row := 1 to NumPoints do
  begin
    Basis[Row, 1] := 1;
    for Column := 2 to NumTerms do
    Basis[Row, Column] := WData[Row] * Basis[Row, Column - 1];
  end;
end; { procedure UserCreateBasisFunctions }

procedure UserTransformSolution(NumTerms        : integer;
                            var OldSolution     : TNRowVector;
                                DummyMultiplier : Float;
                                DummyConstant   : Float;
                            var NewSolution     : TNRowVector);

{--------------------------------------------------------------}
{- Input: NumTerms, OldSolution, DummyMultiplier,             -}
{-        DummyConstant                                       -}
{- Output: NewSolution                                        -}
{-                                                            -}
{- This procedure transforms the solution into an appropriate -}
{- form.  The transformed (or possibly unchanged) solution    -}
{- is returned in NewSoluition.                               -}
{--------------------------------------------------------------}

begin
  NewSolution := OldSolution; { No transformation  }
end; { procedure UserTransformSolution }
