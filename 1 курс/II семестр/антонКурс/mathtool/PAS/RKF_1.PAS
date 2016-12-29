program RungeKuttaFehlberg_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-         Purpose:  This unit demonstrates procedure RungeKuttaFehlberg    -}
{-                   which solves an initial value problem - a first order  -}
{-                   ordinary differential equation with initial conditions -}
{-                   specified - to a specified degree of accuracy using    -}
{-                   the Runge Kutta Fehlberg method.                       -}
{-                                                                          -}
{-         Unit   : InitVal    procedure RungeKuttaFehlberg                 -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}      { Disable I/O error trapping  }
{$R+}      { Enable range checking  }

uses
  InitVal, Dos, Crt, Common;

var
  LowerLimit, UpperLimit : Float;   { Limits over which to approximate X  }
  XInitial : Float;                 { Intial value of X at LowerLimit  }
  NumReturn : integer;              { Number of (T, X) pairs  }
  Tolerance : Float;                { Tolerance in units of X/T  }
  TValues : TNvector;               { Values of T  }
  XValues : TNvector;               { Values of X at TValues  }
  Error : byte;                     { Flags if something went wrong  }

{$F+}
function TNTargetF(T, X : Float) : Float;

{---------------------------------------------------------------}
{-         This is the first order differential equation       -}
{---------------------------------------------------------------}

begin
  TNTargetF := X / T + T - 1;
end; { function TNTargetF }
{$F-}

procedure Initialize(var LowerLimit : Float;
                     var UpperLimit : Float;
                     var XInitial   : Float;
                     var NumReturn  : integer;
                     var Tolerance  : Float;
                     var Error      : byte);

{------------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, XInitial, NumReturn,           -}
{-         Tolerance, Error                                       -}
{-                                                                -}
{- This procedure initializes the above variables to zero         -}
{------------------------------------------------------------------}

begin
  LowerLimit := 0;
  UpperLimit := 0;
  XInitial := 0;
  NumReturn := 0;
  Tolerance := 0;
  Error := 0;
end; { procedure Initialize }

procedure GetData(var LowerLimit : Float;
                  var UpperLimit : Float;
                  var XInitial   : Float;
                  var NumReturn  : integer;
                  var Tolerance  : Float);

{------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, XInitial,                -}
{-         NumReturn, Tolerance                             -}
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

procedure GetXInitial(LowerLimit : Float;
                  var XInitial   : Float);

{----------------------------------------------}
{- Input: LowerLimit                          -}
{- Output: XInitial                           -}
{-                                            -}
{- This procedure assigns a value to XInitial -}
{- from keyboard input.                       -}
{----------------------------------------------}

begin
  Writeln;
  repeat
    Write('X value at t =', LowerLimit : 14, ': ');
    Readln(XInitial);
  until not IOerr;
end; { procedure GetXInitial }

procedure GetTolerance(var Tolerance : Float);

{------------------------------------------------------------}
{- Output: Tolerance                                        -}
{-                                                          -}
{- This procedure reads in the tolerance with               -}
{- which to evaluate a solution.                            -}
{------------------------------------------------------------}

begin
  Writeln;
  Tolerance := 1E-6;
  repeat
    Write('Tolerance in X/T units (>0)? ');
    ReadFloat(Tolerance);
    IOCheck;
    if Tolerance <= 0 then
    begin
      IOerr := true;
      Tolerance := 1E-6;
    end;
  until not IOerr;
end; { procedure GetTolerance }

procedure GetNumReturn(var NumReturn : integer);

{------------------------------------------------------------}
{- Output: NumReturn                                        -}
{-                                                          -}
{- This procedure reads in the number of values to be       -}
{- returned from the procedure.                             -}
{------------------------------------------------------------}

begin
  Writeln;
  repeat
    Write('Number of values to return (1-', TNArraySize, ')? ');
    Readln(NumReturn);
    IOCheck;
  until not IOerr and (NumReturn <= TNArraySize) and (NumReturn >= 1);
end; { procedure GetNumReturn }

begin { procedure GetData }
  GetLimits(LowerLimit, UpperLimit);
  GetXInitial(LowerLimit, XInitial);
  GetNumReturn(NumReturn);
  GetTolerance(Tolerance);
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(LowerLimit : Float;
                  UpperLimit : Float;
                  XInitial   : Float;
                  NumReturn  : integer;
                  Tolerance  : Float;
              var TValues    : TNvector;
              var XValues    : TNvector;
                  Error      : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

var
  Index : integer;

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'Lower Limit:' : 29, LowerLimit);
  Writeln(OutFile, 'Upper Limit:' : 29, UpperLimit);
  Writeln(OutFile, 'Value of X at ' : 19, LowerLimit:8:4, ' :' , XInitial);
  Writeln(OutFile, 'Tolerance:' : 29, Tolerance);
  Writeln(OutFile);
  if Error = 4 then
    DisplayWarning;
  if Error in [1, 2, 3] then
    DisplayError;

  case Error of
    1 : Writeln(OutFile, 'The tolerance must be greater than ',TNNearlyZero);

    2 : Writeln(OutFile,
                'The number of values returned must be greater than zero.');

    3 : Writeln(OutFile, 'The lower limit must be different ',
                         'from the upper limit.');

    4 : begin
          Writeln(OutFile, 'Tolerance not reached for all values.');
          Writeln(OutFile, 'The partial results are:');
          Writeln(OutFile);
        end;
  end; { case }

  if Error in [0, 4] then
  begin
    Writeln(OutFile, 't' : 15, 'X' : 15);
    for Index := 0 to NumReturn do
      Writeln(OutFile, TValues[Index] : 20 : 8, ' ', XValues[Index]);
  end;
end; { procedure Results }

begin { program RungeKuttaFehlberg }
  ClrScr;
  Initialize(LowerLimit, UpperLimit, XInitial, NumReturn, Tolerance, Error);
  GetData(LowerLimit, UpperLimit, XInitial, NumReturn, Tolerance);
  RungeKuttaFehlberg(LowerLimit, UpperLimit, XInitial, Tolerance,
                     NumReturn, TValues, XValues, Error, @TNTargetF);
  Results(LowerLimit, UpperLimit, XInitial, NumReturn, Tolerance,
          TValues, XValues, Error);
  Close(OutFile);
end. { program RungeKuttaFehlberg }
