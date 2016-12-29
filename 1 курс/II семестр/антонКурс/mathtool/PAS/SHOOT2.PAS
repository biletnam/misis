program Shooting_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-       Purpose:  This unit demonstrates the procedure Shooting            -}
{-                 which solves a boundary value problem - a 2nd order,     -}
{-                 non-linear ordinary differential equation with boundary  -}
{-                 conditions specified - using the non-linear shooting     -}
{-                 method.                                                  -}
{-                                                                          -}
{-       Unit   : InitVal    procedure Shooting                             -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}      { Disable I/O error trapping  }
{$R+}      { Enable range checking  }

uses
  InitVal, Dos, Crt, Common;

var
  LowerLimit, UpperLimit : Float;     { Limits over which to approximate Y  }
  LowerInitial, UpperInitial : Float; { Boundary values of Y at limits  }
  InitialSlope : Float;               { A guess of the slope at LowerLimit  }
  NumReturn : integer;                { Number of points to be returned  }
  NumIntervals : integer;             { Number of sub-intervals  }
  Tolerance : Float;                  { Tolerance in answer  }
  MaxIter : integer;                  { Maximum number of iterations  }
  Iter : integer;                     { Number of iterations  }
  XValues : TNvector;                 { Values of X between limits  }
  YValues : TNvector;                 { Value of Y at XValues  }
  YDerivValues : TNvector;            { Derivative of Y at XValues  }
  Error : byte;                       { Flags if something went wrong  }

{$F+}
function TNTargetF(X      : Float;
                   Y      : Float;
                   yPrime : Float) : Float;

{--------------------------------------------------------------------}
{-    This is the 2nd order non-linear differential equation        -}
{--------------------------------------------------------------------}

begin
  TNTargetF := 192 * Sqr(Y / yPrime);
end; { function TNTargetF }
{$F-}

procedure Initialize(var LowerLimit   : Float;
                     var UpperLimit   : Float;
                     var LowerInitial : Float;
                     var UpperInitial : Float;
                     var InitialSlope : Float;
                     var NumIntervals : integer;
                     var NumReturn    : integer;
                     var Error        : byte);

{------------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, LowerInitial, UpperInitial,    -}
{-         InitialSlope, NumIntervals, NumReturn, Error           -}
{-                                                                -}
{- This procedure initializes the above variables to zero         -}
{------------------------------------------------------------------}

begin
  LowerLimit := 0;
  UpperLimit := 0;
  LowerInitial := 0;
  UpperInitial := 0;
  InitialSlope := 0;
  NumIntervals := 0;
  NumReturn := 0;
  Error := 0;
end; { procedure Initialize }

procedure GetData(var LowerLimit   : Float;
                  var UpperLimit   : Float;
                  var LowerInitial : Float;
                  var UpperInitial : Float;
                  var InitialSlope : Float;
                  var NumReturn    : integer;
                  var NumIntervals : integer;
                  var Tolerance    : Float;
                  var MaxIter      : integer);

{------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, LowerInitial,            -}
{-         UpperInitial, NumReturn, NumIntervals,           -}
{-         Tolerance, MaxIter                               -}
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

procedure GetBoundaryValues(LowerLimit   : Float;
                            UpperLimit   : Float;
                        var LowerInitial : Float;
                        var UpperInitial : Float);

{--------------------------------------------------}
{- Input: LowerLimit, UpperLimit                  -}
{- Output: LowerInitial, UpperInitial             -}
{-                                                -}
{- This procedure assigns a value to LowerInitial -}
{- and UpperInitial from keyboard input.          -}
{--------------------------------------------------}

begin
  Writeln;
  repeat
    Write('Enter Y value at X =', LowerLimit : 14, ': ');
    Readln(LowerInitial);
    IOCheck;
  until not IOerr;
  repeat
    Write('Enter Y value at X =', UpperLimit : 14, ': ');
    Readln(UpperInitial);
    IOCheck;
  until not IOerr;
end; { procedure GetBoundaryValues }

procedure GetInitialSlope(LowerLimit   : Float;
                          UpperLimit   : Float;
                          LowerInitial : Float;
                          UpperInitial : Float;
                      var InitialSlope : Float);

{--------------------------------------------------}
{- Input: LowerLimit, UpperLimit, LowerInitial,   -}
{-        UpperInitial                            -}
{- Output: InitialSlope                           -}
{-                                                -}
{- This procedure assigns a value to InitialSlope -}
{--------------------------------------------------}

begin
  Writeln;
  if LowerLimit <> UpperLimit then
    InitialSlope := (UpperInitial - LowerInitial) / (UpperLimit - LowerLimit);
    repeat
      Write('Enter a guess for the slope at X =', LowerLimit : 14, '): ');
      ReadFloat(InitialSlope);
      IOCheck;
    until not IOerr;
end; { procedure GetInitialSlope }

procedure GetNumReturn(var NumReturn : integer);

{------------------------------------------------------------}
{- Output: NumReturn                                        -}
{-                                                          -}
{- This procedure reads in the number of points which will  -}
{- be returned from the procedure.                          -}
{------------------------------------------------------------}

begin
  Writeln;
  repeat
    Write('Number of points returned (1-', TNArraySize, ')? ');
    Readln(NumReturn);
    IOCheck;
  until not IOerr and (NumReturn <= TNArraySize) and (NumReturn >= 1);
end; { procedure GetNumReturn }

