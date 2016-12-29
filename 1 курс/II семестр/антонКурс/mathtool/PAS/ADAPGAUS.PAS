program Adaptive_Gauss_Quadrature_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-           Purpose: This program demonstrates integration with            -}
{-                    Adaptive Quadrature methods and Gaussian Quadrature.  -}
{-                                                                          -}
{-           Unit   : Integrat    procedure Adaptive_Gauss_Quadrature       -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}      { Disable I/O error trapping }
{$R+}      { Enable range checking }

uses
  Integrat, Dos, Crt, Common;

var
  LowerLimit, UpperLimit : Float;   { Limits of integration }
  Tolerance : Float;                { Tolerance in the answer }
  MaxIntervals : integer;           { Maximum number of subintervals used }
                                    { to approximate the integral }
  Integral : Float;                 { Value of the integral }
  NumIntervals : integer;           { Number of subintervals used }
                                    { to approximate integral }
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
                     var Tolerance    : Float;
                     var MaxIntervals : integer;
                     var NumIntervals : integer;
                     var Error        : byte);

{------------------------------------------------------------------}
{- Output: LowerLimit, UppterLimit, Integral, Tolerance,          -}
{-         MaxIntervals, NumIntervals, Error                      -}
{-                                                                -}
{- This procedure initializes the above variables to zero         -}
{------------------------------------------------------------------}

begin
  Writeln;
  LowerLimit := 0;
  UpperLimit := 0;
  Integral := 0;
  Tolerance := 0;
  MaxIntervals := 0;
  NumIntervals := 0;
  Error := 0;
end; { procedure Initialize }

procedure GetData(var LowerLimit   : Float;
                  var UpperLimit   : Float;
                  var Tolerance    : Float;
                  var MaxIntervals : integer);

{------------------------------------------------------------}
{- Output: LowerLimit, UpperLimit, Tolerance, MaxIntervals  -}
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
    Write('Tolerance in answer: (> 0): ');
    ReadFloat(Tolerance);
    IOCheck;
    if Tolerance <= 0 then
    begin
      IOerr := true;
      Tolerance := 1E-8;
    end;
  until not IOerr;
end; { procedure GetTolerance }

procedure GetMaxIntervals(var MaxIntervals : integer);

{--------------------------------------------------}
{- Output: MaxIntervals                           -}
{-                                                -}
{- This procedure reads in the maximum number of  -}
{- subintervals to be used in approximating the   -}
{- integral.  Input is from the keyboard.         -}
{--------------------------------------------------}

begin
  Writeln;
  repeat
    MaxIntervals := 1000;
    Write('Maximum number of subintervals (> 0): ');
    ReadInt(MaxIntervals);
    IOCheck;
    if MaxIntervals <= 0 then
    begin
      IOerr := true;
      MaxIntervals := 1000;
    end;
  until not IOerr;
end; { procedure GetMaxIntervals }

begin { procedure GetData }
  GetLimits(LowerLimit, UpperLimit);
  GetTolerance(Tolerance);
  GetMaxIntervals(MaxIntervals);
  GetOutputFile(OutFile);
end; { procedure GetData }

procedure Results(LowerLimit   : Float;
                  UpperLimit   : Float;
                  Tolerance    : Float;
                  MaxIntervals : integer;
                  Integral     : Float;
                  NumIntervals : integer;
                  Error        : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'Lower Limit:' : 35, LowerLimit : 25);
  Writeln(OutFile, 'Upper Limit:' : 35, UpperLimit : 25);
  Writeln(OutFile, 'Tolerance:' : 35, Tolerance : 25);
  Writeln(OutFile, 'Maximum number of subintervals:' : 35, MaxIntervals : 5);
  Writeln(OutFile, 'Number of subintervals used:' : 35, NumIntervals : 5);
  Writeln(OutFile);
  if Error = 3 then
    DisplayWarning;
  if Error in [1, 2] then
    DisplayError;

  case Error of
    0 : Writeln(OutFile, 'Integral:' : 25, Integral);

    1 : Writeln(OutFile, 'The tolerance must be greater than zero.');

    2 : Writeln(OutFile,
                'The maximum number of intervals must be greater than zero.');

    3 : begin
          Writeln(OutFile, 'The integral was not found with ', NumIntervals,
                           ' subintervals.');
          Writeln(OutFile, 'The integral thus far: ', Integral);
        end;
  end; { case }
end; { procedure Results }

begin { program Adaptive_Gauss_Quadrature }
  ClrScr;
  Initialize(LowerLimit, UpperLimit, Integral, Tolerance, MaxIntervals,
             NumIntervals, Error);
  GetData(LowerLimit, UpperLimit, Tolerance, MaxIntervals);
  Adaptive_Gauss_Quadrature(LowerLimit, UpperLimit, Tolerance, MaxIntervals,
                            Integral, NumIntervals, Error, @TNTargetF);
  Results(LowerLimit, UpperLimit, Tolerance, MaxIntervals,
          Integral, NumIntervals, Error);
  Close(OutFile);
end. { program Adaptive_Gauss_Quadrature }
