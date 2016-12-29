unit Interp;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-  This unit provides procedures for performing interpolation.             -}
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

  TNArraySize = 50;            { Size of vectors }

type
  TNvector = array[0..TNArraySize] of Float;
  TNmatrix = array[0..TNArraySize] of TNvector;

procedure Lagrange(NumPoints : integer;
               var XData     : TNvector;
               var YData     : TNvector;
                   NumInter  : integer;
               var XInter    : TNvector;
               var YInter    : TNvector;
               var Poly      : TNvector;
               var Error     : byte);

{--------------------------------------------------------------------------}
{-                                                                        -}
{-    Input:  NumPoints, XData, YData, NumInter, XInter                   -}
{-    Output: YInter, Poly, Error                                         -}
{-                                                                        -}
{-           Purpose: Given a set of points (X,Y), use Lagrange           -}
{-                    polynomials to construct a polynomial               -}
{-                    to fit the points.                                  -}
{-                    The degree of the polynomial is one less            -}
{-                    than the number of points.                          -}
{-                    Use this polynomial to interpolate between          -}
{-                    the points.                                         -}
{-                                                                        -}
{- User-defined Types: TNvector = array[0..TNArraySize] of real;          -}
{-                                                                        -}
{-                                                                        -}
{-  Global Variables: NumPoints : integer;  Number of points              -}
{-                    XData     : TNvector; X-coordinate data points      -}
{-                    YData     : TNvector; Y-coordinate data points      -}
{-                    NumInter  : integer;  Number of interpolated points -}
{-                    XInter    : TNvector; X-coordinate of points        -}
{-                                          at which to interpolate       -}
{-                    YInter    : TNvector; Calculated Y-coordinate of    -}
{-                                          interpolated points           -}
{-                    Poly      : TNvector; Coefficients of               -}
{-                                          interpolating polynomial      -}
{-                    Error     : byte;     Flags an error                -}
{-                                                                        -}
{-            Errors: 0: No errors                                        -}
{-                    1: Points not unique                                -}
{-                    2: NumPoints < 1                                    -}
{-                                                                        -}
{--------------------------------------------------------------------------}

procedure Divided_Difference(NumPoints : integer;
                         var XData     : TNvector;
                         var YData     : TNvector;
                             NumInter  : integer;
                         var XInter    : TNvector;
                         var YInter    : TNvector;
                         var Error     : byte);


