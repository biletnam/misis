unit Differ;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-  This unit provides procedures for performing numerical differentiation. -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I Float.inc} { Determines the setting of the $N compiler directive }

interface

{$IFOPT N+}
type
  Float = Double; { 8 byte real, requires 8087 math chip }
{$ELSE}
type
  Float = real;   { 6 byte real, no math chip required }
{$ENDIF}

const
  TNArraySize = 100;              { Size of the vectors }

type
  TNvector = array[1..TNArraySize] of Float;

procedure First_Derivative(NumPoints : integer;
                       var XData     : TNvector;
                       var YData     : TNvector;
                           Point     : byte;
                           NumDeriv  : integer;
                       var XDeriv    : TNvector;
                       var YDeriv    : TNvector;
                       var Error     : byte);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input: NumPoints, XData, YData, Point, NumDeriv, XDeriv               -}
{-   Output: YDeriv, Error                                                  -}
{-                                                                          -}
{-  Purpose: Given a set of points (X,Y) to a function f, determine the     -}
{-           first derivative of f at the points XDeriv.  All the XDeriv    -}
{-           must be in the data set (X,Y).  Either 2, 3 or 5 point         -}
{-           differentiation may be used.                                   -}
{-                                                                          -}
{-  User-defined Types:  TNvector = array[1..TNArraySize] of real;          -}
{-                                                                          -}
{-    Global Variables:  NumPoints : integer;  Number of points             -}
{-                       XData     : TNvector; X-coordinate data points     -}
{-                       YData     : TNvector; Y-coordinate data points     -}
{-                       NumDeriv  : integer;  Number points at which to    -}
{-                                             take the derivative          -}
{-                       XDeriv    : TNvector; Point at which to take       -}
{-                                             the derivative               -}
{-                       YDeriv    : TNvector; Derivative at                -}
{-                                             points XDeriv                -}
{-                       Point     : byte;     2, 3, 5 point diff.          -}
{-                       Error     : byte;     Flags if something goes      -}
{-                                             wrong                        -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: Warning - not all the 2nd derivatives           -}
{-                          were calculated; NOT A FATAL ERROR! See Note    -}
{-                       2: Data not unique                                 -}
{-                       3: Data not in increasing order                    -}
{-                       4: Not enough data                                 -}
{-                       5: NOT(Point in [2, 3, 5])                         -}
{-                       6: Data points not evenly spaced for 5 point       -}
{-                                                                          -}
{-                Note:  If the point at which to take the derivative       -}
{-                       is not among the data points, the value of         -}
{-                       -9.9999999E35 is arbitrarily assigned as the       -}
{-                       derivative at that point. Error = 1 is returned.   -}
{-                       When trying to do 5 point differentiation          -}
{-                       with only 5 points, there is not enough            -}
{-                       information to calculate the 2nd derivative at     -}
{-                       the 1st, 2nd, 4th or 5th point. Likewise, if there -}
{-                       are only 6 points, there is not enough information -}
{-                       to calculate the derivative at the 2nd or 5th      -}
{-                       point. Should an attempt be made to evaluate the   -}
{-                       derivative at any of these points, the             -}
{-                       value of 9.9999999E35 is arbitrarily assigned      -}
{-                       as the derivative at that point. Error = 1 is      -}
{-                       returned.                                          -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Second_Derivative(NumPoints : integer;
                        var XData     : TNvector;
                        var YData     : TNvector;
                            Point     : byte;
                            NumDeriv  : integer;
                        var XDeriv    : TNvector;
                        var YDeriv    : TNvector;
                        var Error     : byte);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input: NumPoints, XData, YData, Point, NumDeriv, XDeriv               -}
{-   Output: YDeriv, Error                                                  -}
{-                                                                          -}
{-  Purpose: Given a set of points (X,Y) to a function f, determine the     -}
{-           second derivative of f at the points XDeriv.  All the XDeriv   -}
{-           must be in the data set (X,Y).  Either 3 or 5 point            -}
{-           second differentiation may be used.                            -}
{-                                                                          -}
{-  User-defined Types:  TNvector = array[1..TNArraySize] of real;          -}
{-                                                                          -}
{-    Global Variables:  NumPoints : integer;  Number of points             -}
{-                       XData     : TNvector; X-coordinate data points     -}
{-                       YData     : TNvector; Y-coordinate data points     -}
{-                       NumDeriv  : integer;  Number points at which to    -}
{-                                             take the 2nd derivative      -}
{-                       XDeriv    : TNvector; Point at which to take       -}
{-                                             the 2nd derivative           -}
{-                       YDeriv    : TNvector; 2nd derivative at            -}
{-                                             points XDeriv                -}
{-                       Point     : byte;     3 or 5 point diff.           -}
{-                       Error     : byte;     Flags if something goes      -}
{-                                             wrong                        -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: Warning, at least one point was                 -}
{-                          not calculated. NOT A FATAL ERROR! (See Note)   -}
{-                       2: Data not unique                                 -}
{-                       3: Data not in increasing order                    -}
{-                       4: Not enough data                                 -}
{-                       5: not(Point IN [3, 5])                            -}
{-                       6: Data points not evenly spaced                   -}
{-                                                                          -}
{-                Note:  If the point at which to take the 2nd derivative   -}
{-                       is not among the data points, the value of         -}
{-                       NotADataPoint is arbitrarily assigned as the       -}
{-                       derivative at that point. Error = 1 is returned.   -}
{-                       When trying to do 5 point 2nd differentiation      -}
{-                       with only 5 points, there is not enough            -}
{-                       information to calculate the 2nd derivative at     -}
{-                       the 2nd or 4th point.  Should an attempt be made   -}
{-                       to evaluate the 2nd derivative at these points,    -}
{-                       the value of NotEnoughPoints is arbitrarily        -}
{-                       assigned as the 2nd derivative at that point.      -}
{-                       Error = 1 is returned.                             -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Interpolate_Derivative(NumPoints : integer;
                             var XData     : TNvector;
                             var YData     : TNvector;
                                 NumDeriv  : integer;
                             var XDeriv    : TNvector;
                             var YInter    : TNvector;
                             var YDeriv    : TNvector;
                             var YDeriv2   : TNvector;
                             var Error     : byte);


{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input:  NumPoints, XData, YData, NumDeriv, XDeriv                     -}
{-    Output: YInter, YDeriv, YDeriv2, Error                                -}
{-                                                                          -}
{-            Purpose: To construct a cubic spline interpolant              -}
{-                     and its derivative given a set of points.            -}
{-                     Use these interpolants to find the value and         -}
{-                     first and second derivative at a set of points       -}
{-                     XDeriv.  The second derivative of the interpolant    -}
{-                     is assumed to be zero at the endpoints.              -}
{-                     The spline is of the form                            -}
{-                                                                          -}
{-                                                2              3          -}
{-            A[I]  + B[I](X-X[I])  + C[I](X-X[I]) + D[I](X-X[I])           -}
{-                                                                          -}
{-                     where 1 < I < NumPoints - 1.                         -}
{-                                                                          -}
{-  User-defined Types: TNvector = array[0..TNArraySize] of real;           -}
{-                                                                          -}
{- Global Variables: NumPoints : integer;  Number of points                 -}
{-                   XData     : TNvector; X-coordinate data points         -}
{-                                         (must be in increasing order)    -}
{-                   YData     : TNvector; Y-coordinate data points         -}
{-                   NumDeriv  : integer;  Number of interpolated points    -}
{-                   XDeriv    : TNvector; Points at which to interpolate   -}
{-                   YInter    : TNvector; Interpolated values at XDeriv    -}
{-                   YDeriv    : TNvector; Interpolated first derivative    -}
{-                                         at XDeriv                        -}
{-                   YDeriv2   : TNvector; Interpolated second derivative   -}
{-                                         at XDeriv                        -}
{-                   Error     : byte;     Flags if something goes wrong    -}
{-                                                                          -}
{-             Errors: 0: No error                                          -}
{-                     1: X-coordinate points not                           -}
{-                        unique                                            -}
{-                     2: X-coordinate points not                           -}
{-                        in increasing order                               -}
{-                     3: NumPoints < 2                                     -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure FirstDerivative(NumDeriv : integer;
                     var XDeriv    : TNvector;
                     var YDeriv    : TNvector;
                         Tolerance : Float;
                     var Error     : byte;
                         FuncPtr   : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input: NumDeriv, XDeriv, Tolerance                                    -}
{-   Output: YDeriv, Error                                                  -}
{-                                                                          -}
{-  Purpose: Given a function TNTargetF(X), approximate the first           -}
{-           derivative of TNTargetF(X) at the points XDeriv. The algorithm -}
{-           uses a three point formula and Richardson extrapolation        -}
{-                                                                          -}
{- User-defined Function:  FUNCTION TNTargetF(X : real) : real;             -}
{-                                                                          -}
{-  User-defined Types:  TNvector = array[1..TNArraySize] of real;          -}
{-                                                                          -}
{-    Global Variables:  NumDeriv  : integer;   Number points at which to   -}
{-                                              take the derivative         -}
{-                       XDeriv    : TNvector;  Point at which to take      -}
{-                                              the derivative              -}
{-                       YDeriv    : TNvector;  Derivative at               -}
{-                                              points XDeriv               -}
{-                       Tolerance : real;      Tolerance in answer         -}
{-                       Error     : byte;      Flags if something goes     -}
{-                                              wrong                       -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: Tolerance < TNNearlyZero                        -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure SecondDerivative(NumDeriv  : integer;
                       var XDeriv    : TNvector;
                       var YDeriv    : TNvector;
                           Tolerance : Float;
                       var Error     : byte;
                           FuncPtr   : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input: NumDeriv, XDeriv, Tolerance                                    -}
{-   Output: YDeriv, Error                                                  -}
{-                                                                          -}
{-  Purpose: Given a function TNTargetF(X), approximate the second          -}
{-           derivative of TNTargetF(X) at the points XDeriv. The algorithm -}
{-           uses a three point formula and Richardson extrapolation.       -}
{-                                                                          -}
{- User-defined function:  function TNTargetF(X : real) : real;             -}
{-                                                                          -}
{-  User-defined Types:  TNvector = array[1..TNArraySize] of real;          -}
{-                                                                          -}
{-    Global Variables:  NumDeriv  : integer;  Number points at which to    -}
{-                                             take the derivative          -}
{-                       XDeriv    : TNvector; Point at which to take       -}
{-                                             the derivative               -}
{-                       YDeriv    : TNvector; Derivative at                -}
{-                                             points XDeriv                -}
{-                       Tolerance : real;     Tolerance in answer          -}
{-                       Error     : byte;     Flags if something goes      -}
{-                                             wrong                        -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: Tolerance < TNNearlyZero                        -}
{-                                                                          -}
{----------------------------------------------------------------------------}

implementation

{$F+}
{$L Differ.OBJ}
function UserFunction(X : Float; ProcAddr : Pointer) : Float; external;
{$F-}

procedure First_Derivative{(NumPoints : integer;
                       var XData      : TNvector;
                       var YData      : TNvector;
                           Point      : byte;
                           NumDeriv   : integer;
                       var XDeriv     : TNvector;
                       var YDeriv     : TNvector;
                       var Error      : byte)};

{$IFOPT N+}
const
  TNNearlyZero = 1E-013;
{$ELSE}
const
  TNNearlyZero = 1E-06;
{$ENDIF}

  NotADataPoint = -9.9999999E35;    { See Note above }
  NotEnoughPoints = 9.9999999E35;   { See Note above }

  procedure CheckData(NumPoints : integer;
                  var XData     : TNvector;
                      Point     : byte;
                  var Error     : byte);

{---------------------------------------------------------}
{- Input: NumPoints, XData, Point                        -}
{- Output: Error                                         -}
{-                                                       -}
{- This procedure checks the data for errors:            -}
{-                                                       -}
{- Errors:  0: No errors                                 -}
{-          2: Data not unique                           -}
{-          3: Data not in increasing order              -}
{-          4: Not enough data                           -}
{-          5: Not(Point in [2, 3, 5])                   -}
{-          6: Data points not evenly spaced for 5 point -}
{---------------------------------------------------------}

var
  Spacing, CurrentSpacing : Float;
  Index : integer;

begin { procedure CheckData }
  Error := 0;
  if not(Point in [2, 3, 5]) then
    Error := 5
  else
    if (NumPoints < Point) then
      Error := 4;       { Not enough data }
  Spacing := XData[2] - XData[1];
  for Index := 2 to NumPoints do
  begin
    CurrentSpacing := XData[Index] - XData[Index - 1];
    if CurrentSpacing < 0 then
      Error := 3;  { Data not increasing }
    if ABS(CurrentSpacing) < TNNearlyZero then
      Error := 2;  { Data not unique }
    if (Point = 5) and (ABS(Spacing - CurrentSpacing) > TNNearlyZero) then
      Error := 6; { Data not evenly spaced }
  end;
end; { procedure CheckData }

procedure Differentiate(Point     : byte;
                        NumPoints : integer;
                    var XData     : TNvector;
                    var YData     : TNvector;
                        NumDeriv  : integer;
                    var XDeriv    : TNvector;
                    var YDeriv    : TNvector;
                    var Error     : byte);

{------------------------------------------------------------}
{- Input:  Point, NumPoints, XData, YData, NumDeriv, XDeriv -}
{- Output: YDeriv, Error                                    -}
{-                                                          -}
{- This procedure approximates the derivative at the        -}
{- XDeriv points using a 2, 3 or 5 point formula and stores -}
{- them in YDeriv. If any of the XDeriv points are not in   -}
{- XData then Error = 1 (a warning - not a fatal error) is  -}
{- returned.                                                -}
{------------------------------------------------------------}

var
  Term, Index : integer;

procedure FindIndex(NumPoints : integer;
                var XData     : TNvector;
                    XDeriv    : Float;
                var Index     : integer);

{------------------------------------------------------------}
{- Input:  NumPoints, XData, XDeriv                         -}
{- Output: Index                                            -}
{-                                                          -}
{- This procedure searches the vector XData for the value   -}
{- XDeriv. The position of XDeriv withing XData is returned -}
{- as Index.                                                -}
{------------------------------------------------------------}

begin
  Index := 1;
  while (Index <= NumPoints) and (ABS(XData[Index] - XDeriv) > TNNearlyZero) do
    Index := Succ(Index);
end; { procedure FindIndex }

procedure TwoPoint(var XData  : TNvector;
                   var YData  : TNvector;
                       Index  : integer;
                   var YDeriv : Float);

{----------------------------------------------------}
{- Input:  XData, YData, Index                      -}
{- Output: YDeriv                                   -}
{-                                                  -}
{- This procedure applies two point differentiation -}
{- to the function represented by (XData, YData) at -}
{- the point XData[Index].  The value of the        -}
{- derivative is returned in YDeriv.                -}
{- Due to the nature of the two point formula, a    -}
{- different (though equivalent) formula is used    -}
{- for the leftmost point than for the rest of the  -}
{- points.                                          -}
{----------------------------------------------------}

begin { procedure TwoPoint }
  if Index = 1 then
    YDeriv := (YData[Index + 1] - YData[Index]) /
              (XData[Index + 1] - XData[Index])
  else
    YDeriv := (YData[Index - 1] - YData[Index]) /
              (XData[Index - 1] - XData[Index]);
end; { procedure TwoPoint }

procedure ThreePoint(NumPoints : integer;
                 var XData     : TNvector;
                 var YData     : TNvector;
                     Index     : integer;
                 var YDeriv    : Float);

{------------------------------------------------------}
{- Input:  NumPoints, XData, YData, Index             -}
{- Output: YDeriv                                     -}
{-                                                    -}
{- This procedure applies three point differentiation -}
{- to the function represented by (XData, YData) at   -}
{- the point XData[Index].  The value of the          -}
{- derivative is returned in YDeriv.                  -}
{- Due to the nature of the three point formula, a    -}
{- different (less accurate) formula is used for the  -}
{- endpoints than for the rest of the points.         -}
{------------------------------------------------------}

var
  Dif1, Dif2, Dif3 : Float;  { Differences }

begin { procedure ThreePoint }
  if Index = 1 then   { Leftmost point }
    begin
      Dif1 := XData[1] - XData[2];
      Dif2 := XData[1] - XData[3];
      Dif3 := XData[2] - Xdata[3];
      YDeriv := YData[Index] * (Dif1 + Dif2) / (Dif1 * Dif2)
                - YData[Index + 1] * Dif2 / (Dif1 * Dif3)
                + YData[Index + 2] * Dif1 / (Dif2 * Dif3);
    end
  else
    if Index = NumPoints then { Rightmost point }
      begin
        Dif1 := XData[NumPoints - 2] - XData[NumPoints - 1];
        Dif2 := XData[NumPoints - 2] - XData[NumPoints];
        Dif3 := XData[NumPoints - 1] - Xdata[NumPoints];
        YDeriv := - YData[Index - 2] * Dif3 / (Dif1 * Dif2)
                  + YData[Index - 1] * Dif2 / (Dif1 * Dif3)
                  - YData[Index] * (Dif2 + Dif3) / (Dif2 * Dif3);
      end
    else { Middle points }
      begin
        Dif1 := XData[Index - 1] - XData[Index];
        Dif2 := XData[Index - 1] - XData[Index + 1];
        Dif3 := XData[Index] - XData[Index + 1];
        YDeriv := YData[Index - 1] * Dif3 / (Dif1 * Dif2)
                  - YData[Index] * (Dif3 - Dif1) / (Dif1 * Dif3)
                  - YData[Index + 1] * Dif1 / (Dif2 * Dif3);
      end;
end; { procedure ThreePoint }

procedure FivePoint(NumPoints : integer;
                var XData     : TNvector;
                var YData     : TNvector;
                    Index     : integer;
                var YDeriv    : Float;
                var Error     : byte);

{------------------------------------------------------}
{- Input:  NumPoints, XData, YData, Index             -}
{- Output: YDeriv, Error                              -}
{-                                                    -}
{- This procedure applies five point differentiation  -}
{- to the function represented by (XData, YData) at   -}
{- the point XData[Index].  The value of the          -}
{- derivative is returned in YDeriv.                  -}
{- Due to the nature of the five point formula,       -}
{- different (less accurate) formulas are used for    -}
{- the two leftmost and two rightmost points than for -}
{- the rest of the points.                            -}
{- If there are only 5 data points, the only point    -}
{- at which a 5 point formula may be applied is point -}
{- 3.  If there are only 6 data points, the only      -}
{- points at which a 5 point formula may be applied   -}
{- are points 1, 3, 4 and 6.  If these conditions are -}
{- not met, then Error = 1 (a warning - not a fatal   -}
{- error is returned.  The value of the derivative at -}
{- such an "error point" is arbitrarily assigned to   -}
{- be NotEnoughPoints.                                -}
{------------------------------------------------------}

var
  Spacing : Float;

begin  { procedure FivePoint }
  Spacing := XData[2] - XData[1];
  if ((NumPoints = 6) and (Index in [2, 5])) or
     ((NumPoints = 5) and not(Index = 3))    then
    begin
      YDeriv := NotEnoughPoints;
      Error := 1;    { Warning about this point }
    end
  else
    if Index <= 2 then { Leftmost points }
      YDeriv := (-25 * YData[Index] + 48 * YData[Index + 1]
                 - 36 * YData[Index + 2] + 16 * YData[Index + 3]
                 - 3 * YData[Index + 4]) / (12 * Spacing)
    else
      if Index >= NumPoints-1  then { Rightmost points }
        YDeriv := (-25*YData[Index] + 48 * YData[Index - 1]
                   - 36 * YData[Index - 2] + 16 * YData[Index - 3]
                   - 3 * YData[Index - 4]) / (-12 * Spacing)
      else { Middle points }
         YDeriv := (YData[Index - 2] - 8 * YData[Index - 1]
                   + 8 * YData[Index + 1] - YData[Index + 2]) / (12 * Spacing);
end; { procedure FivePoint }

begin { procedure Differentiate }
  for Term := 1 to NumDeriv do
  begin
    FindIndex(NumPoints, XData, XDeriv[Term], Index);
    if Index > NumPoints then
      begin
        YDeriv[Term] := NotADataPoint; { YDeriv[Term] isn't }
                                       { in XData           }
         Error := 1;                   { Warning about this point }
       end
     else
       case Point of
         2 : TwoPoint(XData, YData, Index, YDeriv[Term]);
         3 : ThreePoint(NumPoints, XData, YData, Index, YDeriv[Term]);
         5 : FivePoint(NumPoints, XData, YData, Index, YDeriv[Term], Error);
       end;
  end;
end; { procedure Differentiate }

begin { procedure First_Derivative }
  CheckData(NumPoints, XData, Point, Error);
  if Error = 0 then
    Differentiate(Point, NumPoints, XData, YData,
                  NumDeriv, XDeriv, YDeriv, Error);
end; { procedure First_Derivative }

procedure Second_Derivative{(NumPoints : integer;
                        var XData      : TNvector;
                        var YData      : TNvector;
                            Point      : byte;
                            NumDeriv   : integer;
                        var XDeriv     : TNvector;
                        var YDeriv     : TNvector;
                        var Error      : byte)};

{$IFOPT N+}
const
  NearlyZero = 1E-013;
{$ELSE}
const
  NearlyZero = 1E-06;
{$ENDIF}

  NotADataPoint = -9.9999999E35;    { See Note above }
  NotEnoughPoints = 9.9999999E35;   { See Note above }

var
  SpacingSquared : Float;   { Square of the spacing between data points }

procedure CheckData(NumPoints      : integer;
                var XData          : TNvector;
                    Point          : byte;
                var SpacingSquared : Float;
                var Error          : byte);

{---------------------------------------------------------}
{- Input:  NumPoints, XData, Point                       -}
{- Output: Error                                         -}
{-                                                       -}
{- This procedure checks the data for errors             -}
{-                                                       -}
{- Errors:  0: No errors                                 -}
{-          2: Data not unique                           -}
{-          3: Data not in increasing order              -}
{-          4: Not enough data                           -}
{-          5: not(Point IN [2, 3, 5])                   -}
{-          6: Data points not evenly spaced for 5 point -}
{---------------------------------------------------------}

var
  Spacing, CurrentSpacing : Float;
  Index : integer;

begin { procedure CheckData }
  if not(Point in [3, 5]) then
    Error := 5      { Point <> 3 or 5 }
  else
    if (NumPoints < Point)  then
      Error := 4;   { Too few points }
  Spacing := XData[2] - XData[1];
  for Index := 2 to NumPoints do
  begin
    CurrentSpacing := XData[Index] - XData[Index - 1];
    if ABS(CurrentSpacing) < NearlyZero then
      Error := 2;  { Data not unique }
    if CurrentSpacing < 0 then
      Error := 3;  { Data not increasing }
    if ABS(Spacing - CurrentSpacing) > NearlyZero then
      Error := 6;  { Data not evenly spaced }
  end;
  SpacingSquared := Sqr(Spacing);
end; { procedure CheckData }

procedure Differentiate(Point          : byte;
                        NumPoints      : integer;
                    var XData          : TNvector;
                    var YData          : TNvector;
                        SpacingSquared : Float;
                        NumDeriv       : integer;
                    var XDeriv         : TNvector;
                    var YDeriv         : TNvector;
                    var Error          : byte);

{------------------------------------------------------------}
{- Input: Point, NumPoints, XData, YData, SpacingSquared,   -}
{-        NumDeriv, XDeriv                                  -}
{- Output: YDeriv, Error                                    -}
{-                                                          -}
{- This procedure approximates the second derivative of the -}
{- function represented by (XData, YData) at the XDeriv     -}
{- points using a 3 or 5 point formula and stores them in   -}
{- YDeriv. If any of the XDeriv points are not in XData,    -}
{- then Error = 1 (a warning - not a fatal error) is        -}
{- returned. The value of the second derivative at one of   -}
{- these "error points" is arbitrarily assigned to be       -}
{- NotADataPoint.                                           -}
{------------------------------------------------------------}

var
  Term, Index : integer;

procedure FindIndex(NumPoints : integer;
                var XData     : TNvector;
                var XDeriv    : Float;
                var Index     : integer);

{------------------------------------------------------------}
{- Input: NumPoints, XData, XDeriv                          -}
{- Output: Index                                            -}
{-                                                          -}
{- This procedure searches the vector XData for the value   -}
{- XDeriv. The position of XDeriv withing XData is returned -}
{- as Index.                                                -}
{------------------------------------------------------------}

begin
  Index := 1;
  while (Index <= NumPoints) and (XData[Index] <> XDeriv) do
    Index := Succ(Index);
end; { procedure FindIndex }

procedure ThreePoint(NumPoints      : integer;
                 var YData          : TNvector;
                     Index          : integer;
                     SpacingSquared : Float;
                 var YDeriv         : Float);

{------------------------------------------------------}
{- Input: NumPoints, YData, Index, SpacingSquared     -}
{- Output: YDeriv                                     -}
{-                                                    -}
{- This procedure applies three point second          -}
{- differentiation to the function represented by     -}
{- (XData, YData) at the point XData[Index].  The     -}
{- value of the derivative is returned in YDeriv.     -}
{- Due to the nature of the three point formula, a    -}
{- different (less accurate) formula is used for the  -}
{- endpoints than for the rest of the points.         -}
{------------------------------------------------------}

begin { procedure ThreePoint }
  if Index = 1 then  { Leftmost point }
    YDeriv := (YData[1] - 2 * YData[2] + YData[3]) / SpacingSquared
    { The error in this Term is O(Spacing) }
  else
    if Index = NumPoints then { Rightmost point }
      YDeriv := (YData[NumPoints] - 2 * YData[NumPoints - 1]
                + YData[NumPoints - 2]) / SpacingSquared
      { The error in this Term is O(Spacing) }
    else  { Middle points }
      YDeriv := (YData[Index - 1] - 2 * YData[Index]
                + YData[Index + 1]) / SpacingSquared;
      { The error in this Term is O(SpacingSquared) }
end; { procedure ThreePoint }

procedure FivePoint(NumPoints      : integer;
                var YData          : TNvector;
                    Index          : integer;
                    SpacingSquared : Float;
                var YDeriv         : Float;
                var Error          : byte);

{------------------------------------------------------}
{- Input: NumPoints, YData, Index                     -}
{- Output: YDeriv, Error                              -}
{-                                                    -}
{- This procedure applies five point differentiation  -}
{- to the function represented by (XData, YData) at   -}
{- the point XData[Index].  The value of the          -}
{- derivative is returned in YDeriv.                  -}
{- Due to the nature of the five point formula,       -}
{- different (less accurate) formulas are used for    -}
{- the two leftmost and two rightmost points than for -}
{- the rest of the points.                            -}
{- If there are only 5 data points, the only points   -}
{- at which a 5 point formula may be applied are      -}
{- points 1, 3 or 5. If this condition is not met,    -}
{- then Error = 1 (a warning - not a fatal error is   -}
{- returned.  The value of the derivative at such an  -}
{- "error point" is arbitrarily assigned to be        -}
{- NotEnoughPoints.                                   -}
{------------------------------------------------------}

begin { procedure FivePoint }
  if (NumPoints = 5) and (Index in [2, 4]) then
    begin
      YDeriv := NotEnoughPoints;    { Too few points to       }
                                    { compute derivative here }
      Error := 1;     { Warning about this point }
    end
  else
    if Index <= 2 then { Leftmost points }
      YDeriv := (2 * YData[Index] - 5 * YData[Index + 1]
                + 4 * YData[Index + 2] - YData[Index + 3]) / SpacingSquared
                { The error in this Term is O(SpacingSquared) }
    else
      if Index >= NumPoints - 1 then { Rightmost points }
        YDeriv := (2 * YData[Index] - 5 * YData[Index - 1]
                  + 4 * YData[Index - 2] - YData[Index - 3]) / SpacingSquared
                  { The error in this Term is O(SpacingSquared) }
      else { Middle points }
        YDeriv := (-YData[Index - 2] + 16 * YData[Index - 1]
        - 30 * YData[Index] + 16 * YData[Index + 1]
        - YData[Index + 2]) / (12 * SpacingSquared);
        { The error in this Term is O(SQR(SpacingSquared)) }
end; { procedure FivePoint }

begin  { procedure Differentiate }
  for Term := 1 to NumDeriv do
  begin
    FindIndex(NumPoints, XData, XDeriv[Term], Index);
    if Index > NumPoints then
      begin
        YDeriv[Term] := NotADataPoint;    { YDeriv[Term] isn't in XData }
        Error := 1;   { Warning about this point }
      end
    else
      if Point = 3 then
        ThreePoint(NumPoints, YData, Index, SpacingSquared, YDeriv[Term])
      else
        FivePoint(NumPoints, YData, Index, SpacingSquared, YDeriv[Term], Error);
  end;
end; { procedure Differentiate }

begin  { procedure Second_Derivative }
  CheckData(NumPoints, XData, Point, SpacingSquared, Error);
  if Error = 0 then
    Differentiate(Point, NumPoints, XData, YData, SpacingSquared,
                  NumDeriv, XDeriv, YDeriv, Error);
end; { procedure Second_Derivative }

procedure Interpolate_Derivative{(NumPoints : integer;
                             var XData      : TNvector;
                             var YData      : TNvector;
                                 NumDeriv   : integer;
                             var XDeriv     : TNvector;
                             var YInter     : TNvector;
                             var YDeriv     : TNvector;
                             var YDeriv2    : TNvector;
                             var Error      : byte)};

{$IFOPT N+}
const
  TNNearlyZero = 1E-015;
{$ELSE}
const
  TNNearlyZero = 1E-08;
{$ENDIF}

type
  TNcoefficients = record
                     A, B, C, D : TNvector;
                   end;
var
  Spline : TNcoefficients;     { Cubics defining the interpolated function }

{------------------------------------------------------------------------}
procedure CubicSplineFree(NumPoints : integer;
                      var XData     : TNvector;
                      var YData     : TNvector;
                      var CoefA     : TNvector;
                      var CoefB     : TNvector;
                      var CoefC     : TNvector;
                      var CoefD     : TNvector;
                          NumInter  : integer;
                      var XInter    : TNvector;
                      var YInter    : TNvector;
                      var Error     : byte);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input: NumPoints, XData, YData, NumInter, XInter                      -}
{-    Output: CoefA, CoefB, CoefC, CoefD, YInter, Error                     -}
{-                                                                          -}
{-            Purpose: To construct a cubicspline interpolant               -}
{-                     to a set of points. The second derivative            -}
{-                     of the interpolant is assumed to be zero             -}
{-                     at the endpoints (free cubic spline)                 -}
{-                     The spline is of the form                            -}
{-                                                                          -}
{-                        3               2                                 -}
{-            D[I](X-X[I])  + C[I](X-X[I])  + B[I](X-X[I]) + A[I]           -}
{-                                                                          -}
{-                     Where 1 < I < NumPoints.                             -}
{-                                                                          -}
{-  User-defined Types: TNvector = array[0..TNArraySize] of real;           -}
{-                                                                          -}
{- Global Variables: NumPoints : integer;  Number of points                 -}
{-                   XData     : TNvector; X-coordinate data points         -}
{-                                         (must be in increasing order)    -}
{-                   YData     : TNvector; Y-coordinate data points         -}
{-                   CoefA     : TNvector; 0th coefficient of spline        -}
{-                   CoefB     : TNvector; 1st coefficient of spline        -}
{-                   CoefC     : TNvector; 2nd coefficient of spline        -}
{-                   CoefD     : TNvector; 3rd coefficient of spline        -}
{-                   NumInter  : integer;  Number of interpolated points    -}
{-                   XInter    : TNvector; Points at which to interpolate   -}
{-                   YInter    : TNvector; Interpolated values at XInter    -}
{-                   Error     : byte;     Flags if something goes wrong    -}
{-                                                                          -}
{-              Errors: 0: No error                                         -}
{-                      1: X-coordinate points not                          -}
{-                         unique                                           -}
{-                      2: X-coordinate points not                          -}
{-                         in increasing order                              -}
{-                      3: NumPoints < 2                                    -}
{-                                                                          -}
{----------------------------------------------------------------------------}

var
  Interval : TNvector;        { Intervals between adjacent points }
  Spline : TNcoefficients;    { All the cubics }

procedure CalculateIntervals(NumPoints : integer;
                         var XData     : TNvector;
                         var Interval  : TNvector;
                         var Error     : byte);

{----------------------------------------------------------}
{- Input:  NumPoints, XData                               -}
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
{- Input:  NumPoints, XData, YData, Interval                   -}
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
                    var Spline    : TNcoefficients);

{---------------------------------------------}
{- Input: NumPoints, XData, Interval         -}
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
      L[Index] := 2 * (XData[Index+1] - XData[Index-1]) -
                  Interval[Index-1] * Mu[Index-1];
      Mu[Index] := Interval[Index] / L[Index];
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
  CoefA := Spline.A;
  CoefB := Spline.B;
  CoefC := Spline.C;
  CoefD := Spline.D;
end;  { procedure CubicSplineFree }

{------------------------------------------------------------------------}

procedure Differentiate(NumPoints : integer;
                    var XData     : TNvector;
                    var Spline    : TNcoefficients;
                        NumDeriv  : integer;
                    var XDeriv    : TNvector;
                    var YDeriv    : TNvector;
                    var YDeriv2   : TNvector);

{-----------------------------------------------------}
{- Input: NumPoints, XData, Spline, NumDeriv, XDeriv -}
{- Output: YDeriv, YDeriv2                           -}
{-                                                   -}
{-                                                   -}
{- This procedure uses the cubic spline interpolant, -}
{- Spline, to approximate the first and second       -}
{- derivatives.  The derivatives are returned in     -}
{- YDeriv, YDeriv2.                                  -}
{-----------------------------------------------------}

var
  Index, Location, Term : integer;
  X : Float;

begin
  for Index := 1 to NumDeriv do
  begin
    Location := 1;
    for Term := 1 to NumPoints-1 do
      if XDeriv[Index] > XData[Term] then
        Location := Term;
    X := XDeriv[Index] - XData[Location];

    with Spline do    { Interpolate first derivative }
      YDeriv[Index] := (3 * D[Location] * X + 2 * C[Location]) * X
                       + B[Location];
    with Spline do  { Interpolate second derivative }
      YDeriv2[Index] := 6 * D[Location] * X + 2 * C[Location];
  end;
end; { procedure Differentiate }

begin { procedure Interpolate_Derivative }
  Error := 0;
  if NumPoints < 2 then
    Error := 3
  else
    CubicSplineFree(NumPoints, XData, YData, Spline.A, Spline.B, Spline.C,
                    Spline.D, NumDeriv, XDeriv, YInter, Error);
  if Error = 0 then
    Differentiate(NumPoints, XData, Spline, NumDeriv, XDeriv, YDeriv, YDeriv2);
end; { procedure Interpolate_Derivative }

procedure FirstDerivative{(NumDeriv : integer;
                     var XDeriv     : TNvector;
                     var YDeriv     : TNvector;
                         Tolerance  : Float;
                     var Error      : byte;
                         FuncPtr    : Pointer)};

{$IFOPT N+}
const
  TNNearlyZero = 1E-010;
{$ELSE}
const
  TNNearlyZero = 1E-05;
{$ENDIF}

procedure Differentiate(Tolerance : Float;
                        NumDeriv  : integer;
                    var XDeriv    : TNvector;
                    var YDeriv    : TNvector);

{------------------------------------------------------------}
{- Input: Tolerance, NumDeriv, XDeriv                       -}
{- Output: YDeriv                                           -}
{-                                                          -}
{- This procedure uses a three point formula and Richardson -}
{- extrapolation to approximate the value of the derivative -}
{- of the function TNTargetF at the points XDeriv.  The     -}
{- derivatives are returned in YDeriv.                      -}
{------------------------------------------------------------}

var
  Term, Iter : integer;
  TwoToTheIterMinus2 : integer;
  X, DeltaX : Float;
  OldEstimate, NewEstimate : TNvector;

function EvaluateFirstDeriv(X      : Float;
                            DeltaX : Float) : Float;

{------------------------------------------------------}
{- Input: X, DeltaX                                   -}
{- Output: EvaluateFirstDeriv                         -}
{-                                                    -}
{- This procedure uses a three point formula to       -}
{- evaluate the derivative of the function TNTargetF  -}
{- at the point X.  The function returns the value of -}
{- the derivative.                                    -}
{------------------------------------------------------}

var
  LeftPoint, RightPoint : Float;   { Points on either side of X }

begin  { function EvaluateFirstDeriv }
  LeftPoint := UserFunction(X - DeltaX, FuncPtr);
  RightPoint := UserFunction(X + DeltaX, FuncPtr);
  EvaluateFirstDeriv := (RightPoint - LeftPoint)/(2 * DeltaX);
end; { function EvaluateFirstDeriv }

procedure Extrapolate(Iter        : integer;
                  var OldEstimate : TNvector;
                  var NewEstimate : TNvector);

{--------------------------------------------------------}
{- Input:  Iter, OldEstimate                            -}
{- Output: NewEstimate                                  -}
{-                                                      -}
{- This procedure uses Richardson extrapolation         -}
{- to improve the current approximation to the          -}
{- derivative (OldEstimate).  The result is returned    -}
{- as the Iter element in the array NewEstimate         -}
{--------------------------------------------------------}

var
  Extrap : integer;
  FourToTheExtrapMinus1 : Float;

begin
  FourToTheExtrapMinus1 := 1;
  for Extrap := 2 to Iter do
  begin
    FourToTheExtrapMinus1 := FourToTheExtrapMinus1 * 4;
    NewEstimate[Extrap] := (FourToTheExtrapMinus1 * NewEstimate[Extrap - 1] -
                        OldEstimate[Extrap - 1]) / (FourToTheExtrapMinus1 - 1);
  end;
end; { procedure Extrapolate }

begin { procedure Differentiate }
  for Term := 1 to NumDeriv do
  begin
    X := XDeriv[Term];
    if ABS(X) < TNNearlyZero then
      DeltaX := Sqrt(Tolerance)
    else
      DeltaX := ABS(X * Sqrt(Tolerance));
    OldEstimate[1] := EvaluateFirstDeriv(X, DeltaX);
    Iter := 1;
    TwoToTheIterMinus2 := 1;
    repeat
      Iter := Succ(Iter);
      DeltaX := DeltaX / 2;
      NewEstimate[1] := EvaluateFirstDeriv(X, DeltaX);
      TwoToTheIterMinus2 := TwoToTheIterMinus2 * 2;
      Extrapolate(Iter, OldEstimate, NewEstimate);
      OldEstimate := NewEstimate;
    until { The fractional difference between }
          { iterations is within Tolerance    }
          (ABS(NewEstimate[Iter - 1] - NewEstimate[Iter]) <=
           ABS(Tolerance * NewEstimate[Iter])) or
          (ABS(DeltaX) < TNNearlyZero);  { Prevents infinite loops }
    YDeriv[Term] := NewEstimate[Iter];
  end;
end; { procedure Differentiate }

begin  { procedure FirstDerivative }
  if Tolerance < TNNearlyZero then
    Error := 1
  else
    Differentiate(Tolerance, NumDeriv, XDeriv, YDeriv);
end; { procedure FirstDerivative }

procedure SecondDerivative{(NumDeriv : integer;
                       var XDeriv    : TNvector;
                       var YDeriv    : TNvector;
                           Tolerance : Float;
                       var Error     : byte;
                           FuncPtr   : Pointer)};

{$IFOPT N+}
const
  TNNearlyZero = 1E-004;
{$ELSE}
const
  TNNearlyZero = 1E-02;
{$ENDIF}

procedure Differentiate(Tolerance : Float;
                        NumDeriv  : integer;
                    var XDeriv    : TNvector;
                    var YDeriv    : TNvector);

var
  Term, Iter : integer;
  TwoToTheIterMinus2 : integer;
  X, DeltaX : Float;
  OldEstimate, NewEstimate : TNvector;


function EvaluateSecondDeriv(X      : Float;
                             DeltaX : Float) : Float;

{------------------------------------------------------}
{- Input: X, DeltaX                                   -}
{- Output: EvaluateSecondDeriv                        -}
{-                                                    -}
{- This procedure uses a three point formula to       -}
{- evaluate the second derivative of the function     -}
{- TNTargetF at the point X.  The function returns    -}
{- the value of the second derivative.                -}
{------------------------------------------------------}

var
  Point, LeftPoint, RightPoint : Float;   { Value of function at X  }
                                         { and on either side of X }

begin { function EvaluateSecondDeriv }
  LeftPoint := UserFunction(X - DeltaX, FuncPtr);
  RightPoint := UserFunction(X + DeltaX, FuncPtr);
  Point := UserFunction(X, FuncPtr);
  EvaluateSecondDeriv := (RightPoint - 2 * Point + LeftPoint) / Sqr(DeltaX);
end; { function EvaluateSecondDeriv }

procedure Extrapolate(Iter        : integer;
                  var OldEstimate : TNvector;
                  var NewEstimate : TNvector);

{--------------------------------------------------------}
{- Input: Iter, OldEstimate                             -}
{- Output: NewEstimate                                  -}
{-                                                      -}
{- This procedure uses Richardson extrapolation         -}
{- to improve the current approximation to the          -}
{- derivative (OldEstimate).  The result is returned    -}
{- as the Iter element in the array NewEstimate         -}
{--------------------------------------------------------}

var
  Extrap : integer;
  FourToTheExtrapMinus1 : Float;

begin
  FourToTheExtrapMinus1 := 1;
  for Extrap := 2 to Iter do
  begin
    FourToTheExtrapMinus1 := FourToTheExtrapMinus1 * 4;
    NewEstimate[Extrap] := (FourToTheExtrapMinus1 * NewEstimate[Extrap - 1] -
                        OldEstimate[Extrap - 1]) / (FourToTheExtrapMinus1 - 1);
  end;
end; { procedure Extrapolate }

begin { procedure Differentiate }
  for Term := 1 to NumDeriv do
  begin
    X := XDeriv[Term];
    if ABS(X) < TNNearlyZero then
      DeltaX := Tolerance
    else
      DeltaX := ABS(X * Tolerance);
    OldEstimate[1] := EvaluateSecondDeriv(X, DeltaX);
    Iter := 1;
    TwoToTheIterMinus2 := 1;
    repeat
      Iter := Succ(Iter);
      DeltaX := DeltaX / 2;
      NewEstimate[1] := EvaluateSecondDeriv(X, DeltaX);
      TwoToTheIterMinus2 := TwoToTheIterMinus2 * 2;
      Extrapolate(Iter, OldEstimate, NewEstimate);
      OldEstimate := NewEstimate;
    until (ABS(NewEstimate[Iter - 1] - NewEstimate[Iter]) <=
           ABS(Tolerance * NewEstimate[Iter])) or
           (ABS(DeltaX) < TNNearlyZero);
    { Prevents excessive roundoff }
    YDeriv[Term] := NewEstimate[Iter];
  end;
end; { procedure Differentiate }

begin { procedure SecondDerivative }
    if Tolerance < TNNearlyZero then
      Error := 1
    else
      Differentiate(Tolerance, NumDeriv, XDeriv, YDeriv);
end; { procedure SecondDerivative }

end. { Differ }
