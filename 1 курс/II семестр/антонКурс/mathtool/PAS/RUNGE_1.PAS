program InitialCond1stOrder_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-       Purpose:  This unit demonstrates the procedure InitialCond1stOrder -}
{-                 which solves an initial value problem - a first order    -}
{-                 ordinary differential equation with initial conditions   -}
{-                 specified - using a four stage Runge Kutta formula.      -}
{-                                                                          -}
{-       Unit   :  InitVal    procedure InitialCond1stOrder                 -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}      { Disable I/O error trapping  }
{$R+}      { Enable range checking  }

uses
  InitVal, Dos, Crt, Common;

var
  LowerLimit, UpperLimit : Float;   { Limits over which to approximate X  }
  XInitial : Float;                 { Intial value of X at LowerLimit  }
  NumIntervals : integer;           { Number of intervals  }
  NumReturn : integer;              { Number of values to return  }
  TValues : TNvector;               { Value of T between the limits  }
  XValues : TNvector;               { Value of X at TValues  }
  Error : byte;                     { Flags if something went wrong  }

{$F+}
function TNTargetF(T, X : Float) : Float;

{---------------------------------------------------------------}
{-         This is the first order differential equation       -}
{---------------------------------------------------------------}

begin
  TNTargetF := X / T + T - 1
end; { function TNTargetF }
{$F-}

procedure Initialize(var LowerLimit   : Float;
                     var UpperLimit   : Float;
                     var XInitial     : Float;
                     var NumIntervals : integer;
                     var Error        : byte);

{------------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, XInitial, NumIntervals, Error  -}
{-                                                                -}
{- This procedure initializes the above variables to zero         -}
{------------------------------------------------------------------}

begin
  LowerLimit := 0;
  UpperLimit := 0;
  XInitial := 0;
  NumIntervals := 0;
  Error := 0;
end; { procedure Initialize }

procedure GetData(var LowerLimit   : Float;
                  var UpperLimit   : Float;
                  var XInitial     : Float;
                  var NumReturn    : integer;
                  var NumIntervals : integer);

{------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, XInitial,                -}
{-         NumReturn, NumIntervals                          -}
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

procedure GetNumReturn(var NumReturn : integer);

{------------------------------------------------------------}
{- Output: NumReturn                                        -}
{-                                                          -}
{- This procedure reads in the number of values to return   -}
{- in the XValues vector.                                   -}
{------------------------------------------------------------}

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
{- Input : NumReturn                                        -}
{- Output: NumIntervals                                     -}
{-                                                          -}
{- This procedure reads in the number of intervals          -}
{- over which to evaluate the function.                     -}
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
  GetXInitial(LowerLimit, XInitial);
  GetNumReturn(NumReturn);
  GetNumIntervals(NumReturn, NumIntervals);
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(LowerLimit   : Float;
                  UpperLimit   : Float;
                  XInitial     : Float;
                  NumIntervals : integer;
                  NumReturn    : integer;
              var TValues      : TNvector;
              var XValues      : TNvector;
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
  Writeln(OutFile, 'Value of X at ' : 19, LowerLimit:8:4, ' :' , XInitial);
  Writeln(OutFile, 'Number of intervals : ' : 30, NumIntervals);
  Writeln(OutFile);
  if Error >= 1 then
    DisplayError;
  case Error of
    0 : begin
          Writeln(OutFile, 't' : 15, 'X' : 15);
          for Index := 0 to NumReturn do
            Writeln(OutFile, TValues[Index] : 20 : 8, ' ', XValues[Index]);
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

begin { program InitialCond1stOrder }
  ClrScr;
  Initialize(LowerLimit, UpperLimit, XInitial, NumIntervals, Error);
  GetData(LowerLimit, UpperLimit, XInitial, NumReturn, NumIntervals);
  InitialCond1stOrder(LowerLimit, UpperLimit, XInitial, NumReturn,
                      NumIntervals, TValues, XValues, Error, @TNTargetF);
  Results(LowerLimit, UpperLimit, XInitial, NumIntervals,
          NumReturn, TValues, XValues, Error);
  Close(OutFile);
end. { program InitialCond1stOrder }
