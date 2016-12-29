program Romberg_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-           Purpose: This program demonstrates integration with the        -}
{-                    Romberg algorithm.                                    -}
{-                                                                          -}
{-           Unit   : Integrat    procedure Romberg                         -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}      { Disable I/O checking }
{$R+}      { Enable range checking }

uses
  Integrat, Dos, Crt, Common;

var
  LowerLimit, UpperLimit : Float;   { Limits of integration }
  Tolerance : Float;                { Tolerance in the answer }
  MaxIter : integer;                { Maximum number of iterations }
  Integral : Float;                 { Value of the integral }
  Iter : integer;                   { Number of iterations to find answer }
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

procedure Initialize(var LowerLimit : Float;
                     var UpperLimit : Float;
                     var Integral   : Float;
                     var Tolerance  : Float;
                     var MaxIter    : integer;
                     var Iter       : integer;
                     var Error      : byte);

{------------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, Integral,                      -}
{-         Tolerance, MaxIter, Iter, Error                        -}
{-                                                                -}
{- This procedure initializes the above variables to zero         -}
{------------------------------------------------------------------}

begin
  LowerLimit := 0;
  UpperLimit := 0;
  Integral := 0;
  Tolerance := 0;
  MaxIter := 0;
  Iter := 0;
  Error := 0;
end; { procedure Initialize }

procedure GetData(var LowerLimit : Float;
                  var UpperLimit : Float;
                  var Tolerance  : Float;
                  var MaxIter    : integer);

{------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, Tolerance, MaxIter       -}
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

procedure GetTolerance(var Tolerance : Float);

{--------------------------------------------------}
{- Output: Tolerance                              -}
{-                                                -}
{- This procedure reads in the accepted Tolerance -}
{- from the keyboard.                             -}
{--------------------------------------------------}

begin
  Writeln;
  repeat
    Tolerance := 1E-8;
    Write('Tolerance (> 0) ');
    ReadFloat(Tolerance);
    IOCheck;
    if Tolerance <= 0 then
    begin
      IOerr := true;
      Tolerance := 1E-8;
    end;
  until not IOerr;
end; { procedure GetTolerance }

procedure GetMaxIter(var MaxIter : integer);

{--------------------------------------------------}
{- Output: MaxIter                                -}
{-                                                -}
{- This procedure reads in the accepted MaxIter   -}
{- from the keyboard.                             -}
{--------------------------------------------------}

begin
  Writeln;
  repeat
    MaxIter := 100;
    Write('Maximum number of iterations: (> 0) ');
    ReadInt(MaxIter);
    IOCheck;
    if MaxIter <= 0 then
    begin
      IOerr := true;
      MaxIter := 1000;
    end;
  until not IOerr;
end; { procedure GetMaxIter }

begin { procedure GetData }
  GetLimits(LowerLimit, UpperLimit);
  GetTolerance(Tolerance);
  GetMaxIter(MaxIter);
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(LowerLimit : Float;
                  UpperLimit : Float;
                  Tolerance  : Float;
                  MaxIter    : integer;
                  Integral   : Float;
                  Iter       : integer;
                  Error      : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'Lower Limit:' : 30, LowerLimit : 25);
  Writeln(OutFile, 'Upper Limit:' : 30, UpperLimit : 25);
  Writeln(OutFile, 'Tolerance:' : 30, Tolerance : 25);
  Writeln(OutFile, 'Maximum number of iterations:' : 30, MaxIter : 5);
  Writeln(OutFile, 'Number of iterations:' : 30, Iter : 5);
  Writeln(OutFile);
  if Error = 3 then
    DisplayWarning;
  if Error in [1, 2] then
    DisplayError;

  case Error of
    0 : Writeln(OutFile, 'Integral:' : 25, Integral);

    1 : Writeln(OutFile, 'The tolerance must be greater than zero.');

    2 : Writeln(OutFile,
                'The maximum number of iterations must be greater than zero.');
    3 : begin
          Writeln(OutFile, 'Tolerance not reached in ', Iter, ' iterations.');
          Writeln(OutFile, 'The last iterate of the integral is:', Integral);
        end;
  end; { case }
end; { procedure Results }

begin { program Romberg }
  ClrScr;
  Initialize(LowerLimit, UpperLimit, Integral, Tolerance,
             MaxIter, Iter, Error);
  GetData(LowerLimit, UpperLimit, Tolerance, MaxIter);
  Romberg(LowerLimit, UpperLimit, Tolerance, MaxIter,
          Integral, Iter, Error, @TNTargetF);
  Results(LowerLimit, UpperLimit, Tolerance, MaxIter, Integral, Iter, Error);
  Close(OutFile);
end. { program Romberg }
