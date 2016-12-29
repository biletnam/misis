program InitialCond2ndOrder_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-       Purpose:  This unit demonstrates the procedure InitialCond2ndOrder -}
{-                 which solves an initial value problem - a second order   -}
{-                 ordinary differential equation with initial conditions   -}
{-                 specified - using the fourth order, two variable         -}
{-                 Runge Kutta formula.                                     -}
{-                                                                          -}
{-       Unit   : InitVal    procedure InitialCond2ndOrder                  -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}      { Disable I/O error trapping  }
{$R+}      { Enable range checking  }

uses
  InitVal, Dos, Crt, Common;

var
  LowerLimit, UpperLimit : Float;     { Limits over which to approximate X  }
  InitialValue, InitialDeriv : Float; { Initial values at lower limit  }
  NumReturn : integer;                { Number of values to return  }
  NumIntervals : integer;             { Number of intervals  }
  TValues : TNvector;                 { Value of T between the limits  }
  XValues : TNvector;                 { Value of X at TValues  }
  XDerivValues : TNvector;            { Derivative of X at TValues  }
  Error : byte;                       { Flags if something went wrong  }

{$F+}
function TNTargetF(T      : Float;
                   X      : Float;
                   XPrime : Float) : Float;

{---------------------------------------------------------------}
{-         This is the second order differential equation      -}
{---------------------------------------------------------------}

begin
  TNTargetF := 9 / 2 * Sin (5 * T) - 32 / 2 * X;
end; { function TNTargetF }
{$F-}

procedure Initialize(var LowerLimit   : Float;
                     var UpperLimit   : Float;
                     var InitialValue : Float;
                     var InitialDeriv : Float;
                     var NumIntervals : integer;
                     var NumReturn    : integer;
                     var Error        : byte);

{------------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, LowreInitial, InitialDeriv,    -}
{-         NumIntervals, NumReturn, Error                         -}
{-                                                                -}
{- This procedure initializes the above variables to zero         -}
{------------------------------------------------------------------}

begin
  LowerLimit := 0;
  UpperLimit := 0;
  InitialValue := 0;
  InitialDeriv := 0;
  NumReturn := 0;
  NumIntervals := 0;
  Error := 0;
end; { procedure Initialize }

procedure GetData(var LowerLimit   : Float;
                  var UpperLimit   : Float;
                  var InitialValue : Float;
                  var InitialDeriv : Float;
                  var NumReturn    : integer;
                  var NumIntervals : integer);

{------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, InitialValue,            -}
{-         InitialDeriv, NumReturn, NumIntervals            -}
{-                                                          -}
{- This procedure assigns values to the above variables     -}
{- from keyboard input                                      -}
{------------------------------------------------------------}

procedure GetLimits(var LowerLimit : Float;
                    var UpperLimit : Float);

{------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit                           -}
{-                                                          -}
{- This procedure assigns values to the limits of           -}
{- integration from keyboard input                          -}
{------------------------------------------------------------}

begin
  repeat
    repeat
      Write('Lower limit of interval? ');
      Readln(LowerLimit);
      IOCheck;
    until not IOerr;
    Writeln;
    repeat
      Write('Upper limit of interval? ');
      Readln(UpperLimit);
      IOCheck;
    until not IOerr;
    if LowerLimit = UpperLimit then
    begin
      Writeln;
      Writeln('       The limits of integration must be different.');
      Writeln;
    end;
  until LowerLimit <> UpperLimit;
end; { procedure GetLimits }

procedure GetInitialValues(LowerLimit   : Float;
                       var InitialValue : Float;
                       var InitialDeriv : Float);

{--------------------------------------------------}
{- Input: LowerLimit                              -}
{- Output: InitialValue, InitialDeriv             -}
{-                                                -}
{- This procedure assigns a value to InitialValue -}
{- and InitialDeriv from keyboard input.          -}
{--------------------------------------------------}

begin
  Writeln;
  repeat
    Write('Enter X value at t =', LowerLimit : 14, ': ');
    Readln(InitialValue);
    IOCheck;
  until not IOerr;
  repeat
    Write('Enter Derivative of X at t =', LowerLimit : 14, ': ');
    Readln(InitialDeriv);
    IOCheck;
  until not IOerr;