procedure GetNumIntervals(NumReturn    : integer;
                      var NumIntervals : integer);

{---------------------------------------------}
{- Input: LowerInitial, UpperInitial,        -}
{-        NumReturn                          -}
{- Output: NumIntervals                      -}
{-                                           -}
{- This procedure reads in the NumIntervals. -}
{---------------------------------------------}

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

procedure GetTolerance(var Tolerance : Float);

{------------------------------------------------------------}
{- Output: Tolerance                                        -}
{-                                                          -}
{- This procedure reads in the tolerance in the answer.     -}
{------------------------------------------------------------}

begin
  Writeln;
  Tolerance := 1E-6;
  repeat
    Write('Tolerance (> 0)? ');
    ReadFloat(Tolerance);
    IOCheck;
    if Tolerance <= 0 then
    begin
      IOerr := true;
      Tolerance := 1E-6;
    end;
  until not IOerr;
end; { procedure GetTolerance }

procedure GetMaxIter(var MaxIter : integer);

{-------------------------------------------------------------}
{- Output: MaxIter                                           -}
{-                                                           -}
{- This procedure reads in the maximum number of iterations. -}
{-------------------------------------------------------------}

begin
  Writeln;
  MaxIter := 100;
  repeat
    Write('Maximum number of iterations (>0)? ');
    ReadInt(MaxIter);
    IOCheck;
    if MaxIter <= 0 then
    begin
      IOerr := true;
      MaxIter := 100;
    end;
  until not IOerr;
end; { procedure GetMaxIter }

begin { procedure GetData }
  GetLimits(LowerLimit, UpperLimit);
  GetBoundaryValues(LowerLimit, UpperLimit, LowerInitial, UpperInitial);
  GetInitialSlope(LowerLimit, UpperLimit, LowerInitial, UpperInitial,
                  InitialSlope);
  GetNumReturn(NumReturn);
  GetNumIntervals(NumReturn, NumIntervals);
  GetTolerance(Tolerance);
  GetMaxIter(MaxIter);
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(LowerLimit   : Float;
                  UpperLimit   : Float;
                  LowerInitial : Float;
                  UpperInitial : Float;
                  InitialSlope : Float;
                  NumIntervals : integer;
                  NumReturn    : integer;
                  Tolerance    : Float;
                  MaxIter      : integer;
                  Iter         : integer;
              var XValues      : TNvector;
              var YValues      : TNvector;
              var YDerivValues : TNvector;
                  Error        : byte);

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
  Writeln(OutFile, 'Value of Y at ' : 19, LowerLimit:8:4, ' :' , LowerInitial);
  Writeln(OutFile, 'Value of Y at ' : 19, UpperLimit:8:4, ' :' , UpperInitial);
  Writeln(OutFile, 'Initial slope at ' : 19, LowerLimit:8:4, ' :', InitialSlope);
  Writeln(Outfile, 'NumIntervals:' : 29, NumIntervals : 3);
  Writeln(OutFile, 'Tolerance:  ' : 31, Tolerance : 10);
  Writeln(OutFile, 'Maximum number of iterations:' : 29, MaxIter);
  Writeln(OutFile);
  Writeln(OutFile, 'Number of iterations:' : 29, Iter:3);
  Writeln(OutFile);
  if Error = 6 then
    DisplayWarning;
  if (Error >= 1) and (Error <> 6) then
    DisplayError;
  case Error of
    1 : Writeln(OutFile,
                'The number of points returned must be greater than zero.');

    2 : begin
          Writeln(OutFile, 'The number of intervals must be greater than');
          Writeln(OutFile, 'or equal to the number of values to return.');
        end;

    3 : Writeln(OutFile,
                'The lower limit must not equal the upper limit.');

    4 : Writeln(OutFile, 'The tolerance must be greater than zero.');

    5 : Writeln(OutFile,
                'The maximum number of iterations must be greater than zero.');

    6 : begin
          Writeln(OutFile,
                  'Convergence was not reached in ', iter, ' iterations.');
          Writeln(OutFile, 'Results of the last iteration:');
        end;

    7 : begin
          Writeln(OutFile, 'Convergence not possible.');
          Writeln(OutFile,
                  'Try another approximation to the initial slope.');
        end;
  end; { case }

  if Error in [0, 6] then
  begin
    Writeln(OutFile, 'X':10, 'Y Value' : 30, 'Derivative of Y' : 28);
    for Index := 0 to NumReturn do
      Writeln(OutFile, XValues[Index], YValues[Index] : 26, YDerivValues[Index]:24);
  end;
end; { procedure Results }

begin { program Shooting }
  ClrScr;
  Initialize(LowerLimit, UpperLimit, LowerInitial, UpperInitial,
             InitialSlope, NumIntervals, NumReturn, Error);
  GetData(LowerLimit, UpperLimit, LowerInitial, UpperInitial, InitialSlope,
          NumReturn, NumIntervals, Tolerance, MaxIter);
  Shooting(LowerLimit, UpperLimit, LowerInitial, UpperInitial, InitialSlope,
           NumReturn, Tolerance, MaxIter, NumIntervals, Iter, XValues,
           YValues, YDerivValues, Error, @TNTargetF);
  Results(LowerLimit, UpperLimit, LowerInitial, UpperInitial, InitialSlope,
          NumIntervals, NumReturn, Tolerance, MaxIter, Iter, XValues,
          YValues, YDerivValues, Error);
  Close(OutFile);
end. { program Shooting }
