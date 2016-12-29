{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Bisect{(LeftEnd : Float;
                 RightEnd : Float;
                 Tol      : Float;
                 MaxIter  : integer;
             var Answer   : Float;
             var fAnswer  : Float;
             var Iter     : integer;
             var Error    : byte;
                 FuncPtr  : Pointer)};

var
  Found : boolean;

procedure TestInput(LeftEndpoint  : Float;
                    RightEndpoint : Float;
                    Tol           : Float;
                    MaxIter       : integer;
                var Answer        : Float;
                var fAnswer       : Float;
                var Error         : byte;
                var Found         : boolean);

{--------------------------------------------------------------}
{- Input:  LeftEndpoint, RightEndpoint, Tol, MaxIter          -}
{- Output: Answer, fAnswer, Error, Found                      -}
{-                                                            -}
{- This procedure tests the input data for errors.  If        -}
{- LeftEndpoint > RightEndpoint, Tol <= 0, or MaxIter < 0,    -}
{- then an error is returned.  If one the of the endpoints    -}
{- (LeftEndpoint, RightEndpoint) is a root, then Found = TRUE -}
{- and Answer and fAnswer are returned.                       -}
{--------------------------------------------------------------}

var
  yLeft, yRight : Float; { The values of the function at the endpoints. }

begin
  yLeft := UserFunction(LeftEndpoint, FuncPtr);
  yRight := UserFunction(RightEndpoint, FuncPtr);

  if ABS(yLeft) <= TNNearlyZero then
  begin
    Answer := LeftEndpoint;
    fAnswer := UserFunction(Answer, FuncPtr);
    Found := true;
  end;

  if ABS(yRight) <= TNNearlyZero then
  begin
    Answer := RightEndpoint;
    fAnswer := UserFunction(Answer, FuncPtr);
    Found := true;
  end;

  if not Found then   { Test for errors }
  begin
    if yLeft * yRight > 0 then
      Error := 2;
    if Tol <= 0 then
      Error := 3;
    if MaxIter < 0 then
      Error := 4;
  end;
end; { procedure Tests }

procedure Converge(var LeftEndpoint  : Float;
                   var RightEndpoint : Float;
                       Tol           : Float;
                   var Found         : boolean;
                       MaxIter       : integer;
                   var Answer        : Float;
                   var fAnswer       : Float;
                   var Iter          : integer;
                   var Error         : byte);

{------------------------------------------------------------------}
{- Input:  LeftEndpoint, RightEndpoint, Tol, MaxIter              -}
{- Output: Found, Answer, fAnswer, Iter, Error                    -}
{-                                                                -}
{- This procedure applies the bisection method to find a          -}
{- root to TNTargetF(x) on the interval [LeftEndpoint,            -}
{- RightEndpoint]. The root must be found within MaxIter          -}
{- iterations to a tolerance of Tol.  If a root is found, then it -}
{- is returned in Answer, the value of the function at the        -}
{- approximated root is returned in fAnswer (should be close to   -}
{- zero), and the number of iterations is returned in Iter.       -}
{------------------------------------------------------------------}

var
  yLeft : Float;
  MidPoint, yMidPoint : Float;

procedure Initial(LeftEndpoint : Float;
              var Iter         : integer;
              var yLeft        : Float);
{ Initialize variables. }
begin
  Iter := 0;
  yLeft := UserFunction(LeftEndpoint, FuncPtr);
end; { procedure Initial }

function TestForRoot(X, OldX, Y, Tol : Float) : boolean;
{--------------------------------------------------------------------}
{-  These are the stopping criteria.  Four different ones are       -}
{-  provided.  If you wish to change the active criteria, simply    -}
{-  comment off the current criteria (including the appropriate OR) -}
{-  and remove the comment brackets from the criteria (including    -}
{-  the appropriate OR) you wish to be active.                      -}
{--------------------------------------------------------------------}
begin
  TestForRoot :=                      {---------------------------}
    (ABS(Y) <= TNNearlyZero)          {- Y = 0                   -}
                                      {-                         -}
           or                         {-                         -}
                                      {-                         -}
    (ABS(X - OldX) < ABS(OldX * Tol)) {- Relative change in X    -}
                                      {-                         -}
                                      {-                         -}
(*         or                      *) {-                         -}
(*                                 *) {-                         -}
(*  (ABS(X - OldX) < Tol)          *) {- Absolute change in X    -}
(*                                 *) {-                         -}
(*         or                      *) {-                         -}
(*                                 *) {-                         -}
(*  (ABS(Y) <= Tol)                *) {- Absolute change in Y    -}
                                      {---------------------------}

{-----------------------------------------------------------------------}
{- The first criteria simply checks to see if the value of the         -}
{- function is zero.  You should probably always keep this criteria    -}
{- active.                                                             -}
{-                                                                     -}
{- The second criteria checks the relative error in x. This criteria   -}
{- evaluates the fractional change in x between interations. Note      -}
{- that x has been multiplied through the inequality to avoid divide   -}
{- by zero errors.                                                     -}
{-                                                                     -}
{- The third criteria checks the absolute difference in x between      -}
{- iterations.                                                         -}
{-                                                                     -}
{- The fourth criteria checks the absolute difference between          -}
{- the value of the function and zero.                                 -}
{-----------------------------------------------------------------------}

end; { function TestForRoot }

begin { procedure Converge }
  Initial(LeftEndpoint, Iter, yLeft);
  while not(Found) and (Iter < MaxIter) do
  begin
    Iter := Succ(Iter);
    MidPoint := (LeftEndpoint + RightEndpoint) / 2;
    yMidPoint := UserFunction(MidPoint, FuncPtr);
    Found := TestForRoot(MidPoint, LeftEndpoint, yMidPoint, Tol);
    if (yLeft * yMidPoint) < 0 then
       RightEndpoint := MidPoint
    else
      begin
        LeftEndpoint := MidPoint;
        yLeft := yMidPoint;
      end;
  end;
  Answer := MidPoint;
  fAnswer := yMidPoint;
  if Iter >= MaxIter then
    Error := 1;
end; { procedure Converge }

begin { procedure Bisect }
  Found := false;
  TestInput(LeftEnd, RightEnd, Tol, MaxIter, Answer, fAnswer, Error, Found);
  if (Error = 0) and (Found = false) then  { i.e. no error }
    Converge(LeftEnd, RightEnd, Tol, Found, MaxIter,
             Answer, fAnswer, Iter, Error);
end; { procedure Bisect }

procedure Newton_Raphson{(Guess   : Float;
                         Tol      : Float;
                         MaxIter  : integer;
                     var Root     : Float;
                     var Value    : Float;
                     var Deriv    : Float;
                     var Iter     : integer;
                     var Error    : byte;
                         FuncPtr1 : Pointer;
                         FuncPtr2 : Pointer)};

var
  Found : boolean;              { Flags that a root has been Found }
  OldX, OldY, OldDeriv,
  NewX, NewY, NewDeriv : Float;  { Iteration variables }

procedure CheckSlope(Slope : Float;
                 var Error : byte);

{---------------------------------------------------}
{- Input:  Slope                                   -}
{- Output: Error                                   -}
{-                                                 -}
{- This procedure checks the slope to see if it is -}
{- zero.  The Newton Raphson algorithm may not be  -}
{- applied at a point where the slope is zero.     -}
{---------------------------------------------------}

begin
  if ABS(Slope) <= TNNearlyZero then
    Error := 2;     { Slope is zero }
end; { procedure CheckSlope }

procedure Initial(Guess    : Float;
                  Tol      : Float;
                  MaxIter  : integer;
              var OldX     : Float;
              var OldY     : Float;
              var OldDeriv : Float;
              var Found    : boolean;
              var Iter     : integer;
              var Error    : byte);


{-------------------------------------------------------------}
{- Input:  Guess, Tol, MaxIter                               -}
{- Output: OldX, OldY, OldDeriv, Found, Iter, Error          -}
{-                                                           -}
{- This procedure sets the initial values of the above       -}
{- variables. If OldY is zero, then a root has been          -}
{- Found and Found = TRUE.  This procedure also checks       -}
{- the tolerance (Tol) and the maximum number of iterations  -}
{- (MaxIter) for errors.                                     -}
{-------------------------------------------------------------}

begin
  Found := false;
  Iter := 0;
  Error := 0;
  OldX := Guess;
  OldY := UserFunction(OldX, FuncPtr1);
  OldDeriv := UserFunction(OldX, FuncPtr2);
  if ABS(OldY) <= TNNearlyZero then
    Found := true
  else
    CheckSlope(OldDeriv, Error);
  if Tol <= 0 then
    Error := 3;
  if MaxIter < 0 then
    Error := 4;
end; { procedure Initial }

function TestForRoot(X, OldX, Y, Tol : Float) : boolean;

{-----------------------------------------------------------------}
{- These are the stopping criteria.  Four different ones are     -}
{- provided.  If you wish to change the active criteria, simply  -}
{- comment off the current criteria (including the preceding OR) -}
{- and remove the comment brackets from the criteria (including  -}
{- the following OR) you wish to be active.                      -}
{-----------------------------------------------------------------}

    begin
      TestForRoot :=                      {---------------------------}
        (ABS(Y) <= TNNearlyZero)          {- Y = 0                   -}
                                          {-                         -}
               or                         {-                         -}
                                          {-                         -}
        (ABS(X - OldX) < ABS(OldX*Tol))   {- Relative change in X    -}
                                          {-                         -}
(*             or                      *) {-                         -}
(*                                     *) {-                         -}
(*      (ABS(OldX - X) < Tol)          *) {- Absolute change in X    -}
(*                                     *) {-                         -}
(*             or                      *) {-                         -}
(*                                     *) {-                         -}
(*      (ABS(Y) <= Tol)                *) {- Absolute change in Y    -}
                                          {---------------------------}

{-----------------------------------------------------------------------}
{- The first criteria simply checks to see if the value of the         -}
{- function is zero.  You should probably always keep this criteria    -}
{- active.                                                             -}
{-                                                                     -}
{- The second criteria checks the relative error in X. This criteria   -}
{- evaluates the fractional change in X between interations. Note      -}
{- that X has been multiplied throught the inequality to avoid divide  -}
{- by zero errors.                                                     -}
{-                                                                     -}
{- The third criteria checks the absolute difference in X between      -}
{- iterations.                                                         -}
{-                                                                     -}
{- The fourth criteria checks the absolute difference between          -}
{- the value of the function and zero.                                 -}
{-----------------------------------------------------------------------}

end; { procedure TestForRoot }

begin { procedure Newton_Raphson }
  Initial(Guess, Tol, MaxIter, OldX, OldY, OldDeriv,
          Found, Iter, Error);

  while not(Found) and (Error = 0) and (Iter<MaxIter) do
  begin
    Iter := Succ(Iter);
    NewX := OldX - OldY / OldDeriv;
    NewY := UserFunction(NewX, FuncPtr1);
    NewDeriv := UserFunction(NewX, FuncPtr2);
    Found := TestForRoot(NewX, OldX, NewY, Tol);
    OldX := NewX;
    OldY := NewY;
    OldDeriv := NewDeriv;
    if not(Found) then
      CheckSlope(OldDeriv, Error);
  end;
  Root := OldX;
  Value := OldY;
  Deriv := OldDeriv;
  if not(Found) and (Error = 0) and (Iter >= MaxIter) then
    Error := 1;
end; { procedure Newton_Raphson }

procedure Secant{(Guess1 : Float;
                 Guess2  : Float;
                 Tol     : Float;
                 MaxIter : integer;
             var Root    : Float;
             var Value   : Float;
             var Iter    : integer;
             var Error   : byte;
                 FuncPtr : Pointer)};

var
  Found : boolean;            { Flags that a root has been Found }
  OldX, OldY, X, Y,
  NewX, NewY  : Float;         { Iteration variables }

procedure Initial(Guess1  : Float;
                  Guess2  : Float;
                  Tol     : Float;
                  MaxIter : integer;
              var OldX    : Float;
              var X       : Float;
              var OldY    : Float;
              var Y       : Float;
              var Found   : boolean;
              var Iter    : integer;
              var Error   : byte);

{-------------------------------------------------------------}
{- Input:  Guess1, Guess2, Tol, MaxIter                      -}
{- Output: OldX, X, OldY, Y, Found, Iter, Error              -}
{-                                                           -}
{- This procedure sets the initial values of the above       -}
{- variables. If OldY or Y is zero, then a root has been     -}
{- Found and Found = TRUE.  This procedure also checks       -}
{- the tolerance (Tol) and the maximum number of iterations  -}
{- (MaxIter) for errors.                                     -}
{-------------------------------------------------------------}

begin
  Found := false;
  Iter := 0;
  Error := 0;
  OldX := Guess1;
  X := Guess2;
  OldY := UserFunction(OldX, FuncPtr);
  Y := UserFunction(X, FuncPtr);
  if ABS(OldY) <= TNNearlyZero then         { OldX is the root }
    begin
      X := OldX;
      Y := OldY;
      Found := true;
    end
  else
    if ABS(Y) <= TNNearlyZero then
      Found := true                         {  X is the root  }
    else
      if ABS(OldY - Y) <= TNNearlyZero then
        Error := 2;                  { Slope of line is zero; no intercept }
  if Tol <= 0 then
    Error := 3;
  if MaxIter < 0 then
    Error := 4;
end; { procedure Initial }

function TestForRoot(X, OldX, y, Tol : Float) : boolean;

{-----------------------------------------------------------------}
{- These are the stopping criteria.  Four different ones are     -}
{- provided.  If you wish to change the active criteria, simply  -}
{- comment off the current criteria (including the preceding OR) -}
{- and remove the comment brackets from the criteria (including  -}
{- the following OR) you wish to be active.                      -}
{-----------------------------------------------------------------}

begin
  TestForRoot :=                      {---------------------------}
    (ABS(y) <= TNNearlyZero)          {- Y = 0                   -}
                                      {-                         -}
           or                         {-                         -}
                                      {-                         -}
    (ABS(X - OldX) < ABS(OldX*Tol))   {- Relative change in X    -}
                                      {-                         -}
(*         or                      *) {-                         -}
(*                                 *) {-                         -}
(*  (ABS(OldX - X) < Tol)          *) {- Absolute change in X    -}
(*                                 *) {-                         -}
(*         or                      *) {-                         -}
(*                                 *) {-                         -}
(*  (ABS(y) <= Tol)                *) {- Absolute change in Y    -}
                                      {---------------------------}

{-----------------------------------------------------------------------}
{- The first criteria simply checks to see if the value of the         -}
{- function is zero.  You should probably always keep this criteria    -}
{- active.                                                             -}
{-                                                                     -}
{- The second criteria checks the relative error in X. This criteria   -}
{- evaluates the fractional change in X between interations. Note      -}
{- that X has been multiplied through the inequality to avoid divide   -}
{- by zero errors.                                                     -}
{-                                                                     -}
{- The third criteria checks the absolute difference in X between      -}
{- iterations.                                                         -}
{-                                                                     -}
{- The fourth criteria checks the absolute difference between          -}
{- the value of the function and zero.                                 -}
{-----------------------------------------------------------------------}

end; { procedure TestForRoot }

begin { procedure Secant }
  Initial(Guess1, Guess2, Tol, MaxIter, OldX, X, OldY, Y,
          Found, Iter, Error);
  while not(Found) and (Error = 0) and (Iter<MaxIter) do
  begin
    Iter := Succ(Iter);
    NewX := X - Y * (X - OldX) / (Y - OldY);    { The secant formula }
    NewY := UserFunction(NewX, FuncPtr);
    Found := TestForRoot(NewX, OldX, NewY, Tol);
    OldX := X;
    OldY := Y;
    X := NewX;
    Y := NewY;
  end;
  Root := X;
  Value := Y;
  if not(Found) and (Error = 0) and (Iter >= MaxIter) then
    Error := 1;
end; { procedure Secant }

procedure Newt_Horn_Defl{(InitDegree : integer;
                          InitPoly   : TNvector;
                          Guess      : Float;
                          Tol        : Float;
                          MaxIter    : integer;
                      var Degree     : integer;
                      var NumRoots   : integer;
                      var Poly       : TNvector;
                      var Root       : TNvector;
                      var Imag       : TNvector;
                      var Value      : TNvector;
                      var Deriv      : TNvector;
                      var Iter       : TNIntVector;
                      var Error      : byte)};

var
  Iter1 : integer;

procedure SynDiv(Degree  : integer;
                 Poly    : TNvector;
                 X       : Float;
             var NewPoly : TNvector);

{--------------------------------------------------------------------------}
{- Input:  Degree, Poly                                                   -}
{- Output: NewPoly                                                        -}
{-                                                                        -}
{- This procedure applies the technique of synthetic division             -}
{- to a polynomial, Poly, at the value X.  The kth element of NewPoly     -}
{- is the (k-1)th element of the new polynomial. The 0th element          -}
{- of the resulting polynomial, NewPoly, is the value of the polynomial   -}
{- at X                                                                   -}
{--------------------------------------------------------------------------}

var
  Term : integer;

begin
  NewPoly[Degree] := Poly[Degree];
  for Term := Degree - 1 downto 0 do
    NewPoly[Term] := NewPoly[Term + 1] * X + Poly[Term];
end; { procedure SynDiv }

procedure QuadraticFormula(A       : Float;
                           B       : Float;
                           C       : Float;
                       var ReRoot1 : Float;
                       var ImRoot1 : Float;
                       var ReRoot2 : Float;
                       var ImRoot2 : Float);

{----------------------------------------------------------------}
{- Input:  A, B, C                                              -}
{- Output: ReRoot1, ImRoot1, ReRoot2, ImRoot2                   -}
{-                                                              -}
{- This procedure applies the quadratic formula to the equation -}
{- AX^2 + BX + C, where A,B,C are real.  It returns the real or -}
{- complex roots of the equation                                -}
{----------------------------------------------------------------}

var
  Denominator, Discrim : Float;

begin
  Denominator := 2 * A;
  ReRoot1 := -B / Denominator;
  ReRoot2 := ReRoot1;
  Discrim := B * B - 4 * A * C;
  if Discrim < 0 then
    begin
      ImRoot1 := -Sqrt(-Discrim) / Denominator;
      ImRoot2 :=  Sqrt(-Discrim) / Denominator;
    end
  else
    begin
      if B < 0 then  { Choose ReRoot1 to have the greatest absolute value }
        ReRoot1 := ReRoot1 + Sqrt(Discrim) / Denominator
      else
        ReRoot1 := ReRoot1 - Sqrt(Discrim) / Denominator;
      ReRoot2 := C / (A * ReRoot1);   { The product of the 2 roots is C/A }
      ImRoot1 := 0;
      ImRoot2 := 0;
    end;
end;    { procedure QuadraticFormula }

procedure TestData(InitDegree : integer;
                   InitPoly   : TNvector;
                   Tol        : Float;
                   MaxIter    : integer;
               var Degree     : integer;
               var Poly       : TNvector;
               var NumRoots   : integer;
               var Roots      : TNvector;
               var yRoots     : TNvector;
               var Iter       : TNIntVector;
               var Error      : byte);

{----------------------------------------------------------}
{- Input:  InitDegree, InitPoly, Tol, MaxIter             -}
{- Output: Degree, Poly, NumRoots, Roots, yRoots,         -}
{-         Iter, Error                                    -}
{-                                                        -}
{- This procedure sets the initial value of the above     -}
{- variables.  This procedure also tests the tolerance    -}
{- (Tol), maximum number of iterations (MaxIter), and     -}
{- Degree for errors and returns the appropriate error    -}
{- code.  Finally, it examines the coefficients of Poly.  -}
{- If the constant term is zero, then zero is one of the  -}
{- roots and the polynomial is deflated accordingly. Also -}
{- if the leading coefficient is zero, then Degree is     -}
{- reduced until the leading coefficient is non-zero.     -}
{----------------------------------------------------------}

var
  Term : integer;

begin
  Error := 0;
  NumRoots := 0;
  Degree := InitDegree;
  Poly := InitPoly;
  if Tol <= 0 then
    Error := 4;
  if MaxIter < 0 then
    Error :=5;
  { Reduce Degree until leading coefficient <> zero }
  while (Degree > 0) and (ABS(Poly[Degree]) < TNNearlyZero) do
    { Reduce Degree until leading coefficient <> zero }
    Degree  :=  Pred(Degree);
  if Degree <= 0 then
    Error := 3;
  { Deflate polynomial until the constant term <> zero }
  while (ABS(Poly[0]) < TNNearlyZero) and (Degree > 0) do
  begin
    NumRoots := Succ(NumRoots);
    Roots[NumRoots] := 0;
    yRoots[NumRoots] := 0;
    Iter[NumRoots] := 0;
    Degree := Pred(Degree);
    for Term := 0 to Degree do
      Poly[Term] := Poly[Term + 1];
  end;
end; { procedure TestData }

procedure FindValueAndDeriv(Degree : integer;
                            Poly   : TNvector;
                            X      : Float;
                        var Value  : Float;
                        var Deriv  : Float);

{--------------------------------------------------------------------}
{- Input:  Degree, Poly, X                                          -}
{- Output: Value, Deriv                                             -}
{-                                                                  -}
{- This procedure applies the technique of synthetic division to    -}
{- determine both the Value and derivative of the polynomial, Poly, -}
{- at X.  The 0th element of the first synthetic division is the    -}
{- value of the polynomial at X, and the 1st element of the second  -}
{- synthetic division is the derivative of the polynomial at X.     -}
{--------------------------------------------------------------------}

var
  Poly1, Poly2 : TNvector;
begin
  SynDiv(Degree, Poly, X, Poly1);
  Value := Poly1[0];
  SynDiv(Degree, Poly1, X, Poly2);
  Deriv := Poly2[1];
end; { procedure FindValueAndDeriv }

procedure FindOneRoot(Degree  : integer;
                      Poly    : TNvector;
                      Guess   : Float;
                      Tol     : Float;
                      MaxIter : integer;
                  var Root    : Float;
                  var Value   : Float;
                  var Deriv   : Float;
                  var Iter    : integer;
                  var Error   : byte);

{-------------------------------------------------------------------}
{- Input:  Degree, Poly, Guess, Tol, MaxIter                       -}
{- Output: Root, Value, Deriv, Iter, Error                         -}
{-                                                                 -}
{- A single root of the polynomial Poly.  The root must be         -}
{- approximated within MaxIter iterations to a tolerance of Tol.   -}
{- The root, value of the polynomial at the root (Value), and the  -}
{- value of the derivative of the polynomial at the root (Deriv),  -}
{- and the number of iterations (Iter) are returned. If no root    -}
{- is found, the appropriate error code (Error) is returned.       -}
{-------------------------------------------------------------------}

var
  Found : boolean;
  OldX, OldY, OldDeriv,
  NewX, NewY, NewDeriv : Float;

procedure CheckSlope(Slope : Float;
                 var Error : byte);

{---------------------------------------------------}
{- Input:  Slope                                   -}
{- Output: Error                                   -}
{-                                                 -}
{- This procedure checks the slope to see if it is -}
{- zero.  The Newton Raphson algorithm may not be  -}
{- applied at a point where the slope is zero.     -}
{---------------------------------------------------}

begin
  if ABS(Slope) <= TNNearlyZero then
    Error := 2;
end; { procedure CheckSlope }

procedure Initial(Degree   : integer;
                  Poly     : TNvector;
                  Guess    : Float;
              var OldX     : Float;
              var OldY     : Float;
              var OldDeriv : Float;
              var Found    : boolean;
              var Iter     : integer;
              var Error    : byte);

{-------------------------------------------------------------}
{- Input:  Degree, Poly, Guess                               -}
{- Output: OldX, OldY, OldDeriv, Found, Iter, Error          -}
{-                                                           -}
{- This procedure sets the initial values of the above       -}
{- variables. If OldY is zero, then a root has been          -}
{- found and Found = TRUE.                                   -}
{-------------------------------------------------------------}

begin
  Found := false;
  Iter := 0;
  Error := 0;
  OldX := Guess;
  FindValueAndDeriv(Degree, Poly, OldX, OldY, OldDeriv);
  if ABS(OldY) <= TNNearlyZero then
    Found := true
  else
    CheckSlope(OldDeriv, Error);
end; { procedure Initial }

function TestForRoot(X, OldX, Y, Tol : Float) : boolean;

{----------------------------------------------------------------}
{ These are the stopping criteria.  Four different ones are     -}
{ provided.  If you wish to change the active criteria, simply  -}
{ comment off the current criteria (including the preceding OR) -}
{ and remove the comment brackets from the criteria (including  -}
{ the following OR) you wish to be active.                      -}
{----------------------------------------------------------------}

begin
  TestForRoot :=                      {---------------------------}
    (ABS(Y) <= TNNearlyZero)          {- Y=0                     -}
                                      {-                         -}
           or                         {-                         -}
                                      {-                         -}
    (ABS(X - OldX) < ABS(OldX*Tol))   {- Relative change in X    -}
                                      {-                         -}
 (*        or                      *) {-                         -}
 (*                                *) {-                         -}
 (* (ABS(OldX - X) < Tol)          *) {- Absolute change in X    -}
 (*                                *) {-                         -}
 (*        or                      *) {-                         -}
 (*                                *) {-                         -}
 (* (ABS(Y) <= Tol)                *) {- Absolute change in Y    -}
                                      {---------------------------}

{-----------------------------------------------------------------------}
{- The first criteria simply checks to see if the value of the         -}
{- function is zero.  You should probably always keep this criteria    -}
{- active.                                                             -}
{-                                                                     -}
{- The second criteria checks the relative error in X. This criteria   -}
{- evaluates the fractional change in X between interations. Note      -}
{- that X has been multiplied through the inequality to avoid divide   -}
{- by zero errors.                                                     -}
{-                                                                     -}
{- The third criteria checks the absolute difference in X between      -}
{- iterations.                                                         -}
{-                                                                     -}
{- The fourth criteria checks the absolute difference between          -}
{- the value of the function and zero.                                 -}
{-----------------------------------------------------------------------}

end; { procedure TestForRoot }

begin { procedure FindOneRoot }
  Initial(Degree, Poly, Guess, OldX, OldY, OldDeriv, Found, Iter, Error);
  while not(Found) and (Error = 0) and (Iter<MaxIter) do
  begin
    Iter := Succ(Iter);
    NewX := OldX - OldY / OldDeriv;
    FindValueAndDeriv(Degree, Poly, NewX, NewY, NewDeriv);
    Found := TestForRoot(NewX, OldX, NewY, Tol);
    OldX := NewX;
    OldY := NewY;
    OldDeriv := NewDeriv;
    if not(Found) then
      CheckSlope(OldDeriv, Error);
  end;
  Root := OldX;
  Value := OldY;
  Deriv := OldDeriv;
  if not(Found) and (Error = 0) and (Iter >= MaxIter) then
    Error := 1;
  if Found then
    Error := 0;
end; { procedure FindOneRoot }

procedure ReducePolynomial(var Degree : integer;
                           var Poly   : TNvector;
                               Root   : Float);

{------------------------------------------------------}
{- Input:  Degree, Poly, Root                         -}
{- Output: Degree, Poly                               -}
{-                                                    -}
{- This procedure deflates the polynomial Poly by     -}
{- factoring out the Root.  Degree is reduced by one. -}
{------------------------------------------------------}

var
  NewPoly : TNvector;
  Term : integer;
begin
  SynDiv(Degree, Poly, Root, NewPoly);
  Degree := Pred(Degree);
  for Term := 0 to Degree do
    Poly[Term] := NewPoly[Term+1];
end; { procedure ReducePolynomial }

begin  { procedure Newt_Horn_Defl }
  TestData(InitDegree, InitPoly, Tol, MaxIter,
           Degree, Poly, NumRoots, Root, Value, Iter, Error);
  while (Error=0) and (Degree>2) do
  begin
    FindOneRoot(Degree, Poly, Guess, Tol, MaxIter, Root[NumRoots+1],
                Value[NumRoots+1], Deriv[NumRoots+1], Iter[NumRoots+1], Error);
    if Error = 0 then
    begin
      NumRoots := Succ(NumRoots);
      {------------------------------------------------------}
      {- The next statement refines the approximate root by -}
      {- plugging it into the original polynomial.  This    -}
      {- eliminates a lot of the round-off error            -}
      {- accumulated through many iterations                -}
      {------------------------------------------------------}
      if NumRoots > 1 then
      begin
        Iter1 := 0;
        FindOneRoot(InitDegree, InitPoly, Root[NumRoots],
                    Tol, MaxIter, Root[NumRoots], Value[NumRoots],
                    Deriv[NumRoots], Iter1, Error);
        Iter[NumRoots] := Iter[NumRoots] + Iter1;
      end;
      ReducePolynomial(Degree, Poly, Root[NumRoots]);
      Guess := Root[NumRoots];
    end;
  end;
  case Degree of
    1 : begin           { Solve this linear }
          Degree := 0;
          NumRoots := Succ(NumRoots);
          Root[NumRoots] := -Poly[0] / Poly[1];
          FindOneRoot(InitDegree, InitPoly, Root[NumRoots], Tol,
                      MaxIter, Root[NumRoots], Value[NumRoots],
                      Deriv[NumRoots], Iter[NumRoots], Error);
        end;

    2 : begin           { Solve this quadratic }
          Degree := 0;
          NumRoots := Succ(Succ(NumRoots));
          QuadraticFormula(Poly[2], Poly[1], Poly[0],
                           Root[NumRoots - 1], Imag[NumRoots - 1],
                           Root[NumRoots], Imag[NumRoots]);
          if ABS(Imag[NumRoots]) < TNNearlyZero then
            { if the roots are real, they can be     }
            { made more accurate using Newton-Horner }
            begin
              FindOneRoot(InitDegree, InitPoly, Root[NumRoots-1], Tol,
                          MaxIter, Root[NumRoots-1], Value[NumRoots-1],
                          Deriv[NumRoots-1], Iter[NumRoots-1], Error);

              FindOneRoot(InitDegree, InitPoly, Root[NumRoots], Tol,
                          MaxIter, Root[NumRoots], Value[NumRoots],
                          Deriv[NumRoots], Iter[NumRoots], Error);
            end
          else
            { If the roots are complex, then assign    }
            { the value to be zero (which is true,     }
            { except for some roundoff error) and the  }
            { derivative to be zero (which is usually  }
            { FALSE; the derivative is usually complex }
            begin
              Value[NumRoots-1] := 0;    Value[NumRoots] := 0;
              Deriv[NumRoots-1] := 0;    Deriv[NumRoots] := 0;
              Iter[NumRoots-1] := 0;     Iter[NumRoots] := 0;
            end;
        end;
  end; { case }
end; { procedure Newt_Horn_Defl }

procedure Muller{(Guess  : TNcomplex;
                 Tol     : Float;
                 MaxIter : integer;
             var Answer  : TNcomplex;
             var yAnswer : TNcomplex;
             var Iter    : integer;
             var Error   : byte;
                 FuncPtr : Pointer)};

type
  TNquadratic = record
                  A, B, C : TNcomplex;
                end;

var
  X0, X1, OldApprox,
  NewApprox, yNewApprox : TNcomplex;    { Iteration variables }
  Factor : TNquadratic;                 { Factor of polynomial }
  Found : boolean;                      { Flags that a factor }
                                        { has been found }

{----------- Here are a few complex operations ------------}

procedure Conjugate(C1 : TNcomplex; var C2 : TNcomplex);
begin
  C2.Re := C1.Re;
  C2.Im := -C1.Im;
end; { procedure Conjugate }

function Modulus(var C1 : TNcomplex) : Float;
begin
  Modulus := Sqrt(Sqr(C1.Re) + Sqr(C1.Im));
end; { function Modulus }

procedure Add(C1, C2 : TNcomplex; var C3 : TNcomplex);
begin
  C3.Re := C1.Re + C2.Re;
  C3.Im := C1.Im + C2.Im;
end; { procedure Add }

procedure Sub(C1, C2 : TNcomplex; var C3 : TNcomplex);
begin
  C3.Re := C1.Re - C2.Re;
  C3.Im := C1.Im - C2.Im;
end; { procedure Sub }

procedure Mult(C1, C2 : TNcomplex; var C3 : TNcomplex);
begin
  C3.Re := C1.Re * C2.Re - C1.Im * C2.Im;
  C3.Im := C1.Im * C2.Re + C1.Re * C2.Im;
end; { procedure Mult }

procedure Divide(C1, C2 : TNcomplex; var C3 : TNcomplex);
var
  Dum1, Dum2 : TNcomplex;
  E : Float;
begin
  Conjugate(C2, Dum1);
  Mult(C1, Dum1, Dum2);
  E := Sqr(Modulus(C2));
  C3.Re := Dum2.Re / E;
  C3.Im := Dum2.Im / E;
end; { procedure Divide }

procedure SquareRoot(C1 : TNcomplex; var C2 : TNcomplex);
var
  R, Theta : Float;
begin
  R := Sqrt(Sqr(C1.Re) + Sqr(C1.Im));
  if ABS(C1.Re) < TNNearlyZero then
    begin
      if C1.Im < 0 then
        Theta := Pi / 2
      else
        Theta := -Pi / 2;
    end
  else
    if C1.Re < 0 then
      Theta := ArcTan(C1.Im / C1.Re) + Pi
    else
      Theta := ArcTan(C1.Im / C1.Re);
  C2.Re := Sqrt(R) * Cos(Theta / 2);
  C2.Im := Sqrt(R) * Sin(Theta / 2);
end; { procedure SquareRoot }


procedure MakeParabola(X0     : TNcomplex;
                       X1     : TNcomplex;
                       Approx : TNcomplex;
                   var Factor : TNquadratic;
                   var Error  : byte);

{--------------------------------------------------------}
{- Input:  X0, X1, Approx                               -}
{- Output: Factor, Error                                -}
{-                                                      -}
{- This procedure constructs a parabola to fit the      -}
{- three points X0, X1, Approx.  The intersection of    -}
{- this parabola with the x-axis will yield the next    -}
{- approximation.  If the parabola is a horizontal line -}
{- then Error = 2 since a horizontal line will not      -}
{- intersect the x-axis.                                -}
{--------------------------------------------------------}

var
  H1, H2, H3, H : TNcomplex;
  Delta1, Delta2 : TNcomplex;
  Dum1, Dum2, Dum3, Dum4 : TNcomplex;     { Dummy variables }

begin
  with Factor do
  begin
    Sub(X0, Approx, H1);
    Sub(X1, Approx, H2);
    Sub(X0, X1, H3);
    Mult(H2, H3, Dum1);
    Mult(H1, Dum1, H);
    if Modulus(H) < TNNearlyZero then
      Error := 2;                     { Can't fit a quadratic to these points }
    UserProcedure(X1, Dum1, FuncPtr);
    Sub(Dum1, C, Delta1);             { C was passed in }
    UserProcedure(X0, Dum1, FuncPtr);
    Sub(Dum1, C, Delta2);

    if Error = 0 then                 { Calculate coefficients of quadratic }
    begin
      Mult(H1, H1, Dum1);             { Calculate B }
      Mult(Dum1, Delta1, Dum2);
      Mult(H2, H2, Dum1);
      Mult(Dum1, Delta2, Dum3);
      Sub(Dum2, Dum3, Dum4);
      Divide(Dum4, H, B);

      Mult(H2, Delta2, Dum1);         { Calculate A }
      Mult(H1, Delta1, Dum2);
      Sub(Dum1, Dum2, Dum3);
      Divide(Dum3, H, A);
    end;

    if (Modulus(A) <= TNNearlyZero) and (Modulus(B) <= TNNearlyZero) then
      Error := 2;            { Test if parabola is actually a constant }
  end; { with }
end; { procedure MakeParabola }

procedure Initial(Guess      : TNcomplex;
                  Tol        : Float;
                  MaxIter    : integer;
              var Error      : byte;
              var Iter       : integer;
              var Found      : boolean;
              var NewApprox  : TNcomplex;
              var yNewApprox : TNcomplex;
              var X0         : TNcomplex;
              var X1         : TNcomplex;
              var OldApprox  : TNcomplex;
              var Factor     : TNquadratic);

{------------------------------------------------------------------}
{- Input:  Guess, Tol, MaxIter                                    -}
{- Output: Error, Iter, Found, NewApprox, yNewApprox,             -}
{-         X0, X1, OldApprox, Factor                              -}
{-                                                                -}
{- This procedure initializes all the above variables. It         -}
{- sets OldApprox equal to Guess, X0 and X1 are set close to      -}
{- Guess.  The procedure also checks the tolerance (Tol) and      -}
{- maximum number of iterations (MaxIter) for errors.             -}
{------------------------------------------------------------------}

var
  cZero, yOldApprox : TNcomplex;

begin
  cZero.Re := 0;    { Complex zero }
  cZero.Im := 0;    { Complex zero }
  Error := 0;
  Found := false;
  Iter := 0;
  NewApprox := cZero;
  yNewApprox := cZero;
          { X0 and X1 are points which are close to Guess }
  X0.Re := -0.75 * Guess.Re - 1;     X0.Im := Guess.Im;
  X1.Re := 0.75 * Guess.Re;          X1.Im := 1.2 * Guess.Im + 1;
  OldApprox := Guess;
  UserProcedure(OldApprox, yOldApprox, FuncPtr);  { Evaluate the function at OldApprox }
  Factor.A := cZero;
  Factor.B := cZero;
  Factor.C := yOldApprox;
  MakeParabola(X0, X1, OldApprox, Factor, Error);
  if Tol <= 0 then
    Error := 3;
  if MaxIter < 0 then
    Error := 4;
end; { procedure Initial }

procedure QuadraticFormula(Factor    : TNquadratic;
                           OldApprox : TNcomplex;
                       var NewApprox : TNcomplex);

{-------------------------------------------------------------}
{- Input:  Factor, OldApprox                                 -}
{- Output: NewApprox                                         -}
{-                                                           -}
{- This procedure applies the complex quadratic formula      -}
{- to the quadratic Factor to determine where the parabola   -}
{- represented by Factor intersects the x-axis. The solution -}
{- of the quadratic formula is subtracted from OldApprox to  -}
{- yield NewApprox.                                          -}
{-------------------------------------------------------------}

var
  Discrim, Difference, Dum1, Dum2, Dum3 : TNcomplex;

begin
  with Factor do
  begin
    Mult(B, B, Dum1);                     { B^2 }
    Mult(A, C, Dum2);
    Discrim.Re := Dum1.Re - 4 * Dum2.Re;  { B^2 - 4AC }
    Discrim.Im := Dum1.Im - 4 * Dum2.Im;
    SquareRoot(Discrim, Discrim);
    Sub(B, Discrim, Dum1);                { B +/- sqrt(B^2 - 4AC) }
    Add(B, Discrim, Dum2);
    { Choose the root with B +/- Discrim greatest }
    if Modulus(Dum1) < Modulus(Dum2) then
      Dum1 := Dum2;
    Add(C, C, Dum3);
    if Modulus(Dum1) < TNNearlyZero then  { if B +/- sqrt(B^2 - 4AC) = 0 }
      begin
        NewApprox.Re := 0;
        NewApprox.Im := 0;
      end
    else
      begin                               { 2C/[B +/- sqrt(B^2 - 4AC)] }
        Divide(Dum3, Dum1, Difference);
        { Calculate NewApprox }
        Sub(OldApprox, Difference, NewApprox);
      end;
  end; { with }
end; { procedure QuadraticFormula }

function TestForRoot(X    : TNcomplex;
                     OldX : TNcomplex;
                     Y    : TNcomplex;
                     Tol  : Float) : boolean;

var
  Dif, FracDif : TNcomplex;

{-----------------------------------------------------------------}
{- These are the stopping criteria.  Four different ones are     -}
{- provided.  If you wish to change the active criteria, simply  -}
{- comment off the current criteria (including the preceding OR) -}
{- and remove the comment brackets from the criteria (including  -}
{- the following OR) you wish to be active.                      -}
{-----------------------------------------------------------------}

begin
  Sub(X, OldX, Dif);
  FracDif.Re := X.Re * Tol;
  FracDif.Im := X.Im * Tol;

  TestForRoot :=                      {---------------------------}
    (Modulus(Y) <= TNNearlyZero)      {- Y = 0                   -}
                                      {-                         -}
           or                         {-                         -}
                                      {-                         -}
    (Modulus(Dif) < Modulus(FracDif)) {- Relative change in X    -}
                                      {-                         -}
                                      {-                         -}
(*         or                      *) {-                         -}
(*                                 *) {-                         -}
(*  (Modulus(Dif) < Tol)           *) {- Absolute change in X    -}
(*                                 *) {-                         -}
(*         or                      *) {-                         -}
(*                                 *) {-                         -}
(*  (Modulus(Y) <= Tol)            *) {- Absolute change in y   -}
                                      {---------------------------}

{-----------------------------------------------------------------------}
{- The first criteria simply checks to see if the value of the         -}
{- function is zero.  You should probably always keep this criteria    -}
{- active.                                                             -}
{-                                                                     -}
{- The second criteria checks the relative error in x. This criteria   -}
{- evaluates the fractional change in x between interations. Note      -}
{- that x has been multiplied through the inequality to avoid Divide   -}
{- by zero errors.                                                     -}
{-                                                                     -}
{- The third criteria checks the absolute difference in x between      -}
{- iterations.                                                         -}
{-                                                                     -}
{- The fourth criteria checks the absolute difference between          -}
{- the value of the function and zero.                                 -}
{-----------------------------------------------------------------------}

end; { function TestForRoot }

begin { procedure  Muller }
  Initial(Guess, Tol, MaxIter, Error, Iter, Found, NewApprox, yNewApprox,
          X0, X1, OldApprox, Factor);

  while not Found and (Error = 0) and (Iter < MaxIter) do
  begin
    Iter := Succ(Iter);
    QuadraticFormula(Factor, OldApprox, NewApprox);
    UserProcedure(NewApprox, yNewApprox, FuncPtr);    { Calculate a new yNewApprox }
    Found := TestForRoot(NewApprox, OldApprox, yNewApprox, Tol);
    X0 := X1;
    X1 := OldApprox;
    OldApprox := NewApprox;
    Factor.C := yNewApprox;
    MakeParabola(X0, X1, OldApprox, Factor, Error);
  end;
  Answer := NewApprox;
  yAnswer := yNewApprox;
  if Found then
    Error := 0
  else
    if (Error = 0) and (Iter >= MaxIter) then
      Error := 1;
end; { procedure Muller }

procedure Laguerre{(var Degree   : integer;
                   var Poly      : TNCompVector;
                       InitGuess : TNcomplex;
                       Tol       : Float;
                       MaxIter   : integer;
                   var NumRoots  : integer;
                   var Roots     : TNCompVector;
                   var yRoots    : TNCompVector;
                   var Iter      : TNIntVector;
                   var Error     : byte)};

type
  TNquadratic = record
                  A, B, C : Float;
                end;

var
  AddIter    : integer;
  InitDegree : integer;
  InitPoly   : TNCompVector;
  GuessRoot  : TNcomplex;

{----------- Here are a few complex operations ------------}

procedure Conjugate(var C1, C2 : TNcomplex);
begin
  C2.Re := C1.Re;
  C2.Im := -C1.Im;
end; { procedure Conjugate }

function Modulus(var C1 : TNcomplex) : Float;
begin
  Modulus := Sqrt(Sqr(C1.Re) + Sqr(C1.Im));
end; { function Modulus }

procedure Add(var C1, C2, C3 : TNcomplex);
begin
  C3.Re := C1.Re + C2.Re;
  C3.Im := C1.Im + C2.Im;
end; { procedure Add }

procedure Sub(var C1, C2, C3 : TNcomplex);
begin
  C3.Re := C1.Re - C2.Re;
  C3.Im := C1.Im - C2.Im;
end; { procedure Sub }

procedure Mult(var C1, C2, C3 : TNcomplex);
begin
  C3.Re := C1.Re * C2.Re - C1.Im * C2.Im;
  C3.Im := C1.Im * C2.Re + C1.Re * C2.Im;
end; { procedure Mult }

procedure Divide(var C1, C2, C3 : TNcomplex);
var
  Dum1, Dum2 : TNcomplex;
  E : Float;
begin
  Conjugate(C2, Dum1);
  Mult(C1, Dum1, Dum2);
  E := Sqr(Modulus(C2));
  C3.Re := Dum2.Re / E;
  C3.Im := Dum2.Im / E;
end;  { procedure Divide }

procedure SquareRoot(var C1, C2 : TNcomplex);
const
  NearlyZero = 1E-015;
var
  R, Theta : Float;
begin
  R := Sqrt(Sqr(C1.Re) + Sqr(C1.Im));
  if ABS(C1.Re) < NearlyZero then
    begin
      if C1.Im < 0 then
        Theta := Pi / 2
      else
        Theta := -Pi / 2;
    end
  else
    if C1.Re < 0 then
      Theta := ArcTan(C1.Im / C1.Re) + Pi
    else
      Theta := ArcTan(C1.Im / C1.Re);
  C2.Re := Sqrt(R) * Cos(Theta / 2);
  C2.Im := Sqrt(R) * Sin(Theta / 2);
end; { procedure SquareRoot }

procedure InitAndTest(var Degree     : integer;
                      var Poly       : TNCompVector;
                          Tol        : Float;
                          MaxIter    : integer;
                          InitGuess  : TNcomplex;
                      var NumRoots   : integer;
                      var Roots      : TNCompVector;
                      var yRoots     : TNCompVector;
                      var Iter       : TNIntVector;
                      var GuessRoot  : TNcomplex;
                      var InitDegree : integer;
                      var InitPoly   : TNCompVector;
                      var Error      : byte);

{----------------------------------------------------------}
{- Input:  Degree, Poly, Tol, MaxIter, InitGuess          -}
{- Output: InitDegree, InitPoly, Degree, Poly, NumRoots,  -}
{-         Roots, yRoots, Iter, GuessRoot, Error          -}
{-                                                        -}
{- This procedure sets the initial value of the above     -}
{- variables.  This procedure also tests the tolerance    -}
{- (Tol), maximum number of iterations (MaxIter), and     -}
{- code.  Finally, it examines the coefficients of Poly.  -}
{- If the constant term is zero, then zero is one of the  -}
{- roots and the polynomial is deflated accordingly. Also -}
{- if the leading coefficient is zero, then Degree is     -}
{- reduced until the leading coefficient is non-zero.     -}
{----------------------------------------------------------}

var
  Term : integer;

begin
  Error := 0;
  if Degree <= 0 then
    Error := 2;      { degree is less than 2 }
  if Tol <= 0 then
    Error := 3;
  if MaxIter < 0 then
    Error := 4;

  if Error = 0 then
  begin
    NumRoots := 0;
    GuessRoot := InitGuess;
    InitDegree := Degree;
    InitPoly := Poly;
    { Reduce degree until leading coefficient <> zero }
    while (Degree > 0) and (Modulus(Poly[Degree]) < TNNearlyZero) do
      Degree := Pred(Degree);
    { Deflate polynomial until the constant term <> zero }
    while (Modulus(Poly[0]) = 0) and (Degree > 0) do
    begin
      { Zero is a root }
      NumRoots := Succ(NumRoots);
      Roots[NumRoots].Re := 0;
      Roots[NumRoots].Im := 0;
      yRoots[NumRoots].Re := 0;
      yRoots[NumRoots].Im := 0;
      Iter[NumRoots] := 0;
      Degree := Pred(Degree);
      for Term := 0 to Degree do
        Poly[Term] := Poly[Term + 1];
    end;
  end;
end; { procedure InitAndTest }

procedure FindOneRoot(Degree    : integer;
                      Poly      : TNCompVector;
                      GuessRoot : TNcomplex;
                      Tol       : Float;
                      MaxIter   : integer;
                  var Root      : TNcomplex;
                  var yValue    : TNcomplex;
                  var Iter      : integer;
                  var Error     : byte);

{-------------------------------------------------------------------}
{- Input:  Degree, Poly, GuessRoot, Tol, MaxIter                   -}
{- Output: Root, yValue, Iter, Error                               -}
{-                                                                 -}
{- This procedure approximates a single root of the polynomial     -}
{- Poly.  The root must be approximated within MaxIter             -}
{- iterations to a tolerance of Tol.  The root, value of the       -}
{- polynomial at the root (yValue), and the number of iterations   -}
{- (Iter) are returned. If no root is found, the appropriate error -}
{- code (Error) is returned.                                       -}
{-------------------------------------------------------------------}

var
  Found : boolean;
  Dif : TNcomplex;
  yPrime, yDoublePrime : TNcomplex;

procedure EvaluatePoly(Degree       : integer;
                       Poly         : TNCompVector;
                       X            : TNcomplex;
                   var yValue       : TNcomplex;
                   var yPrime       : TNcomplex;
                   var yDoublePrime : TNcomplex);

{--------------------------------------------------------------------}
{- Input:  Degree, Poly, X                                          -}
{- Output: yValue, yPrime, yDoublePrime                             -}
{-                                                                  -}
{- This procedure applies the technique of synthetic division to    -}
{- determine value (yValue), first derivative (yPrime) and second   -}
{- derivative (yDoublePrime) of the  polynomial, Poly, at X.        -}
{- The 0th element of the first synthetic division is the           -}
{- value of Poly at X, the 1st element of the second synthetic      -}
{- division is the first derivative of Poly at X, and twice the     -}
{- 2nd element of the third synthetic division is the second        -}
{- derivative of Poly at X.                                         -}
{--------------------------------------------------------------------}

var
  Loop : integer;
  Dummy, yDPdummy : TNcomplex;
  Deriv, Deriv2 : TNCompVector;

begin
  Deriv[Degree] := Poly[Degree];
  for Loop := Degree - 1 downto 0 do
  begin
    Mult(Deriv[Loop + 1], X, Dummy);
    Add(Dummy, Poly[Loop], Deriv[Loop]);
  end;
  yValue := Deriv[0];    { Value of Poly at X }

  Deriv2[Degree] := Deriv[Degree];
  for Loop := Degree - 1 downto 1 do
  begin
    Mult(Deriv2[Loop + 1], X, Dummy);
    Add(Dummy, Deriv[Loop], Deriv2[Loop]);
  end;
  yPrime := Deriv2[1];   { 1st deriv. of Poly at X }

  yDPdummy := Deriv2[Degree];
  for Loop := Degree - 1 downto 2 do
  begin
    Mult(yDPdummy, X, Dummy);
    Add(Dummy, Deriv2[Loop], yDPdummy);
  end;
  yDoublePrime.Re := 2 * yDPdummy.Re;    { 2nd derivative of Poly at X }
  yDoublePrime.Im := 2 * yDPdummy.Im;
end; { procedure EvaluatePoly }

procedure ConstructDifference(Degree       : integer;
                              yValue       : TNcomplex;
                              yPrime       : TNcomplex;
                              yDoublePrime : TNcomplex;
                          var Dif          : TNcomplex);

{------------------------------------------------------------------}
{- Input:  Degree, yValue, yPrime, yDoublePrime                   -}
{- Output: Dif                                                    -}
{-                                                                -}
{- This procedure computes the difference between approximations; -}
{- given information about the function and its first two         -}
{- derivatives.                                                   -}
{-----------------------------------------------------------------}

var
  yPrimeSQR, yTimesyDPrime, Sum, SRoot,
  Numer1, Numer2, Numer, Denom : TNcomplex;

begin
  Mult(yPrime, yPrime, yPrimeSQR);
  yPrimeSQR.Re := Sqr(Degree - 1) * yPrimeSQR.Re;
  yPrimeSQR.Im := Sqr(Degree - 1) * yPrimeSQR.Im;
  Mult(yValue, yDoublePrime, yTimesyDPrime);
  yTimesyDPrime.Re := (Degree - 1) * Degree * yTimesyDPrime.Re;
  yTimesyDPrime.Im := (Degree - 1) * Degree * yTimesyDPrime.Im;
  Sub(yPrimeSQR, yTimesyDPrime, Sum);
  SquareRoot(Sum, SRoot);
  Add(yPrime, SRoot, Numer1);
  Sub(yPrime, SRoot, Numer2);
  if Modulus(Numer1) > Modulus(Numer2) then
    Numer := Numer1
  else
    Numer := Numer2;
  Denom.Re := Degree * yValue.Re;
  Denom.Im := Degree * yValue.Im;
  if Modulus(Numer) < TNNearlyZero then
    begin
      Dif.Re := 0;
      Dif.Im := 0;
    end
  else
    Divide(Denom, Numer, Dif);  { The difference is the   }
                                { inverse of the fraction }
end; { procedure ConstructDifference }

function TestForRoot(X, Dif, Y, Tol : Float) : boolean;

{--------------------------------------------------------------------}
{-  These are the stopping criteria.  Four different ones are       -}
{-  provided.  If you wish to change the active criteria, simply    -}
{-  comment off the current criteria (including the appropriate OR) -}
{-  and remove the comment brackets from the criteria (including    -}
{-  the appropriate OR) you wish to be active.                      -}
{--------------------------------------------------------------------}

begin
  TestForRoot :=                      {---------------------------}
    (ABS(Y) <= TNNearlyZero)          {- Y=0                     -}
                                      {-                         -}
           or                         {-                         -}
                                      {-                         -}
    (ABS(Dif) < ABS(X * Tol))         {- Relative change in X    -}
                                      {-                         -}
                                      {-                         -}
 (*       or                      *)  {-                         -}
 (*                               *)  {-                         -}
 (* (ABS(Dif) < Tol)              *)  {- Absolute change in X    -}
 (*                               *)  {-                         -}
 (*       or                      *)  {-                         -}
 (*                               *)  {-                         -}
 (* (ABS(Y) <= Tol)               *)  {- Absolute change in Y    -}
                                      {---------------------------}

{-----------------------------------------------------------------------}
{- The first criteria simply checks to see if the value of the         -}
{- function is zero.  You should probably always keep this criteria    -}
{- active.                                                             -}
{-                                                                     -}
{- The second criteria checks the relative error in X. This criteria   -}
{- evaluates the fractional change in X between interations. Note      -}
{- that X has been multiplied throught the inequality to avoid divide  -}
{- by zero errors.                                                     -}
{-                                                                     -}
{- The third criteria checks the absolute difference in X between      -}
{- iterations.                                                         -}
{-                                                                     -}
{- The fourth criteria checks the absolute difference between          -}
{- the value of the function and zero.                                 -}
{-----------------------------------------------------------------------}

end; { procedure TestForRoot }

begin { procedure FindOneRoot }
  Root := GuessRoot;
  Found := false;
  Iter := 0;
  EvaluatePoly(Degree, Poly, Root, yValue, yPrime, yDoublePrime);
  while (Iter < MaxIter) and not(Found) do
  begin
    Iter := Succ(Iter);
    ConstructDifference(Degree, yValue, yPrime, yDoublePrime, Dif);
    Sub(Root, Dif, Root);
    EvaluatePoly(Degree, Poly, Root, yValue, yPrime, yDoublePrime);
    Found := TestForRoot(Modulus(Root), Modulus(Dif), Modulus(yValue), Tol);
  end;
  if not(Found) then Error := 1;   { Iterations execeeded MaxIter }
end; { procedure FindOneRoot }

procedure ReducePoly(var Degree : integer;
                     var Poly   : TNCompVector;
                     Root       : TNcomplex);

{------------------------------------------------------}
{- Input: Degree, Poly, Root                          -}
{- Output: Degree, Poly                               -}
{-                                                    -}
{- This procedure deflates the polynomial Poly by     -}
{- factoring out the Root.  Degree is reduced by one. -}
{------------------------------------------------------}

var
  Term : integer;
  NewPoly : TNCompVector;
  Dummy : TNcomplex;

begin
  NewPoly[Degree - 1] := Poly[Degree];
  for Term := Degree - 1 downto 1 do
  begin
    Mult(NewPoly[Term], Root, Dummy);
    Add(Dummy, Poly[Term], NewPoly[Term - 1]);
  end;
  Degree := Pred(Degree);
  Poly := NewPoly;
end; { procedure ReducePoly }

begin  { procedure Laguerre }
  InitAndTest(Degree, Poly, Tol, MaxIter, InitGuess, NumRoots, Roots,
              yRoots, Iter, GuessRoot, InitDegree, InitPoly, Error);
  while (Degree > 0) and (Error = 0) do
  begin
    FindOneRoot(Degree, Poly, GuessRoot, Tol, MaxIter,
                Roots[NumRoots + 1], yRoots[NumRoots + 1],
                Iter[NumRoots + 1], Error);
    if Error = 0 then
    begin
      {------------------------------------------------------}
      {- The next statement refines the approximate root by -}
      {- plugging it into the original polynomial.  This    -}
      {- eliminates a lot of the round-off error            -}
      {- accumulated through many iterations                -}
      {------------------------------------------------------}
      FindOneRoot(InitDegree, InitPoly, Roots[NumRoots + 1],
                  Tol, MaxIter, Roots[NumRoots + 1],
                  yRoots[NumRoots + 1], AddIter, Error);
      Iter[NumRoots + 1] := Iter[NumRoots + 1] + AddIter;
      NumRoots := Succ(NumRoots);
      ReducePoly(Degree, Poly, Roots[NumRoots]); { Reduce polynomial }
    end;
    GuessRoot := Roots[NumRoots];
  end;
end; { procedure Laguerre }