end; { procedure GetInitialValues }

procedure GetNumReturn(var NumReturn : integer);

{----------------------------------------------------------}
{- Output: NumReturn                                      -}
{-                                                        -}
{- This procedure reads in the number of values to return -}
{- in the vectors TValues, XValues and XDerivValues.      -}
{----------------------------------------------------------}

begin
  Writeln;
  repeat
    Write('Number of values to return (1-', TNArraySize, ')? ');
    Readln(NumReturn);
    IOCheck;
  until not IOerr and (NumReturn <= TNArraySize) and (NumReturn >= 1);
end; { procedure GetNumReturn }

procedure GetNumIntervals(NumReturn    : integer;
                      var NumIntervals : integer);

{------------------------------------------------------------}
{- Input: NumReturn                                         -}
{- Output: NumIntervals                                     -}
{-                                                          -}
{- This procedure reads in the number of intervals          -}
{- over which to solve the equation.                        -}
{------------------------------------------------------------}

begin
  Writeln;
  NumIntervals := NumReturn;
  repeat
    Write('Number of intervals (>= ', NumReturn, ')? ');
    ReadInt(NumIntervals);
    IOCheck;
    if NumIntervals < NumReturn then
    begin
      IOerr := true;
      NumIntervals := NumReturn;
    end;
  until not IOerr;
end; { procedure GetNumIntervals }

begin { procedure GetData }
  GetLimits(LowerLimit, UpperLimit);
  GetInitialValues(LowerLimit, InitialValue, InitialDeriv);
  GetNumReturn(NumReturn);
  GetNumIntervals(NumReturn, NumIntervals);
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(LowerLimit   : Float;
                  UpperLimit   : Float;
                  InitialValue : Float;
                  InitialDeriv : Float;
                  NumIntervals : integer;
                  NumReturn    : integer;
              var TValues      : TNvector;
              var XValues      : TNvector;
              var XDerivValues : TNvector;
                  Error        : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  Index : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'Lower Limit: ' : 30, LowerLimit);
  Writeln(OutFile, 'Upper Limit: ' : 30, UpperLimit);
  Writeln(OutFile, 'Value of X at ' : 19, LowerLimit:8:4, ' : ' ,
                   InitialValue);
  Writeln(OutFile, 'Value of X'' at ' : 19, LowerLimit:8:4, ' : ' ,
                   InitialDeriv);
  Writeln(OutFile, 'Number of intervals: ' : 30, NumIntervals);
  Writeln(OutFile);
  if Error >= 1 then
    DisplayError;
  case Error of
    0 : begin
          Writeln(OutFile, 't':4, 'Value of X' : 30, 'Derivative of X' : 32);
          for Index := 0 to NumReturn do
            Writeln(OutFile, TValues[Index] : 10 : 8,
                             XValues[Index] : 28, XDerivValues[Index] : 28);
        end;

    1 : Writeln(OutFile,
                'The number of values to return must be greater than zero.');
    2 : begin
          Writeln(OutFile, 'The number of intervals must be greater than');
          Writeln(OutFile, 'or equal to the number of values to return.');
        end;

    3 : Writeln(OutFile, 'The lower limit must be different ',
                         'from the upper limit.');
  end; { case }
end; { procedure Results }

begin { program InitialCond2ndOrder }
  ClrScr;
  Initialize(LowerLimit, UpperLimit, InitialValue, InitialDeriv,
             NumIntervals, NumReturn, Error);
  GetData(LowerLimit, UpperLimit, InitialValue,
          InitialDeriv, NumReturn, NumIntervals);
  InitialCond2ndOrder(LowerLimit, UpperLimit, InitialValue, InitialDeriv,
                      NumReturn, NumIntervals, TValues, XValues, XDerivValues,
                      Error, @TNTargetF);
  Results(LowerLimit, UpperLimit, InitialValue, InitialDeriv, NumIntervals,
          NumReturn, TValues, XValues, XDerivValues, Error);
  Close(OutFile);
end. { program InitialCond2ndOrder }
