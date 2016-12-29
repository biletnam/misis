program Newton_Raphson_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-            Purpose: This sample program demonstrates the                 -}
{-                     Newton-Raphson algorithm.  This program is very      -}
{-                     bare-boned; it contains no I/O checking.             -}
{-                                                                          -}
{-            Unit   : RootsEqu    procedure Newton_Raphson                 -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$R+}              { Enable range checking }

uses
  RootsEqu, Crt;

var
  InitGuess : Float;           { Initial approximation }
  Tolerance : Float;           { Tolerance in answer }
  Root, Value, Deriv : Float;  { Resulting roots and other info }
  Iter : integer;              { Number of iterations to find root }
  MaxIter : integer;           { Maximum number of iterations }
  Error : byte;                { Error flag }
  OutFile : text;              { Output file }

{$F+}
{------- HERE IS THE FUNCTION ----------}
function TNTargetF(X : Float) : Float;
begin
  TNTargetF := Cos(X) - X;
end; { function TNTargetF }
{---------------------------------------}

{------- HERE IS THE DERIVATIVE --------}
function TNDerivF(X : Float) : Float;
begin
  TNDerivF := -Sin(X) - 1;
end; { function TNDerivF }
{---------------------------------------}
{$F-}

begin { program Newton_Raphson }
  ClrScr;
  InitGuess := 0;
  Tolerance := 1E-6;
  MaxIter := 100;
  Write('Initial Approximation to the root: ');
  Readln(InitGuess);
  Writeln;
  Write('Tolerance (> 0): ');
  Readln(Tolerance);
  Write('Maximum number of iterations (>= 0): ');
  Readln(MaxIter);

  Newton_Raphson(InitGuess, Tolerance, MaxIter,
                 Root, Value, Deriv, Iter, Error, @TNTargetF, @TNDerivF);

  Writeln;
  Writeln('Error = ', Error);
  Writeln('Number of iterations: ': 30, Iter : 3);
  Writeln('Calculated root: ': 30, Root);
  Writeln('Value of the function' : 28);
  Writeln('at the root: ': 30, Value);
  Writeln('Value of the derivative' :28);
  Writeln('of the function at the' : 28);
  Writeln('calculated root: ' : 30, Deriv);
end. { program Newton_Raphson }
