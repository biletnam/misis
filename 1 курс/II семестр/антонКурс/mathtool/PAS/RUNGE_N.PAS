program InitialCondition_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-       Purpose:  This unit demonstrates the procedure InitialCondition    -}
{-                 which solves an initial value problem - an nth order     -}
{-                 ordinary differential equation with initial conditions   -}
{-                 specified - using the fourth order, generalized          -}
{-                 Runge-Kutta formula.                                     -}
{-                                                                          -}
{-       Unit   : InitVal    procedure InitialCondition                     -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}      { Disable I/O error trapping  }
{$R+}      { Enable range checking  }

uses
  InitVal, Dos, Crt, Common;

const
  TNOrder = TNArraySize;

var
  Order : integer;              { The order, n, of the equation  }
  LowerLimit : Float;           { Lower limit of interval  }
  UpperLimit : Float;           { Upper limit of interval  }
  InitialValues : TNvector;     { Initial values at lower limit  }
  NumReturn : integer;          { Number of values to return  }
  NumIntervals : integer;       { Number of intervals  }
  SolutionValues : TNmatrix;    { Values of the n parameters at NumReturn  }
                                { Mesh points between the intervals  }
  Error : byte;                 { Flags if something went wrong  }

{$F+}
function TNTargetF(V : TNvector) : Float;

{-------------------------------------------}
{- This is the differential equation.      -}
{-   n                                     -}
{-  d X                               n-1  -}
{-  -----  = TNTargetF(t, X, X', ... X   ) -}
{-     n                                   -}
{-   dt                                    -}
{-                                         -}
{- where n is the order of the equation.   -}
{-                                         -}
{- V[0] corresponds to t                   -}
{- V[1] corresponds to X                   -}
{- V[2] corresponds to 1st derivative of X -}
{- V[3] corresponds to 2nd derivative of X -}
{-                  .                      -}
{-                  .                      -}
{-                  .                      -}
{-------------------------------------------}

begin
  TNTargetF := -4 * V[1] * V[4];
end; { function TNTargetF }
{$F-}

procedure Initialize(var Order        : integer;
                     var LowerLimit   : Float;
                     var UpperLimit   : Float;
                     var InitialValue : TNvector;
                     var NumIntervals : integer;
                     var NumReturn    : integer;
                     var Error        : byte);

{------------------------------------------------------------------}
{- Output: Order, LowerLimit, UpperLimit, LowerInitial,           -}
{-         InitialValues, NumIntervals, NumReturn, Error          -}
{-                                                                -}
{- This procedure initializes the above variables to zero.        -}
{------------------------------------------------------------------}

begin
  Order := 0;
  LowerLimit := 0;
  UpperLimit := 0;
  FillChar(InitialValue, SizeOf(InitialValue), 0);
  NumReturn := 0;
  NumIntervals := 0;
  Error := 0;
end; { procedure Initialize }

procedure GetData(var Order         : integer;
                  var LowerLimit    : Float;
                  var UpperLimit    : Float;
                  var InitialValues : TNvector;
                  var NumReturn     : integer;
                  var NumIntervals  : integer);

{------------------------------------------------------------}
{- Output: Order, LowerLimit, UpperLimit, InitialValues,    -}
{-         NumReturn, NumIntervals                          -}
{-                                                          -}
{- This procedure assigns values to the above variables     -}
{- from keyboard input                                      -}
{------------------------------------------------------------}

procedure GetOrder(var Order : integer);

{--------------------------------------}
{- Output: Order                      -}
{-                                    -}
{- This procedure reads in the order  -}
{- of the equation from the keyboard. -}
{--------------------------------------}

begin
  Writeln;
  repeat
    Write('Order of the equation: (1-', TNorder, ')? ');
    Readln(Order);
    IOCheck;
  until not IOerr and (Order <= TNorder) and (Order >= 1);
  Writeln;
end; { procedure GetOrder }

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

procedure GetInitialValues(Order         : integer;
                           LowerLimit    : Float;
                       var InitialValues : TNvector);

{--------------------------------------------------}
{- Input: Order, LowerLimit                       -}
{- Output: InitialValues                          -}
{-                                                -}
{- This procedure assigns values to InitialValues -}
{- from keyboard input.                           -}
{--------------------------------------------------}

var
  Term : integer;

begin
  InitialValues[0] := LowerLimit;
  Writeln;
  repeat
    Write('Enter X value at t =':24, LowerLimit : 14, ': ');
    Readln(InitialValues[1]);
    IOCheck;
  until not IOerr;
  for Term := 2 to Order do
  repeat
    Write('Derivative ', Term - 1, ' of X at t =', LowerLimit:14,': ');
    Readln(InitialValues[Term]);
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
  GetOrder(Order);
  GetLimits(LowerLimit, UpperLimit);
  GetInitialValues(Order, LowerLimit, InitialValues);
  GetNumReturn(NumReturn);
  GetNumIntervals(NumReturn, NumIntervals);
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(Order          : integer;
                  LowerLimit     : Float;
                  UpperLimit     : Float;
                  InitialValues  : TNvector;
                  NumIntervals   : integer;
                  NumReturn      : integer;
              var SolutionValues : TNmatrix;
                  Error          : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  Term : integer;
  Index : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'Lower Limit:' : 35, LowerLimit);
  Writeln(OutFile, 'Upper Limit:' : 35, UpperLimit);
  Writeln(OutFile, 'Number of intervals:' : 35, NumIntervals);
  Writeln(OutFile, 'Initial conditions at lower limit:' : 35);
  for Term := 1 to Order do
    Writeln(OutFile, 'X[' : 21, Term,']=', InitialValues[Term]);
  Writeln(OutFile);
  if Error >= 1 then
    DisplayError;

  case Error of
    0 : begin
          for Term := 1 to Order do
          begin
            Writeln(OutFile, 't':10, 'Value X[' : 30, Term, ']');
            for Index := 0 to NumReturn do
              Writeln(OutFile, SolutionValues[Index, 0] : 15 : 8,
                               SolutionValues[Index, Term] : 30);
            Writeln(OutFile);
          end;
        end;

    1 : Writeln(OutFile,
                'The number of values to return must be greater than zero.');
    2 : begin
          Writeln(OutFile, 'The number of intervals must be greater than');
          Writeln(OutFile, 'or equal to the number of values to return.');
        end;

    3 : Writeln(OutFile,
                'The order of the equation must be greater than zero.');
    4 : Writeln(OutFile, 'The lower limit must be different ',
                         'from the upper limit.');
  end; { case }
end; { procedure Results }

begin { program InitialCondition }
  ClrScr;
  Initialize(Order, LowerLimit, UpperLimit, InitialValues,
             NumIntervals, NumReturn, Error);
  GetData(Order, LowerLimit, UpperLimit, InitialValues,
          NumReturn, NumIntervals);
  InitialCondition(Order, LowerLimit, UpperLimit, InitialValues,
                   NumReturn, NumIntervals, SolutionValues, Error, @TNTargetF);
  Results(Order, LowerLimit, UpperLimit, InitialValues, NumIntervals,
          NumReturn, SolutionValues, Error);
  Close(OutFile);
end. { program InitialCondition }
