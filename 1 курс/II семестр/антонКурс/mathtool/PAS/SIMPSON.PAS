program Simpson_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-           Purpose: This program demonstrates integration with            -}
{-                    Simpson's Composite Algorithm.                        -}
{-                                                                          -}
{-           Unit   : Integrat    procedure Simpson                         -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}      { Disable I/O error trapping }
{$R+}      { Enable range checking }

uses
  Integrat, Dos, Crt, Common;

var
  LowerLimit, UpperLimit : Float;   { Limits of integration }
  NumIntervals : integer;           { Number of intervals }
  Integral : Float;                 { Value of the integral }
  Error : byte;                     { Flags if something went wrong }

{$F+}
function TNTargetF(X : Float) : Float;

{-----------------------------------------------------}
{-         This is the function to integrate         -}
{-----------------------------------------------------}

begin
  TNTargetF := Exp(3 * X) + Sqr(X) / 3;
end; { function TNTargetF }
{$F-}

procedure Initialize(var LowerLimit   : Float;
                     var UpperLimit   : Float;
                     var Integral     : Float;
                     var NumIntervals : integer;
                     var Error        : byte);

{------------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, Integral, NumIntervals, Error  -}
{-                                                                -}
{- This procedure initializes the above variables to zero         -}
{------------------------------------------------------------------}

begin
  Writeln;
  LowerLimit := 0;
  UpperLimit := 0;
  Integral := 0;
  NumIntervals := 0;
  Error := 0;
end; { procedure Initialize }

procedure GetData(var LowerLimit   : Float;
                  var UpperLimit   : Float;
                  var NumIntervals : integer);

{------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, NumIntervals             -}
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
      Write('Lower limit of integration? ');
      Readln(LowerLimit);
      IOCheck;
    until not IOerr;
    Writeln;
    repeat
      Write('Upper limit of integration? ');
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

procedure GetNumIntervals(var NumIntervals : integer);

{------------------------------------------------------------}
{- Output: NumIntervals                                     -}
{-                                                          -}
{- This procedure reads in the number of intervals          -}
{- over which to apply Simpson's rule                       -}
{------------------------------------------------------------}

begin
  Writeln;
  repeat
    Write('Number of intervals (> 0)? ');
    Readln(NumIntervals);
    IOCheck;
    if NumIntervals <= 0 then
      IOerr := true;
  until not IOerr;
end; { procedure GetNumIntervals }

begin { procedure GetData }
  GetLimits(LowerLimit, UpperLimit);
  GetNumIntervals(NumIntervals);
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(LowerLimit   : Float;
                  UpperLimit   : Float;
                  NumIntervals : integer;
                  Integral     : Float;
                  Error        : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'Lower Limit:' : 25, LowerLimit : 25);
  Writeln(OutFile, 'Upper Limit:' : 25, UpperLimit : 25);
  Writeln(OutFile, 'Number of intervals:' : 25, NumIntervals : 5);
  Writeln(OutFile);
  if Error = 1 then
    DisplayError;

  case Error of
    0 : Writeln(OutFile, 'Integral:' : 25, Integral : 25);

    1 : Writeln(OutFile, 'The number of intervals must be greater than 0.');

  end; { case }
end; { procedure Results }

begin { program Simpson }
  ClrScr;
  Initialize(LowerLimit, UpperLimit, Integral, NumIntervals, Error);
  GetData(LowerLimit, UpperLimit, NumIntervals);
  Simpson(LowerLimit, UpperLimit, NumIntervals, Integral, Error, @TNTargetF);
  Results(LowerLimit, UpperLimit, NumIntervals, Integral, Error);
  Close(OutFile);
end. { program Simpson }
