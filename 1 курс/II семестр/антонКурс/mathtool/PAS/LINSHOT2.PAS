program LinearShooting_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-       Purpose:  This unit demonstrates the procedure LinearShooting      -}
{-                 which solves a boundary value problem - a 2nd order,     -}
{-                 LINEAR, ordinary differential equation with boundary     -}
{-                 conditions specified - using the linear shooting method. -}
{-                                                                          -}
{-       Unit   : InitVal    procedure LinearShooting                       -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}      { Disable I/O error trapping  }
{$R+}      { Enable range checking  }

uses
  InitVal, Dos, Crt, Common;

var
  LowerLimit, UpperLimit : Float;     { Limits over which to approximate Y  }
  LowerInitial, UpperInitial : Float; { Boundary values of Y at limits  }
  NumReturn : integer;                { Number of points to return  }
  NumIntervals : integer;             { Number of sub-intervals  }
  XValues : TNvector;                 { Values of X between limits  }
  YValues : TNvector;                 { Value of Y at XValues  }
  YDerivValues : TNvector;            { Derivative of Y at XValues  }
  Error : byte;                       { Flags if something went wrong  }

{$F+}
function TNTargetF(X      : Float;
                   Y      : Float;
                   yPrime : Float) : Float;

{---------------------------------------------------------------}
{-         This is the 2nd order differential equation         -}
{---------------------------------------------------------------}

begin
  TNTargetF := yPrime / X - Y / Sqr(X) + 1;
end; { function TNTargetF }
{$F-}

procedure Initialize(var LowerLimit   : Float;
                     var UpperLimit   : Float;
                     var LowerInitial : Float;
                     var UpperInitial : Float;
                     var NumReturn    : integer;
                     var NumIntervals : integer;
                     var Error        : byte);

{------------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, LowerInitial, UpperInitial,    -}
{-         NumReturn, NumIntervals, Error                         -}
{-                                                                -}
{- This procedure initializes the above variables to zero         -}
{------------------------------------------------------------------}

begin
  LowerLimit := 0;
  UpperLimit := 0;
  LowerInitial := 0;
  UpperInitial := 0;
  NumReturn := 0;
  NumIntervals := 0;
  Error := 0;
end; { procedure Initialize }

procedure GetData(var LowerLimit   : Float;
                  var UpperLimit   : Float;
                  var LowerInitial : Float;
                  var UpperInitial : Float;
                  var NumReturn    : integer;
                  var NumIntervals : integer);

{------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, LowerInitial,            -}
{-         UpperInitial, NumReturn, NumIntervals            -}
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

procedure GetNumReturn(var NumReturn : integer);

{-------------------------------------------------}
{- Output: NumReturn                             -}
{-                                               -}
{- This procedure reads in the number of points  -}
{- that will be returned from the procedure      -}
{-------------------------------------------------}

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

{----------------------------------------------}
{- Input: LowerLimit, UpperLimit, NumReturn   -}
{- Output: NumIntervals                       -}
{-                                            -}
{- This procedure reads in the length of      -}
{- the sub-intervals used in the algorithm.   -}
{----------------------------------------------}

begin
  NumIntervals := NumReturn;
  Writeln;
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
  GetBoundaryValues(LowerLimit, UpperLimit, LowerInitial, UpperInitial);
  GetNumReturn(NumReturn);
  GetNumIntervals(NumReturn, NumIntervals);
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(LowerLimit   : Float;
                  UpperLimit   : Float;
                  LowerInitial : Float;
                  UpperInitial : Float;
                  NumIntervals : Float;
                  NumReturn    : integer;
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
  Writeln(OutFile, 'NumIntervals:' : 29, NumIntervals);
  Writeln(OutFile);
  if Error >= 1 then
    DisplayError;

  case Error of
    0 : begin
          Writeln(OutFile, 'X':10, 'Value Y' : 30, 'Derivative of Y' : 28);
          for Index := 0 to NumReturn do
            Writeln(OutFile, XValues[Index],
                             YValues[Index] : 26, YDerivValues[Index]:24);
        end;

    1 : Writeln(OutFile,
                'The number of values returned must be greater than zero.');
    2 : begin
          Writeln(OutFile, 'The number of intervals must be greater than');
          Writeln(OutFile, 'or equal to the number of values to return.');
        end;

    3 : Writeln(OutFile, 'The lower limit must not equal the upper limit.');

    4 : Writeln(OutFile, 'The differential equation must be linear.');
  end; { case }
end; { procedure Results }

begin { program LinearShooting }
  ClrScr;
  Initialize(LowerLimit, UpperLimit, LowerInitial, UpperInitial,
             NumReturn, NumIntervals, Error);
  GetData(LowerLimit, UpperLimit, LowerInitial, UpperInitial,
          NumReturn, NumIntervals);
  LinearShooting(LowerLimit, UpperLimit, LowerInitial, UpperInitial, NumReturn,
                 NumIntervals, XValues, YValues, YDerivValues, Error, @TNTargetF);
  Results(LowerLimit, UpperLimit, LowerInitial, UpperInitial,
          NumIntervals, NumReturn, XValues, YValues, YDerivValues, Error);
  Close(OutFile);
end. { program LinearShooting }
