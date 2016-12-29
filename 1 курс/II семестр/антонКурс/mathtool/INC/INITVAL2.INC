{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure InitialConditionSystem{(NumEquations  : integer;
                                 LowerLimit     : Float;
                                 UpperLimit     : Float;
                                 InitialValues  : TNvector;
                                 NumReturn      : integer;
                                 NumIntervals   : integer;
                             var SolutionValues : TNmatrix;
                             var Error          : byte;
                                 Vector         : FuncVect)};
type
  Ptr = ^Data;

  Data = record
           Values : TNvector;
           Next : Ptr;
         end;

var
  ValuesStack : Ptr;                     { Pointer to the stack  }
  Spacing, HalfSpacing : Float;           { Size of each subinterval  }
  Index : integer;
  Term : integer;
  F1 : TNvector;
  F2 : TNvector;
  F3 : TNvector;
  F4 : TNvector;
  CurrentValues : TNvector;
  TempValues : TNvector;

procedure InitializeStack(var ValuesStack : Ptr);
begin
  ValuesStack := nil;
end; { procedure InitializeStack }

procedure Push(var ValuesStack   : Ptr;
               var CurrentValues : TNvector);

{--------------------------------------}
{- Input: ValuesStack, CurrentValues  -}
{- Output: ValuesStack                -}
{-                                    -}
{- Push data onto the Stack           -}
{--------------------------------------}

var
  NewNode : Ptr;

begin
  New(NewNode);
  NewNode^.Values := CurrentValues;
  NewNode^.Next := ValuesStack;
  ValuesStack := NewNode;
end; { procedure Push }

procedure Pop(var ValuesStack   : Ptr;
              var CurrentValues : TNvector);

{--------------------------------------}
{- Input: ValuesStack, CurrentValues  -}
{- Output: ValuesStack                -}
{-                                    -}
{- Pop data from the Stack            -}
{--------------------------------------}

var
  OldNode : Ptr;

begin
  OldNode := ValuesStack;
  ValuesStack := OldNode^.Next;
  CurrentValues := OldNode^.Values;
end; { procedure Pop }

procedure TestAndInitialize(NumEquations     : integer;
                            LowerLimit       : Float;
                            UpperLimit       : Float;
                            var NumIntervals : integer;
                            NumReturn        : integer;
                        var ValuesStack      : Ptr;
                        var Spacing          : Float;
                        var Error            : byte);

{-----------------------------------------------------------------}
{- Input: NumEquations, LowerLimit, UpperLimit,                  -}
{-        NumIntervals, NumReturn                                -}
{- Output: ValuesStack, Spacing, Error                           -}
{-                                                               -}
{- This procedure initializes the above variables. ValuesStack   -}
{- is initialized to NIL. Spacing is initialized to              -}
{-        (UpperLimit - LowerLimit)/NumIntervals.                -}
{- NumEquations, NumIntervals, and NumReturn are checked for     -}
{- errors; they must be greater than zero.                       -}
{-----------------------------------------------------------------}

begin
  Error := 0;
  if NumReturn <= 0 then
    Error := 1;
  if NumIntervals < NumReturn then
    Error := 2;
  if NumEquations < 1 then
    Error := 3;
  if LowerLimit = UpperLimit then
    Error := 4;
  if Error = 0 then
  begin
    InitializeStack(ValuesStack);
    Spacing := (UpperLimit - LowerLimit)/NumIntervals;
  end;
end; { procedure TestAndInitialize }

procedure GetValues(NumReturn      : integer;
                    NumIntervals   : integer;
                var ValuesStack    : Ptr;
                var SolutionValues : TNmatrix);

{----------------------------------------------------------}
{- Input: NumReturn, NumIntervals, ValuesStack            -}
{- Output: SolutionValues                                 -}
{-                                                        -}
{- This procedure fills in the matrix SolutionValues      -}
{- with data from the values stack. For example,          -}
{- if there are five times as many items on the stack     -}
{- (NumIntervals) as should be returned (NumReturn) then  -}
{- every fifth value from the stack will be returned.     -}
{----------------------------------------------------------}

var
  Index, Term   : integer;
  CurrentValues : TNvector;

begin
  Term := NumIntervals;
  for Index := NumReturn downto 0 do
  begin
    Pop(ValuesStack, CurrentValues);
    Term := Pred(Term);
    while (Term / NumIntervals >= Index / NumReturn) and (Term >= 0) do
    begin
      Pop(ValuesStack, CurrentValues);
      Term := Pred(Term);
    end;
    SolutionValues[Index] := CurrentValues;
  end;
end; { procedure GetValues }

procedure Step(Spacing       : Float;
           var CurrentValues : TNvector;
           var F             : TNvector);

{---------------------------------------------------------}
{- Input: Spacing, CurrentValues                         -}
{- Output: F                                             -}
{-                                                       -}
{- This procedure performs one step in the Runge-Kutta   -}
{- four-step algorithm. By varying CurrentValues, this   -}
{- procedure can be used at all steps in the Runge-      -}
{- Kutta algorithm.                                      -}
{-                                                       -}
{- This procedure assumes that there are no more than    -}
{- ten coupled 1st-order equations.  The F's record      -}
{- information about the 10 (or fewer) independent       -}
{- variables.                                            -}
{---------------------------------------------------------}

begin
  F[1] := Spacing * UserFunction3(CurrentValues, Vector[1]);
  F[2] := Spacing * UserFunction3(CurrentValues, Vector[2]);
  F[3] := Spacing * UserFunction3(CurrentValues, Vector[3]);
  F[4] := Spacing * UserFunction3(CurrentValues, Vector[4]);
  F[5] := Spacing * UserFunction3(CurrentValues, Vector[5]);
  F[6] := Spacing * UserFunction3(CurrentValues, Vector[6]);
  F[7] := Spacing * UserFunction3(CurrentValues, Vector[7]);
  F[8] := Spacing * UserFunction3(CurrentValues, Vector[8]);
  F[9] := Spacing * UserFunction3(CurrentValues, Vector[9]);
  F[10] := Spacing * UserFunction3(CurrentValues, Vector[10]);
end; { procedure Step }

begin  { procedure InitialConditionSystem }
  TestAndInitialize(NumEquations, LowerLimit, UpperLimit,
                    NumIntervals, NumReturn, ValuesStack, Spacing, Error);
  if Error = 0 then
  begin
    CurrentValues := InitialValues;
    Push(ValuesStack, CurrentValues);
    HalfSpacing := Spacing / 2;
    for Index := 1 to NumIntervals do
    begin
      { First step - calculate F1  }
      Step(Spacing, CurrentValues, F1);
      TempValues[0] := CurrentValues[0] + HalfSpacing;
      for Term := 1 to NumEquations do
        TempValues[Term] := CurrentValues[Term] + 0.5 * F1[Term];

      { 2nd step - calculate F2  }
      Step(Spacing, TempValues, F2);
      for Term := 1 to NumEquations do
        TempValues[Term] := CurrentValues[Term] + 0.5 * F2[Term];

      { Third step - calculate F3  }
      Step(Spacing, TempValues, F3);
      TempValues[0] := CurrentValues[0] + Spacing;
      for Term := 1 to NumEquations do
        TempValues[Term] := CurrentValues[Term] + F3[Term];

      { Fourth step - calculate F4[1]; first equation  }
      Step(Spacing, TempValues, F4);

      { Combine F1, F2, F3, and F4 to get  }
      { the solution at this mesh point    }
      CurrentValues[0] := CurrentValues[0] + Spacing;
      for Term := 1 to NumEquations do
        CurrentValues[Term] := CurrentValues[Term] + (F1[Term] + 2 * F2[Term] +
                               2 * F3[Term] + F4[Term]) / 6;

      Push(ValuesStack, CurrentValues);
    end;
    GetValues(NumReturn, NumIntervals, ValuesStack, SolutionValues);
  end;
end; { procedure InitialConditionSystem }

procedure InitialConditionSystem2{(NumEquations  : integer;
                                  LowerLimit     : Float;
                                  UpperLimit     : Float;
                                  InitialValues  : TNvector2;
                                  NumReturn      : integer;
                                  NumIntervals   : integer;
                              var SolutionValues : TNmatrix2;
                              var Error          : byte;
                                  Vector         : FuncVect)};

type
  Ptr = ^Data;

  Data = record
           Values : TNvector2;
           Next : Ptr;
         end;

var
  ValuesStack : Ptr;                     { Pointer to the stack  }
  Spacing, HalfSpacing : Float;           { Size of each subinterval  }
  Index : integer;
  Term : integer;
  F1 : TNvector2;
  F2 : TNvector2;
  F3 : TNvector2;
  F4 : TNvector2;
  CurrentValues : TNvector2;
  TempValues : TNvector2;

procedure InitializeStack(var ValuesStack : Ptr);
begin
  ValuesStack := nil;
end; { procedure InitializeStack }

procedure Push(var ValuesStack   : Ptr;
               var CurrentValues : TNvector2);

{--------------------------------------}
{- Input: ValuesStack, CurrentValues  -}
{- Output: ValuesStack                -}
{-                                    -}
{- Push data onto the Stack           -}
{--------------------------------------}

var
  NewNode : Ptr;

begin
  New(NewNode);
  NewNode^.Values := CurrentValues;
  NewNode^.Next := ValuesStack;
  ValuesStack := NewNode;
end; { procedure Push }

procedure Pop(var ValuesStack   : Ptr;
              var CurrentValues : TNvector2);

{--------------------------------------}
{- Input: ValuesStack, CurrentValues  -}
{- Output: ValuesStack                -}
{-                                    -}
{- Pop data from the Stack            -}
{--------------------------------------}

var
  OldNode : Ptr;

begin
  OldNode := ValuesStack;
  ValuesStack := OldNode^.Next;
  CurrentValues := OldNode^.Values;
end; { procedure Pop }

procedure TestAndInitialize(NumEquations  : integer;
                            LowerLimit    : Float;
                            UpperLimit    : Float;
                            NumIntervals  : integer;
                            NumReturn     : integer;
                        var InitialValues : TNvector2;
                        var ValuesStack   : Ptr;
                        var Spacing       : Float;
                        var Error         : byte);

{-----------------------------------------------------------------}
{- Input: NumEquations, LowerLimit, UpperLimit,                  -}
{-        NumIntervals, NumReturn                                -}
{- Output: InitialValues, ValuesStack, Spacing, Error            -}
{-                                                               -}
{- This procedure initializes the above variables. ValuesStack   -}
{- is initialized to NIL. Spacing is initialized to              -}
{-        (UpperLimit - LowerLimit)/NumIntervals.                -}
{- NumEquations, NumIntervals, and NumReturn are checked for     -}
{- errors; they must be greater than zero.                       -}
{-----------------------------------------------------------------}

begin
  Error := 0;
  if NumReturn <= 0 then
    Error := 1;
  if NumIntervals < NumReturn then
    Error := 2;
  if NumEquations < 1 then
    Error := 3;
  if LowerLimit = UpperLimit then
    Error := 4;
  if Error = 0 then
  begin
    InitializeStack(ValuesStack);
    Spacing := (UpperLimit - LowerLimit)/NumIntervals;
    InitialValues[0].X := LowerLimit;
  end;
end; { procedure TestAndInitialize }

procedure GetValues(NumReturn      : integer;
                    NumIntervals   : integer;
                var ValuesStack    : Ptr;
                var SolutionValues : TNmatrix2);

{----------------------------------------------------------}
{- Input: NumReturn, NumIntervals, ValuesStack            -}
{- Output: SolutionValues                                 -}
{-                                                        -}
{- This procedure fills in the matrix SolutionValues      -}
{- with data from the values stack. For example,          -}
{- if there are five times as many items on the stack     -}
{- (NumIntervals) as should be returned (NumReturn) then  -}
{- every fifth value from the stack will be returned.     -}
{----------------------------------------------------------}

var
  Index : integer;
  Term : integer;
  CurrentValues : TNvector2;

begin
  Term := NumIntervals;
  for Index := NumReturn downto 0 do
  begin
    Pop(ValuesStack, CurrentValues);
    Term := Pred(Term);
    while (Term/NumIntervals >= Index/NumReturn) and (Term >= 0) do
    begin
      Pop(ValuesStack, CurrentValues);
      Term := Pred(Term);
    end;
    SolutionValues[Index] := CurrentValues;
  end;
end; { procedure GetValues }

procedure Step(Spacing       : Float;
           var CurrentValues : TNvector2;
           var F             : TNvector2);

{---------------------------------------------------------}
{- Input: Spacing, CurrentValues                         -}
{- Output: F                                             -}
{-                                                       -}
{- This procedure performs one step in the Runge-Kutta   -}
{- four-step algorithm. By varying CurrentValues, this   -}
{- procedure can be used at all steps in the Runge-      -}
{- Kutta algorithm.                                      -}
{-                                                       -}
{- This procedure assumes that there are no more than    -}
{- ten coupled 2nd-order equations.  The F.X's record    -}
{- information about the 10 (or fewer) independent       -}
{- variables.  The F.xDeriv's record information about   -}
{- their derivatives.                                    -}
{---------------------------------------------------------}

begin
  F[1].X := Spacing * CurrentValues[1].xDeriv;
  F[1].xDeriv := Spacing * UserFunction4(CurrentValues, Vector[1]);

  F[2].X := Spacing * CurrentValues[2].xDeriv;
  F[2].xDeriv := Spacing * UserFunction4(CurrentValues, Vector[2]);

  F[3].X := Spacing * CurrentValues[3].xDeriv;
  F[3].xDeriv := Spacing * UserFunction4(CurrentValues, Vector[3]);

  F[4].X := Spacing * CurrentValues[4].xDeriv;
  F[4].xDeriv := Spacing * UserFunction4(CurrentValues, Vector[4]);

  F[5].X := Spacing * CurrentValues[5].xDeriv;
  F[5].xDeriv := Spacing * UserFunction4(CurrentValues, Vector[5]);

  F[6].X := Spacing * CurrentValues[6].xDeriv;
  F[6].xDeriv := Spacing * UserFunction4(CurrentValues, Vector[6]);

  F[7].X := Spacing * CurrentValues[7].xDeriv;
  F[7].xDeriv := Spacing * UserFunction4(CurrentValues, Vector[7]);

  F[8].X := Spacing * CurrentValues[8].xDeriv;
  F[8].xDeriv := Spacing * UserFunction4(CurrentValues, Vector[8]);

  F[9].X := Spacing * CurrentValues[9].xDeriv;
  F[9].xDeriv := Spacing * UserFunction4(CurrentValues, Vector[9]);

  F[10].X := Spacing * CurrentValues[10].xDeriv;
  F[10].xDeriv := Spacing * UserFunction4(CurrentValues, Vector[10]);
end; { procedure Step }

begin  {procedure InitialConditionSystem2}
  TestAndInitialize(NumEquations, LowerLimit, UpperLimit, NumIntervals,
                    NumReturn, InitialValues, ValuesStack, Spacing, Error);
  if Error = 0 then
  begin
    CurrentValues := InitialValues;
    Push(ValuesStack, CurrentValues);
    HalfSpacing := Spacing / 2;
    for Index := 1 to NumIntervals do
    begin

      { First step - calculate F1  }
      Step(Spacing, CurrentValues, F1);
      TempValues[0].X := CurrentValues[0].X + HalfSpacing;
      for Term := 1 to NumEquations do
      begin
        TempValues[Term].X := CurrentValues[Term].X + 0.5 * F1[Term].X;
        TempValues[Term].xDeriv := CurrentValues[Term].xDeriv +
                                   0.5 * F1[Term].xDeriv;
      end;

      { Second step - calculate F2  }
      Step(Spacing, TempValues, F2);
      for Term := 1 to NumEquations do
      begin
        TempValues[Term].X := CurrentValues[Term].X + 0.5 * F2[Term].X;
        TempValues[Term].xDeriv := CurrentValues[Term].xDeriv +
                                   0.5 * F2[Term].xDeriv;
      end;

      { Third step - calculate F3  }
      Step(Spacing, TempValues, F3);
      TempValues[0].X := CurrentValues[0].X + Spacing;
      for Term := 1 to NumEquations do
      begin
        TempValues[Term].X := CurrentValues[Term].X + F3[Term].X;
        TempValues[Term].xDeriv := CurrentValues[Term].xDeriv + F3[Term].xDeriv;
      end;

      { Fourth step - calculate F4  }
      Step(Spacing, TempValues, F4);

      { Combine F1, F2, F3, and F4 to get  }
      { the solution at this mesh point    }
      CurrentValues[0].X := CurrentValues[0].X + Spacing;
      for Term := 1 to NumEquations do
      begin
        CurrentValues[Term].X := CurrentValues[Term].X + (F1[Term].X +
                             2 * F2[Term].X + 2 * F3[Term].X + F4[Term].X) / 6;
        CurrentValues[Term].xDeriv := CurrentValues[Term].xDeriv +
                                      (F1[Term].xDeriv + 2 * F2[Term].xDeriv +
                                    2 * F3[Term].xDeriv + F4[Term].xDeriv) / 6;
      end;
      Push(ValuesStack, CurrentValues);
    end;
    GetValues(NumReturn, NumIntervals, ValuesStack, SolutionValues);
  end;
end; { procedure InitialConditionSystem2 }

procedure Shooting{(LowerLimit  : Float;
                   UpperLimit   : Float;
                   LowerInitial : Float;
                   UpperInitial : Float;
                   InitialSlope : Float;
                   NumReturn    : integer;
                   Tolerance    : Float;
                   MaxIter      : integer;
                   NumIntervals : integer;
               var Iter         : integer;
               var XValues      : TNvector;
               var YValues      : TNvector;
               var YDerivValues : TNvector;
               var Error        : byte;
                   FuncPtr      : Pointer)};
type
  Ptr = ^Data;

  Data = record
           X, Y, YPrime : Float;
           Next : Ptr;
         end;

var
  HeapTop : Ptr;                      { Top of the heap  }
  Values : Ptr;                       { Pointer to the stack  }
  Spacing : Float;                     { Size of sub-intervals  }
  UpperApprox1 : Float;                { Approx to UpperInitial  }
  UpperApprox2 : Float;
  Slope1 : Float;                      { Slope at LowerLimit  }
  Slope2 : Float;
  NewSlope : Float;
  Done : boolean;                     { True  --> algorithm finished  }
                                      { False --> algorithm not finished  }

procedure Push(var Values  : Ptr;
               XValue      : Float;
               YValue      : Float;
               YPrimeValue : Float);

{----------------------------------}
{- Input: Values, XValue, YValue  -}
{-        YPrimeValue             -}
{- Output: Values                 -}
{-                                -}
{- Push data into the Stack       -}
{----------------------------------}

begin
  Values^.X := XValue;
  Values^.Y := YValue;
  Values^.YPrime := YPrimeValue;
  Values := Values^.Next;
end; { procedure Push }

procedure Pop(var Values      : Ptr;
              var XValue      : Float;
              var YValue      : Float;
              var YPrimeValue : Float);

{----------------------------------}
{- Input: Values, XValue, YValue  -}
{-        YPrimeValue             -}
{- Output: Values                 -}
{-                                -}
{- Pop Data from the Stack        -}
{----------------------------------}

var
  OldNode : Ptr;

begin
  OldNode := Values;
  Values := OldNode^.Next;
  XValue := OldNode^.X;
  YValue := OldNode^.Y;
  YPrimeValue := OldNode^.YPrime;
  Dispose(OldNode);
end; { procedure Pop }

procedure TestAndInitialize(LowerLimit   : Float;
                            UpperLimit   : Float;
                            InitialSlope : Float;
                            NumReturn    : integer;
                            var Spacing  : Float;
                            Tolerance    : Float;
                            MaxIter      : integer;
                        var HeapTop      : Ptr;
                        var Iter         : integer;
                        var Values       : Ptr;
                        var NumIntervals : integer;
                        var Done         : boolean;
                        var Slope1       : Float;
                        var Error        : byte);

{---------------------------------------------------------------}
{- Input: LowerLimit, UpperLimit, InitialSlope, NumReturn,     -}
{-        Spacing, Tolerance, MaxIter                          -}
{- Output: Iter, Values1, Values2, Spacing, Done,              -}
{-         Slope1, Slope2, Error                               -}
{-                                                             -}
{- This procedure initializes the above variables.  Values1    -}
{- and Values2 are initialized to NIL. NumIntervals is         -}
{- initialized to  (UpperLimit - LowerLimit)/Spacing.          -}
{- NumReturn, Tolerance, MaxIter and NumIntervals are          -}
{- checked for errors (they must be greater than zero).        -}
{---------------------------------------------------------------}

var
  Index : integer;
  Dummy : Ptr;

begin
  Error := 0;
  if NumReturn <= 0 then
    Error := 1;
  if NumIntervals < NumReturn then
    Error := 2;
  if ABS(LowerLimit - UpperLimit) < TNNearlyZero then
    Error := 3;
  if Tolerance < TNNearlyZero then
    Error := 4;
  if MaxIter < 1 then
    Error := 5;
  if Error = 0 then
  begin
    Iter := 0;
    New(HeapTop);
    { Create space on the heap  }
    Values := HeapTop;
    for Index := 0 to NumIntervals do
    begin
      New(Dummy);
      Values^.Next := Dummy;
      Values := Dummy;
    end;
    Values := HeapTop;
    Spacing := (UpperLimit - LowerLimit) / NumIntervals;
    Slope1 := InitialSlope;
    Done := false;
  end;
end; { procedure TestAndInitialize }

procedure RungeKuttaFour(NumIntervals : integer;
                         Spacing      : Float;
                         LowerLimit   : Float;
                         LowerInitial : Float;
                         Slope        : Float;
                         HeapTop      : Ptr;
                     var Values       : Ptr;
                     var UpperApprox  : Float;
                     var Error        : byte);

{--------------------------------------------------------------}
{- Input: NumIntervals, Spacing, LowerLimit, LowerLimit,      -}
{-        Slope, HeapTop                                      -}
{- Output: Values, UpperApprox, Error                         -}
{-                                                            -}
{- This procedure solves a possibly non-linear 2nd order      -}
{- ordinary differential equation with specified initial      -}
{- conditions.                                                -}
{- Given a possibly non-linear function of the form           -}
{-           Y" = TNTargetF(X, Y, Y')                         -}
{- and initial conditions                                     -}
{-           Y[LowerLimit] = LowerInitial                     -}
{-          Y'[LowerLimit] = Slope                            -}
{- the Runge-Kutta one step method for two variables (Y and   -}
{- Y') is used to solve for Y and Y' in the interval          -}
{- [LowerLimit, UpperLimit].  The algorithm uses              -}
{- sub-intervals of length Spacing. The approximation at      -}
{- UpperLimit is returned as UpperApprox.                     -}
{- If the solution to the initial value problem is unstable   -}
{- (i.e. blows up), then Error 7 is returned.                 -}
{--------------------------------------------------------------}

var
  Index : integer;
  HalfSpacing : Float;
  F1y, F2y, F3y, F4y, F1yPrime, F2yPrime, F3yPrime, F4yPrime : Float;
  X, Y, YPrime : Float;

procedure TestForInstability(LowerLimit   : Float;
                             LowerInitial : Float;
                             X            : Float;
                             Y            : Float;
                         var Error        : byte);

{------------------------------------------------------------}
{- Input: LowerLimit, LowerInitial, X, Y                    -}
{- Output: Error                                            -}
{-                                                          -}
{- This procedure determines if the solution to the initial -}
{- value problem is unstable (i.e. if it is blowing up).    -}
{- If the slope between the current point (X, Y) and the    -}
{- initial point (LowerLimit, LowerInitial) is greater than -}
{- 1E20, then the solution is assumed to be blowing up and  -}
{- Error 7 is returned.                                     -}
{------------------------------------------------------------}

begin
  if ABS((Y - LowerInitial) / (X - LowerLimit)) > 1E20 then
    Error := 7;   { Convergence not possible  }
end; { procedure TestForInstability }

begin { procedure RungeKuttaFour }
  { Clear the heap  }
  Values := HeapTop;
  X := LowerLimit;
  Y := LowerInitial;
  YPrime := Slope;
  Push(Values, X, Y, yPrime);
  HalfSpacing := Spacing / 2;
  Index := 0;
  while (Index < NumIntervals) and (Error = 0) do
  begin
    Index := Succ(Index);
    F1y := Spacing * YPrime;
    F1yPrime := Spacing * UserFunction2(X, Y, YPrime, FuncPtr);
    F2y := Spacing * (YPrime + 0.5 * F1yPrime);
    F2yPrime := Spacing * UserFunction2(X + HalfSpacing, Y + 0.5 * F1y,
                                    YPrime + 0.5 * F1yPrime, FuncPtr);
    F3y := Spacing * (YPrime + 0.5 * F2yPrime);
    F3yPrime := Spacing * UserFunction2(X + HalfSpacing, Y + 0.5 * F2y,
                                    YPrime + 0.5 * F2yPrime, FuncPtr);
    F4y := Spacing * (YPrime + F3yPrime);
    F4yPrime := Spacing * UserFunction2(X + Spacing, Y + F3y,
                                    YPrime + F3yPrime, FuncPtr);

    Y := Y + (F1y + 2*F2y + 2*F3y + F4y) / 6;
    YPrime := YPrime + (F1yPrime + 2 * F2yPrime + 2 * F3yPrime + F4yPrime) / 6;
    X := X + Spacing;
    Push(Values, X, Y, YPrime);
    TestForInstability(LowerLimit, LowerInitial, X, Y, Error);
  end;
  UpperApprox := Y;
end; { procedure RungeKuttaFour }

procedure ComputeNewSlope(UpperInitial : Float;
                          UpperApprox1 : Float;
                          UpperApprox2 : Float;
                          Slope1       : Float;
                          Slope2       : Float;
                      var NewSlope     : Float;
                      var Done         : boolean;
                      var Error        : byte);

{-------------------------------------------------------------}
{- Input: UpperInitial, UpperApprox1, UpperApprox2,          -}
{-        Slope1, Slope2                                     -}
{- Output: NewSlope, Done                                    -}
{-                                                           -}
{- This procedure uses the secant method and information     -}
{- from the last two iterations to interpolate a value       -}
{- for the slope at the left endpoint.                       -}
{-------------------------------------------------------------}

begin
  if ABS(UpperApprox2 - UpperApprox1) > TNNearlyZero then
    NewSlope := Slope2 - (UpperApprox2 - UpperInitial) *
               (Slope2 - Slope1)/(UpperApprox2 - UpperApprox1)
  else
    if ABS(UpperApprox1 - UpperInitial) < TNNearlyZero then
      Done := true
    else
      Error := 7     { Convergence not possible  }
end; { procedure ComputeNewSlope }

procedure GetValues(NumReturn    : integer;
                    NumIntervals : integer;
                var HeapTop      : Ptr;
                var Values       : Ptr;
                var XValues      : TNvector;
                var YValues      : TNvector;
                var YDerivValues : TNvector);

{-------------------------------------------------------------}
{- Input: NumReturn, NumIntervals, HeapTop, Values           -}
{- Output: XValues, YValues, YDerivValues                    -}
{-                                                           -}
{- This procedure fills in the arrays XValues, YValues and   -}
{- YDerivValues with data from the Values stack. For         -}
{- example, if there are five times as many items on the     -}
{- stack (NumIntervals) as should be returned (NumReturn)    -}
{- then every fifth value from the stack will be returned.   -}
{-------------------------------------------------------------}

var
  Index, Term : integer;
  X, Y, YPrime : Float;

begin
  Values := HeapTop;
  Term := 0;
  for Index := 0 to NumReturn do
  begin
    Pop(Values, X, Y, YPrime);
    Term := Succ(Term);
    while (Term / NumIntervals <= Index / NumReturn) and
          (Term <= NumIntervals) do
    begin
      Pop(Values, X, Y, YPrime);
      Term := Succ(Term);
    end;
    XValues[Index] := X;
    YValues[Index] := Y;
    YDerivValues[Index] := YPrime;
  end;
end; { procedure GetValues }

begin { procedure Shooting }
  TestAndInitialize(LowerLimit, UpperLimit,  InitialSlope,
                    NumReturn, Spacing, Tolerance, MaxIter,
                    HeapTop, Iter, Values, NumIntervals, Done,
                    Slope1, Error);
  if Error = 0 then
  begin
    Iter := Succ(Iter);
    RungeKuttaFour(NumIntervals, Spacing, LowerLimit, LowerInitial,
                   Slope1, HeapTop, Values, UpperApprox1, Error);
    Done := ABS(UpperApprox1 - UpperInitial) <
            ABS(UpperInitial * Tolerance);
    Slope2 := Slope1 +
              (UpperInitial - UpperApprox1) / (UpperLimit - LowerLimit);

    while (Iter < MaxIter) and not Done and (Error = 0) do
    begin
      Iter := Succ(Iter);
      RungeKuttaFour(NumIntervals, Spacing, LowerLimit, LowerInitial,
                     Slope2, HeapTop, Values, UpperApprox2, Error);
      Done := ABS(UpperApprox2 - UpperInitial) <
              ABS(UpperInitial * Tolerance);
      ComputeNewSlope(UpperInitial, UpperApprox1, UpperApprox2,
                      Slope1, Slope2, NewSlope, Done, Error);
      Slope1 := Slope2;
      Slope2 := NewSlope;
      UpperApprox1 := UpperApprox2;
    end;
    GetValues(NumReturn, NumIntervals, HeapTop, Values, XValues,
              YValues, YDerivValues);
    if Iter = MaxIter then
      Error := 6;
  end;
end; { procedure Shooting }

procedure LinearShooting{(LowerLimit  : Float;
                         UpperLimit   : Float;
                         LowerInitial : Float;
                         UpperInitial : Float;
                         NumReturn    : integer;
                         NumIntervals : integer;
                     var XValues      : TNvector;
                     var YValues      : TNvector;
                     var YDerivValues : TNvector;
                     var Error        : byte;
                         FuncPtr      : Pointer)};

type
  Ptr = ^Data;

  Data = record
           X, Y, YPrime : Float;
           Next : Ptr;
         end;

var
  Values1, Values2 : Ptr;             { Pointers to the stacks  }
  Spacing : Float;                     { Size of sub-intervals  }
  UpperApprox1, UpperApprox2 : Float;  { Approx to UpperInitial  }
  Slope1, Slope2 : Float;              { Initial slopes of    }
                                      { Iterative solutions  }

procedure InitializeStack(var Values : Ptr);
begin
  Values := nil;
end; { procedure InitializeStack }

procedure Push(var Values      : Ptr;
                   TValue      : Float;
                   XValue      : Float;
                   yPrimeValue : Float);

{----------------------------------}
{- Input: Values, TValue, XValue  -}
{-        yPrimeValue             -}
{- Output: Values                 -}
{-                                -}
{- Push data onto the Stack       -}
{----------------------------------}

var
  NewNode : Ptr;

begin
  New(NewNode);
  NewNode^.X := TValue;
  NewNode^.Y := XValue;
  NewNode^.YPrime := yPrimeValue;
  NewNode^.Next := Values;
  Values := NewNode;
end; { procedure Push }

procedure Pop(var Values      : Ptr;
              var TValue      : Float;
              var XValue      : Float;
              var yPrimeValue : Float);

{----------------------------------}
{- Input: Values, TValue, XValue  -}
{-        yPrimeValue             -}
{- Output: Values                 -}
{-                                -}
{- Pop Data from the Stack        -}
{----------------------------------}

var
  OldNode : Ptr;

begin
  OldNode := Values;
  Values := OldNode^.Next;
  TValue := OldNode^.X;
  XValue := OldNode^.Y;
  yPrimeValue := OldNode^.YPrime;
  Dispose(OldNode);
end; { procedure Pop }

procedure TestAndInitialize(LowerLimit   : Float;
                            UpperLimit   : Float;
                            NumReturn    : integer;
                        var Spacing      : Float;
                        var Values1      : Ptr;
                        var Values2      : Ptr;
                        var NumIntervals : integer;
                        var Slope1       : Float;
                        var Slope2       : Float;
                        var Error        : byte);

{-------------------------------------------------------------}
{- Input: LowerLimit, UpperLimit, NumReturn, Spacing         -}
{- Output: Values, Spacing, Done, Slope1, Slope2, Error      -}
{-                                                           -}
{- This procedure initializes the above variables.  Values1  -}
{- and Values2 are initialized to NIL. Spacing is            -}
{- initialized to (UpperLimit - LowerLimit)/NumIntervals.    -}
{- NumReturn and NumIntervals are checked for errors (they   -}
{- must be greater than zero).                               -}
{-------------------------------------------------------------}

begin
  Error := 0;
  if NumReturn <= 0 then
    Error := 1;
  if NumIntervals < NumReturn then
    Error := 2;
  if ABS(LowerLimit - UpperLimit) < TNNearlyZero then
    Error := 3;
  if Error = 0 then
  begin
    InitializeStack(Values1);
    InitializeStack(Values2);
    if NumIntervals < NumReturn then
      NumIntervals := NumReturn;
    { Adjust the Spacing so there are an integral  }
    { number of sub-intervals in the interval      }
    Spacing := (UpperLimit - LowerLimit) / NumIntervals;
    Slope1 := 1;
    Slope2 := 0;
  end;
end; { procedure TestAndInitialize }

procedure RungeKuttaFour(NumIntervals : integer;
                         Spacing      : Float;
                         LowerLimit   : Float;
                         LowerInitial : Float;
                         Slope        : Float;
                     var Values       : Ptr;
                     var UpperApprox  : Float);

{--------------------------------------------------------------}
{- Input: NumIntervals, Spacing, LowerLimit, LowerLimit,      -}
{-        Slope                                               -}
{- Output: Values, UpperApprox                                -}
{-                                                            -}
{- This procedure solves a possibly non-linear 2nd order      -}
{- ordinary differential equation with specified initial      -}
{- conditions.                                                -}
{- Given a possibly non-linear function of the form           -}
{-           Y" = TNTargetF(X, Y, Y')                         -}
{- and initial conditions                                     -}
{-           Y[LowerLimit] = LowerInitial                     -}
{-          Y'[LowerLimit] = Slope                            -}
{- the Runge-Kutta one step method for two variables (Y and   -}
{- Y') is used to solve for Y and Y' in the interval          -}
{- [LowerLimit, UpperLimit].  The algorithm uses              -}
{- sub-intervals of length Spacing. The approximation at      -}
{- UpperLimit is returned as UpperApprox.                     -}
{--------------------------------------------------------------}

var
  Index : integer;
  HalfSpacing : Float;
  F1y, F2y, F3y, F4y, F1yPrime, F2yPrime, F3yPrime, F4yPrime : Float;
  X, Y, YPrime : Float;

begin
  X := LowerLimit;
  Y := LowerInitial;
  YPrime := Slope;
  Push(Values, X, Y, YPrime);
  HalfSpacing := Spacing/2;
  for Index := 1 to NumIntervals do
  begin
    F1y := Spacing * YPrime;
    F1yPrime := Spacing * UserFunction2(X, Y, YPrime, FuncPtr);
    F2y := Spacing * (YPrime + 0.5 * F1yPrime);
    F2yPrime := Spacing * UserFunction2(X + HalfSpacing, Y + 0.5 * F1y,
                YPrime + 0.5 * F1yPrime, FuncPtr);
    F3y := Spacing * (YPrime + 0.5 * F2yPrime);
    F3yPrime := Spacing * UserFunction2(X + HalfSpacing, Y + 0.5 * F2y,
                YPrime + 0.5 * F2yPrime, FuncPtr);
    F4y := Spacing * (YPrime + F3yPrime);
    F4yPrime := Spacing * UserFunction2(X + Spacing, Y + F3y,
                YPrime + F3yPrime, FuncPtr);

    Y := Y + (F1y + 2 * F2y + 2 * F3y + F4y) / 6;
    YPrime := YPrime + (F1yPrime + 2 * F2yPrime + 2 * F3yPrime + F4yPrime) / 6;
    X := X + Spacing;
    Push(Values, X, Y, YPrime);
  end;
  UpperApprox := Y;
end; { procedure RungeKuttaFour }

procedure ComputeActualAnswer(NumIntervals : integer;
                              NumReturn    : integer;
                              UpperInitial : Float;
                              UpperApprox1 : Float;
                              UpperApprox2 : Float;
                          var Values1      : Ptr;
                          var Values2      : Ptr;
                          var XValues      : TNvector;
                          var YValues      : TNvector;
                          var YDerivValues : TNvector;
                          var Error        : byte);

{-------------------------------------------------------------------------}
{- Input: NumIntervals, NumReturn, UpperInitial, UpperApprox1,           -}
{-        UpperApprox2, Values1, Values2                                 -}
{- Output: XValues, YValues, YDerivValues, Error                         -}
{-                                                                       -}
{- This procedure fills in the arrays XValues, YValues and               -}
{- YDerivValues with data from the Values stack. For                     -}
{- example, if there are five times as many items on the                 -}
{- stack (NumIntervals) as should be returned (NumReturn)                -}
{- then every fifth value from the stack will be returned.               -}
{-                                                                       -}
{- A linear combination of the solutions (Values1 and Values2)           -}
{- to the two initial value problems will give the solution              -}
{- to the boundary value problem.  This procedure uses the               -}
{- equations:                                                            -}
{-                                                                       -}
{-   Multiplier1 - LowerInitial +                                        -}
{-               Multiplier2 - LowerInitial = LowerInitial               -}
{-                                                                       -}
{-   Multiplier1 - UpperApprox1 +                                        -}
{-               Multiplier2 - UpperApprox2 = UpperInitial               -}
{-                                                                       -}
{- to compute the Multipliers.  These multipliers are used to            -}
{- form the linear combination of the two solutions:                     -}
{-   YValues := Multiplier1 - Values1.Y +                                -}
{-              Multiplier2 - Values2.Y                                  -}
{-   YDerivValues := Multiplier1 - Values1.YPrime +                      -}
{-                   Mulitplier2 - Values2.YPrime                        -}
{-------------------------------------------------------------------------}

var
  Index, Term : integer;
  Multiplier1, Multiplier2 : Float;
  X, Y1, yPrime1, Y2, yPrime2 : Float;

begin
  if ABS(UpperApprox2 - UpperApprox1) > TNNearlyZero then
    begin
      Multiplier2 := (UpperInitial - UpperApprox1) /
                     (UpperApprox2- UpperApprox1);
      Multiplier1 := 1 - Multiplier2;

      Term := NumIntervals;
      for Index := NumReturn downto 0 do
      begin
        Pop(Values1, X, Y1, yPrime1);
        Pop(Values2, X, Y2, yPrime2);
        Term := Pred(Term);
        while (Term / NumIntervals >= Index / NumReturn) and (Term >= 0) do
        begin
          Pop(Values1, X, Y1, yPrime1);
          Pop(Values2, X, Y2, yPrime2);
          Term := Pred(Term);
        end;
        XValues[Index] := X;
        YValues[Index] := Y1 * Multiplier1 + Y2 * Multiplier2;
        YDerivValues[Index] := yPrime1 * Multiplier1 + yPrime2 * Multiplier2;
      end;
    end
  else
    Error := 4;   { Differential equation not linear  }
end;  { procedure ComputeActualAnswer }

begin  { procedure LinearShooting }
  TestAndInitialize(LowerLimit, UpperLimit, NumReturn, Spacing, Values1,
                    Values2, NumIntervals, Slope1, Slope2, Error);
  if Error = 0 then
  begin
    RungeKuttaFour(NumIntervals, Spacing, LowerLimit, LowerInitial,
                   Slope1, Values1, UpperApprox1);
    RungeKuttaFour(NumIntervals, Spacing, LowerLimit, LowerInitial,
                   Slope2, Values2, UpperApprox2);
    ComputeActualAnswer(NumIntervals, NumReturn,
                        UpperInitial, UpperApprox1, UpperApprox2, Values1,
                        Values2, XValues, YValues, YDerivValues, Error);
  end;
end; { procedure LinearShooting }
