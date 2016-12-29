unit Integrat;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-  This unit provides procedures for performing numerical integration.     -}
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
  TNArraySize = 50;              { Size of the vectors }

type
  TNvector = array[0..TNArraySize] of Float;

procedure Simpson(LowerLimit   : Float;
                  UpperLimit   : Float;
                  NumIntervals : integer;
              var Integral     : Float;
              var Error        : byte;
                  FuncPtr      : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-  Purpose: given a function, TNTargetF(X), compute the integral of        -}
{-           TNTargetF(X) from LowerLimit to UpperLimit using Simpson       -}
{-           Composite Algorithm.                                           -}
{-                                                                          -}
{-  User-defined Functions: TNTargetF(X : real) : real;                     -}
{-                                                                          -}
{-    Global Variables:  LowerLimit   : real;    Lower limit of integration -}
{-                       UpperLimit   : real;    Upper limit of integration -}
{-                       NumIntervals : integer; Number of subintervals     -}
{-                                               over which to use          -}
{-                                               Simpson's rule.            -}
{-                       Integral     : real;    Value of the integral of   -}
{-                                               TNTargetF over the given   -}
{-                                               interval                   -}
{-                       Error        : byte;    Flags if something goes    -}
{-                                               wrong                      -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: NumIntervals < 0                                -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Trapezoid(LowerLimit   : Float;
                    UpperLimit   : Float;
                    NumIntervals : integer;
                var Integral     : Float;
                var Error        : byte;
                    FuncPtr      : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-  Purpose: Given a function, TNTargetF(X), compute the integral of        -}
{-  TNTargetF(X) from LowerLimit to UpperLimit using the Trapezoid Rule     -}
{-                                                                          -}
{-  User-defined Functions: TNTargetF(X : real) : real;                     -}
{-                                                                          -}
{-    Global Variables:  LowerLimit   : real;    Lower limit of integration -}
{-                       UpperLimit   : real;    Upper limit of integration -}
{-                       NumIntervals : integer; Number of subintervals     -}
{-                                               over which to use the      -}
{-                                               trapezoid rule.            -}
{-                       Integral     : real;    Value of the integral of   -}
{-                                               TNTargetF over the given   -}
{-                                               interval                   -}
{-                       Error        : byte;    Flags if something goes    -}
{-                                               wrong                      -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: NumIntervals < 0                                -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Adaptive_Simpson(LowerLimit   : Float;
                           UpperLimit   : Float;
                           Tolerance    : Float;
                           MaxIntervals : integer;
                       var Integral     : Float;
                       var NumIntervals : integer;
                       var Error        : byte;
                           FuncPtr      : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input: LowerLimit, UpperLimit, Tolerance, MaxIntervals                -}
{-   Output: Integral, NumIntervals, Error                                  -}
{-                                                                          -}
{-  Purpose: Given a function, TNTargetF(X), compute the integral of        -}
{-           TNTargetF from LowerLimit to UpperLimit using Adaptive         -}
{-           Quadrature and Simpson's rule.                                 -}
{-                                                                          -}
{-  User-defined Functions: TNTargetF(X : real) : real;                     -}
{-                                                                          -}
{-  Global Variables:  LowerLimit   : real;    Lower limit of integration   -}
{-                     UpperLimit   : real;    Upper limit of integration   -}
{-                     Tolerance    : real;    Tolerance in answer          -}
{-                     MaxIntervals : integer; Max. number of subintervals  -}
{-                                             used to approximate integral -}
{-                     Integral     : real;    Value of the integral of     -}
{-                                             TNTargetF over the given     -}
{-                                             interval                     -}
{-                     NumIntervals : integer; Number of subintervals       -}
{-                     Error        : byte;    Flags if something goes      -}
{-                                             wrong                        -}
{-                                                                          -}
{-            Errors:  0: No errors                                         -}
{-                     1: Tolerance <= 0                                    -}
{-                     2: MaxIntervals <= 0                                 -}
{-                     3: NumIntervals >= MaxIntervals                      -}
{-                                                                          -}
{-              Note:  Adaptive quadrature is a recursive routine.          -}
{-                     In order to avoid recursive procedure calls,         -}
{-                     (which slows down the execution) a stack is          -}
{-                     created to simulate recursion.  The stack is         -}
{-                     created using pointer implementation.                -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Adaptive_Gauss_Quadrature(LowerLimit   : Float;
                                    UpperLimit   : Float;
                                    Tolerance    : Float;
                                    MaxIntervals : integer;
                                var Integral     : Float;
                                var NumIntervals : integer;
                                var Error        : byte;
                                    FuncPtr      : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-  Purpose: Given a function, TNTargetF(X), compute the integral of        -}
{-           TNTargetF from LowerLimit to UpperLimit using Adaptive         -}
{-           Quadrature and Gaussian Quadrature with a 16th order           -}
{-           Legendre polynomial.                                           -}
{-                                                                          -}
{-  User-defined Functions: TNTargetF(X : real) : real;                     -}
{-                                                                          -}
{-  Global Variables:  LowerLimit   : real;    Lower limit of integration   -}
{-                     UpperLimit   : real;    Upper limit of integration   -}
{-                     Tolerance    : real;    Tolerance in answer          -}
{-                     MaxIntervals : integer; Max no. of subintervals over -}
{-                                             Which to approximate integral-}
{-                     Integral     : real;    Value of the integral of     -}
{-                                             TNTargetF over the given     -}
{-                                             interval                     -}
{-                     NumIntervals : integer; Number of subintervals       -}
{-                                             used to approximate integral -}
{-                     Error        : byte;    Flags if something goes      -}
{-                                             wrong                        -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: Tolerance <= 0                                  -}
{-                       2: MaxIntervals <= 0                               -}
{-                       3: NumIntervals >= MaxIntervals                    -}
{-                                                                          -}
{-                Note:  Adaptive quadrature is a recursive routine.        -}
{-                       In order to avoid recursive procedure calls,       -}
{-                       (which slow down the execution) a stack is         -}
{-                       created to simulate recursion.  The stack is       -}
{-                       created using pointer implementation.              -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure Romberg(LowerLimit : Float;
                  UpperLimit : Float;
                  Tolerance  : Float;
                  MaxIter    : integer;
              var Integral   : Float;
              var Iter       : integer;
              var Error      : byte;
                  FuncPtr    : Pointer);

{----------------------------------------------------------------------------}
{-                                                                          -}
{-    Input: LowerLimit, UpperLimit, Tolerance, MaxIter                     -}
{-   Output: Integral, Iter, Error                                          -}
{-                                                                          -}
{-  Purpose: Given a function, TNTargetF(X), this procedure approximates    -}
{-           the integral of TNTargetF from LowerLimit to UpperLimit        -}
{-           using the Romberg method.                                      -}
{-                                                                          -}
{-  User-defined Functions: TNTargetF(X : real) : real;                     -}
{-                                                                          -}
{-    Global Variables:  LowerLimit : real;    Lower limit of integration   -}
{-                       UpperLimit : real;    Upper limit of integration   -}
{-                       Tolerance  : real;    Tolerance in answer          -}
{-                       MaxIter    : integer; Maximum number of iterations -}
{-                       Integral   : real;    Value of the integral of     -}
{-                                             TNTargetF over the given     -}
{-                                             interval                     -}
{-                       Iter       : integer; Number of iterations         -}
{-                       Error      : byte;    Flags if something goes      -}
{-                                             wrong                        -}
{-                                                                          -}
{-              Errors:  0: No errors                                       -}
{-                       1: Tolerance <= 0                                  -}
{-                       2: MaxIter <= 0                                    -}
{-                       3: Iter > MaxIter                                  -}
{-                                                                          -}
{-        Version Date:  26 January 1987                                    -}
{-                                                                          -}
{----------------------------------------------------------------------------}

implementation

{$F+}
{$L Integrat.OBJ}
function UserFunction(X : Float; ProcAddr : Pointer) : Float; external;
{$F-}

procedure Simpson{(LowerLimit  : Float;
                  UpperLimit   : Float;
                  NumIntervals : integer;
              var Integral     : Float;
              var Error        : byte;
                  FuncPtr      : Pointer)};

var
  Spacing : Float;           { Size of each subinterval }
  Point : Float;             { Midway point of each interval }
  OddSum, EvenSum : Float;   { Sums of values over odd numbered }
                            { and even numbered subintervals }
  LimitsValue : Float;       { Sum of values at the endpoints }
  Interval : integer;       { Counter }

begin { procedure Simpson }
  if NumIntervals <= 0 then
    Error := 1
  else
    begin
      Spacing := (UpperLimit - LowerLimit) / (2 * NumIntervals);
      Point := LowerLimit;
      OddSum := 0;
      EvenSum := 0;
      for Interval := 1 to 2*NumIntervals - 1 do
      begin
        Point := Point + Spacing;
        if Odd(Interval) then
          OddSum := OddSum + UserFunction(Point, FuncPtr)
        else
          EvenSum := EvenSum + UserFunction(Point, FuncPtr);
      end;
      LimitsValue := UserFunction(UpperLimit, FuncPtr) +
                     UserFunction(LowerLimit, FuncPtr);
      Integral := Spacing * (LimitsValue + 2 * EvenSum + 4 * OddSum) / 3;
    end;
end; { procedure Simpson }

procedure Trapezoid{(LowerLimit  : Float;
                    UpperLimit   : Float;
                    NumIntervals : integer;
                var Integral     : Float;
                var Error        : byte;
                    FuncPtr      : Pointer)};

var
  Spacing : Float;           { Size of each subinterval }
  Point : Float;             { Midway point of each interval }
  Sum : Float;               { Sums of values over intervals }
  LimitsValue : Float;       { Sum of values at the endpoints }
  Interval : integer;       { Counter }

begin  { procedure Trapezoid }
  if NumIntervals <= 0 then
    Error := 1
  else
    begin
      Spacing := (UpperLimit - LowerLimit) / NumIntervals;
      Point := LowerLimit;
      Sum := 0;
      for Interval := 1 to NumIntervals - 1 do
      begin
        Point := Point + Spacing;
        Sum := Sum + UserFunction(Point, FuncPtr);
      end;
      LimitsValue := UserFunction(UpperLimit, FuncPtr) +
                     UserFunction(LowerLimit, FuncPtr);
      Integral := Spacing * (LimitsValue + 2 * Sum) / 2;
    end;
end; { procedure Trapezoid }

procedure Adaptive_Simpson{(LowerLimit  : Float;
                           UpperLimit   : Float;
                           Tolerance    : Float;
                           MaxIntervals : integer;
                       var Integral     : Float;
                       var NumIntervals : integer;
                       var Error        : byte;
                           FuncPtr      : Pointer)};
type
  IntegralData = record
                   LB, VLB, UB, VUB, Est : Float;
                 end;

  Ptr = ^StackItem;

  StackItem = record
                Info : IntegralData;
                Next : Ptr;
              end;

var
  Spacing, Estimate, NewEstimate1, NewEstimate2, NewEstimate,
  Middle, ValueMiddle : Float;
  Data : IntegralData;
  Stack : Ptr;
  Finished : boolean;

procedure InitializeStack(var Stack : Ptr);
begin
  Stack := nil;
end; { procedure InitializeStack}

procedure Push(Data  : IntegralData;
           var Stack : Ptr);

{------------------------------}
{- Input: Data, Stack         -}
{- Output: Stack              -}
{-                            -}
{- Push Data onto the Stack   -}
{------------------------------}

var
  NewNode : Ptr;

begin
  New(NewNode);
  NewNode^.Info := Data;
  NewNode^.Next := Stack;
  Stack := NewNode;
end; { procedure Push }

procedure Pop(var Data  : IntegralData;
              var Stack : Ptr);

{------------------------------}
{- Input: Stack               -}
{- Output: Data, Stack        -}
{-                            -}
{- Pop Data from the Stack    -}
{------------------------------}

var
  OldNode : Ptr;

begin
  OldNode := Stack;
  Stack := OldNode^.Next;
  Data := OldNode^.Info;
  Dispose(OldNode);
end; { procedure Pop }

function Simpson(LowerLimit  : Float;
                 ValueLowLmt : Float;
                 UpperLimit  : Float;
                 ValueUpLmt  : Float) : Float;

{----------------------------------------------------------}
{- Input: LowerLimit, ValueLowLmt, UpperLimit, ValueUpLmt -}
{-                                                        -}
{- This function returns the integral of TNTargetF(X)     -}
{- from LowerLimit to UpperLimit using Simpson's rule.    -}
{----------------------------------------------------------}

var
  Spacing : Float;

begin
  Spacing := (UpperLimit - LowerLimit) / 2;
  Simpson := Spacing * (ValueLowLmt + 4 * UserFunction(LowerLimit + Spacing, FuncPtr)
             + ValueUpLmt) / 3;
end; { function Simpson }

procedure TestAndInitialize(LowerLimit   : Float;
                            UpperLimit   : Float;
                            Tolerance    : Float;
                            MaxIntervals : integer;
                        var Data         : IntegralData;
                        var Integral     : Float;
                        var NumIntervals : integer;
                        var Stack        : Ptr;
                        var Finished     : boolean;
                        var Error        : byte);

{-----------------------------------------------------------}
{- Input: LowerLimit, UpperLimit, Tolerance, MaxIntervals  -}
{- Output: Data, Integral, NumIntervals, Stack, Finished,  -}
{-         Error                                           -}
{-                                                         -}
{- This procedure tests Tolerance and MaxIntervals for     -}
{- errors (they must be greater than zero).                -}
{- This procedure initializes the Data record with the     -}
{- input data (LowerLimit, etc) and initializes the other  -}
{- variables to 0, Nil or False.                           -}
{-----------------------------------------------------------}

begin
  Error := 0;
  if Tolerance < 0 then
    Error := 1;
  if MaxIntervals < 0 then
    Error := 2;
  if Error = 0 then
  begin
    with Data do
    begin
      LB := LowerLimit;
      VLB := UserFunction(LowerLimit, FuncPtr);
      UB := UpperLimit;
      VUB := UserFunction(UpperLimit, FuncPtr);
      Est := Simpson(LB, VLB, UB, VUB);
    end; { with }
    Integral := 0;
    NumIntervals := 0;
    InitializeStack(Stack);
    Finished := false;
  end;
end; { procedure TestAndInitialize }

procedure AddIntoIntegral(NewEstimate  : Float;
                      var Integral     : Float;
                          NumIntervals : integer;
                          MaxIntervals : integer;
                      var Stack        : Ptr;
                      var Data         : IntegralData;
                      var Finished     : boolean;
                      var Error        : byte);

{-----------------------------------------------------------}
{- Input: NewEstimate, NumIntervals, MaxIntervals, Stack   -}
{- Output: Integral, Stack, Data, Finished, Error          -}
{-                                                         -}
{- This procedure adds the integral of the subinterval     -}
{- (NewEstimate) into the integral of the whole interval   -}
{- (Integral).  This procedure also checks to see if the   -}
{- number of intervals (NumIntervals) exceeds the maximum  -}
{- number of intervals allowed (MaxIntervals).  If the     -}
{- Stack is empty, the integral of the whole interval has  -}
{- been approximated and Found=True, otherwise information -}
{- from the next subinterval is popped off the stack.      -}
{-----------------------------------------------------------}

begin
  Integral := Integral + NewEstimate;
  if NumIntervals = MaxIntervals then
    begin  { Max number of intervals exceeded }
      Finished := true;
      Error := 3;
    end
  else     { Pop next interval off stack }
           { or end if Stack = NIL       }
    if Stack = nil then    { For optimization purposes }
                           { no function call is made }
      Finished := true
    else
      Pop(Data, Stack);
end; { procedure AddIntoIntegral }

procedure DivideInterval(Middle       : Float;
                         ValueMiddle  : Float;
                         NewEstimate1 : Float;
                         NewEstimate2 : Float;
                     var Stack        : Ptr;
                     var Data         : IntegralData);

{---------------------------------------------------------------}
{- Input: Middle, ValueMiddle, NewEstimate1, NewEstimate2      -}
{- Output: Stack, Data,                                        -}
{-                                                             -}
{- This procedure stores the information from the left half    -}
{- of the interval on the stack and puts the information       -}
{- from the right half of the interval into the variable Data. -}
{---------------------------------------------------------------}

var
  StoreData : IntegralData;

begin
  StoreData.LB := Data.LB;
  StoreData.VLB := Data.VLB;
  StoreData.UB := Middle;
  StoreData.VUB := ValueMiddle;
  StoreData.Est := NewEstimate1;
  Push(StoreData, Stack);
  Data.LB := Middle;
  Data.VLB := ValueMiddle;
  Data.Est := NewEstimate2;
end; { procedure DivideInterval }

begin  { procedure Adaptive_Simpson }
  TestAndInitialize(LowerLimit, UpperLimit, Tolerance, MaxIntervals,
                    Data, Integral, NumIntervals, Stack, Finished, Error);
  if Error = 0 then
  repeat
    with Data do
    begin
      NumIntervals := Succ(NumIntervals);
      Spacing := (UB - LB) / 2;
      Middle := LB + Spacing;
      ValueMiddle := UserFunction(Middle, FuncPtr);
      Estimate := Est;
      { NewEstimate1 is the integral of the left half of the interval }
      NewEstimate1 := Simpson(LB, VLB, Middle, ValueMiddle);
      { NewEstimate2 is the integral of the right half of the interval }
      NewEstimate2 := Simpson(Middle, ValueMiddle, UB, VUB);
      NewEstimate := NewEstimate1 + NewEstimate2;
    end;

    if (ABS(Estimate - NewEstimate) <= ABS(Tolerance * NewEstimate)) or
       (NumIntervals = MaxIntervals) then { Prevents infinite loops }

      { The integral of this subinterval has      }
      { been approximated to the proper tolerance }
      AddIntoIntegral(NewEstimate, Integral, NumIntervals,
                      MaxIntervals, Stack, Data, Finished, Error)

    else  { Divide the interval in 2 and }
          { compute the integral in each }
      DivideInterval(Middle, ValueMiddle, NewEstimate1, NewEstimate2,
                     Stack, Data);
  until Finished;
end; { procedure Adaptive_Simpson }

procedure Adaptive_Gauss_Quadrature{(LowerLimit  : Float;
                                    UpperLimit   : Float;
                                    Tolerance    : Float;
                                    MaxIntervals : integer;
                                var Integral     : Float;
                                var NumIntervals : integer;
                                var Error        : byte;
                                    FuncPtr      : Pointer)};

type
  IntegralData = record
                   LB, VLB, UB, VUB, Est : Float;
                 end;

  Ptr = ^StackItem;

  StackItem = record
                Info : IntegralData;
                Next : Ptr;
              end;

var
  Spacing, Estimate, NewEstimate1, NewEstimate2, NewEstimate,
  Middle, ValueMiddle : Float;
  Data : IntegralData;
  Stack : Ptr;
  Finished : boolean;

function Gaussian_Quadrature(LowerLimit : Float;
                             UpperLimit : Float) : Float;

{------------------------------------------------------------}
{- Input: LowerLimit, UpperLimit                            -}
{-                                                          -}
{- This function returns the integral of TNTargetF(X)       -}
{- from LowerLimit to UpperLimit using Gaussian quadrature. -}
{------------------------------------------------------------}

const
  NumLegendreTerms = 16;

type
  TNConstants = array[1..NumLegendreTerms] of record
                                                Root, Weight : Float;
                                              end;

const

{------------------------------------------------------------------}
{- These numbers are the zeros and weight factors of the          -}
{- NumLegendreTermsth order Legendre Polynomial.  The numbers are -}
{- taken from Abramowitz, Milton and Stegum, Irene. "Handbook of  -}
{- Mathematical Functions with Formulas, Graphs and Mathematical  -}
{- Tables." Washington DC: National Bureau of Standards, Applied  -}
{- Mathematics Series, 55. 1972.                                  -}
{-                                                                -}
{- These numbers satisfy the following:                           -}
{-                                                                -}
{-     Integral from -1 to 1 of f(X) dx                           -}
{-                  equals                                        -}
{-     Sum from I=1 to NumLegendreTerms of                        -}
{-                Legendre[I].Weight - f(Legendre[I].Root)        -}
{------------------------------------------------------------------}

      Legendre : TNConstants = (
        { Legendre[1] } (Root : 0.095012509837637440185;
          Weight : 0.189450610455068496285),
        { Legendre[2] } (Root : 0.281603550779258913230;
          Weight : 0.182603415044923588867),
        { Legendre[3] } (Root : 0.458016777657227386342;
          Weight : 0.169156519395002538189),
        { Legendre[4] } (Root : 0.617876244402643748447;
          Weight : 0.149595988816576732081),
        { Legendre[5] } (Root : 0.755404408355003033895;
          Weight : 0.124628971255533872052),
        { Legendre[6] } (Root : 0.865631202387831743880;
          Weight : 0.095158511682492784810),
        { Legendre[7] } (Root : 0.944575023073232576078;
          Weight : 0.062253523938647892863),
        { Legendre[8] } (Root : 0.989400934991649932596;
          Weight : 0.027152459411754094852),
        { Legendre[9] } (Root : -0.095012509837637440185;
          Weight : 0.189450610455068496285),
        { Legendre[10] } (Root : -0.281603550779258913230;
          Weight : 0.182603415044923588867),
        { Legendre[11] } (Root : -0.458016777657227386342;
          Weight : 0.169156519395002538189),
        { Legendre[12] } (Root : -0.617876244402643748447;
          Weight : 0.149595988816576732081),
        { Legendre[13] } (Root : -0.755404408355003033895;
          Weight : 0.124628971255533872052),
        { Legendre[14] } (Root : -0.865631202387831743880;
          Weight : 0.095158511682492784810),
        { Legendre[15] } (Root : -0.944575023073232576078;
          Weight : 0.062253523938647892863),
        { Legendre[16] } (Root : -0.989400934991649932596;
          Weight : 0.027152459411754094852));

var
  Slope, Intercept, TransRoot, Sum : Float;
  Term : integer;

begin { function Gaussian_Quadrature }
  Slope := (UpperLimit - LowerLimit) / 2;
  Intercept := (UpperLimit + LowerLimit) / 2;
  Sum := 0;
  for Term := 1 to NumLegendreTerms do
  with Legendre[Term] do
  begin
    TransRoot := Slope * Root + Intercept;
    Sum := Sum + Weight * UserFunction(TransRoot, FuncPtr);
  end;
  Gaussian_Quadrature := Slope * Sum;
end; { function Gaussian_Quadrature }

procedure InitializeStack(var Stack : Ptr);
begin
  Stack := nil;
end; { procedure InitializeStack }

procedure Push(Data  : IntegralData;
           var Stack : Ptr);

{------------------------------}
{- Input: Data, Stack         -}
{- Output: Stack              -}
{-                            -}
{- Push Data onto the Stack   -}
{------------------------------}

var
  NewNode : Ptr;

begin
  New(NewNode);
  NewNode^.Info := Data;
  NewNode^.Next := Stack;
  Stack := NewNode;
end; { procedure Push }

procedure Pop(var Data  : IntegralData;
              var Stack : Ptr);

{------------------------------}
{- Input: Stack               -}
{- Output: Data, Stack        -}
{-                            -}
{- Pop Data from the Stack    -}
{------------------------------}

var
  OldNode : Ptr;

begin
  OldNode := Stack;
  Stack := OldNode^.Next;
  Data := OldNode^.Info;
  Dispose(OldNode);
end; { procedure Pop }

procedure TestAndInitialize(LowerLimit   : Float;
                            UpperLimit   : Float;
                            Tolerance    : Float;
                            MaxIntervals : integer;
                        var Data         : IntegralData;
                        var Integral     : Float;
                        var NumIntervals : integer;
                        var Stack        : Ptr;
                        var Finished     : boolean;
                        var Error        : byte);

{-----------------------------------------------------------}
{- Input: LowerLimit, UpperLimit, Tolerance, MaxIntervals  -}
{- Output: Data, Integral, NumIntervals, Stack, Finished,  -}
{-         Error                                           -}
{-                                                         -}
{- This procedure tests Tolerance and MaxIntervals for     -}
{- errors (they must be greater than zero).                -}
{- This procedure initializes the Data record with the     -}
{- input data (LowerLimit, etc) and initializes the other  -}
{- variables to 0, Nil or False.                           -}
{-----------------------------------------------------------}

begin
  Error := 0;
  if Tolerance < 0 then
    Error := 1;
  if MaxIntervals < 0 then
    Error := 2;
  if Error = 0 then
  begin
    with Data do
    begin
      LB := LowerLimit;
      VLB := UserFunction(LowerLimit, FuncPtr);
      UB := UpperLimit;
      VUB := UserFunction(UpperLimit, FuncPtr);
      Est := Gaussian_Quadrature(LB, UB);
    end; { with }
    Integral := 0;
    NumIntervals := 0;
    InitializeStack(Stack);
    Finished := false;
  end;
end; { procedure TestAndInitialize }

procedure AddIntoIntegral(NewEstimate  : Float;
                      var Integral     : Float;
                          NumIntervals : integer;
                          MaxIntervals : integer;
                      var Stack        : Ptr;
                      var Data         : IntegralData;
                      var Finished     : boolean;
                      var Error        : byte);

{-----------------------------------------------------------}
{- Input: NewEstimate, NumIntervals, MaxIntervals, Stack   -}
{- Output: Integral, Stack, Data, Finished, Error          -}
{-                                                         -}
{- This procedure adds the integral of the subinterval     -}
{- (NewEstimate) into the integral of the whole interval   -}
{- (Integral).  This procedure also checks to see if the   -}
{- number of intervals (NumIntervals) exceeds the maximum  -}
{- number of intervals allowed (MaxIntervals).  If the     -}
{- Stack is empty, the integral of the whole interval has  -}
{- been approximated and Found=True, otherwise information -}
{- from the next subinterval is popped off the stack.      -}
{-----------------------------------------------------------}

begin
  Integral := Integral + NewEstimate;
  if NumIntervals = MaxIntervals then
    begin    { Max number of intervals exceeded }
      Finished := true;
      Error := 3;
    end
  else       { Pop next interval off stack }
             { or end if Stack = NIL       }
    if Stack = nil then     { for optimization purposes }
                            { no function call is made }
      Finished := true
    else
      Pop(Data, Stack);
end; { procedure AddIntoIntegral }

procedure DivideInterval(Middle       : Float;
                         ValueMiddle  : Float;
                         NewEstimate1 : Float;
                         NewEstimate2 : Float;
                     var Stack        : Ptr;
                     var Data         : IntegralData);

{---------------------------------------------------------------}
{- Input: Middle, ValueMiddle, NewEstimate1, NewEstimate2      -}
{- Output: Stack, Data,                                        -}
{-                                                             -}
{- This procedure stores the information from the left half    -}
{- of the interval on the stack and puts the information       -}
{- from the right half of the interval into the variable Data. -}
{---------------------------------------------------------------}

var
  StoreData : IntegralData;

begin
  StoreData.LB := Data.LB;
  StoreData.VLB := Data.VLB;
  StoreData.UB := Middle;
  StoreData.VUB := ValueMiddle;
  StoreData.Est := NewEstimate1;
  Push(StoreData, Stack);
  Data.LB := Middle;
  Data.VLB := ValueMiddle;
  Data.Est := NewEstimate2;
end; { procedure DivideInterval }

begin  { procedure Adaptive_Gauss_Quadrature }
  TestAndInitialize(LowerLimit, UpperLimit, Tolerance, MaxIntervals,
                    Data, Integral, NumIntervals, Stack, Finished, Error);

  if Error = 0 then
  repeat
    with Data do
    begin
      NumIntervals := Succ(NumIntervals);
      Spacing := (UB - LB) / 2;
      Middle := LB + Spacing;
      ValueMiddle := UserFunction(Middle, FuncPtr);
      Estimate := Est;
      { NewEstimate1 is the integral of the left half of the interval }
      NewEstimate1 := Gaussian_Quadrature(LB, Middle);
      { NewEstimate2 is the integral of the right half of the interval }
      NewEstimate2 := Gaussian_Quadrature(Middle, UB);
      NewEstimate := NewEstimate1 + NewEstimate2;
    end; { with }

    if (ABS(Estimate - NewEstimate) <= ABS(Tolerance * NewEstimate)) or
       (NumIntervals = MaxIntervals) then { Prevents infinite loops }

      { The integral of this subinterval has      }
      { been approximated to the proper tolerance }
      AddIntoIntegral(NewEstimate, Integral, NumIntervals,
                      MaxIntervals, Stack, Data, Finished, Error)

    else  { Divide the interval in 2 and }
          { compute the integral in each }
      DivideInterval(Middle, ValueMiddle, NewEstimate1, NewEstimate2,
                     Stack, Data);
  until Finished;
end; { procedure Adaptive_Gauss_Quadrature }

procedure Romberg{(LowerLimit : Float;
                  UpperLimit  : Float;
                  Tolerance   : Float;
                  MaxIter     : integer;
              var Integral    : Float;
              var Iter        : integer;
              var Error       : byte;
                  FuncPtr     : Pointer)};

var
  Spacing : Float;                 { Spacing between points }
  NewEstimate,
  OldEstimate : TNvector;         { Iteration variables }
  TwoToTheIterMinus2 : integer;

procedure TestAndInitialize(LowerLimit         : Float;
                            UpperLimit         : Float;
                            Tolerance          : Float;
                            MaxIter            : integer;
                        var Iter               : integer;
                        var Spacing            : Float;
                        var OldEstimate        : TNvector;
                        var TwoToTheIterMinus2 : integer;
                        var Error              : byte);

{------------------------------------------------------------------}
{- Input: LowerLimit, UpperLimit, Tolerance, MaxIter              -}
{- Output: Iter, Spacing, OldEstimate, TwoToTheIterMinus2, Error  -}
{-                                                                -}
{- This procedure tests Tolerance and MaxIter for errors (they    -}
{- must be greater than zero) and initializes the above           -}
{- variables.                                                     -}
{------------------------------------------------------------------}

begin
  Error := 0;
  if Tolerance <= 0 then
    Error := 1;
  if MaxIter <= 0 then
    Error := 2;
  if Error = 0 then
  begin
    Spacing := UpperLimit - LowerLimit;
    OldEstimate[1] := Spacing *
                      (UserFunction(LowerLimit, FuncPtr) +
                       UserFunction(UpperLimit, FuncPtr)) / 2;
    Iter := 1;
    TwoToTheIterMinus2 := 1;
  end;
end; { procedure TestAndInitialize }

procedure Trapezoid(TwoToTheIterMinus2 : integer;
                    LowerLimit         : Float;
                    Spacing            : Float;
                    OldEstimate        : Float;
                var NewEstimate        : Float);

{--------------------------------------------------------}
{- Input: TwoToTheIterMinus2, LowerLimit, Spacing,      -}
{-        OldEstimate                                   -}
{- Output: NewEstimate                                  -}
{-                                                      -}
{- This procedure uses the trapezoid rule to            -}
{- improve the integral approximation (OldEstimate)     -}
{- on the interval [LowerLimit, LowerLimit + Spacing].  -}
{- The results are returned in the variable NewEstimate -}
{--------------------------------------------------------}

var
  Sum : Float;
  Dummy : integer;

begin
  Sum := 0;
  for Dummy := 1 to TwoToTheIterMinus2 do
    Sum := Sum + UserFunction(LowerLimit + (Dummy - 0.5) * Spacing, FuncPtr);
  NewEstimate := 0.5 * (OldEstimate + Spacing * Sum);
end; { procedure Trapezoid }

procedure Extrapolate(Iter        : integer;
                      OldEstimate : TNvector;
                  var NewEstimate : TNvector);

{--------------------------------------------------------}
{- Input: Iter, OldEstimate                             -}
{- Output: NewEstimate                                  -}
{-                                                      -}
{- This procedure uses Richardson extrapolation         -}
{- to improve the current approximation to the integral -}
{- (OldEstimate).  The result is returned in the        -}
{- variable NewEstimate                                 -}
{--------------------------------------------------------}

var
  Extrap : integer;
  FourToTheExtrapMinus1 : Float;

begin
  FourToTheExtrapMinus1 := 1;
  for Extrap := 2 to Iter do
  begin
    FourToTheExtrapMinus1 := FourToTheExtrapMinus1 * 4;
    NewEstimate[Extrap] :=
                        (FourToTheExtrapMinus1 * NewEstimate[Extrap - 1] -
                        OldEstimate[Extrap - 1]) / (FourToTheExtrapMinus1 - 1);
  end;
end; { procedure Extrapolate }

begin { procedure Romberg }
  TestAndInitialize(LowerLimit, UpperLimit, Tolerance, MaxIter, Iter,
                    Spacing, OldEstimate, TwoToTheIterMinus2, Error);
  if Error = 0 then
  begin
    repeat
      Iter := Succ(Iter);
      Trapezoid(TwoToTheIterMinus2, LowerLimit, Spacing, OldEstimate[1],
                NewEstimate[1]);
      TwoToTheIterMinus2 := TwoToTheIterMinus2 * 2;
      Extrapolate(Iter, OldEstimate, NewEstimate);
      Spacing := Spacing / 2;
      OldEstimate := NewEstimate;
    until { The fractional difference between }
          { iterations is within Tolerance    }
          (ABS(NewEstimate[Iter - 1] - NewEstimate[Iter]) <=
           ABS(Tolerance * NewEstimate[Iter])) or (Iter >= MaxIter);

    if Iter >= MaxIter then
      Error := 3;
    Integral := NewEstimate[Iter];
  end;
end; { procedure Romberg }

end. { Integrat }
