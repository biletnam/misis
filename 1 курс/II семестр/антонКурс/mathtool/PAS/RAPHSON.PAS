program Newton_Raphson_Prog;

{----------------------------------------------------------------------------}
{-                                                                          -}
{-     Turbo Pascal Numerical Methods Toolbox                               -}
{-     Copyright (c) 1986, 87 by Borland International, Inc.                -}
{-                                                                          -}
{-            Purpose: This sample program demonstrates the                 -}
{-                     Newton-Raphson algorithm.                            -}
{-                                                                          -}
{-            Unit   : RootsEqu    procedure Newton_Raphson                 -}
{-                                                                          -}
{----------------------------------------------------------------------------}

{$I-}                          { Disable I/O error trapping }
{$R+}                          { Enable range checking }

uses
  RootsEqu, Dos, Crt, Common;

var
  InitGuess : Float;           { Initial approximation }
  Tolerance : Float;           { Tolerance in answer }
  Root, Value, Deriv : Float;  { Resulting roots and other info }
  Iter : integer;              { Number of iterations to find root }
  MaxIter : integer;           { Maximum number of iterations }
  Error : byte;                { Error flag }

{$F+}
{------- HERE IS THE FUNCTION ----------}
function TNTargetF(X : Float) : Float;
begin
  TNTargetF := Cos(X) - X;
end;  { function TNTargetF }
{---------------------------------------}

{------- HERE IS THE DERIVATIVE --------}
function TNDerivF(X : Float) : Float;
begin
  TNDerivF := -Sin(X) - 1;
end; { function TNDerivF }
{---------------------------------------}
{$F-}

procedure Initialize(var InitGuess : Float;
                     var Tolerance : Float;
                     var Root      : Float;
                     var Value     : Float;
                     var Deriv     : Float;
                     var MaxIter   : integer;
                     var Iter      : integer;
                     var Error     : byte);

{-----------------------------------------------------------}
{- Output: InitGuess, Tolerance, Root, Value, Deriv,       -}
{-         MaxIter, Iter, Error                            -}
{-                                                         -}
{- This procedure initializes the above variables to zero. -}
{-----------------------------------------------------------}

begin
  InitGuess := 0;
  Tolerance := 0;
  MaxIter := 0;
  Root := 0;
  Value := 0;
  Deriv := 0;
  Error := 0;
  Iter := 0;
end; { procedure Initialize }

procedure UserInput(var InitGuess : Float;
                    var Tol       : Float;
                    var MaxIter   : integer);

{-------------------------------------------------------------}
{- Output: InitGuess, Tol, MaxIter                           -}
{-                                                           -}
{- This procedure assigns values to the initial guess        -}
{- (InitGuess), to the tolerance with which the answer       -}
{- should be found, and to the maximum number of iterations  -}
{- to be performed. Input is from the keyboard.              -}
{-------------------------------------------------------------}

procedure GetInitialGuess(var InitGuess : Float);
begin
  repeat
    Writeln;
    Write('Initial approximation to the root: ');
    Readln(InitGuess);
    IOCheck;        { Check for I/O errors }
  until not IOerr;
end; { procedure GetInitialGuess }

procedure GetTolerance(var Tol : Float);
begin
  Tol := 1E-8;
  repeat
    Writeln;
    Write('Tolerance (> 0): ');
    ReadFloat(Tol);
    IOCheck;        { Check for I/O errors }
    if Tol <= 0 then
    begin
      IOerr := true;
      Tol := 1E-8;
    end;
  until not IOerr;
end; { procedure GetTolerance }

procedure GetMaxIter(var MaxIter : integer);
begin
  MaxIter := 100;
  repeat
    Writeln;
    Write('Maximum number of iterations (> 0): ');
    ReadInt(MaxIter);
    IOCheck;        { Check for I/O errors }
    if MaxIter < 0 then
    begin
      IOerr := true;
      MaxIter := 100;
    end;
  until not IOerr;
end; { procedure GetMaxIter }

begin { procedure UserInput }
  GetInitialGuess(InitGuess);
  GetTolerance(Tol);
  GetMaxIter(MaxIter);
  GetOutputFile(OutFile);
end; { procedure UserInput }

procedure Results(InitGuess : Float;
                  Tol       : Float;
                  MaxIter   : integer;
              var OutFile   : text;
                  Root      : Float;
                  Value     : Float;
                  Deriv     : Float;
                  Iter      : integer;
                  Error     : byte);

{------------------------------------------------------------}
{- This procedure outputs the results to the device OutFile -}
{------------------------------------------------------------}

begin
  Writeln(OutFile);
  Writeln(OutFile);
  Writeln(OutFile, 'Initial approximation: ' : 30, InitGuess);
  Writeln(OutFile, 'Tolerance: ' : 30, Tol);
  Writeln(OutFile, 'Maximum number of iterations: ' : 30, MaxIter);
  Writeln(OutFile);
  if Error in [1, 2] then
    DisplayWarning;
  if Error >= 3 then
    DisplayError;

  case Error of
    1 : begin
          Write(OutFile, 'It will take more than ',MaxIter,
                         ' iterations to solve this equation');
        end;

    2 : Writeln(OutFile,'The slope is approaching zero.');

    3 : Writeln(OutFile, 'The tolerance must be greater than zero!');

    4 : Writeln(OutFile,
                'The maximum number of iteration must be greater than zero!');

  end; { case }

  if Error <= 2 then
  begin
    Writeln(OutFile);
    Writeln(OutFile, 'Number of iterations: ' : 26, Iter : 3);
    Writeln(OutFile, 'Calculated root: ' : 26, Root);
    Writeln(OutFile, 'Value of the function  ' : 26);
    Writeln(OutFile, 'at the calculated root: ' : 26, Value);
    Writeln(OutFile, 'Value of the derivative  ' : 26);
    Writeln(OutFile, 'of the function at the  ' : 26);
    Writeln(OutFile, 'calculated root: ' : 26, Deriv);
    Writeln(OutFile);
  end;
end; { procedure Results }

begin { program Newton_Raphson }
  ClrScr;
  Initialize(InitGuess, Tolerance, Root, Value, Deriv, MaxIter, Iter, Error);
  UserInput(InitGuess, Tolerance, MaxIter);
  { Use the Newton-Raphson method to converge onto a root }
  Newton_Raphson(InitGuess, Tolerance, MaxIter,
                 Root, Value, Deriv, Iter, Error, @TNTargetF, @TNDerivF);
  Results(InitGuess, Tolerance, MaxIter, OutFile,
          Root, Value, Deriv, Iter, Error);
  Close(OutFile);         { Close output file }
end. { program Newton_Raphson }