{----------------------------------------------------------------------------}
{-                                                                          -}
{-      Input:  NumPoints, XData, YData, NumInter, XInter                   -}
{-      Output: YInter, Error                                               -}
{-                                                                          -}
{-            Purpose: This unit uses Newton's interpolary divided          -}
{-                     difference equation as an interpolation algorithm.   -}
{-                     This is a general divided difference equation and    -}
{-                     so is not limited to uniform spacing; variable       -}
{-                     spacing is allowed.  Furthermore, the data points    -}
{-                     do not have to be in sequential order. The user      -}
{-                     must supply the data points (X,Y) and the points     -}
{-                     at which an interpolated value should be calculated. -}
{-                                                                          -}
{-  User-defined Types: TNvector = array[0..TNArraySize] OF real;           -}
{-                      TNmatrix = array[0..TNArraySize] OF TNvector;       -}
{-                                                                          -}
{-   Global Variables: NumPoints : integer;   Number of data points         -}
{-                     XData     : TNvector;  X-coordinate data points      -}
{-                     YData     : TNvector;  Y-coordinate data points      -}
{-                     NumInter  : integer;   Number of points at which     -}
{-                                            to interpolate                -}
{-                     XInter    : TNvector;  X-coordinate of               -}
{-                                            interpolation points          -}
{-                     YInter    : TNvector;  Calculated Y-coordinate       -}
{-                                            of interpolation points       -}
{-                     Error     : byte;      Flags if something went wrong -}
{-                                                                          -}
{-             Errors: 0: No Error                                          -}
{-                     1: XData points not unique                           -}
{-                     2: NumPoints < 1                                     -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure CubicSplineFree(NumPoints : integer;
                      var XData     : TNvector;
                      var YData     : TNvector;
                          NumInter  : integer;
                      var XInter    : TNvector;
                      var Coef0     : TNvector;
                      var Coef1     : TNvector;
                      var Coef2     : TNvector;
                      var Coef3     : TNvector;
                      var YInter    : TNvector;
                      var Error     : byte);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input:  NumPoints, XData, YData, NumInter, XInter                     -}
{-    Output: Coef0, Coef1, Coef2, Coef3, YInter, Error                     -}
{-                                                                          -}
{-            Purpose: To construct a cubic spline interpolant              -}
{-                     to a set of points. The second derivative            -}
{-                     of the interpolant is assumed to be zero             -}
{-                     at the endpoints (free cubic spline)                 -}
{-                     The spline is of the form                            -}
{-                                                                          -}
{-                        3               2                                 -}
{-            D[I](X-X[I])  + C[I](X-X[I])  + B[I](X-X[I]) + A[I]           -}
{-                                                                          -}
{-                     where 1 < I < NumPoints.                             -}
{-                                                                          -}
{-  User-defined Types: TNvector = ARRAY[0..TNArraySize] OF real;           -}
{-                                                                          -}
{- Global Variables: NumPoints : integer;  Number of points                 -}
{-                   XData     : TNvector; X-coordinate data points         -}
{-                                         (must be in increasing order)    -}
{-                   YData     : TNvector; Y-coordinate data points         -}
{-                   Coef0     : TNvector; 0th coefficient of spline        -}
{-                   Coef1     : TNvector; 1st coefficient of spline        -}
{-                   Coef2     : TNvector; 2nd coefficient of spline        -}
{-                   Coef3     : TNvector; 3rd coefficient of spline        -}
{-                   NumInter  : integer;  Number of interpolated points    -}
{-                   XInter    : TNvector; Points at which to interpolate   -}
{-                   YInter    : TNvector; Interpolated values at XInter    -}
{-                   Error     : byte;     0: flags if something goes wrong -}
{-                                                                          -}
{-              Errors: 0: No error                                         -}
{-                      1: X-coordinate points not                          -}
{-                         unique                                           -}
{-                      2: X-coordinate points not                          -}
{-                         in increasing order                              -}
{-                      3: NumPoints < 2                                    -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure CubicSplineClamped(NumPoints : integer;
                         var XData     : TNvector;
                         var YData     : TNvector;
                             DerivLE   : Float;
                             DerivRE   : Float;
                             NumInter  : integer;
                         var XInter    : TNvector;
                         var Coef0     : TNvector;
                         var Coef1     : TNvector;
                         var Coef2     : TNvector;
                         var Coef3     : TNvector;
                         var YInter    : TNvector;
                         var Error     : byte);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input:  NumPoints, XData, YData, DerivLE, DerivRE, NumInter, XInter   -}
{-    Output: Coef0, Coef1, Coef2, Coef3, YInter, Error                     -}
{-                                                                          -}
{-            Purpose: To construct a cubic spline interpolant              -}
{-                     to a set of points. The first derivative             -}
{-                     of the interpolant is defined by the user            -}
{-                     at the endpoints (clamped cubic spline)              -}
{-                     The spline is of the form                            -}
{-                                                                          -}
{-                        3               2                                 -}
{-            D[I](X-X[I])  + C[I](X-X[I])  + B[I](X-X[I]) + A[I]           -}
{-                                                                          -}
{-                     where 1 < I < NumPoints.                             -}
{-                                                                          -}
{-  User-defined Types: TNvector = ARRAY[0..TNArraySize] of real;           -}
{-                                                                          -}
{- Global Variables: NumPoints : integer;   Number of points                -}
{-                   XData     : TNvector;  X-coordinate data points        -}
{-                                          (must be in increasing order)   -}
{-                   YData     : TNvector;  y-coordinate data points        -}
{-                   DerivLE   : real;      derivative on the left end      -}
{-                   DerivRE   : real;      derivative on the right end     -}
{-                   Coef0     : TNvector;  0th coefficient of spline       -}
{-                   Coef1     : TNvector;  1st coefficient of spline       -}
{-                   Coef2     : TNvector;  2nd coefficient of spline       -}
{-                   Coef3     : TNvector;  3rd coefficient of spline       -}
{-                   NumInter  : integer;   Number of interpolated points   -}
{-                   XInter    : TNvector;  Points at which to interpolate  -}
{-                   YInter    : TNvector;  interpolated values at XInter   -}
{-                   Error     : byte;      flags if something goes wrong   -}
{-                                                                          -}
{-             Errors: 0: No error                                          -}
{-                     1: X-coordinate points not                           -}
{-                        unique                                            -}
{-                     2: X-coordinate points not                           -}
{-                        in increasing order                               -}
{-                     3: NumPoints < 2                                     -}
{-                                                                          -}
{----------------------------------------------------------------------------}

implementation

procedure Lagrange{(NumPoints : integer;
               var XData      : TNvector;
               var YData      : TNvector;
                   NumInter   : integer;
               var XInter     : TNvector;
               var YInter     : TNvector;
               var Poly       : TNvector;
               var Error      : byte)};

var
  Degree : integer;        { Degree of resulting polynomial }
                           { one less than NumPoints        }

procedure SynDiv(Degree : integer;
             var Poly   : TNvector;
                 X      : Float;
             var Y      : Float);

{----------------------------------------------------------------------}
{- Input:  Degree, Poly, X                                            -}
{- Output: Y                                                          -}
{-                                                                    -}
{- This procedure applies the technique of synthetic division         -}
{- to a polynomial, Poly, at the value X.  The result is the value    -}
{- of the polynomial at X.                                            -}
{----------------------------------------------------------------------}

var
  Index : integer;

begin
  Y := Poly[Degree];
  for Index := Degree-1 downto 0 do
    Y := Y * X + Poly[Index];
end; { procedure SynDiv }

procedure MakePolynomial(Degree : integer;
                     var XData  : TNvector;
                     var YData  : TNvector;
                     var Poly   : TNvector;
                     var Error  : byte);

{----------------------------------------------------------------}
{- Input: Degree, XData, YData                                  -}
{- Output: Poly, Error                                          -}
{-                                                              -}
{- This procedure constructs the polynomial which fits the data -}
{- points (XData, YData).  The coefficients of the polynomial   -}
{- are returned in Poly.  If the XData points are not unique,   -}
{- then Error = 1 is returned.                                  -}
{----------------------------------------------------------------}

var
  T, D : TNvector;       { Iterative variables for computing }
                         { the Lagrange Polynomial           }
  Num, Denom, Coef : Float;
  Term, Term2 : integer;

begin
  for Term := 1 to Degree + 1 do
  begin
    T[Term] := 0;
    D[Term] := 0
  end;
  T[0] := YData[1];
  D[0] := -XData[1];
  D[1] := 1;
  for Term := 1 to Degree do
  begin
    { Evaluate D at XData[Term] }
    SynDiv(Term, D, XData[Term + 1], Denom);
    if ABS(Denom) < TNNearlyZero then
      Error := 1    { Points not unique }
    else
      begin
        { Evaluate T at XData[Term] }
        SynDiv(Term - 1, T, XData[Term + 1], Num);
        Coef := (YData[Term + 1] - Num) / Denom;
        for Term2 := Term downto 0 do
        begin
          T[Term2] := Coef * D[Term2] + T[Term2];
          D[Term2 + 1] := D[Term2] - XData[Term + 1] * D[Term2 + 1];
        end;
        D[0] := -XData[Term + 1] * D[0];
      end;
  end;
  Poly := T;
end; { procedure MakePoly }

procedure SolvePolynomial(Degree   : integer;
                          NumInter : integer;
                      var XInter   : TNvector;
                      var Poly     : TNvector;
                      var YInter   : TNvector);

{--------------------------------------------------------------}
{- Input:  Degree, NumInter, XInter, Poly                     -}
{- Output: YInter                                             -}
{-                                                            -}
{- This procedure uses the technique of synthetic division to -}
{- solve the polynomial, Poly, at the X values contained in   -}
{- XInter.  These interpolated values are returned in YInter. -}
{--------------------------------------------------------------}

var
  Term : integer;

begin
  for Term := 1 to NumInter do
    SynDiv(Degree, Poly, XInter[Term], YInter[Term]);
end; { procedure SolvePolynomial }

begin { procedure Lagrange }
  Degree := NumPoints - 1;
  Error := 0;
  if NumPoints < 1 then
    Error := 2
  else
    begin
      MakePolynomial(Degree, XData, YData, Poly, Error);
      SolvePolynomial(Degree, NumInter, XInter, Poly, YInter);
    end;
end; { procedure Lagrange }

procedure Divided_Difference{(NumPoints : integer;
                         var XData      : TNvector;
                         var YData      : TNvector;
                             NumInter   : integer;
                         var XInter     : TNvector;
                         var YInter     : TNvector;
                         var Error      : byte)};


var
  DividedDif : TNmatrix;              { Divided difference table }

procedure MakeDivDifTable(NumPoints : integer;
                      var XData     : TNvector;
                      var YData     : TNvector;
                      var DivDif    : TNmatrix;
                      var Error     : byte);

{--------------------------------------------------------------}
{- Input: NumPoints, XData, YData                             -}
{- Output: DivDif, Error                                      -}
{-                                                            -}
{- This procedure constructs a NumPoints X NumPoints divided  -}
{- difference table (DivDif). If the X values are not unique, -}
{- then Error = 1 is returned.                                -}
{--------------------------------------------------------------}

var
  Row, Column : integer;
  Den : Float;

begin
  Error := 0;
  for Row := 1 to NumPoints do
    DivDif[Row, 1] := YData[Row];

  for Column := 2 to NumPoints do
    for Row := Column to NumPoints do
    begin
      Den := XData[Row] - XData[Row - Column + 1];
      if ABS(Den) < TNNearlyZero then
        Error := 1
      else
        DivDif[Row, Column] :=
                   (DivDif[Row, Column-1] - DivDif[Row-1, Column-1]) / Den;
    end;
end; { procedure MakeDivDifTable }

procedure EvaluateNewtonFormula(NumPoints : integer;
                            var DivDif    : TNmatrix;
                            var XData     : TNvector;
                                NumInter  : integer;
                            var XInter    : TNvector;
                            var YInter    : TNvector);

{---------------------------------------------------------------------}
{- Input:  NumPoints, DivDif, XData, NumInter, XInter                -}
{- Output: YInter                                                    -}
{-                                                                   -}
{- Newton's interpolary divided difference formula interpolates      -}
{- between data points if a divided difference table of those points -}
{- exists.  This procedure interpolates at the points contained in   -}
{- XInter using Newton's interpolary  divided difference formula.    -}
{- The interpolated values are returned in YInter.                   -}
{---------------------------------------------------------------------}

var
  Index, Coef : integer;
  Factor, Unknown : Float;

begin { procedure EvaluateNewtonFormula }
  for Index := 1 to NumInter do
  begin
    YInter[Index] := 0;
    Unknown := XInter[Index];
    for Coef := 1 to NumPoints do
    begin
      if Coef = 1 then
        Factor := 1
      else
        Factor := Factor * (Unknown - XData[Coef-1]);
      YInter[Index] := YInter[Index] + Factor * DivDif[Coef, Coef];
    end;
  end;
end; { procedure EvaluateNewtonFormula }

begin { procedure Divided_Difference }
  Error := 0;
  if NumPoints < 1 then
    Error := 2
  else
    MakeDivDifTable(NumPoints, XData, YData, DividedDif, Error);
  if Error = 0 then
    EvaluateNewtonFormula(NumPoints, DividedDif, XData,
                          NumInter, XInter, YInter);
end; { procedure Divided_Difference }

procedure CubicSplineFree{(NumPoints : integer;
                      var XData      : TNvector;
                      var YData      : TNvector;
                          NumInter   : integer;
                      var XInter     : TNvector;
                      var Coef0      : TNvector;
                      var Coef1      : TNvector;
                      var Coef2      : TNvector;
                      var Coef3      : TNvector;
                      var YInter     : TNvector;
                      var Error      : byte)};

type
  TNcoefficients = record
                     A, B, C, D : TNvector;
                   end;

var
  Interval : TNvector;        { Intervals between adjacent points }
  Spline : TNcoefficients;    { All the cubics }

procedure CalculateIntervals(NumPoints : integer;
                         var XData     : TNvector;
                         var Interval  : TNvector;
                         var Error     : byte);

{----------------------------------------------------------}
{- Input: NumPoints, XData                                -}
{- Output: Interval, Error                                -}
{-                                                        -}
{- This procedure calculates the length of the interval   -}
{- between two adjacent X values, contained in XData. If  -}
{- the X values are not sequential, Error = 2 is returned -}
{- and if the X values are not unique, then Error = 1 is  -}
{- returned.                                              -}
{----------------------------------------------------------}

var
  Index : integer;

begin
  Error := 0;
  for Index := 1 to NumPoints - 1 do
  begin
    Interval[Index] := XData[Index+1] - XData[Index];
    if ABS(Interval[Index]) < TNNearlyZero then
      Error := 1;     { Data not unique }
    if Interval[Index] < 0 then
      Error := 2;     { Data not in increasing order }
  end;
end; { procedure CalculateIntervals }

procedure CalculateCoefficients(NumPoints : integer;
                            var XData     : TNvector;
                            var YData     : TNvector;
                            var Interval  : TNvector;
                            var Spline    : TNcoefficients);

{---------------------------------------------------------------}
{- Input: NumPoints, XData, YData, Interval                    -}
{- Output: Spline                                              -}
{-                                                             -}
{- This procedure calculates the coefficients of each cubic    -}
{- in the interpolating spline. A separate cubic is calculated -}
{- for every interval between data points.  The coefficients   -}
{- are returned in the variable Spline.                        -}
{---------------------------------------------------------------}

procedure CalculateAs(NumPoints : integer;
                  var YData     : TNvector;
                  var Spline    : TNcoefficients);

{------------------------------------------}
{- Input: NumPoints, YData                -}
{- Ouput: Spline                          -}
{-                                        -}
{- This procedure calculates the constant -}
{- Term in each cubic.                    -}
{------------------------------------------}

var
  Index : integer;
begin
  for Index := 1 to NumPoints do
    Spline.A[Index] := YData[Index];
end; { procedure CalculateAs }

procedure CalculateCs(NumPoints : integer;
                  var XData     : TNvector;
                  var Interval  : TNvector;
                  var Spline    : TNcoefficients);

{---------------------------------------------}
{- Input: NumPoints, XData, Interval         -}
{- Ouput: Spline                             -}
{-                                           -}
{- This procedure calculates the coefficient -}
{- of the squared Term in each cubic.        -}
{---------------------------------------------}

var
  Alpha, L, Mu, Z : TNvector;
  Index : integer;
begin
  with Spline do
  begin
    { The next few lines solve a tridiagonal matrix }
    for Index := 2 to NumPoints - 1 do
      Alpha[Index] := 3 * ((A[Index+1] * Interval[Index-1])
                         - (A[Index] * (XData[Index+1] - XData[Index-1]))
                         + (A[Index-1] * Interval[Index]))
                         / (Interval[Index-1] * Interval[Index]);
    L[1] := 0;
    Mu[1] := 0;
    Z[1] := 0;
    for Index := 2 to NumPoints - 1 do
    begin
      L[Index] := 2 * (XData[Index+1] - XData[Index-1])
                    - Interval[Index-1] * Mu[Index-1];
      Mu[Index] := Interval[Index]/L[Index];
      Z[Index] := (Alpha[Index] - Interval[Index-1] * Z[Index-1]) / L[Index];
    end;
    { Now calculate the C's }
    C[NumPoints] := 0;
    for Index := NumPoints - 1 downto 1 do
      C[Index] := Z[Index] - Mu[Index] * C[Index+1];
  end; { with }
end; { procedure CalculateCs }

procedure CalculateBandDs(NumPoints : integer;
                      var Interval  : TNvector;
                      var Spline    : TNcoefficients);

{------------------------------------------------}
{- Input: NumPoints, Interval                   -}
{- Ouput: Spline                                -}
{-                                              -}
{- This procedure calculates the coefficient of -}
{- the linear and cubic terms in each cubic.    -}
{------------------------------------------------}

var
  Index : integer;
begin
  with Spline do
    for Index := NumPoints - 1 downto 1 do
    begin
      B[Index] := (A[Index+1] - A[Index]) / Interval[Index]
                   - Interval[Index] * (C[Index+1] + 2 * C[Index]) / 3;
      D[Index] := (C[Index+1] - C[Index]) / (3 * Interval[Index]);
    end;
end; { procedure CalculateDs }

begin { procedure CalculateCoefficients }
  CalculateAs(NumPoints, YData, Spline);
  CalculateCs(NumPoints, XData, Interval, Spline);
  CalculateBandDs(NumPoints, Interval, Spline);
end; { procedure CalculateCoefficients }

procedure Interpolate(NumPoints : integer;
                  var XData     : TNvector;
                  var Spline    : TNcoefficients;
                      NumInter  : integer;
                  var XInter    : TNvector;
                  var YInter    : TNvector);

{---------------------------------------------------------------}
{- Input: NumPoints, XData, Spline, NumInter, XInter           -}
{- Output: YInter                                              -}
{-                                                             -}
{- This procedure uses the interpolating cubic spline (Spline) -}
{- to interpolate values for the X positions contained         -}
{- in XInter.  The interpolated values are returned in YInter. -}
{---------------------------------------------------------------}

var
  Index, Location, Term : integer;
  X : Float;

begin
  for Index := 1 to NumInter do
  begin
    Location := 1;
    for Term := 1 to NumPoints - 1 do
      if XInter[Index] > XData[Term] then
        Location := Term;
    X := XInter[Index] - XData[Location];
    with Spline do
      YInter[Index] := ((D[Location] * X + C[Location]) * X +
                         B[Location]) * X + A[Location];
  end;
end; { procedure Interpolate }

begin { procedure CubicSplineFree }
  Error := 0;
  if NumPoints < 2 then
    Error := 3
  else
    CalculateIntervals(NumPoints, XData, Interval, Error);
  if Error = 0 then
  begin
    CalculateCoefficients(NumPoints, XData, YData, Interval, Spline);
    Interpolate(NumPoints, XData, Spline, NumInter, XInter, YInter);
  end;
  Coef0 := Spline.A;
  Coef1 := Spline.B;
  Coef2 := Spline.C;
  Coef3 := Spline.D;
end; { procedure CubicSplineFree }

procedure CubicSplineClamped{(NumPoints : integer;
                         var XData      : TNvector;
                         var YData      : TNvector;
                             DerivLE    : Float;
                             DerivRE    : Float;
                             NumInter   : integer;
                         var XInter     : TNvector;
                         var Coef0      : TNvector;
                         var Coef1      : TNvector;
                         var Coef2      : TNvector;
                         var Coef3      : TNvector;
                         var YInter     : TNvector;
                         var Error      : byte)};

type
  TNcoefficient = record
                    A, B, C, D : TNvector;
                  end;

var
  Interval : TNvector;
  Spline : TNcoefficient;

procedure CalculateIntervals(NumPoints : integer;
                         var XData     : TNvector;
                         var Interval  : TNvector;
                         var Error     : byte);

{----------------------------------------------------------}
{- Input: NumPoints, XData                                -}
{- Output: Interval, Error                                -}
{-                                                        -}
{- This procedure calculates the length of the interval   -}
{- between two adjacent X values, contained in XData. If  -}
{- the X values are not sequential, Error = 2 is returned -}
{- and if the X values are not unique, then Error = 1 is  -}
{- returned.                                              -}
{----------------------------------------------------------}

var
  Index : integer;

begin
  Error := 0;
  for Index := 1 to NumPoints - 1 do
  begin
    Interval[Index] := XData[Index+1] - XData[Index];
    if ABS(Interval[Index]) < TNNearlyZero then
      Error := 1;    { Points not unique }

    if Interval[Index] < 0 then
      Error := 2;    { Points not in increasing order }
  end;
end; { procedure CalculateIntervals }

procedure CalculateCoefficients(NumPoints : integer;
                            var XData     : TNvector;
                            var YData     : TNvector;
                            var Interval  : TNvector;
                                DerivLE   : Float;
                                DerivRE   : Float;
                            var Spline    : TNcoefficient);

{---------------------------------------------------------------}
{- Input: NumPoints, XData, YData, Interval, DerivLE, DerivRE  -}
{- Output: Spline                                              -}
{-                                                             -}
{- This procedure calculates the coefficients of each cubic    -}
{- in the interpolating spline. A separate cubic is calculated -}
{- for every interval between data points.  The coefficients   -}
{- are returned in the variable Spline.                        -}
{---------------------------------------------------------------}

procedure CalculateAs(NumPoints : integer;
                  var YData     : TNvector;
                  var Spline    : TNcoefficient);

{------------------------------------------}
{- Input: NumPoints, YData                -}
{- Ouput: Spline                          -}
{-                                        -}
{- This procedure calculates the constant -}
{- term in each cubic.                    -}
{------------------------------------------}

var
  Index : integer;
begin
  for Index := 1 to NumPoints do
    Spline.A[Index] := YData[Index];
end; { procedure CalculateAs }

procedure CalculateCs(NumPoints : integer;
                  var XData     : TNvector;
                  var Interval  : TNvector;
                      DerivLE   : Float;
                      DerivRE   : Float;
                  var Spline    : TNcoefficient);

{---------------------------------------------}
{- Input: NumPoints, XData, Interval,        -}
{-        DerivLE, DerivRE                   -}
{- Ouput: Spline                             -}
{-                                           -}
{- This procedure calculates the coefficient -}
{- of the squared term in each cubic.        -}
{---------------------------------------------}

var
  Alpha, L, Mu, Z : TNvector;
  Index : integer;
begin
  with Spline do
  begin
    { The next few lines solve a tridiagonal matrix }
    Alpha[1] := 3*(A[2] - A[1]) / Interval[1] - 3 * DerivLE;
    Alpha[NumPoints] := 3 * DerivRE - 3 * (A[NumPoints] - A[NumPoints - 1])
                        / Interval[NumPoints - 1];
    for Index := 2 to NumPoints - 1 do
       Alpha[Index] := 3 * ((A[Index+1] * Interval[Index-1])
                       - (A[Index] * (XData[Index+1] - XData[Index-1]))
                       + (A[Index-1] * Interval[Index]))
                       / (Interval[Index-1] * Interval[Index]);
    L[1] := 2 * Interval[1];
    Mu[1] := 0.5;
    Z[1] := Alpha[1] / L[1];
    for Index := 2 to NumPoints - 1 do
    begin
      L[Index] := 2 * (XData[Index+1] - XData[Index-1]) -
                  Interval[Index-1] * Mu[Index-1];
      Mu[Index] := Interval[Index] / L[Index];
      Z[Index] := (Alpha[Index] - Interval[Index-1] * Z[Index-1]) / L[Index];
    end;

    { Now calculate the C's }
    C[NumPoints] := (Alpha[NumPoints] -
                    Interval[NumPoints - 1] * Z[NumPoints - 1])
                    / (Interval[NumPoints - 1] * (2-Mu[NumPoints - 1]));
    for Index := NumPoints - 1 downto 1 do
      C[Index] := Z[Index] - Mu[Index] * C[Index+1];
  end; { with }
end; { procedure CalculateCs }

procedure CalculateBandDs(NumPoints : integer;
                      var Interval  : TNvector;
                      var Spline    : TNcoefficient);

{------------------------------------------------}
{- Input: NumPoints, Interval                   -}
{- Ouput: Spline                                -}
{-                                              -}
{- This procedure calculates the coefficient of -}
{- the linear and cubic terms in each cubic.    -}
{------------------------------------------------}

var
  Index : integer;
begin
  with Spline do
    for Index := NumPoints - 1 downto 1 do
    begin
      B[Index] := (A[Index+1] - A[Index]) / Interval[Index]
                  - Interval[Index] * (C[Index+1] + 2 * C[Index]) / 3;
      D[Index] := (C[Index+1] - C[Index]) / (3 * Interval[Index]);
    end;
end; { procedure CalculateBandDs }

begin { procedure CalculateCoefficients }
  CalculateAs(NumPoints, YData, Spline);
  CalculateCs(NumPoints, XData, Interval, DerivLE, DerivRE, Spline);
  CalculateBandDs(NumPoints, Interval, Spline);
end; { procedure CalculateCoefficients }

procedure Interpolate(NumPoints : integer;
                  var XData     : TNvector;
                  var Spline    : TNcoefficient;
                      NumInter  : integer;
                  var XInter    : TNvector;
                  var YInter    : TNvector);

{---------------------------------------------------------------}
{- Input:  NumPoints, XData, Spline, NumInter, XInter          -}
{- Output: YInter                                              -}
{-                                                             -}
{- This procedure uses the interpolating cubic spline (Spline) -}
{- to interpolate values for the X positions contained         -}
{- in XInter.  The interpolated values are returned in YInter. -}
{---------------------------------------------------------------}

var
  Index, Location, Term : integer;
  X : Float;

begin
  for Index := 1 to NumInter do
  begin
    Location := 1;
    for Term := 1 to NumPoints - 1 do
      if XInter[Index] > XData[Term] then
        Location := Term;
    X := XInter[Index] - XData[Location];
    with Spline do
      YInter[Index] := ((D[Location] * X + C[Location]) * X +
                       B[Location]) * X + A[Location];
  end;
end; { procedure Interpolate }

begin { procedure CubicSplineClamped }
  Error := 0;
  if NumPoints < 2 then
    Error := 3
  else
    CalculateIntervals(NumPoints, XData, Interval, Error);
  if Error = 0 then
  begin
    CalculateCoefficients(NumPoints, XData, YData, Interval,
                          DerivLE, DerivRE, Spline);
    InterPolate(NumPoints, XData, Spline, NumInter, XInter, YInter);
  end;
  Coef0 := Spline.A;
  Coef1 := Spline.B;
  Coef2 := Spline.C;
  Coef3 := Spline.D;
end; { procedure CubicSplineClamped }

end. { Interp }
