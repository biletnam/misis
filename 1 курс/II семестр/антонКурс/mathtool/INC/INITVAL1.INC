{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{----------------------------------------------------------------------------}

procedure InitialCond1stOrder{(LowerLimit   : Float;
                              UpperLimit    : Float;
                              XInitial      : Float;
                              NumReturn     : integer;
                              NumIntervals  : integer;
                          var TValues       : TNvector;
                          var XValues       : TNvector;
                          var Error         : byte;
                              FuncPtr       : Pointer)};

type
  Ptr = ^Data;

  Data = record
           T, X : Float;
           Next : Ptr;
         end;

  Stack = Ptr;

var
  Values : Stack;
  Spacing, HalfSpacing : Float;        { Size of each subinterval  }
  T, X, F1, F2, F3, F4 : Float;        { Step values  }
  Index : integer;                    { A counter  }

procedure InitializeStack(var Values : Stack);
begin
  Values := nil;
end; { procedure InitializeStack }

procedure Push(var Values : Stack;
                   TValue : Float;
                   XValue : Float);

{----------------------------------}
{- Input: Values, TValue, XValue  -}
{- Output: Values                 -}
{-                                -}
{- Push data onto the Stack       -}
{----------------------------------}

var
  NewNode : Ptr;

begin
  New(NewNode);
  NewNode^.T := TValue;
  NewNode^.X := XValue;
  NewNode^.Next := Values;
  Values := NewNode;
end; { procedure Push }

procedure Pop(var Values : Stack;
              var TValue : Float;
              var XValue : Float);

{----------------------------------}
{- Input: Values, TValue, XValue  -}
{- Output: Values                 -}
{-                                -}
{- Pop Data from the Stack        -}
{----------------------------------}

var
  OldNode : Ptr;

begin
  OldNode := Values;
  Values := OldNode^.Next;
  TValue := OldNode^.T;
  XValue := OldNode^.X;
  Dispose(OldNode);
end; { procedure Pop }

procedure TestAndInitialize(LowerLimit   : Float;
                            UpperLimit   : Float;
                            XInitial     : Float;
                        var NumIntervals : integer;
                        var NumReturn    : integer;
                        var Values       : Stack;
                        var Spacing      : Float;
                        var HalfSpacing  : Float;
                        var T            : Float;
                        var X            : Float;
                        var Error        : byte);

{---------------------------------------------------------------}
{- Input: LowerLimit, UpperLimit, XInitial, NumIntervals,      -}
{-        NumReturn                                            -}
{- Output: Values, Spacing, HalfSpacing, T, X, Error           -}
{-                                                             -}
{- This procedure initializes the above variables.  Values is  -}
{- initialized to NIL;  Spacing is initialized to              -}
{- (UpperLimit - LowerLimit)/NumIntervals, HalfSpacing is half -}
{- this; T is initialized to LowerLimit; X is initialized to   -}
{- XInitial.  Also NumIntervals and NumReturn are checked for  -}
{- errors (it must be greater than zero).                      -}
{---------------------------------------------------------------}

begin
  Error := 0;
  if NumReturn < 1 then
    Error := 1;
  if NumIntervals < NumReturn then
    Error := 2;
  if LowerLimit = UpperLimit then
    Error := 3;
  if Error = 0 then
  begin
    InitializeStack(Values);
    Spacing := (UpperLimit - LowerLimit) / NumIntervals;
    HalfSpacing := Spacing / 2;
    T := LowerLimit;
    X := XInitial;
    Push(Values, T, X);
  end;
end; { procedure TestAndInitialize }

procedure GetValues(NumReturn    : integer;
                    NumIntervals : integer;
                var Values       : Stack;
                var TValues      : TNvector;
                var XValues      : TNvector);

{-------------------------------------------------------------}
{- Input: NumReturn, NumIntervals, Values                    -}
{- Output: TValues, XValues                                  -}
{-                                                           -}
{- This procedure fills in the arrays TValues and XValues    -}
{- with data from the Values stack. For example, if there    -}
{- are five times as many items on the stack (NumIntervals)  -}
{- as should be returned (NumReturn) then every fifth value  -}
{- from the stack will be returned.                          -}
{-------------------------------------------------------------}

var
  Index, Term : integer;
  T, X : Float;

begin
  Term := NumIntervals;
  for Index := NumReturn downto 0 do
  begin
    Pop(Values, T, X);
    Term := Pred(Term);
    while (Term / NumIntervals >= Index / NumReturn) and (Term >= 0) do
    begin
      Pop(Values, T, X);
      Term := Pred(Term);
    end;
    TValues[Index] := T;
    XValues[Index] := X;
  end;
end; { procedure GetValues }

begin  { procedure InitialCond1stOrder }
  TestAndInitialize(LowerLimit, UpperLimit, XInitial, NumIntervals,
                    NumReturn, Values, Spacing, HalfSpacing, T, X, Error);
  if Error = 0 then
  begin
    for Index := 1 to NumIntervals do
    begin
      F1 := Spacing * UserFunction1(T, X, FuncPtr);
      F2 := Spacing * UserFunction1(T + HalfSpacing, X + F1 / 2, FuncPtr);
      F3 := Spacing * UserFunction1(T + HalfSpacing, X + F2 / 2, FuncPtr);
      F4 := Spacing * UserFunction1(T + Spacing, X + F3, FuncPtr);
      X := X + (F1 + 2 * F2 + 2 * F3 + F4) / 6;
      T := T + Spacing;
      Push(Values, T, X);
    end;
    GetValues(NumReturn, NumIntervals, Values, TValues, XValues);
  end;
end; { procedure InitialCond1stOrder }

procedure RungeKuttaFehlberg{(LowerLimit : Float;
                              UpperLimit : Float;
                              XInitial   : Float;
                              Tolerance  : Float;
                              NumReturn  : integer;
                          var TValues    : TNvector;
                          var XValues    : TNvector;
                          var Error      : byte;
                              FuncPtr    : Pointer)};

type
  Ptr = ^Data;

  Data = record
           T, X : Float;
           Next : Ptr;
         end;

  Stack = Ptr;

var
  NumValues : integer;        { Number of values on the stack  }
  Values : Stack;             { Pointer to stack of all computed values  }
  MaxSpacing : Float;          { Maximum size of each subinterval  }
  Spacing : Float;             { Size of each subinterval  }
  T, X, TempX : Float;         { Step values  }
  Difference : Float;          { Fractional difference between steps  }

procedure InitializeStack(var Values : Stack);
begin
  Values := nil;
end; { procedure InitializeStack }

procedure Push(var Values : Stack;
                   TValue : Float;
                   XValue : Float);

{----------------------------------}
{- Input: Values, TValue, XValues -}
{- Output: Values                 -}
{-                                -}
{- Push data onto the Stack       -}
{----------------------------------}

var
  NewNode : Ptr;

begin
  New(NewNode);
  NewNode^.T := TValue;
  NewNode^.X := XValue;
  NewNode^.Next := Values;
  Values := NewNode;
end; { procedure Push }

procedure Pop(var Values : Stack;
              var TValue : Float;
              var XValue : Float);

{----------------------------------}
{- Input: Values, TValue, XValues -}
{- Output: Values                 -}
{-                                -}
{- Pop Data from the Stack        -}
{----------------------------------}

var
  OldNode : Ptr;

begin
  OldNode := Values;
  Values := OldNode^.Next;
  TValue := OldNode^.T;
  XValue := OldNode^.X;
  Dispose(OldNode);
end; { procedure Pop }


procedure TestAndInitialize(LowerLimit : Float;
                            UpperLimit : Float;
                            XInitial   : Float;
                            Tolerance  : Float;
                            NumReturn  : integer;
                        var NumValues  : integer;
                        var TValues    : TNvector;
                        var XValues    : TNvector;
                        var Values     : Stack;
                        var MaxSpacing : Float;
                        var Spacing    : Float;
                        var T          : Float;
                        var X          : Float;
                        var TempX      : Float;
                        var Error      : byte);

{------------------------------------------------------------------------}
{- Input: LowerLimit, UpperLimit, XInitial, Tolerance, NumReturn        -}
{- Output: NumValues, TValues, XValues, Values, MaxSpacing, Spacing,    -}
{-         T, X, TempX, Error                                           -}
{-                                                                      -}
{- This procedure initializes the above variables.  NumValues, TValues, -}
{- XValues and are initialized to zero, Values is initialized to NIL,   -}
{- X and TempX are initialized to XInitial, T is initialized to         -}
{- LowerLimit; MaxSpacing and  Spacing are initialized to               -}
{- (LowerLimit - UpperLimit)/NumReturn.  Also, Tolerance and NumReturn  -}
{- check for errors (they must be greater than TNNearlyZero).           -}
{------------------------------------------------------------------------}

begin
  Error := 0;
  if Tolerance <= TNNearlyZero then
    Error := 1;      { Tolerance less than zero }
  if NumReturn < 1 then
    Error := 2;      { NumReturn less than one  }
  if LowerLimit = UpperLimit then
    Error := 3;      { End points are identical  }
  NumValues := 0;
  FillChar(XValues, SizeOf(XValues), 0);
  TValues[0] := LowerLimit;
  XValues[0] := XInitial;
  InitializeStack(Values);
  T := LowerLimit;
  X := XInitial;
  TempX := XInitial;
  if Error = 0 then
  begin
    MaxSpacing := (UpperLimit - LowerLimit) / NumReturn;
    Spacing := MaxSpacing;
  end;
end; { procedure TestAndInitialize }

procedure RungeKuttaSix(Spacing    : Float;
                        T          : Float;
                    var X          : Float;
                    var Difference : Float);

{-------------------------------------------------------------------}
{- Input: Spacing, T                                               -}
{- Output: X, Difference                                           -}
{-                                                                 -}
{- This procedure applies the six-stage, fifth-order Runge-Kutta   -}
{- formula and the four-stage, fourth-order Runge-Kutta formula to -}
{- approximate the value of X at T + Spacing given the value of X  -}
{- at T.  The difference between the fourth order and fifth order  -}
{- formulas is returned as Difference.                             -}
{-------------------------------------------------------------------}

var
  F1, F2, F3, F4, F5, F6 : Float;
  DummyT, DummyX : Float;

begin
  F1 := Spacing * UserFunction1(T, X, FuncPtr);
  DummyT := T + Spacing / 4;
  DummyX := X + F1 / 4;
  F2 := Spacing * UserFunction1(DummyT, DummyX, FuncPtr);
  DummyT := T + 3 * Spacing / 8;
  DummyX := X + (3 * F1 + 9 * F2) / 32;
  F3 := Spacing * UserFunction1(DummyT, DummyX, FuncPtr);
  DummyT := T + 12 * Spacing / 13;
  DummyX := X + (1932 * F1 - 7200 * F2 + 7296 * F3) / 2197;
  F4 := Spacing * UserFunction1(DummyT, DummyX, FuncPtr);
  DummyT := T + Spacing;
  DummyX := X + (8341 * F1 - 32832.0 * F2 + 29440 * F3 - 845 * F4) / 4104;
  F5 := Spacing * UserFunction1(DummyT, DummyX, FuncPtr);
  DummyT := T + Spacing / 2;
  DummyX := X + (-6080 * F1 + 41040.0 * F2 - 28352 * F3 +
                  9295 * F4 - 5643 * F5) / 20520;
  F6 := Spacing * UserFunction1(DummyT, DummyX, FuncPtr);
  X := X + (2375 * F1 + 11264 * F3 + 10985 * F4 - 4104 * F5) / 20520;
  Difference := ABS(3135.0 * F1 - 33792.0 * F3 - 32955.0 * F4 +
                22572.0 * F5 + 41040.0 * F6) / 1128600.0;
end; { procedure RungeKuttaSix }

procedure CalculateNewSpacing(Tolerance  : Float;
                              Difference : Float;
                              MaxSpacing : Float;
                          var Spacing    : Float);

{----------------------------------------------------------------}
{- Input: Tolerance, Difference, MaxSpacing                     -}
{- Output: Spacing                                              -}
{-                                                              -}
{- If the Difference between to two Runge-Kutta evaluations     -}
{- is larger or smaller than the Tolerance then reduce or       -}
{- increase the size of the Spacing appropriately.  However,    -}
{- the Spacing should not be reduced smaller than 0.1 - Spacing -}
{- nor should it be increased larger than MaxSpacing.           -}
{----------------------------------------------------------------}

var
  DeltaDif : Float;

begin
  if ABS(Difference) > TNNearlyZero then
  begin
    DeltaDif := Sqrt(Sqrt(ABS(Spacing * Tolerance/(2 * Difference))));
    if DeltaDif < 0.1 then
      Spacing := 0.1 * Spacing
    else
      begin
        Spacing := DeltaDif * Spacing;
        if ABS(Spacing) > ABS(MaxSpacing) then
          Spacing := MaxSpacing;
      end
  end;
end; { procedure CalculateNewSpacing }

procedure GetValues(NumReturn : integer;
                var NumValues : integer;
                var Values    : Stack;
                var TValues   : TNvector;
                var XValues   : TNvector);

{-------------------------------------------------------------}
{- Input: NumReturn, NumValues                               -}
{- Output: NumValues, Values, TValues, XValues               -}
{-                                                           -}
{- This procedure fills in the arrays TValues and XValues    -}
{- with data from the Values stack. If NumReturn (the        -}
{- number of values to be returned) is less than             -}
{- NumValues (the number of items on the stack) then only    -}
{- some of the values on the stack will be returned.  For    -}
{- example, if there are five times as many items on the     -}
{- stack (NumValues) as should be returned (NumReturn) then  -}
{- every fifth value from the stack will be returned.        -}
{-------------------------------------------------------------}

var
  Index, Term : integer;
  TVal, XVal : Float;

begin
  if NumValues > NumReturn then
    begin
      Term := NumValues;
      for Index := NumReturn downto 1 do
      begin
        Pop(Values, TVal, XVal);
        Term := Pred(Term);
        while Term/NumValues > Index/NumReturn do
        begin
          Pop(Values, TVal, XVal);
          Term := Pred(Term);
        end;
        TValues[Index] := TVal;
        XValues[Index] := XVal;
      end;
    end
  else
    for Index := NumValues downto 1 do
      Pop(Values, TValues[Index], XValues[Index]);
end; { procedure GetValues }

begin { procedure RungeKuttaFehlberg }
  TestAndInitialize(LowerLimit, UpperLimit, XInitial, Tolerance, NumReturn,
                    NumValues, TValues, XValues, Values,
                    MaxSpacing, Spacing, T, X, TempX, Error);
  if Error = 0 then
  begin
    while (ABS((T - LowerLimit)) < ABS((UpperLimit - LowerLimit))) and
          (ABS(Spacing) > TNNearlyZero) do
    begin
      RungeKuttaSix(Spacing, T, TempX, Difference);
      if Difference > ABS(Tolerance * Spacing) then
        TempX := X
      else
        begin
          T := T + Spacing;
          X := TempX;
          Push(Values, T, X);
          NumValues := Succ(NumValues);
        end;
      CalculateNewSpacing(Tolerance, Difference, MaxSpacing, Spacing);
    end; { while }

    if (ABS(Spacing) <= TNNearlyZero) and (T < UpperLimit) then
      Error := 4;     { Tolerance not reached  }
    GetValues(NumReturn, NumValues, Values, TValues, XValues);
  end;
end; { procedure RungeKuttaFehlberg }

procedure Adams{(LowerLimit  : Float;
                UpperLimit   : Float;
                XInitial     : Float;
                NumReturn    : integer;
                NumIntervals : integer;
            var TValues      : TNvector;
            var XValues      : TNvector;
            var Error        : byte;
                FuncPtr      : Pointer)};

type
  TNFourVector = array[1..4] of Float;

  Ptr = ^Data;

  Data = record
           T, X : Float;
           Next : Ptr;
         end;

  Stack = Ptr;

var
  Values : Stack;
  Spacing : Float;                 { Size of each subinterval }
  T : Float;                       { Value of T }
  X, NewX : Float;                 { Iteration variables }
  Index : integer;                { A counter }
  DerivValues : TNFourVector;     { Derivative at last 4 X values }

procedure InitializeStack(var Values : Stack);
begin
  Values := nil;
end; { procedure InitializeStack }

procedure Push(var Values : Stack;
                   TValue : Float;
                   XValue : Float);

{----------------------------------}
{- Input: Values, TValue, XValue  -}
{- Output: Values                 -}
{-                                -}
{- Push data onto the Stack       -}
{----------------------------------}

var
  NewNode : Ptr;

begin
  New(NewNode);
  NewNode^.T := TValue;
  NewNode^.X := XValue;
  NewNode^.Next := Values;
  Values := NewNode;
end; { procedure Push }

procedure Pop(var Values : Stack;
              var TValue : Float;
              var XValue : Float);

{----------------------------------}
{- Input: Values, TValue, XValue  -}
{- Output: Values                 -}
{-                                -}
{- Pop Data from the Stack        -}
{----------------------------------}

var
  OldNode : Ptr;

begin
  OldNode := Values;
  Values := OldNode^.Next;
  TValue := OldNode^.T;
  XValue := OldNode^.X;
  Dispose(OldNode);
end; { procedure Pop }

procedure TestAndInitialize(LowerLimit   : Float;
                            UpperLimit   : Float;
                            XInitial     : Float;
                        var NumIntervals : integer;
                            NumReturn    : integer;
                        var Values       : Stack;
                        var DerivValues  : TNFourVector;
                        var Spacing      : Float;
                        var T            : Float;
                        var X            : Float;
                        var Error        : byte);

{--------------------------------------------------------------------}
{- Input: LowerLimit, UpperLimit, XInitial, NumIntervals            -}
{-        NumReturn                                                 -}
{- Output: Values, DerivValues, Spacing, T, X, Error                -}
{-                                                                  -}
{- This procedure initializes the above variables. Values is set to -}
{- Nil; DerivValues is initialized to zero;  Spacing is initialized -}
{- to (UpperLimit - LowerLimit)/NumIntervals; T is initialized to   -}
{- LowerLimit; NumIntervals and NumReturn are checked for errors    -}
{- (it must be greater than zero).                                  -}
{--------------------------------------------------------------------}

begin
  Error := 0;
  if NumReturn <= 0 then
    Error := 1;
  if NumIntervals < NumReturn then
    Error := 2;
  if LowerLimit = UpperLimit then
    Error := 3;
  if Error = 0 then
  begin
    InitializeStack(Values);
    FillChar(DerivValues, SizeOf(DerivValues), 0);
    DerivValues[1] := UserFunction1(LowerLimit, XInitial, FuncPtr);
    Spacing := (UpperLimit - LowerLimit) / NumIntervals;
    T := LowerLimit;
    X := XInitial;
    Push(Values, T, X);
  end;
end; { procedure TestAndInitialize }

procedure GetFirstThreeValues(Spacing     : Float;
                          var T           : Float;
                          var X           : Float;
                          var Values      : Stack;
                          var DerivValues : TNFourVector);

{---------------------------------------------------------------}
{- Input: Spacing, T, X, Values, DerivValues                   -}
{- Output: T, X, Values, DerivValues                           -}
{-                                                             -}
{- This procedure uses the Runge-Kutta one step method to      -}
{- solve for the first three (T + i-Spacing, 1<=i<=3) Values.  -}
{- The derivative at these points are also calculated          -}
{- (DerivValues).                                              -}
{---------------------------------------------------------------}

var
  Index : integer;
  HalfSpacing : Float;
  F1, F2, F3, F4 : Float;

begin
  HalfSpacing := Spacing / 2;
  for Index := 1 to 3 do
  begin
    F1 := Spacing * UserFunction1(T, X, FuncPtr);
    F2 := Spacing * UserFunction1(T + HalfSpacing, X + F1 / 2, FuncPtr);
    F3 := Spacing * UserFunction1(T + HalfSpacing, X + F2 / 2, FuncPtr);
    F4 := Spacing * UserFunction1(T + Spacing, X + F3, FuncPtr);
    X := X + (F1 + 2 * F2 + 2 * F3 + F4) / 6;
    T := T + Spacing;
    Push(Values, T, X);
    DerivValues[Index + 1] := UserFunction1(T, X, FuncPtr);
  end;
end; { procedure GetFirstThreeValues }

procedure GetValues(NumReturn    : integer;
                    NumIntervals : integer;
                var Values       : Stack;
                var TValues      : TNvector;
                var XValues      : TNvector);

{-------------------------------------------------------------}
{- Input: NumReturn, NumIntervals, Values                    -}
{- Output: TValues, XValues                                  -}
{-                                                           -}
{- This procedure fills in the arrays TValues and XValues    -}
{- with data from the Values stack. For example, if there    -}
{- are five times as many items on the stack (NumIntervals)  -}
{- as should be returned (NumReturn) then every fifth value  -}
{- from the stack will be returned.                          -}
{-------------------------------------------------------------}

var
  Index, Term : integer;
  T, X : Float;

begin
  Term := NumIntervals;
  for Index := NumReturn downto 0 do
  begin
    Pop(Values, T, X);
    Term := Pred(Term);
    while (Term / NumIntervals >= Index/NumReturn) and (Term >= 0) do
    begin
      Pop(Values, T, X);
      Term := Pred(Term);
    end;
    TValues[Index] := T;
    XValues[Index] := X;
  end;
end; { procedure GetValues }

begin { procedure Adams }
  TestAndInitialize(LowerLimit, UpperLimit, XInitial, NumIntervals,
                    NumReturn, Values, DerivValues, Spacing, T, X, Error);
  if Error = 0 then
  begin
    GetFirstThreeValues(Spacing, T, X, Values, DerivValues);
    for Index := 4 to NumIntervals do
    begin
      { Apply predictor }
      NewX := X + Spacing / 24 * (55 * DerivValues[4] - 59 * DerivValues[3] +
                  37 * DerivValues[2] - 9 * DerivValues[1]);

      T := T + Spacing;
      DerivValues[1] := DerivValues[2];
      DerivValues[2] := DerivValues[3];
      DerivValues[3] := DerivValues[4];
      DerivValues[4] := UserFunction1(T, NewX, FuncPtr);

      { Apply corrector }
      NewX := X + Spacing / 24 * (9 * DerivValues[4] + 19 * DerivValues[3] -
              5 * DerivValues[2] + DerivValues[1]);
      X := NewX;
      Push(Values, T, X);
    end;

    GetValues(NumReturn, NumIntervals, Values, TValues, XValues);
  end;
end; { procedure Adams }

procedure InitialCond2ndOrder{(LowerLimit  : Float;
                              UpperLimit   : Float;
                              InitialValue : Float;
                              InitialDeriv : Float;
                              NumReturn    : integer;
                              NumIntervals : integer;
                          var TValues      : TNvector;
                          var XValues      : TNvector;
                          var XDerivValues : TNvector;
                          var Error        : byte;
                              FuncPtr      : Pointer)};

type
  Ptr = ^Data;

  Data = record
           T, X, xPrime : Float;
           Next : Ptr;
         end;

var
  Values : Ptr;                          { Pointer to the stack  }
  Spacing, HalfSpacing : Float;           { Size of each subinterval  }
  Index : integer;
  F1x, F2x, F3x, F4x,
  F1xPrime, F2xPrime,
  F3xPrime, F4xPrime : Float;             { Iteration variables  }
  T, X, xPrime : Float;                   { Values pushed and pulled  }
                                         { from the stack.           }


procedure InitializeStack(var Values : Ptr);
begin
  Values := nil;
end; { procedure InitializeStack }

procedure Push(var Values      : Ptr;
                   TValue      : Float;
                   XValue      : Float;
                   XPrimeValue : Float);

{----------------------------------}
{- Input: Values, TValue, XValue  -}
{-        XPrimeValue             -}
{- Output: Values                 -}
{-                                -}
{- Push data onto the Stack       -}
{----------------------------------}

var
  NewNode : Ptr;

begin
  New(NewNode);
  NewNode^.T := TValue;
  NewNode^.X := XValue;
  NewNode^.XPrime := XPrimeValue;
  NewNode^.Next := Values;
  Values := NewNode;
end; { procedure Push }

procedure Pop(var Values      : Ptr;
              var TValue      : Float;
              var XValue      : Float;
              var XPrimeValue : Float);

{----------------------------------}
{- Input: Values, TValue, XValue  -}
{-        XPrimeValue             -}
{- Output: Values                 -}
{-                                -}
{- Pop Data from the Stack        -}
{----------------------------------}

var
  OldNode : Ptr;

begin
  OldNode := Values;
  Values := OldNode^.Next;
  TValue := OldNode^.T;
  XValue := OldNode^.X;
  XPrimeValue := OldNode^.xPrime;
  Dispose(OldNode);
end; { procedure Pop }

procedure TestAndInitialize(LowerLimit   : Float;
                            UpperLimit   : Float;
                        var NumIntervals : integer;
                            NumReturn    : integer;
                        var Values       : Ptr;
                        var Spacing      : Float;
                        var Error        : byte);

{---------------------------------------------------------------}
{- Input: LowerLimit, UpperLimit, NumIntervals, NumReturn      -}
{- Output: Values, Spacing, Error                              -}
{-                                                             -}
{- This procedure initializes the above variables.  Values     -}
{- is initialized to NIL. Spacing is initialized to            -}
{-        (UpperLimit - LowerLimit)/NumIntervals.              -}
{- NumIntervals and NumReturn are checked for errors (they     -}
{- must be greater than zero).                                 -}
{---------------------------------------------------------------}

begin
  Error := 0;
  if NumReturn <= 0 then
    Error := 1;
  if NumIntervals < NumReturn then
    Error := 2;
  if LowerLimit = UpperLimit then
    Error := 3;
  if Error = 0 then
  begin
    InitializeStack(Values);
    Spacing := (UpperLimit - LowerLimit)/NumIntervals;
  end;
end; { procedure TestAndInitialize }

procedure GetValues(NumReturn    : integer;
                    NumIntervals : integer;
                var Values       : Ptr;
                var TValues      : TNvector;
                var XValues      : TNvector;
                var XDerivValues : TNvector);

{-------------------------------------------------------------}
{- Input: NumReturn, NumIntervals, Values                    -}
{- Output: TValues, XValues, XDerivValues                    -}
{-                                                           -}
{- This procedure fills in the arrays TValues, XValues and   -}
{- XDeriValues with data from the Values stack. For example, -}
{- if there are five times as many items on the stack        -}
{- (NumIntervals) as should be returned (NumReturn) then     -}
{- every fifth value from the stack will be returned.        -}
{-------------------------------------------------------------}

var
  Index, Term : integer;
  T, X, xPrime : Float;

begin
  Term := NumIntervals;
  for Index := NumReturn downto 0 do
  begin
    Pop(Values, T, X, xPrime);
    Term := Pred(Term);
    while (Term / NumIntervals >= Index / NumReturn) and (Term >= 0) do
    begin
      Pop(Values, T, X, xPrime);
      Term := Pred(Term);
    end;
    TValues[Index] := T;
    XValues[Index] := X;
    XDerivValues[Index] := xPrime;
  end;
end; { procedure GetValues }

begin  { procedure InitialCond2ndOrder }
  TestAndInitialize(LowerLimit, UpperLimit,
                    NumIntervals, NumReturn, Values, Spacing, Error);
  if Error = 0 then
  begin
    T := LowerLimit;
    X := InitialValue;
    xPrime := InitialDeriv;
    Push(Values, T, X, xPrime);
    HalfSpacing := Spacing / 2;
    for Index := 1 to NumIntervals do
    begin
      F1x := Spacing * xPrime;
      F1xPrime := Spacing * UserFunction2(T, X, xPrime, FuncPtr);
      F2x := Spacing * (xPrime + 0.5 * F1xPrime);
      F2xPrime := Spacing * UserFunction2(T + HalfSpacing, X + 0.5 * F1x,
                  xPrime + 0.5 * F1xPrime, FuncPtr);
      F3x := Spacing * (xPrime + 0.5 * F2xPrime);
      F3xPrime := Spacing * UserFunction2(T + HalfSpacing, X + 0.5 * F2x,
                  xPrime + 0.5 * F2xPrime, FuncPtr);
      F4x := Spacing * (xPrime + F3xPrime);
      F4xPrime := Spacing * UserFunction2(T + Spacing, X + F3x, xPrime +
                                          F3xPrime, FuncPtr);
      X := X + (F1x + 2 * F2x + 2 * F3x + F4x) / 6;
      xPrime := xPrime + (F1xPrime + 2 * F2xPrime + 2 * F3xPrime + F4xPrime) / 6;
      T := T + Spacing;
      Push(Values, T, X, xPrime);
    end;
    GetValues(NumReturn, NumIntervals, Values, TValues, XValues, XDerivValues);
  end;
end; { procedure InitialCond2ndOrder }

procedure InitialCondition{(Order         : integer;
                           LowerLimit     : Float;
                           UpperLimit     : Float;
                           InitialValues  : TNvector;
                           NumReturn      : integer;
                           NumIntervals   : integer;
                       var SolutionValues : TNmatrix;
                       var Error          : byte;
                           FuncPtr        : Pointer)};

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

procedure TestAndInitialize(Order        : integer;
                            LowerLimit   : Float;
                            UpperLimit   : Float;
                        var NumIntervals : integer;
                            NumReturn    : integer;
                        var ValuesStack  : Ptr;
                        var Spacing      : Float;
                        var Error        : byte);

{-----------------------------------------------------------------}
{- Input: Order, LowerLimit, UpperLimit, NumIntervals, NumReturn -}
{- Output: ValuesStack, Spacing, Error                           -}
{-                                                               -}
{- This procedure initializes the above variables. ValuesStack   -}
{- is initialized to NIL. Spacing is initialized to              -}
{-        (UpperLimit - LowerLimit)/NumIntervals.                -}
{- Order, NumIntervals, and NumReturn are checked for errors;    -}
{- they must be greater than zero.                               -}
{-----------------------------------------------------------------}

begin
  Error := 0;
  if NumReturn <= 0 then
    Error := 1;
  if NumIntervals < NumReturn then
    Error := 2;
  if Order < 1 then
    Error := 3;
  if LowerLimit = UpperLimit then
    Error := 4;
  if Error = 0 then
  begin
    InitializeStack(ValuesStack);
    Spacing := (UpperLimit - LowerLimit) / NumIntervals;
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
  Index, Term : integer;
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

begin { procedure InitialCondition }
  TestAndInitialize(Order, LowerLimit, UpperLimit,
                    NumIntervals, NumReturn, ValuesStack, Spacing, Error);
  if Error = 0 then
  begin
    CurrentValues := InitialValues;
    Push(ValuesStack, CurrentValues);
    HalfSpacing := Spacing / 2;
    for Index := 1 to NumIntervals do
    begin
      { First step - calculate F1  }
      for Term := 1 to Order - 1 do
        F1[Term] := Spacing * CurrentValues[Term + 1];
      F1[Order] := Spacing * UserFunction3(CurrentValues, FuncPtr);

      { 2nd step - calculate F2  }
      TempValues[0] := CurrentValues[0] + HalfSpacing;
      for Term := 1 to Order do
        TempValues[Term] := CurrentValues[Term] + 0.5 * F1[Term];
      for Term := 1 to Order - 1 do
        F2[Term] := Spacing * TempValues[Term + 1];
      F2[Order] := Spacing * UserFunction3(TempValues, FuncPtr);

      { Third step - calculate F3  }
      for Term := 1 to Order do
        TempValues[Term] := CurrentValues[Term] + 0.5 * F2[Term];
      for Term := 1 to Order - 1 do
        F3[Term] := Spacing * TempValues[Term + 1];
      F3[Order] := Spacing * UserFunction3(TempValues, FuncPtr);

      { Fourth step - calculate F4  }
      TempValues[0] := CurrentValues[0] + Spacing;
      for Term := 1 to Order do
        TempValues[Term] := CurrentValues[Term] + F3[Term];
      for Term := 1 to Order - 1 do
        F4[Term] := Spacing * TempValues[Term + 1];
      F4[Order] := Spacing * UserFunction3(TempValues, FuncPtr);

      { Combine F1, F2, F3, and F4 to get  }
      { the solution at this mesh point    }
      CurrentValues[0] := CurrentValues[0] + Spacing;
      for Term := 1 to Order do
        CurrentValues[Term] := CurrentValues[Term] +
                               (F1[Term] + 2 * F2[Term] +
                               2 * F3[Term] + F4[Term]) / 6;

      Push(ValuesStack, CurrentValues);
    end;
    GetValues(NumReturn, NumIntervals, ValuesStack, SolutionValues);
  end;
end; { procedure InitialCondition }
